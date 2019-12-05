# frozen_string_literal: true

class FetchService
  attr_reader :price_source

  def initialize(price_source)
    @price_source = price_source
  end

  def call
    retry_on_error(5) do
      response = RestClient.get price_source.url
      JSON.parse(response.body, symbolize_names: true)
          .select { |key| price_keys.include?(key.to_s) }
    end
  end

  private

  def price_keys
    [
      price_source.last,
      price_source.bid,
      price_source.ask,
      price_source.timestamp
    ]
  end

  def retry_on_error(retry_count)
    yield
  rescue RestClient::ExceptionWithResponse => e
    if retry_count.positive?
      sleep 0.1
      retry_count -= 1
      Rails.logger.warn("Retry fetch price (#{retry_count} retry left) ..")
      retry
    else
      raise CaptureError, e.message
    end
  end
end
