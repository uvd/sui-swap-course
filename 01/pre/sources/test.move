module pre::test {

    use sui::object::UID;

    #[test_only]
    use sui::bag;
    #[test_only]
    use sui::object;
    #[test_only]
    use sui::test_scenario;
    #[test_only]
    use sui::transfer;
    #[test_only]
    use sui::tx_context::sender;
    #[test_only]
    use sui::object_bag;
    #[test_only]
    use std::debug;

    #[test_only]


    struct T1 has store,key {}

    struct T2 has store {}

    struct Obj  has key, store {
        id: UID
    }

    // store  key drop  copy

    struct Obj1 has key{
        id:UID,
    }

    struct O2  has key, store {
        id: UID
    }

    #[test]
    fun test() {
        let sce = test_scenario::begin(@pre);
        let ctx = test_scenario::ctx(&mut sce);

        // let table =   table::new<String,String>(ctx);

        let bag = bag::new(ctx);
        bag::add(&mut bag, b"11", 11u32);
        bag::add(&mut bag, 11, T1 {});
        bag::add(&mut bag, 12, T1{});
        transfer::transfer(bag, sender(ctx));


        let obj_bag = object_bag::new(ctx);
        object_bag::add(&mut obj_bag,1,Obj{
            id:object::new(ctx)
        });



        debug::print(&obj_bag);


       // object_bag::add(&mut obj_bag,1,T1{});

        transfer::transfer(obj_bag, sender(ctx));
        test_scenario::end(sce);
    }
}
