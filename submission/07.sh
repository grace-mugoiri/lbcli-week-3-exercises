# What is the total output value of this partially signed transaction in satoshis
WALLET_NAME="builderswallet"

bitcoin-cli -regtest loadwallet "$WALLET_NAME" 2>/dev/null || \
bitcoin-cli -regtest createwallet "$WALLET_NAME" 2>/dev/null

transaction=cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA
DECODED=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" decodepsbt "$transaction")
TOTAL_OUTPUT_VALUE=$(echo "$DECODED" | jq -r '[.tx.vout[].value] | add * 100000000 | round')
echo "$TOTAL_OUTPUT_VALUE"