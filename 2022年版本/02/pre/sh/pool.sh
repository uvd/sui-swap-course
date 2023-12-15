sui client publish --gas-budget 10000

#Created Objects:
#  - ID: 0xab35fc952016da3198bb31ad8cb5db094a94ac7d , Owner: Immutable


sui client call  --package 0xab35fc952016da3198bb31ad8cb5db094a94ac7d --module swap --function create_pool --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT


#pool  ID: 0xc798fc2ba83eca8fc8ce44cd07589fa044b0a1b5 , Owner: Shared


sui client call  --package 0xab35fc952016da3198bb31ad8cb5db094a94ac7d --module swap --function add_pool --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0xc798fc2ba83eca8fc8ce44cd07589fa044b0a1b5 '["0x4e54ffa3396551aa8ac7a01d143275045a33c173"]' '["0x60deccc2a965929b1d3216dad6eec2402eaf70e5"]' 10000 10000


sui client call  --package 0xab35fc952016da3198bb31ad8cb5db094a94ac7d --module swap --function swap_x_y --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0xc798fc2ba83eca8fc8ce44cd07589fa044b0a1b5  100 '["0xc1b9580d6ebd9acf26f850b230a19c7aa3529e57"]'


sui client call  --package 0xab35fc952016da3198bb31ad8cb5db094a94ac7d --module swap --function swap_y_x --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0xc798fc2ba83eca8fc8ce44cd07589fa044b0a1b5   '["0x0eb614ef78c0278c04640b7595771d74fb2803ba","0xcdad6f41474b0941b3c9767b8f932791396c5001"]' 100


sui client call  --package 0xab35fc952016da3198bb31ad8cb5db094a94ac7d --module swap --function remove --gas-budget 10000 \
--type-args  0x9c1a857aec62f16958ca5f7c4f636df60f4a26b4::usdc::USDC 0x33a83a5ab82e172bef55fed714bea17d821b8531::usdt::USDT \
--args 0xc798fc2ba83eca8fc8ce44cd07589fa044b0a1b5   '["0xec9da41b5ff2d877c1edc6de4fd72878c2a0c595"]' 10000 10000

