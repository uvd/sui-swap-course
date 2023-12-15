# Coin

Coin是Sui上的标准代币协议

我们先来看下Coin的定义
[Coin](https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/packages/sui-framework/sources/coin.move#L26)
```rust
    /// A coin of type `T` worth `value`. Transferable and storable
    struct Coin<phantom T> has key, store {
        id: UID,
        balance: Balance<T>
    }
```
`Coin` 内部有一个 `id` 字段表面是一个对象，只有一个 类型为 `Balance` 的字段 我们把 `Balance`的源码也放出来
```rust
    struct Balance<phantom T> has store {
        value: u64
    }
```

`Balance` 类型
只有一个类型为`u64` 的 `value`字段 和一个泛型的占位符 `T`
