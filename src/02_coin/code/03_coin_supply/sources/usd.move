module coin_demo::usd {
    use std::option;
    use sui::balance;
    use sui::balance::Supply;
    use sui::coin;
    use sui::coin::Coin;
    use sui::object;
    use sui::object::UID;
    use sui::transfer;
    use sui::tx_context::{TxContext, sender};


    const ErrNotLt100: u64 = 0x0001;


    struct USD has drop {}


    struct USDSupply has key {
        id: UID,
        supply: Supply<USD>
    }

    struct AdminCap has key, store {
        id: UID
    }


    struct USDMintCap has key, store {
        id: UID
    }


    fun init(witness: USD, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"USD", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        let supply = coin::treasury_into_supply(treasury);
        transfer::share_object(USDSupply {
            id: object::new(ctx),
            supply
        });

        transfer::public_transfer(AdminCap { id: object::new(ctx) }, sender(ctx));
    }


    public fun give_cap(_: AdminCap, to: address, ctx: &mut TxContext) {
        transfer::public_transfer(USDMintCap {
            id: object::new(ctx)
        }, to);
    }


    public fun mint(usd: &mut USDSupply, amount: u64, ctx: &mut TxContext): Coin<USD> {
        assert!(amount < 100, ErrNotLt100);
        let usdBalance = balance::increase_supply(&mut usd.supply, amount);
        coin::from_balance(usdBalance, ctx)
    }



    public fun mint_cap(_: USDMintCap, usd: &mut USDSupply, amount: u64, ctx: &mut TxContext): Coin<USD> {
        let usdBalance = balance::increase_supply(&mut usd.supply, amount);
        coin::from_balance(usdBalance, ctx)
    }
}