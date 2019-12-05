# frozen_string_literal: true

class Coin < ApplicationRecord
  has_many :price_sources
  has_many :prices
end
