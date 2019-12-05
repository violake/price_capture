# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchService, type: :service do
  let(:btc) { Coin.find_by(symbol: :btc) }
  let(:btc_source) { PriceSource.find_by!(coin_id: btc.id) }

  subject { described_class.new(btc_source) }

  describe 'call' do
    context 'remote api call successfully' do
      before do
        stub_request(:get, btc_source.url)
          .to_return(status: 200, body: {
            volume_24h: '789.000000000',
            volume: '276.900000000',
            transition_time: '2019-12-02T07:50:00Z',
            status: 'continuous',
            session: 3370,
            prev_close: '571.50000000',
            last: '1229.80000000',
            current_time: '2019-12-02T04:05:06.313320Z',
            bid: '1169.80000000',
            ask: '1272.80000000'
          }.to_json)
      end

      it 'should get the json response' do
        expect(subject.call).to eq(
          last: '1229.80000000',
          bid: '1169.80000000',
          ask: '1272.80000000',
          current_time: '2019-12-02T04:05:06.313320Z'
        )
      end
    end

    context 'api call failed' do
      before do
        stub_request(:get, btc_source.url)
          .to_return(status: 400, body: {
            errors: 'something wrong'
          }.to_json)
      end

      it 'should retry 5 times' do
        expect(Rails.logger).to receive(:warn).exactly(5).times
        expect { subject.call }.to raise_error(CaptureError, '400 Bad Request')
      end
    end
  end
end
