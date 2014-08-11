class AirportsController < ApplicationController
  
  def dist
    @airports = Airport.order(:code).where("name ilike ? OR code ilike ? OR city ilike ?","%#{params[:term]}%", "#{params[:term]}%", "#{params[:term]}%").limit(20)
    puts @airports.inspect
    respond_to do |format|
       format.html 
       format.json {render json: @airports.map { |a|   {  label:  "#{a.code.upcase} - #{a.name} | #{a.city}", 
                                                          name:   a.name, 
                                                          code:   a.code,
                                                          city:   a.city,
                                                          lat:    a.lat,
                                                          lng:    a.lng }}}
     end
  end

  # GET /airports
  # GET /airports.json
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport
      @airport = Airport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def airport_params
      params.require(:airport).permit(:city, :code, :country, :lat, :lng, :name, :timezone)
    end
end
