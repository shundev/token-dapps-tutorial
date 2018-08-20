import Web3 from 'web3';

export default new Promise<Web3>((resolve, reject) => {
  window.addEventListener('load', () => {
    let web3 = window.web3;
    if (typeof web3 !== 'undefined') {
      web3 = new Web3(web3.currentProvider);
      console.log('web3 found.');
      resolve(web3);
    } else {
      alert('You need Mist, MetaMask or other Dapps browsers to use our Dapp.');
      reject('Not found.');
    }
  });
});
