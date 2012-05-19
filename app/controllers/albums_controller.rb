class AlbumsController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authorize!, except: [:index, :show]

  protected
    def collection
      if user_signed_in?
        super
      else
        @albums ||= Album.public
      end
    end
end
