module movefuns_usdc::usdc {
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{TxContext, sender};

    struct USDC has drop {}

    fun init(witness: USDC, ctx: &mut TxContext) {
        transfer::share_object(coin::create_currency(witness, 9, ctx));
    }

    public entry fun mint_me(cap: &mut  TreasuryCap<USDC>, amount: u64, ctx: &mut TxContext) {
        let coin_usdt = coin::mint(cap, amount, ctx);
        transfer::transfer(coin_usdt, sender(ctx));
    }

    public entry fun mint_to(cap: &mut  TreasuryCap<USDC>, amount: u64, to: address, ctx: &mut TxContext) {
        let coin_usdt = coin::mint(cap, amount, ctx);
        transfer::transfer(coin_usdt, to);
    }

    //
    // public entry fun mint_and_transfer<T>(
    //     c: &mut TreasuryCap<T>, amount: u64, recipient: address, ctx: &mut TxContext
    // ) {
    //     transfer::transfer(mint(c, amount, ctx), recipient)
    // }
}
