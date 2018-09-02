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
import Web3 from 'web3';
import { Contract } from 'web3/types.d';

import contractInfo from './contractInfo';

// Accessible from all functions
let web3: Web3;
let token: Contract;

@Component
export default class Index extends Vue {
  // These variables are inserted into HTML above.
  title = 'Token Viewer';
  name = 'My token';
  symbol = 'TKN';
  totalSupply = '10000.000000000000000000';
  address = '0x00000000000000000000';
  balance = '0.0';

  /**
   * One of Vue life-cycle functions.
   * Called after all initialization of the Index Component is completed.
   */
  mounted() {
    this.fetchWeb3(() => {
      this.fetchFromBlockchain();
    });
  }

  /**
   * Connect to Ethereum blockchain and Fetch all data needed.
   */
  async fetchFromBlockchain() {
    // Wait until the user's accounts are found on MetaMask.
    const addresses: string[] = await web3.eth.getAccounts();

    // Display the user's address. Vue automatically reload the data and re-render it.
    this.address = addresses[0];

    // Initialize the Token contract
    token = new web3.eth.Contract(
      contractInfo.Token.abi,
      contractInfo.Token.address
    );

    // Common parameter that allways needed when interfact with blockchain.
    const param = { from: this.address };

    // Fetch token name, symbol & decimals from blockchain
    this.name = await token.methods.name().call(param);
    this.symbol = await token.methods.symbol().call(param);

    // Fetch total supply
    const totalSupply: number = await token.methods.totalSupply().call(param);

    // You must handle very big and small number carefully to display correctly.
    // You can use the default function for this because the token has the same decimals as Eth.
    this.totalSupply = web3.utils.fromWei(totalSupply, 'ether');

    // Fetch balance of the user.
    const balance: number = await token.methods
      .balanceOf(this.address)
      .call(param);
    this.balance = web3.utils.fromWei(balance, 'ether');
  }

  /**
   * Find web3 inserted by the browser extension such as MetaMask.
   * web3 is a library to connect to Ethereum blockchain.
   */
  fetchWeb3(onFinish: () => void) {
    window.addEventListener('load', () => {
      if (typeof window.web3 !== 'undefined') {
        // Use MetaMask as connector to Ethereum blockchain if it's installed the browser.
        web3 = new Web3(window.web3.currentProvider);
        console.log('web3 found.');
        onFinish();
      } else {
        // Otherwise users cannot use this app.
        alert(
          'You need Mist, MetaMask or other Dapps browsers to use our Dapp.'
        );
      }
    });
  }

  async awaitable(func: (resolve: () => void) => void): Promise<any> {
    return new Promise(resolve => func(resolve));
  }
}
</script>

<style scoped>
/* CSS can be added here if you need. */
</style>
