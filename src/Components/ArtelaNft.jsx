export const ArtelaNft = {
  id: 11822,
  name: "Artela Testnet",
  network: "Artela Testnet",
  nativeCurrency: {
    decimals: 18,
    name: "ART",
    symbol: "ART",
  },
  rpcUrls: {
    public: { http: ["https://betanet-rpc1.artela.network"] },
    default: { http: ["https://betanet-rpc1.artela.network"] },
  },
  blockExplorers: {
    default: {
      name: "Artela Testnet",
      url: "https://betanet-scan.artela.network/",
    },
  },
  contracts: {
    MyContract: {
      address: "0x4249f6BB711ADbD53146Da1e9dbBcBaed74f313A",
    },
  },
};
