module movefuns_swap::enents {

    use std::string::String;

    use movefuns_swap::flag::get_name;
    use sui::event::emit;

    friend movefuns_swap::pool;


    struct CreatePoolEvent {
        sender: address,
        coin_x: String,
        coin_y: String,
    }

    public(friend) fun emit_create<CoinX, CoinY>(sender: address) {
        emit(&CreatePoolEvent {
            sender,
            coin_x: get_name<CoinX>(),
            coin_y: get_name<CoinY>()
        });
    }
}
