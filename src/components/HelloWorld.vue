<template lang='pug'>
#hello
  h1 {{ msg }}
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

@Component
export default class HelloWorld extends Vue {
  msg: string = 'Welcome to Vue + Typescript + Pug + Stylus!';
}
</script>

<style lang='stylus' scoped>
</style>
