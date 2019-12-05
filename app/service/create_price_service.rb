# frozen_string_literal: true

class CreatePriceService
  attr_reader :price_sources

  def initialize(coin_id)
    coin = Coin.find(coin_id)
    @price_sources = coin.price_sources
  end

  def call
    price_sources.map do |price_source|
      create_price_by_source(price_source)
    end
  end

  private

  def create_price_by_source(price_source)
    fetch_service = FetchService.new price_source

    new_price_hash = fetch_service.call

    Price.create!(
      coin_id: price_source.coin_id,
      price_coin_id: price_source.price_coin_id,
      last: new_price_hash[:last],
      bid: new_price_hash[:bid],
      ask: new_price_hash[:ask],
      created_at: new_price_hash[:timestamp]
    )
  rescue CaptureError => e
    Rails.logger.error("Failed to fetch price: #{e.message}")
  end
end
