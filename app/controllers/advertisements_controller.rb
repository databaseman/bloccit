#
class AdvertisementsController < ApplicationController
  def index
    @advertisements = Advertisement.all # give me all rows from table Advertisements
  end

  def show
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    @advertisement = Advertisement.new
    @advertisement.title = params[:advertisement][:title]
    @advertisement.body = params[:advertisement][:body]
    @advertisement.price = params[:advertisement][:price]
    if @advertisement.save # Calling database save/insert command
      flash[:notice] = 'Advertisement was saved.'
      redirect_to @advertisement # Redirecting to @advertisement will direct the user to the advertisement show view.
    else
      flash.now[:alert] = 'There was an error saving the post. Please try again.'
      render :new # render the new view again
    end
  end
end
