# frozen_string_literal: true

class CoinListService
  def call
    coins = Coin.crypto.order(symbol: :asc)

    coins.inject([]) do |coin_list, coin|
      price = coin.prices.order(created_at: :desc).first
      coin_with_latest_price = {
        id: coin.id,
        name: coin.name,
        symbol: coin.symbol,
        last: price&.last || 0,
        bid: price&.bid || 0,
        ask: price&.ask || 0
      }
      coin_list << coin_with_latest_price
    end
  end
end
