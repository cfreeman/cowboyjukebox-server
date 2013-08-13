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
class InstrumentsController < ApplicationController
  def all
    respond_to do |format|
      format.any {render :json => Instrument.all}
    end
  end

  def clear
    Instrument.delete_all
  end

  def update
    Instrument.update(params[:imei], params[:lat], params[:lon])

    respond_to do |format|
      format.any {render :json => Instrument.other_instruments(params[:imei])}
    end
  end

  def new
    i = Instrument.where('imei = ?', params[:imei]).first_or_create
    i.imei = params[:imei]
    i.slat = params[:slat]
    i.slon = params[:slon]
    i.lat = params[:slat]
    i.lon = params[:slon]
    i.save

    respond_to do |format|
      format.any {render :json => i}
    end
  end

  def remove
    Instrument.where('imei = ?', params[:imei]).delete_all

    respond_to do |format|
      format.any {render :json => params[:imei]}
    end
  end
end
