module movefuns_swap::flag {
    use std::ascii::into_bytes;
    use std::string::{Self, String};
    use std::type_name::{get, into_string};

    use sui::object::{Self, UID, ID};
    use sui::table::{Self, Table};
    use sui::transfer;
    use sui::tx_context::TxContext;

    friend movefuns_swap::swap;

    struct Flag has key {
        id: UID,
        pools: Table<String, ID>
    }

    fun init(ctx: &mut TxContext) {
        let table_pools = table::new<String, ID>(ctx);
        let flag = Flag {
            id: object::new(ctx),
            pools: table_pools,
        };
        transfer::share_object(flag);
    }


    /// X-Y
    public(friend) fun add<CoinX, CoinY>(flag: &mut Flag, id: ID) {
        table::add(&mut flag.pools, get_name_X_Y<CoinX, CoinY>(), id);
    }

    public(friend) fun exists_x_y<CoinX, CoinY>(flag: &mut Flag): bool {
        table::contains(&flag.pools, get_name_X_Y<CoinX, CoinY>())
    }

    public fun get_name_X_Y<CoinX, CoinY>(): String {
        let namex = get_name<CoinX>();
        let namey = get_name<CoinX>();

        string::append(&mut namex, string::utf8(b"-"));
        string::append(&mut namex, namey);

        namex
    }


    public fun get_name<Coin>(): String {
        let name = get<Coin>();
        let str = string::utf8(b"");
        string::append_utf8(&mut str, into_bytes(into_string(name)));
        str
    }
}
