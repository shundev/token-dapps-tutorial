<template lang='pug'>
  #app
    router-view
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

@Component({
  name: 'app',
})
export default class App extends Vue {}
</script>

<style lang='stylus' scoped>
</style>
