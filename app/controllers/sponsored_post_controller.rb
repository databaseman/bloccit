class SponsoredPostController < ApplicationController
  def show
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def create
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]
    @topic = Topic.find(params[:topic_id])
    @sponsored_post.topic = @topic
    if @sponsored_post.save # Calling database save/insert command
      flash[:notice] = 'SponsoredPost was saved.'
      redirect_to [@topic, @sponsored_post] # Redirecting to @sponsored_post will direct the user to the sponsored_posts show view.
    else
      flash.now[:alert] = 'There was an error saving the sponsored_post. Please try again.'
      render :new # render the new view again
    end
  end

  def edit
  end
end
