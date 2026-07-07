# Create a 2-of-3 P2SH multisig address from the public keys below:

WALLET_NAME="builderswallet"
bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" loadwallet "$WALLET_NAME" 2>/dev/null || \
    bitcoin-cli -regtest createwallet "$WALLET_NAME" 2>/dev/null
PUBLEYS='[
"024bc198a88b69316952414af34105613c3617561a433a229100a0966cd631dd3d",
"035e11024a7fa1e0ca537e0e76b15c1631486f6611c7d8187aea8f6c1ae5d30617",
"03ce11c7b563c3d7fae916351f234eac5089ad2e42fa9e29a94ee944e00c880c66"
]'

MULTISIG_ADDRESS=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" createmultisig 2 "$PUBLEYS" | jq -r '.address')
echo "$MULTISIG_ADDRESS"