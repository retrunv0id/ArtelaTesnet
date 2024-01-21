import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import "./App.css";
import "@rainbow-me/rainbowkit/styles.css";
import {
  getDefaultWallets,
  RainbowKitProvider,
  darkTheme,
} from "@rainbow-me/rainbowkit";
import { configureChains, createConfig, WagmiConfig } from "wagmi";
import { sepolia } from "wagmi/chains";
import { publicProvider } from "wagmi/providers/public";
import { ArtelaToken } from "./Components/ArtelaToken.jsx";
import { ArtelaNft } from "./Components/ArtelaNft.jsx";

const { chains, publicClient } = configureChains(
  [sepolia, ArtelaToken, ArtelaNft],
  [publicProvider()]
);

const { connectors } = getDefaultWallets({
  appName: "RainbowKit demo",
  projectId: "YOUR_PROJECT_ID",
  chains,
});

const wagmiConfig = createConfig({
  autoConnect: true,
  connectors,
  publicClient,
});

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <WagmiConfig config={wagmiConfig}>
      <RainbowKitProvider
        coolMode
        showRecentTransactions={true}
        modalSize="compact"
        theme={darkTheme()}
        chains={chains}
      >
        <App />{" "}
      </RainbowKitProvider>
    </WagmiConfig>
  </React.StrictMode>
);
