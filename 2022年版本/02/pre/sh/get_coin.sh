
  - ID: 0x6cee3e24738c458523b723daef59bde654f2258c , Owner: Shared
  - ID: 0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4 , Owner: Immutable





 Created Objects:
   - ID: 0x33a83a5ab82e172bef55fed714bea17d821b8531 , Owner: Immutable
   - ID: 0x490e13105935bf4d146c6d1c378ebdff12c05482 , Owner: Account Address ( 0x1bdf11d6e2e852b49cd331213d6658ae64dba7a7 )


# USDC every one can get
sui client call  --package 0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4 --module usdc --function mint_me --gas-budget 10000 \
 --args 0x6cee3e24738c458523b723daef59bde654f2258c 100000000

# USDT
sui client call  --package 0x33a83a5ab82e172bef55fed714bea17d821b8531 --module usdt --function mint_me --gas-budget 10000 \
 --args 0x490e13105935bf4d146c6d1c378ebdff12c05482 100000000