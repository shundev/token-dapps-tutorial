<template lang="pug">
//- pug comment
div
  div.navbar-fixed
    nav.teal
      div.nav-wrapper
        a.brand-logo {{ name }} |
          small {{ totalSupply }} {{ symbol }} in total
        ul.right 
          li Your balance: {{ balance }} {{ symbol }}

  div.container  
    div.row
      div.col.s12.m6.l6
        h2 Buy tokens
        form(v-on:submit.prevent="onBuyToken")
          label(for="buyAmount") Amount (wei)
          input(id="buyAmount" ref="buyAmount" placeholder="1000000000000000000" type="text")
  
          input.btn(type="submit" value="Buy")
    
      div.col.s12.m6.l6
        h2 Transfer token
        form(v-on:submit.prevent="onTransferToken")
          label(for="recipient") Recipient address
          input(id="recipient" ref="recipient" placeholder="0xXXXXXXXXXXXXXXXXXXXX" type="text")
  
          label(for="amount") Amount (wei)
          input(id="amount" ref="amount" placeholder="1000000000000000000" type="text")
  
          input.btn(type="submit" value="Send")
    
    div
      ul.collection.with-header
        li.collection-header
          h4 Transaction list
        li.collection-item(v-if="transactions.length === 0") No transactions.
        li.collection-item(v-for="tx in transactions")
          //- "etherscan + tx" is rendered like "https://ropsten.etherscan.io/tx/0xXXXXX"
          a(:href="etherscan + tx" target="_blank") {{ tx }}
          
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';
import Web3 from 'web3';
import { Contract } from 'web3/types.d';

import contractInfo from './contractInfo';

// Define global variables
let web3: Web3;
let token: Contract;

@Component
export default class Index extends Vue {
  // These variables are inserted into HTML above.
  title = 'Token Viewer';
  name = 'My token';
  symbol = 'TKN';
  totalSupply = '1.0';
  address = '0x00000000000000000000';
  balance = '0.0';
  decimals = 0;

  // We define the type explicitly here because Typescript compiler gets angry :)
  transactions: string[] = [];

  // The website where you can investgate transactions, addresses and so on.
  etherscan = 'https://ropsten.etherscan.io/tx/';

  /**
   * One of Vue life-cycle functions.
   * Called after all initialization of the Index Component is completed.
   */
  mounted() {
    this.connectToBlockchainAndFetch();
  }

  onBuyToken() {
    if (web3 === undefined || token === undefined) {
      return;
    }

    const amount = this.$refs.buyAmount as HTMLInputElement;

    // Send Eth to the token contract and get tokens.
    web3.eth
      .sendTransaction({
        from: this.address,
        to: contractInfo.Token.address,
        value: amount.value,
        gas: 3000000,
        gasPrice: 1000000000,
      })
      .on('transactionHash', hash => {
        this.transactions = [hash].concat(this.transactions);
        amount.value = '';
      })
      .on('receipt', receipt => {
        // Mining completed.
        this.fetchBalance();
      });
  }

  /**
   * Send transaction to transfer tokens on submit.
   */
  onTransferToken() {
    // If web3 is not fetched yet, do nothing.
    if (web3 === undefined || token === undefined) {
      return;
    }

    // Get form inputs
    const to = this.$refs.recipient as HTMLInputElement;
    const amount = this.$refs.amount as HTMLInputElement;

    // Send transaction
    token.methods
      .transfer(to.value, amount.value)
      .send({ from: this.address, gas: 3000000, gasPrice: 1000000000 })
      .on('transactionHash', hash => {
        // Sending the transaction completed.
        this.transactions = [hash].concat(this.transactions);

        // Clear the form
        to.value = '';
        amount.value = '';
      })
      .on('receipt', receipt => {
        // Mining completed.
        this.fetchBalance();
      });
  }

  /**
   * Connect to Ethereum blockchain and Fetch all data needed.
   */
  async connectToBlockchainAndFetch() {
    // Wait until web3 is found
    web3 = await this.fetchWeb3Async();

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
    this.decimals = await token.methods.decimals().call(param);

    // Fetch total supply
    const totalSupply = await token.methods.totalSupply().call(param);

    // We can use the default utility function because token has the same decimals as Eth.
    this.totalSupply = web3.utils.fromWei(totalSupply, 'ether');

    this.fetchBalance();
  }

  async fetchBalance(): Promise<void> {
    // Fetch balance of the user.
    const balance = await token.methods
      .balanceOf(this.address)
      .call({ from: this.address });
    this.balance = web3.utils.fromWei(balance, 'ether');
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