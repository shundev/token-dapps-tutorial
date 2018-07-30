<template lang='pug'>
#index
  .container
    .row
      h1 Shun Coin Exchange
    .row
      #holderCount
        h2 Current holders: {{ holderCount }}
    .row
      #order.s12.col
        form#order-form
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
    
    .row
      .s6.col
        ul#sell-order-list.collection.with-header
          li.collection-item
            h4 Sell orders
          li(v-for='item in sellOrders').collection-item
            div From: {{ item.from }}
              span: a(href='#').secondary-content
                i.material-icons send
              br
              span Amount {{ item.amount }}
              br
              span Price(ETH): {{ item.price }}
      .s6.col
        ul#buy-order-list.collection.with-header
          li.collection-item
            h4 Buy orders
          li(v-for='item in buyOrders').collection-item
            div From: {{ item.from }}
              span: a(href='#').secondary-content
                i.material-icons send
              br
              span Amount {{ item.amount }}
              br
              span Price(ETH): {{ item.price }}
        
  
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

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

  mounted() {}
}
</script>

<style lang='stylus' scoped>
</style>
