# frozen_string_literal: true

class InitPriceSources < ActiveRecord::Migration[5.2]
  def change
    btc_id = Coin.find_by(symbol: :btc).id
    eth_id = Coin.find_by(symbol: :eth).id
    aud_id = Coin.find_by(symbol: :aud).id

    PriceSource.create!(coin_id: btc_id, price_coin_id: aud_id, name: 'CoinJar',
                        url: 'https://data.exchange.coinjar.com/products/BTCAUD/ticker',
                        last: 'last', ask: 'ask', bid: 'bid', timestamp: 'current_time')

    PriceSource.create!(coin_id: eth_id, price_coin_id: aud_id, name: 'CoinJar',
                        url: 'https://data.exchange.coinjar.com/products/ETHAUD/ticker',
                        last: 'last', ask: 'ask', bid: 'bid', timestamp: 'current_time')
  end
end
