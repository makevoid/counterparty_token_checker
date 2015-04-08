#!/usr/bin/env ruby   
#                      
# Usage:
#
# open words.txt and put there all the words you want to check, separated by space, tab or newline (\n)
# run ruby counterparty_token_checker.rb
#
# note: discards also words that starts with A, that are non-valid custom tokens

require 'counterparty_ruby'

Counterparty.connection = Counterparty::Connection.new 4000, 'counterparty', '1234', 'xcp-dev.vennd.io'

def curl(name)
  Counterparty::Issuance.find filters: [ {field: 'asset', op: '==', value: name.upcase} ], status: 'valid'
end

def find(name)
  curl(name).length > 0
end

def load_words
  words = File.read "./words.txt"
  words = words.strip.split(/\s+/)
  words.reject!{ |w| w[0].upcase == "A" || w.size < 4  }
  words
end

load_words.each{|word| puts "#{word.upcase} found" if find word }
