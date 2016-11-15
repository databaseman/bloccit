#
class PostsController < ApplicationController
  def index
    @posts = Post.all   # give me all rows from table Posts
  end

  def show
     @post = Post.find(params[:id])      
  end

  def new
    @post = Post.new
  end

   def create
     @post = Post.new
     @post.title = params[:post][:title]
     @post.body = params[:post][:body]
     if @post.save  # Calling database save/insert command
       flash[:notice] = "Post was saved."
       redirect_to @post #Redirecting to @post will direct the user to the posts show view.
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :new  # render the new view again
     end
   end
   
  def edit
  end
end
