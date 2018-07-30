# typescript-vue-pug-template

> Vue.js with Typescript and Pug

## Getting Started

``` bash
# Clone repogisotyr
git clone https://github.com/shunsukehondo/Vue-Typescript-Pug.git

# Move into the directory
cd Vue-Typescript-Pug

# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev
```

## Build for production

```
# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report
```

## Auto lint and format with VSCode

You can check errors and coding style of your code in read-time using VSCode editor.

1. Open Vue-Typescript-Pug with VSCode
2. Install following extensions
    1. Prettier
    2. TSLint
    3. Vetur
    4. language-stylus
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
