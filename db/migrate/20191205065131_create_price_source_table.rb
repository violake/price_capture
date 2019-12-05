# frozen_string_literal: true

class CreatePriceSourceTable < ActiveRecord::Migration[5.2]
  def change
    create_table :price_sources, force: :cascade do |t|
      t.integer 'price_coin_id', null: false
      t.string 'name', null: false
      t.string 'url', null: false
      t.string 'last', null: false
      t.string 'ask', null: false
      t.string 'bid', null: false
      t.string 'timestamp', null: false

      t.references :coin, foreigh_key: true
    end
  end
end
