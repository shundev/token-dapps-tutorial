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
  
  div
    h2 Transfer token
    form(v-on:submit.prevent="onSubmit")
      label(for="recipient") Recipient address
      input(id="recipient" placeholder="0xXXXXXXXXXXXXXXXXXXXX" type="text")

      label(for="amount") Amount (wei)
      input(id="amount" placeholder="1000000000000000000" type="text")

      input(type="submit" value="Send")
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';
import Web3 from 'web3';

import contractInfo from './contractInfo';

@Component
export default class Index extends Vue {
  // These variables are inserted into HTML above.
  title = 'Token Viewer';
  name = 'My token';
  symbol = 'TKN';
  totalSupply = 10000.0;
  address = '0x00000000000000000000';
  balance = 0.0;
  decimals = 0;

  /**
   * One of Vue life-cycle functions.
   * Called after all initialization of the Index Component is completed.
   */
  mounted() {
    this.connectToBlockchainAndFetch();
  }

  /**
   *
   */
  onTransferToken() {
    alert('Transfer token');
  }

  /**
   * Connect to Ethereum blockchain and Fetch all data needed.
   */
  async connectToBlockchainAndFetch() {
    // Wait until web3 is found
    const web3: Web3 = await this.fetchWeb3Async();

    // Wait until the user's accounts are found on MetaMask.
    const addresses: string[] = await web3.eth.getAccounts();

    // Display the user's address. Vue automatically reload the data and re-render it.
    this.address = addresses[0];

    // Initialize the Token contract
    const token = new web3.eth.Contract(
      contractInfo.Token.abi,
      contractInfo.Token.address
    );

    // Common parameter that allways needed when interfact with blockchain.
    const param = { from: this.address };

    // Fetch token name from blockchain
    this.name = await token.methods.name().call(param);

    // Fetch decimals for displaying balance correctly.
    this.decimals = await token.methods.decimals().call(param);

    // Fetch total supply
    const totalSupply: number = await token.methods.totalSupply().call(param);
    this.totalSupply = totalSupply / 10 ** this.decimals;

    // Fetch balance of the user.
    const balance: number = await token.methods
      .balanceOf(this.address)
      .call(param);
    this.balance = balance / 10 ** this.decimals;
  }

  /**
   * Find web3 inserted by the browser extension such as MetaMask.
   * web3 is a library to connect to Ethereum blockchain.
   */
  async fetchWeb3Async(): Promise<Web3> {
    return new Promise<Web3>((resolve, reject) => {
      window.addEventListener('load', () => {
        let web3 = window.web3;
        if (typeof web3 !== 'undefined') {
          // Use MetaMask as connector to Ethereum blockchain if it's installed the browser.
          web3 = new Web3(web3.currentProvider);
          console.log('web3 found.');
          resolve(web3);
        } else {
          // Otherwise users cannot use this app.
          alert(
            'You need Mist, MetaMask or other Dapps browsers to use our Dapp.'
          );
          reject('Not found.');
        }
      });
    });
  }
}
</script>

<style scoped>
/* CSS can be added here if you need. */
</style>
