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
