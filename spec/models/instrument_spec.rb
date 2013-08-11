require 'spec_helper'

describe Instrument do
  after(:each) do
    clean_after_test
  end

  it 'should be able to select all other instruments' do
    a = FactoryGirl.create(:instrument, :imei => 'a')
    b = FactoryGirl.create(:instrument, :imei => 'b')
    c = FactoryGirl.create(:instrument, :imei => 'c')

    Instrument.other_instruments('a').should eq [b, c]
  end
end
