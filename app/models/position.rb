class Position < ActiveRecord::Base
	def self.get_last()
		devices = Position.select('max(id) AS id, imei').group('imei')
		Position.where('id IN (?)', devices).load
	end
end
