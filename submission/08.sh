# What is the receiver's address in this partially signed transaction?

WALLET_NAME="builderswallet"

# Load or create the wallet
bitcoin-cli -regtest loadwallet "$WALLET_NAME" 2>/dev/null || \
bitcoin-cli -regtest createwallet "$WALLET_NAME" 2>/dev/null

# PSBT from the exercise
transaction="cHNidP8BAHsCAAAAAhuVpgVRdOxkuC7wW2rvw4800OVxl+QCgezYKHtCYN7GAQAAAAD/////HPTH9wFgyf4iQ2xw4DIDP8t9IjCePWDjhqgs8fXvSIcAAAAAAP////8BigIAAAAAAAAWABTHctb5VULhHvEejvx8emmDCtOKBQAAAAAAAAAA"

# Decode PSBT once and capture JSON
DECODED_JSON=$(bitcoin-cli -regtest -rpcwallet="$WALLET_NAME" decodepsbt "$transaction")

# Try multiple common JSON paths for the output address, across Core versions/shapes
RECEIVER_ADDRESS=$(printf '%s' "$DECODED_JSON" | jq -r '
  (.tx.vout[0].scriptPubKey.address // 
   .tx.vout[0].scriptPubKey.addresses[0] // 
   .outputs[0].address // 
   .vout[0].scriptPubKey.address // 
   .vout[0].scriptPubKey.addresses[0])
')

# Validate we actually found an address
if [[ -z "${RECEIVER_ADDRESS:-}" || "$RECEIVER_ADDRESS" == "null" ]]; then
  echo "Error: failed to extract receiver address from decodepsbt output" >&2
  printf '%s\n' "$DECODED_JSON" >&2
  exit 1
fi

# Print exactly the address, nothing else
printf '%s' "$RECEIVER_ADDRESS"