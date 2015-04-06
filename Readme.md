### Counterparty Token Checker

Checks for available tokens from counterparty API, fill a words.txt wordlist with the token names you want to check!



### Usage:

open words.txt and put there all the words you want to check, separated by space, tab or newline (\n)

run

```sh
ruby counterparty_token_checker.rb
```





note: discards also words that starts with A, that are non-valid custom tokens


have fun!



--- 

It's all about this curl:

```
curl -s -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '
  {
      "jsonrpc": "2.0",
      "id": 0,
      "method": "proxy_to_counterpartyd",
      "params": {
          "method": "get_issuances",
          "params": {
              "filters": {
                  "field": "asset",
                  "op": "==",
                  "value": "TOKEN"
              },
              "status": "valid"
          }
      }
  }' https://cw02.counterwallet.io/_api
```



---

**Extra infos about token creation**


How to register a Counterparty token, full process:

- Create a Counterparty Wallet
- Send some BTC in your wallet (a BTC fee of ~0.00025 btc, included tx costs, is needed for every token creation)
- Go to Poloniex or to a similar exchange
- Deposit some BTC, buy XCP (remember that every token you create costs 0.5XCP), withdraw them in Counterparty
- In Counterparty do: `Address Action > Create Token` 
