<template lang="pug">
  h1 Hello, world!!
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

@Component
export default class Index extends Vue {
  // HTML要素を配置し終わったら呼ばれる
  mounted() {}
}
</script>

<style scoped>
/* CSS can be added here if you need. */
</style>
