# Ethereum dapps tutorial by creating token & its website

## Getting Started

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

