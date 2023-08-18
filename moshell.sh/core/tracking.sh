export _MOSHELL_DIR_CORE_TRACKING="${BASH_SOURCE:-$0}"

# TODO: leave explicit how data is used in privacy policy
# Function to generate a user fingerprint
function _moshell::generate_user_fingerprint() {
  local fingerprint=""

  if [[ "$_MOSHELL_FLAG_ENABLE_TRACKING_FINGERPRINT" == 0 ]]; then
    echo $fingerprint
    return 0
  fi

  # Get hostname
  local hostname=$(hostname)
  fingerprint+="hostname:${hostname},"

  # Get CPU information
  local cpu_info=$(lscpu | grep 'Model name' | sed 's/Model name://' | tr -d '[:space:]')
  fingerprint+="cpu:${cpu_info},"

  # Get total RAM
  local total_ram=$(free -h | awk '/^Mem:/{print $2}')
  fingerprint+="ram:${total_ram},"

  # Get OS version
  local os_version=$(lsb_release -ds | tr -d '"')
  fingerprint+="os:${os_version},"

  # Get kernel version
  local kernel_version=$(uname -r)
  fingerprint+="kernel:${kernel_version},"

  # Get username
  local username=$(whoami)
  fingerprint+="username:${username},"

  # Generate hash of the fingerprint
  local hashed_fingerprint=$(echo -n "$fingerprint" | sha256sum | awk '{print $1}')

  echo "$hashed_fingerprint"
}

function _moshell:tracking_service::build_event() {
  local token="$1"
  local event_key="$2"
  local distinct_id="$3"

  local software_name="moshell.sh"
  local software_version="$(mo version)"

  local payload=$(
    cat <<EOF
[
  {
    "properties": {
      "token": "$token",
      "distinct_id": "$distinct_id",
      "software_name": "$software_name",
      "software_version": "$software_version"
    },
    "event": "$event_key"
  }
]
EOF
  )

  echo $payload
}

# Function to send data to MixPanel
function _moshell:tracking_service::send_to_mixpanel() {
  local payload="$1"
  _moshell::log DEBUG "[_moshell:tracking_service::send_to_mixpanel] payload:$payload"

  local response=$(
    curl --request POST \
      --url 'https://api.mixpanel.com/track?ip=1&verbose=0' \
      --header 'accept: text/plain' \
      --header 'content-type: application/json' \
      --data $payload
  )

  local return_code

  if [[ "$response" -eq "1" ]]; then
    return_code=200
  fi

  return ${return_code}
}

# Function to track user events and send to MixPanel
function _moshell:tracking_service::track_events() {
  local MIX_PANEL_PROJECT_ID="518f965586b28b7ec2e3ecc0bff00a0c" # DISCLAIMER: FALSE POSITIVE: TOKEN TO UNTRUSTED ENVIRONMENT.
  local EVENT_USAGE_KEY="user_usage"
  local EVENT_USER_FINGERPRINT=$(_moshell::generate_user_fingerprint)

  local payload=$(
    _moshell:tracking_service::build_event $MIX_PANEL_PROJECT_ID $EVENT_USAGE_KEY $EVENT_USER_FINGERPRINT
  )

  _moshell:tracking_service::send_to_mixpanel "$payload" &>/dev/null
  last_return_code=$?

  if [[ $last_return_code -eq 200 ]]; then
    logtype=success
  else
    logtype=error
  fi

  _moshell::log $logtype "[_moshell:tracking_service::track_events] [user: $EVENT_USER_FINGERPRINT] [event: $EVENT_USAGE_KEY]"

}

function _moshell:tracking_service() {
  if [[ "$_MOSHELL_FLAG_ENABLE_TRACKING_SERVICE" == "1" ]]; then
    _moshell:tracking_service::track_events &>/dev/null
  fi
}
