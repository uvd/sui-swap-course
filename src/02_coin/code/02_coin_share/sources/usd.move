module coin_share::usd {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{TxContext};

    struct USD has drop {}

    fun init(witness: USD, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"USD", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);


        //
        transfer::public_share_object(treasury);
    }
}