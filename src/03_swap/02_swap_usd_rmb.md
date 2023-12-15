# 固定币对的交换
因为教程是一部一部的  我们先只实现 USD - RMB 交换的合约

## 依赖以前发行的两个币对

因为需要用到两个

我们修改 code/01_swap 下面的 `Move.toml` 文件

```toml
[package]
name = "swap"
version = "0.0.1"

[dependencies]
Sui = { git = "https://github.com/MystenLabs/sui.git", subdir = "crates/sui-framework/packages/sui-framework", rev = "framework/mainnet" }
CoinDemo = { local= "../../../02_coin/code/coin_demo" }

[addresses]
swap = "0x0"
```

在 `dependencies`新增了一行
```toml
CoinDemo = { local= "../../../02_coin/code/coin_demo" }
```