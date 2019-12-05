class AddPriceCoinIdToPrices < ActiveRecord::Migration[5.2]
  def change
    add_column :prices, :price_coin_id, :integer
    change_column_null :prices, :price_coin_id, false
  end
end
