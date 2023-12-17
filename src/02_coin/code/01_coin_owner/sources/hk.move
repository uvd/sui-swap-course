module coin_demo::hk {

    use sui::coin::create_currency;
    use sui::tx_context::{TxContext, sender};
    use std::option;
    use sui::transfer;

    struct HK has drop {}
    const SendAddress: address = @0x01;
    fun init(hk: HK, ctx: &mut TxContext) {


        let (treasury_cap, coin_metadata) = create_currency(hk,
            8,
            b"HK",
            b"HK  made in hongkong",
            b"HK  made in hongkong",
            option::none(),
            ctx);

        transfer::public_freeze_object(coin_metadata);

        let my_address = sender(ctx);
        transfer::public_transfer(treasury_cap, my_address)
    }
}
