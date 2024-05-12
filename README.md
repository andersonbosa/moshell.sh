<section align="center">
  <br>
  <br>
  <img src="docs/assets/banner.svg" title="Project banner" alt="Project banner" />

  <p>
    <p>Fork, customize and take your shell everywhere.</p>
    <!-- <p><i>aka, mô querido shellsin.</i></p> -->
    <p align="center">
      <a href="#">
        <img src="https://img.shields.io/badge/open--source-green.svg">
      </a>
      <a href="#">
        <img src="https://img.shields.io/badge/contributions--welcome-orange.svg">
      </a>
      <br>
      <a href="/LICENSE.md">
        <img src="https://img.shields.io/badge/license-MIT-blue.svg">
      </a>
      <a href="https://github.com/andersonbosa/moshell.sh/blob/main/moshell.sh/version">
        <img src="https://img.shields.io/badge/version-2x-blue.svg">
      </a>
    </p>
  </p>

  <p>
    <a href="#summary">Summary</a> •
    <a href="#getting-started">Getting Started</a> •
    <a href="#contribution">Contribution</a> •
    <a href="#license">License</a>
  </p>
  <br>
  <br>
</section>


---


## Summary

Make your customizations and take them everywhere. **moshell.sh** is a framework to
persist its customizations without complexity!

The general idea is to give users and shell lovers a fork of this **moshell.sh**, allowing
them to easily add and maintain their customizations under a repository of their own control.

The main objective is:
  - Allow users to add their new customizations or those of other users in a simple way.

---

## Getting Started

The quickest way to get started using the program is via the installation script,
but keep in mind that it will point you back to the original project, this repository.

### Install:

```bash
curl https://raw.githubusercontent.com/andersonbosa/moshell.sh/main/moshell.sh/tools/install.sh | bash -s
```

### Uninstall:

```bash
curl https://raw.githubusercontent.com/andersonbosa/moshell.sh/main/moshell.sh/tools/uninstall.sh | bash -s
```

### Usage

The installation script will insert into the shell where you executed thescript to be loaded
whenever the shell is opened. The code injected (in your .bashrc/.zshrc ) for this is:

```bash
# Assuming that the repository was downloaded at $HOME/.moshell.sh,
# the line below load and initialize "moshell.sh" on your shell.
source /home/t4inha/.moshell.sh/moshell.sh/moshell.sh
```

#### CLI:

Through the **moshell.sh CLI** it is possible to perform some operations, listed below:

```
Usage: moshell <command> [options]

Available commands:

  help                Print this help message
  edit                Edit moshell configurations
  reload              Reload the configuration
  flags               Update moshell.sh environment variables
  logs                Get the logs of the day
  plugins             [TODO] Plugins management
  update              [TODO] Update moshell.sh
  version             Show the version
```

---

### Contribution

Your contributions and suggestions are hearty ♥ welcome. [See here the contribution guidelines.](docs/CONTRIBUTING.md)
Please, report bugs via [issues page](https://github.com/andersonbosa/moshell.sh/issues).

---

### License

