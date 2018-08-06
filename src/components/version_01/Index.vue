<template lang="pug">
//- pug comment
//- Converted to:
//- <div>
//-   <h1>Token Viewer</h1>
//- </div>
div
  h1 {{ title }}

</div>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

@Component
export default class Index extends Vue {
  title = 'Token Viewer';
}
</script>

<style scoped>
/* CSS can be added here if you need. */
</style>
