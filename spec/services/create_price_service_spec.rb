# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreatePriceService, type: :service do
  let(:btc) { Coin.find_by(symbol: :btc) }

  subject { described_class.new(btc.id) }

  describe 'call' do
    context 'fetch successfully' do
      before do
        allow_any_instance_of(FetchService).to receive(:call)
          .and_return(
            last: '1229.80000000',
            bid: '1169.80000000',
            ask: '1272.80000000',
            current_time: '2019-12-02T04:05:06.313320Z'
          )
      end

      it 'should create price' do
        expect { subject.call }.to change { Price.count }.from(0).to(1)
      end
    end

    context 'fetch failed' do
      before do
        allow_any_instance_of(FetchService).to receive(:call)
          .and_raise(CaptureError, 'message')
      end

      it 'should create price' do
        expect { subject.call }.not_to change { Price.count }
      end
    end
  end
end
