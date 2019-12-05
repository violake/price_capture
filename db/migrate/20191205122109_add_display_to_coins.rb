class AddDisplayToCoins < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :display, :boolean, default: false
    Coin.reset_column_information
    Coin.find_by(symbol: :btc).update display: true
    Coin.find_by(symbol: :eth).update display: true
  end
end
