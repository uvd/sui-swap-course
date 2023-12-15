module pre::usdc {
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    const Decimals: u8 = 9;

    struct USDC  has drop {}

    fun init(witness: USDC, ctx: &mut TxContext) {
        let cap = coin::create_currency(witness, Decimals, ctx);
        transfer::transfer(cap,tx_context::sender(ctx))
    }

    public entry fun mint_me(cap: &mut TreasuryCap<USDC>, amount: u64, ctx: &mut TxContext) {
        let minted = coin::mint(cap, amount, ctx);
        transfer::transfer(minted, tx_context::sender(ctx));
    }


    public entry fun mint_to(cap: &mut TreasuryCap<USDC>,to:address, amount: u64, ctx: &mut TxContext) {
        let minted = coin::mint(cap, amount, ctx);
        transfer::transfer(minted, to);
    }


}
