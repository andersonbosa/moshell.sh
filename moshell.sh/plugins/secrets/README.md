# secrets

Store your secrets, api-keys and etc in a protected place and keep using them in your shell, without exposing anything!

### Dependencies

- [Github CLI](https://cli.github.com/)
- For correct use, the repository is expected to have "index.sh" file with desired content.

### Gettings started

1. Create a private git repository, for example, moshell-secrets
```bash
# Example of how start your secret repository:
cd ~
gh repo create .moshell-secrets --private --clone
```
2. Configure the following variables in .env.sh (check example [./secrets/.env.sh](./.env.sh.example))
  - `_MOSHELL_PLUGIN_GIT_OWNER` - your git username
  - `_MOSHELL_PLUGIN_GIT_REPO` - your repository name
3. And it's ready to be used! The next time you start Shell the repository will be cloned and moshell.sh will import your "index.sh".
