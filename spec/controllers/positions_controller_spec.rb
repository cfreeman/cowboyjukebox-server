require 'spec_helper'

describe PositionsController do
  after(:each) do
    clean_after_test
  end

  describe 'POST update' do
    it 'should be able to update the position of a device' do
      get :update, :imei => 'a', :lat => 1, :lon => 1

      Position.count.should eq 1
      Position.last.imei.should eq 'a'
      Position.last.lat.should eq 1.0
      Position.last.lon.should eq 1.0
    end
  end

  describe 'GET clear' do
    it 'should be able to clear all the stored positions' do
      a = FactoryGirl.create(:position)
      b = FactoryGirl.create(:position)

      get :clear
      Position.count.should eq 0
    end
  end

	describe 'GET last' do
    it 'should get the last positions of the devices' do
      a = FactoryGirl.create(:position, :imei => 'a', :lat => 1, :lon => 1)
      b = FactoryGirl.create(:position, :imei => 'b', :lat => 2, :lon => 2)

      get :last
      response.body.should eq [{:id => a.id, :imei => a.imei, :lat => a.lat, :lon => a.lon},
                               {:id => b.id, :imei => b.imei, :lat => b.lat, :lon => b.lon}].to_json
    end
  end
end
