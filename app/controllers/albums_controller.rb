class AlbumsController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :authorize!, except: [:index, :show]
end
