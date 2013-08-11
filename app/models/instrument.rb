class Instrument < ActiveRecord::Base

  def self.update(imei, lat, lon)
    i = Instrument.where('imei = ?', imei).first
    unless i.nil?
      i.lat = lat
      i.lon = lon

      i.save
    end
  end

  def self.other_instruments(imei)
    Instrument.where('imei != ?', imei)
  end
end
