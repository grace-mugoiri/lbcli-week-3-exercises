# Create a native segwit address and get the public key from the address.
address=$(bitcoin-cli -regtest getnewaddress address_type=p2sh-segwit)
pubkey=$(bitcoin-cli -regtest -rpcwallet=builderswallet validateaddress $address | jq -r '.pubkey')