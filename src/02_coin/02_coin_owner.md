# 例子
我们先来看一下完整的一个产生Coin的例子


usd的代码

```move
module coin_demo::usd {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct USD has drop {}

    fun init(witness: USD, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"USD", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }
}
```

rmb的代码
```move
module coin_demo::rmb {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
   
    struct RMB has drop {}
    
    fun init(witness: RMB, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"RMB", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }
}
```

大家可以看到 代码本身

```shell
sui client publish --gas-budget 100000000 
```
