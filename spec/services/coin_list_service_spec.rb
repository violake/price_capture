# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoinListService, type: :service do
  subject { described_class.new }

  describe 'call' do
    context 'has price' do
      let(:btc) { Coin.find_by(symbol: :btc) }
      let(:aud) { Coin.find_by(symbol: :aud) }

      before do
        Price.create!(
          coin_id: btc.id,
          price_coin_id: aud.id,
          last: 123,
          bid: 120,
          ask: 128,
          created_at: '2019-12-02T04:05:06.313320Z'
        )
        Price.create!(
          coin_id: btc.id,
          price_coin_id: aud.id,
          last: 125,
          bid: 122,
          ask: 138,
          created_at: '2019-12-04T04:05:06.313320Z'
        )
      end

      it 'should get latest price' do
        coins = subject.call
        expect(coins).to include(
          id: 2,
          name: 'Bitcoin',
          symbol: 'btc',
          last: 125,
          bid: 122,
          ask: 138
        )
      end
    end

    context 'no price' do
      it 'should get price all 0' do
        coins = subject.call
        expect(coins).to include(
          id: 2,
          name: 'Bitcoin',
          symbol: 'btc',
          last: 0,
          bid: 0,
          ask: 0
        )
      end
    end
  end
end
