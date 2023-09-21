module sacabam::scb {
    use std::option;
    use sui::tx_context::TxContext;
    use sui::coin;
    use sui::url;
    use sui::transfer;

    struct SCB has drop {}

    fun init(witness: SCB, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency(
            witness, 
            5,
            b"SCB",
            b"Sacabam",
            b"The best meme token that Sui has ever seen",
            option::some(url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigdxf7biamfqdifni73ca7twmaakkkgylo47ovekl4qjmduu3qaxi")),
            ctx
        );

        //Init minting
        coin::mint_and_transfer<SCB>(&mut treasury_cap, 4700000000000000000, @0xe83f22bc0f57d7553986655751548435e8409c262bae2bf52a0951a2bb10f4e9, ctx);

        //Freeze treasury cap and metadata
        transfer::public_freeze_object(metadata);
        transfer::public_freeze_object(treasury_cap);
    }
}