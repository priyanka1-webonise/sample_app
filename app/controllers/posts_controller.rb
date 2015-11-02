class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = current_user.posts
  end

  def show
    unless @post.present?
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'Bad request.'}
        format.json { render status: 400 }
      end
    end
  end

  def new
    @post = Post.new
  end

  def edit
    unless @post.present?
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'Bad request.'}
        format.json { render status: 400 }
      end
    end
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @post.present?
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'Bad request.'}
        format.json { rendr status: 400 }
      end
    end
  end

  private
    def find_post
      @post = current_user.posts.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description).merge(user_id: current_user.id)
    end
end
