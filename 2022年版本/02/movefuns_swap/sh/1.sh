sui client publish --gas-budget 10000


#Created Objects:
#- ID: 0x6d3e77b93f9fcdcfbd48bd4d4f2423573e193141 , Owner: Immutable

sui client call  --package 0x6d3e77b93f9fcdcfbd48bd4d4f2423573e193141 --module swap --function create_pool --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT

#  0x4d3474d06b0ca4631d1e681a1daf2386970d7c7c , Owner: Shared
#  0x0294b212456553d16f03be823b43d17d21bdf54f


sui client call  --package 0x6d3e77b93f9fcdcfbd48bd4d4f2423573e193141 --module swap --function add_pool --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0x4d3474d06b0ca4631d1e681a1daf2386970d7c7c '["0xd232763fd1d9d810140a35c5647b331cddd69e3e","0xfc8571a2ef6cb319fb85c4a95a2a13898699aa99"]' \
'["0x4a2ff9f2216c8a7d201206d70dc620d60da38f25"]'  10050 10000



sui client call  --package 0x6d3e77b93f9fcdcfbd48bd4d4f2423573e193141 --module swap --function swap_x_to_y --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0x4d3474d06b0ca4631d1e681a1daf2386970d7c7c '["0xb54c6dbd4a7685a50deef4977a863120c5dc0f18"]' \
  100


sui client call  --package 0x6d3e77b93f9fcdcfbd48bd4d4f2423573e193141 --module swap --function swap_y_to_x --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0x4d3474d06b0ca4631d1e681a1daf2386970d7c7c '["0xd40db8e99267791fa6a3b9a3f4862c43c56c03d4"]' \
  100


sui client call  --package 0x6d3e77b93f9fcdcfbd48bd4d4f2423573e193141 --module swap --function remove_pool --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0x4d3474d06b0ca4631d1e681a1daf2386970d7c7c '["0x240dc08d1950875bc4edd8862d08d1c7860d54fc"]' \
  150  250



