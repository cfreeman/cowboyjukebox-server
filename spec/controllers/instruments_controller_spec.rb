#
# Copyright (c) Clinton Freeman 2013
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
# NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
require 'spec_helper'

describe InstrumentsController do
  after(:each) do
    clean_after_test
  end

  describe 'GET all' do
    it 'should be able to update the position of a device' do
      a = FactoryGirl.create(:instrument, :imei => 'a')
      b = FactoryGirl.create(:instrument, :imei => 'b')
      get :all

      response.body.should eq [a,b].to_json
    end
  end

  describe 'GET clear' do
    it 'should be able to clear all the instruments' do
      a = FactoryGirl.create(:instrument, :imei => 'a')
      b = FactoryGirl.create(:instrument, :imei => 'b')
      get :clear

      Instrument.count.should eq 0
    end
  end

  describe 'GET update' do
    it 'should be able to update an existing instrument' do
      a = FactoryGirl.create(:instrument, :imei => 'a')
      get :update, :imei => 'a', :lat => 1.0, :lon => 1.0

      Instrument.count.should eq 1
      Instrument.first.imei.should eq 'a'
      Instrument.first.slat.should eq a.slat
      Instrument.first.slon.should eq a.slon
      Instrument.first.lat.should eq 1.0
      Instrument.first.lon.should eq 1.0
    end
  end

  describe 'GET new' do
    it 'should be able to create a new instrument' do
      get :new, :imei => 'a', :slat => 1.0, :slon => 1.0

      Instrument.count.should eq 1
      Instrument.first.imei.should eq 'a'
      Instrument.first.slat.should eq 1.0
      Instrument.first.slon.should eq 1.0
      Instrument.first.lat.should eq 1.0
      Instrument.first.lon.should eq 1.0
    end
  end

  it 'should be able to re-init an existing instrument' do
    a = FactoryGirl.create(:instrument, :imei => 'a')
    get :new, :imei => 'a', :slat => 1.0, :slon => 1.0

    Instrument.count.should eq 1
    Instrument.first.imei.should eq 'a'
    Instrument.first.slat.should eq 1.0
    Instrument.first.slon.should eq 1.0
    Instrument.first.lat.should eq 1.0
    Instrument.first.lon.should eq 1.0
  end

  it 'should be able to remove an existing instrument' do
    a = FactoryGirl.create(:instrument, :imei => 'a')
    get :remove, :imei => 'a'

    Instrument.count.should eq 0
  end
end
