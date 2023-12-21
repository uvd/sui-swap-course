module coin_lock::lock_coin {
    use std::option;
    use sui::balance::Balance;
    use sui::coin;
    use sui::coin::{TreasuryCap, balance};
    use sui::object;
    use sui::object::{UID, id};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};


    const ErrNotRelease :u64 = 0x00001;

    struct USD has drop {}


    struct LockCoin has key {
        id: UID,
        balance: Balance<USD>,
        release_time: u64
    }


    fun init(witness: USD, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"USD", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }


    public entry fun mint_and_lock(
        treasury: &mut TreasuryCap<USD>,
        amount: u64,
        lock_day: u64,
        to: address,
        ctx: &mut TxContext
    ) {
        let coin = coin::mint(treasury, amount, ctx);
        let current_ms = tx_context::epoch_timestamp_ms(ctx);

        let lock = LockCoin {
            id: object::new(ctx),
            balance: coin::into_balance(coin),
            release_time: current_ms + (lock_day * 24 * 3600 * 1000)
        };

        transfer::transfer(lock, to);
    }

    public entry fun unlock_coin(lock_coin: LockCoin, ctx: &mut TxContext) {

        //

        let current_ms = tx_context::epoch_timestamp_ms(ctx);
        assert!(current_ms > lock_coin.release_time,ErrNotRelease);
        let LockCoin  { id,balance,release_time:_ }= lock_coin;
        object::delete(id);
    }
}
