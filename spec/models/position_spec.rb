require 'spec_helper'

describe Position do
	it 'should return the last location for each imei we are tracking' do
		Timecop.freeze(Time.zone.parse('2012-10-16 08:59:43').utc)
    	a = FactoryGirl.create(:position, :imei => 'a', :lat => 1, :lon => 1)

    	Timecop.freeze(Time.zone.parse('2012-10-16 08:59:44').utc)
    	b = FactoryGirl.create(:position, :imei => 'a', :lat => 2, :lon => 2)
    	c = FactoryGirl.create(:position, :imei => 'b', :lat => 2, :lon => 2)

		Timecop.freeze(Time.zone.parse('2012-10-16 08:59:45').utc)
    	d = FactoryGirl.create(:position, :imei => 'a', :lat => 3, :lon => 3)
    	e = FactoryGirl.create(:position, :imei => 'b', :lat => 3, :lon => 3)

    	Position.get_last().should eq [d, e]
  	end
end