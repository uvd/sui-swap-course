module swap::swap {
    use sui::object::UID;
    use sui::transfer;

    struct Bank has key {
        id: UID,
        rmb: u64
    }

    public entry fun (){

    }
}