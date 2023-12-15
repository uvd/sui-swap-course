
sui client call  --package 0x2 --module coin --function join --gas-budget 10000 \
--type-args 0x2::sui::SUI \
--args 0x2b34e713e919ad195b0292cee061babf73ce96af  0x5866dc8e1bc161185089f64aba0706e95db57e2a


sui client call  --package 0x2 --module pay --function join_vec --gas-budget 10000 \
--type-args 0x2::sui::SUI \
--args 0x2b34e713e919ad195b0292cee061babf73ce96af    '["0x598b129e04ccd0122d720a675d382ace518f1742","0xd2e2a95963efd0ea91b1437cdfb1543e97884c18"]'