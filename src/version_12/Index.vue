<template lang='pug'>
#index
  .container
    .row
      h1 ERC20 Token Viewer
    .row
      #holderCount
        h2 Current holders: {{ holderCount }}
        ul.collection
          li(v-for='item in holders').collection-item
    .row
      #order.s12.col
        form#transfer-form
          .row
            .input-field.col.s6
              input(type='text' id='amount' class='validate')
              label(for='amount' class='active') Amount
            .input-field.col.s6
              input(type='text' id='price' class='validate')
              label(for='price') Price
          .row
            .input-field.col.s6
              p
                label
                  input(name='group1' type='radio' checked)
                  span Sell
              p
                label
                  input(name='group1' type='radio' checked)
                  span Buy
            .input-field.col.s6
              input(type='text' id='expires' class='validate')
              label(for='expires') Expires In (Days)

            .input-field.col.s12
              input(type='submit' value='Order').btn
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';
import fetchWeb3 from '../ethereum/fetchWeb3';
import contractInfo from '../ethereum/contractInfo';

@Component
export default class Index extends Vue {
  holderCount: number = 40;
  sellOrders: object[] = [
    {
      from: '0xFFFFFFFFFFFFFFFFFFFF',
      amount: 5,
      price: 1,
    },
    {
      from: '0xAAAAAAAAAAAAAAAAAAAA',
      amount: 50,
      price: 0.9,
    },
  ];
  buyOrders: object[] = [
    {
      from: '0xBBBBBBBBBBBBBBBBBBBB',
      amount: 8,
      price: 0.8,
    },
    {
      from: '0x00000000000000000000',
      amount: 50,
      price: 0.7,
    },
  ];

  mounted() {
    this.connectToEthereum();
  }

  async connectToEthereum(): Promise<void> {
    const a2 = '0xe31c5b5731f3Cba04f8CF3B1C8Eb6FCbdC66f4B5';
    const web3 = await fetchWeb3;
    const toEth = (v: number) => web3.utils.fromWei(v, 'ether');
    const toWei = (v: number) => web3.utils.toWei(v.toString(), 'ether');
    const accounts = await web3.eth.getAccounts();
    const a1 = accounts[0];

    // Init token contract
    const contract = new web3.eth.Contract(
      contractInfo.ERC20Token.abi,
      contractInfo.ERC20Token.address
    );
    const exchange = new web3.eth.Contract(
      contractInfo.Exchange.abi,
      contractInfo.Exchange.address
    );

    // Fetch balance
    const balance1 = await contract.methods.balanceOf(a1).call({ from: a1 });
    const balance2 = await contract.methods.balanceOf(a2).call({ from: a1 });
    console.log('balance1: ', toEth(balance1));
    console.log('balance2: ', toEth(balance2));

    // Increase allowance
    // const result = await contract.methods
    //   .increaseApproval(contractInfo.Transferer.address, toWei(100))
    //   .send({ from: a1, gas: 500000, gasPrice: '1000000000' });
    // console.log(result);
  }
}
</script>

<style lang='stylus' scoped>
</style>
