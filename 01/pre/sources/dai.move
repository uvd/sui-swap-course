module pre::dai {
    use sui::balance::{Self, create_supply, Supply};
    use sui::coin;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct DAI has drop {}

    struct StoreSupply has key {
        id: UID,
        supply: Supply<DAI>
    }

    fun init(witness: DAI, tx: &mut TxContext) {
        transfer::transfer(StoreSupply {
            id: object::new(tx),
            supply: create_supply(witness)
        }, tx_context::sender(tx));
    }

    public entry fun mint(ss: &mut StoreSupply, amount: u64, ctx: &mut TxContext) {
        let dai = coin::from_balance(balance::increase_supply(&mut ss.supply, amount), ctx);
        transfer::transfer(dai, tx_context::sender(ctx));
    }
}
