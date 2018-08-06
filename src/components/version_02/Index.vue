<template lang="pug">
//- pug comment
div
  //- {{ }} is a variable assigned by Vue
  h1 {{ title }}
  div
    h2 Token imformation
    ul
      li Name: {{ name }}
      li Total supply: {{ totalSupply }} {{ symbol }}

  div  
    h2 Your account
    ul
      li Address: {{ address }}
      li Balance: {{ balance }} {{ symbol }}
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

@Component
export default class Index extends Vue {
  // These variables are inserted into HTML above.
  title = 'Token Viewer';
  name = 'My token';
  symbol = 'TKN';
  totalSupply = '10000.000000000000000000';
  address = '0x00000000000000000000';
  balance = '0.0';
}
</script>

<style scoped>
/* CSS can be added here if you need. */
</style>
