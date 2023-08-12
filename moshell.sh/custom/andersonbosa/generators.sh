function poc_init_python() {
  create_venv

  pysource

  pip freeze >requirements.txt

  curl -s https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore >.gitignore

  git init
  git add .
  git commit -m 'init python project'
}
