module movefuns_swap::swap {
    use movefuns_swap::flag::{Self, Flag};
    use movefuns_swap::pool::{Self, Pool, LPCoin};
    use movefuns_swap::comparator::{less_than};
    use sui::coin::{Self, Coin};
    use sui::pay;
    use sui::transfer;
    use sui::tx_context::{TxContext, sender};
    use std::type_name;
    
    const ErrPoolExists: u64 = 1001;
    const ErrWrongTokenOrder: u64 = 1002;

    public entry fun create_pool<CoinX, CoinY>(flag: &mut Flag, ctx: &mut TxContext) {
        assert!(is_type_in_order<CoinX, CoinY>(), ErrWrongTokenOrder);
        assert!(!flag::exists_x_y<CoinX, CoinY>(flag), ErrPoolExists);
        let id = pool::create_pool<CoinX, CoinY>(ctx);
        flag::add<CoinX, CoinY>(flag, id);
    }
    
    /// Returns true if typeName of x is smaller than y, otherwise false
    fun is_type_in_order<X, Y>(): bool {
        let xType = type_name::borrow_string( &type_name::get<X>());
        let yType = type_name::borrow_string( &type_name::get<Y>());
        less_than(xType, yType)
    }
    

    public entry fun add_pool<CoinX, CoinY>(
        pool: &mut Pool<CoinX, CoinY>,
        coin_x_vec: vector<Coin<CoinX>>,
        coin_y_vec: vector<Coin<CoinY>>,
        amount_x: u64,
        amount_y: u64,
        ctx: &mut TxContext) {
        let coin_x = coin::zero<CoinX>(ctx);
        let coin_y = coin::zero<CoinY>(ctx);

        pay::join_vec<CoinX>(&mut coin_x, coin_x_vec);
        pay::join_vec<CoinY>(&mut coin_y, coin_y_vec);

        let coin_real_x = coin::split(&mut coin_x, amount_x, ctx);
        let coin_real_y = coin::split(&mut coin_y, amount_y, ctx);

        let lp_coin = pool::add_pool<CoinX, CoinY>(pool, coin_real_x, coin_real_y, ctx);

        let sender_addres = sender(ctx);
        transfer::transfer(coin_x, sender_addres);
        transfer::transfer(coin_y, sender_addres);
        transfer::transfer(lp_coin, sender_addres);
    }


    public entry fun remove_pool<CoinX, CoinY>(pool: &mut Pool<CoinX, CoinY>,
                                               lp_coin_vec: vector<Coin<LPCoin<CoinX, CoinY>>>,
                                               amount_x: u64, amount_y: u64,
                                               ctx: &mut TxContext) {
        let coin_lp = coin::zero<LPCoin<CoinX, CoinY>>(ctx);
        pay::join_vec(&mut coin_lp, lp_coin_vec);

        let (coin_x, coin_y, coin_lp) = pool::remove_pool(pool, coin_lp, amount_x, amount_y, ctx);
        let sender_addres = sender(ctx);
        transfer::transfer(coin_x, sender_addres);
        transfer::transfer(coin_y, sender_addres);
        transfer::transfer(coin_lp, sender_addres);
    }


    public entry fun swap_x_to_y<CoinX, CoinY>(pool: &mut Pool<CoinX, CoinY>, coin_x_vec: vector<Coin<CoinX>>, amount: u64, ctx: &mut TxContext) {
        let coin_x = coin::zero<CoinX>(ctx);
        pay::join_vec<CoinX>(&mut coin_x, coin_x_vec);
        let coin_real_x = coin::split(&mut coin_x, amount, ctx);

        let coin_y = pool::swap_x_to_y(pool, coin_real_x, ctx);

        let sender_addres = sender(ctx);
        transfer::transfer(coin_x, sender_addres);
        transfer::transfer(coin_y, sender_addres);
    }


    public entry fun swap_y_to_x<CoinX, CoinY>(pool: &mut Pool<CoinX, CoinY>,
                                               coin_y_vec: vector<Coin<CoinY>>, amount: u64, ctx: &mut TxContext) {
        let coin_y = coin::zero<CoinY>(ctx);
        pay::join_vec<CoinY>(&mut coin_y, coin_y_vec);
        let coin_real_y = coin::split(&mut coin_y, amount, ctx);
        let coin_x = pool::swap_y_to_x(pool, coin_real_y, ctx);
        let sender_addres = sender(ctx);
        transfer::transfer(coin_x, sender_addres);
        transfer::transfer(coin_y, sender_addres);
    }
}
