class PositionsController < ApplicationController
	#
	# Get last positions for all known devices
	#
	def last
    respond_to do |format|
      format.any {render :json => Position.get_last}
    end
	end

	#
	# Update the position of a device.
	#
	def update
    Position.create(:imei => params[:imei], :lat => params[:lat], :lon => params[:lon])

    respond_to do |format|
      format.any {render :json => "update #{params[:imei]}"}
    end
	end

	#
	# Clear all the position data for all known devices.
	#
	def clear
    Position.delete_all
	end
end
