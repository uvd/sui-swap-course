module pre::usdt {
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    const Decimals: u8 = 9;

    struct USDT  has drop {}

    fun init(witness: USDT, ctx: &mut TxContext) {
        let cap = coin::create_currency(witness, Decimals, ctx);
        transfer::share_object(cap)
    }

    public entry fun mint_me(cap: &mut TreasuryCap<USDT>, amount: u64, ctx: &mut TxContext) {
        let minted = coin::mint(cap, amount, ctx);
        transfer::transfer(minted, tx_context::sender(ctx));
    }

    public entry fun mint_balance(cap: &mut TreasuryCap<USDT>, amount: u64, ctx: &mut TxContext) {
        let minted = coin::mint_balance(cap, amount);
        let usdt = coin::from_balance(minted, ctx);
        transfer::transfer(usdt, tx_context::sender(ctx));
    }
}
