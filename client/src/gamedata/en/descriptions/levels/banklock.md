We get it. There are times when a brand new, shiny token or NFT hits the marketplace, and you impulse buy it, losing all your Ethereum in the process. To combat this problem, AnChain.ai has developed an Ethereum lock! Just send your ethereum to this smart contract, and you wont be able to withdraw it again until the end of the week!

Most of these solidity concepts should look familiar, save for one detail.

`block.timestamp` is the Unix timestamp of the exact moment when the block containing this transaction was "collated". For reference, you can find information about a block like so:
```
web3.eth.getBlock("latest")
web3.eth.getBlock("pending")
```

See if you can deposit some funds, then withdraw them without waiting a whole week.