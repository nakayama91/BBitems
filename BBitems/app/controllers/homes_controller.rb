class HomesController < ApplicationController
  def top
    @genres = Genre.all
  end

  def about
    @genres = Genre.all
  end
end
