# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :coins, force: :cascade do |t|
      t.string 'name', null: false
      t.string 'symbol', null: false
      t.integer 'scale', default: 8, null: false
    end

    create_table :prices do |t|
      t.integer 'coin_id', null: false
      t.decimal 'last', precision: 32, scale: 16, null: false
      t.decimal 'bid', precision: 32, scale: 16, null: false
      t.decimal 'ask', precision: 32, scale: 16, null: false
      t.references :price_source, foreigh_key: true

      t.timestamps
    end

    Coin.create!([{ symbol: 'eth', name: 'Ethereum', scale: 8 },
                  { symbol: 'btc', name: 'Bitcoin', scale: 8 },
                  { symbol: 'aud', name: 'Australian Dollar', scale: 2 }])
  end
end
