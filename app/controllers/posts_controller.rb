class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @user = User.find(params[:user_id])
    @post = Post.where(user_id: @user.id, post_id: params[:id])
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  # GET /posts/new
  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  # POST /posts or /posts.json
  def create

    @user = User.find(params[:user_id])
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to (request.referrer || root_path), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.where(id: params[:id], user_id: params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content, :user_id)
    end
end
