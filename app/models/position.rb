class Position < ActiveRecord::Base
  validates :imei, :presence => true
  validates :lat, :presence => true
  validates :lon, :presence => true

	def self.get_last()
		devices = Position.select('max(id) AS id, imei').group('imei')
		Position.select('id, imei, lat, lon').where('id IN (?)', devices).load
	end
end
