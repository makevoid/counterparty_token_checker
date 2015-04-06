# Usage:
#
# open words.txt and put there all the words you want to check, separated by space, tab or newline (\n)
# run ruby counterparty_token_checker.rb
#
#
#
# note: discards also words that starts with A, that are non-valid custom tokens

output_found = '{"jsonrpc": "2.0", "result": [], "id": 0}'

curl = -> (name) do %Q( curl -s -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d '
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
                  "value": "#{name.upcase}"
              },
              "status": "valid"
          }
      }
  }' https://cw02.counterwallet.io/_api )
end

find = -> (name) do
  `#{curl.(name)}`.strip == output_found
end


def load_words
  words = File.read "./words.txt"
  words = words.strip.split(/\s+/)
  words.reject!{ |w| w[0].upcase == "A" || w.size < 4  }
  words
end

words = load_words

for word in words
  found = find.(word)
  if found
    puts "#{word.upcase} found"
  end
end
