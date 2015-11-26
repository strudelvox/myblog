class SearchController < ApplicationController

  def index
    @recordings = Recording.search(params[:q],page: params[:page],per: 5)
  end

end
