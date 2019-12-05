# frozen_string_literal: true

class CoinsController < ApplicationController
  def index
    @coins = CoinListService.new.call
  end

  def show
    @coin = Coin.find(params[:id])

    # TODO: pagination could use gem kaminari
    @prices = @coin.prices.order(created_at: :desc)
  end

  def capture
    coin = Coin.find(params[:id])

    CreatePriceService.new(coin.id).call

    redirect_to coins_path
  end
end
