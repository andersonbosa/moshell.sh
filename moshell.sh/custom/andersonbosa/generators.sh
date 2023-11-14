function create_poc_python() {
  create_venv

  pysource

  pip freeze >requirements.txt

  curl -s https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore >.gitignore

  git init
  git add .
  git commit -m 'init python project'
}

function create_makefile_python() {
  cat <<EOF >./Makefile
  
setup-env:
  python3 -m venv .venv
  source .venv/bin/activate
  pip install -r requeriments.txt

run:
  python main.py

EOF
}
