# Create a native segwit address and get the public key from the address.
WALLET_NAME="builderswallet"
bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" loadwallet "$WALLET_NAME" 2>/dev/null || \
    bitcoin-cli -regtest createwallet "$WALLET_NAME" 2>/dev/null

ADDRESS=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" getnewaddress "" "bech32")

ADDRESS_INFO=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" getaddressinfo $ADDRESS)

PUBLIC_KEY=$(echo $ADDRESS_INFO | jq -r '.pubkey')
echo "$PUBLIC_KEY"