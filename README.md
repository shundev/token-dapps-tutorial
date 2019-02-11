# Ethereum dapps tutorial by creating token & its website

## Getting Started

### Install NodeJS

Don't you have Node JS installed? First install it.

On Ubuntu

```bash
sudo apt-get install -y nodejs
sudo npm install n -g
sudo n 11.8.0 # Current stable
sudo ln -sf /usr/local/bin/node /usr/bin/node
sudo apt-get purge -y nodejs
node -v && npm -v
```

On OSX

```bash
brew install nodejs
npm install n -g
n 11.8.0 # Current stable
sudo ln -sf /usr/local/bin/node /usr/bin/node
brew uninstall nodejs
node -v && npm -v
```

The output will be like:

```bash
v11.8.0
6.5.0
```

### Install Token-Dapps-Tutorial

``` bash
git clone https://github.com/shunsukehondo/token-dapps-tutorial.git
cd token-dapps-tutorial
npm install
npm start
```

## Setting of VSCode for code highlighting, lint & autoformat

1. Open token-dapps-tutorial folder with VSCode
2. Install following extensions
    1. Prettier
    2. TSLint
    3. Vetur
3. Open User Settings (`cmd+,` on Mac) and overwrite it with the follows.

```json
{
    "[typescript]": {
        "editor.formatOnSave": true
      },
    "[vue]": {
        "editor.formatOnSave": true
      },
    "[javascript]": {
        "editor.formatOnSave": true
    }
}
```

