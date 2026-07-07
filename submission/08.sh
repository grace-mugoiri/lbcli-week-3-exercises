# What is the receiver's address in this partially signed transaction?
ALLET_NAME="builderswallet"

bitcoin-cli -regtest loadwallet "$WALLET_NAME" 2>/dev/null || \
bitcoin-cli -regtest createwallet "$WALLET_NAME" 2>/dev/null

transaction=cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA
DECODED=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" decodepsbt "$transaction")
RECEIVER_ADDRESS=$(echo "$DECODED" | jq -r '.tx.vout[0].scriptPubKey.addresses[0]')
echo "$RECEIVER_ADDRESS"