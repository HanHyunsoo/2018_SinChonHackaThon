class PostsController < ApplicationController
  def index
    @posts = Post.all.reverse
  end
  
  def new
    user_authentication
  end

  def create
    temp_post = Post.new
    temp_post.title = params[:post_title]
    temp_post.content = params[:post_content]
    temp_post.user_id = current_user.id
    
    hashtags = params[:hashtags].split(',')
    hashtags.each do |tag|
      hashtag = Hashtag.find_or_create_by(name: tag.delete('#'))
      hashtag.save
      temp_post.hashtags << hashtag
    
    uploader = ImguploaderUploader.new
    uploader.store!(params[:img])
    temp_post.img_url = uploader.url
    end
    
    temp_post.save
    
    redirect_to '/'
  end
  
  def edit
    user_authentication
    @post = Post.find(params[:post_id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @post.title = params[:post_title]
    @post.content = params[:post_content]
    
    hashtags = params[:hashtags].split(',')
    @post.hashtags.clear
    
    hashtags.each do |tag|
      hashtag = Hashtag.find_or_create_by(name: tag.delete('#'))
      hashtag.save
      @post.hashtags << hashtag
    end
    
    @post.save
    redirect_to '/'
  end

  def delete
    user_authentication
    
    temp_post = Post.find(params[:post_id])
    temp_post.destroy
    
    redirect_to '/'
  end
  
  private 
    def user_authentication
      unless user_signed_in?
        redirect_to '/users/sign_in'
      end
    end
    
    def user_authentication
      if user_signed_in?
        @posts = Post.all.reverse
      else
        redirect_to '/users/sign_in'
      end
    end
    
end