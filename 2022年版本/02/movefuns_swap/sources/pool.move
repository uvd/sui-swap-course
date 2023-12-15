module movefuns_swap::pool {
    use movefuns_swap::events;
    use sui::balance::{Self, Balance, Supply};
    use sui::coin::{Self, Coin};
    use sui::object::{Self, UID, ID};
    use sui::transfer;
    use sui::tx_context::{TxContext, sender};

    struct LPCoin<phantom CoinX, phantom CoinY>   has drop {}

    struct Pool<phantom CoinX, phantom CoinY> has key {
        id: UID,
        coin_x: Balance<CoinX>,
        coin_y: Balance<CoinY>,
        lp_coin: Supply<LPCoin<CoinX, CoinY>>
    }

    public fun create_pool<CoinX, CoinY>(ctx: &mut TxContext): ID {
        let pool = Pool<CoinX, CoinY> {
            id: object::new(ctx),
            coin_x: balance::zero(),
            coin_y: balance::zero(),
            lp_coin: balance::create_supply(LPCoin {})
        };
        let id = object::id(&pool);
        transfer::share_object(pool);
        events::emit_create<CoinX, CoinY>(sender(ctx));
        id
    }


    /// 1 : 1 usdc usdt
    public fun add_pool<CoinX, CoinY>(pool: &mut Pool<CoinX, CoinY>,
                                      coin_x: Coin<CoinX>,
                                      coin_y: Coin<CoinY>,
                                      ctx: &mut TxContext):
    Coin<LPCoin<CoinX, CoinY>>
    {
        let coin_x_value = coin::value(&coin_x);
        let coin_y_value = coin::value(&coin_y);

        coin::put(&mut pool.coin_x, coin_x);
        coin::put(&mut pool.coin_y, coin_y);
        let balance_ = balance::increase_supply(&mut pool.lp_coin, coin_x_value + coin_y_value);
        coin::from_balance(balance_, ctx)
    }


    public fun remove_pool<CoinX, CoinY>(pool: &mut Pool<CoinX, CoinY>, lp: Coin<LPCoin<CoinX, CoinY>>, amount_x: u64, amount_y: u64, ctx: &mut TxContext)
    : (Coin<CoinX>, Coin<CoinY>, Coin<LPCoin<CoinX, CoinY>>)
    {
        let coin_x = coin::take(&mut pool.coin_x, amount_x, ctx);
        let coin_y = coin::take(&mut pool.coin_y, amount_y, ctx);
        let balance_lp = coin::into_balance(lp);

        let balance_lp_real = balance::split(&mut balance_lp, amount_x + amount_y);

        balance::decrease_supply(&mut pool.lp_coin, balance_lp_real);
        (coin_x, coin_y, coin::from_balance(balance_lp, ctx))
    }


    public fun swap_x_to_y<CoinX, CoinY>(pool: &mut Pool<CoinX, CoinY>, in: Coin<CoinX>, ctx: &mut TxContext)
    : Coin<CoinY>
    {
        let coin_in_value = coin::value(&in);
        coin::put(&mut pool.coin_x, in);
        coin::take(&mut pool.coin_y, coin_in_value, ctx)
    }


    public fun swap_y_to_x<CoinX, CoinY>(pool: &mut Pool<CoinX, CoinY>, in: Coin<CoinY>, ctx: &mut TxContext)
    : Coin<CoinX>
    {
        let coin_in_value = coin::value(&in);
        coin::put(&mut pool.coin_y, in);
        coin::take(&mut pool.coin_x, coin_in_value, ctx)
    }
}
