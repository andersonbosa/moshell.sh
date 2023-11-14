# Function to upload content to termbin.com
function _termbin::upload() {
  local content="$1"

  local response=$(echo -n "$content" | nc termbin.com 9999)

  if [[ "$response" =~ ^https://termbin.com/[a-zA-Z0-9]+$ ]]; then
    echo "Upload successful. URL: $response"
  else
    echo "Upload failed."
  fi
}

# Function to download content from termbin.com
function _termbin::download() {
  local code="$1"
  local url="https://termbin.com/$code"

  curl -s "$url"
}

function termbin() {
  # Main CLI interface
  if [[ $# -eq 0 ]]; then
    echo "Usage: termbin.sh [upload|download] [content or code]"
    return 2
  fi

  case "$1" in
  "upload")
    if [[ -z "$2" ]]; then
      echo "Usage: termbin.sh upload [content]"
      return 0
    fi

    _termbin::upload "$2"
    ;;

  "download")
    if [[ -z "$2" ]]; then
      echo "Usage: termbin.sh download [code]"
      return 0
    fi

    _termbin::download "$2"
    ;;

  *)
    echo "Invalid command: $1"
    return 1
    ;;
  esac
}
