module swap::swap {
    use sui::balance;
    use sui::balance::Balance;
    use sui::coin;
    use sui::coin::Coin;
    use sui::object::UID;
    use sui::tx_context::TxContext;
    use coin_owner::usd::USD;
    use coin_owner::rmb::RMB;
    struct Bank has key {
        id: UID,
        rmb: Balance<USD>,
        usd:Balance<RMB>
    }







    public  fun swap_rmb_usd(bank: &mut Bank,rmb :Coin<RMB>,ctx:&mut TxContext):Coin<USD>{
        ///
        balance::join(&mut bank.rmb, coin::into_balance(rmb));
        let usd_balance = balance::split(&mut bank.usd, 1000);
        coin::from_balance(usd_balance, ctx)
    }
}