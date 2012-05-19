class AlbumsController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authorize!, except: [:index, :show]

  def show
    @album = Album.find params[:id]
    render_404 unless @album.is_public? and user_signed_in?
  end

  protected
    def collection
      if user_signed_in?
        super
      else
        @albums ||= Album.public
      end
    end
end
