class HomeController < ApiController
  def index
    @artists = Artist.all
    render json: @artists
  end
end
