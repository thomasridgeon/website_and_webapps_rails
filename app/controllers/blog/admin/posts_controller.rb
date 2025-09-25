class Blog::Admin::PostsController < ApplicationController
  # require admin login
  before_action :authenticate_blog_admin!
  before_action :set_post, only: [ :edit, :update, :destroy ]
  # edit, update and destroy need a specific post, so set_post's definition which stores the blog post based on id in an instance variable @post, mneans the action edit, update and destroy can use it.
  def index
    @posts = Post.order(created_at: :desc) # desc means the created_at column will be ordered in descending order.
    render Blog::Admin::Posts::Index.new(posts: @posts)
  end

  def new
    @post = Post.new
    render Blog::Admin::Posts::New.new(post: @post)
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to blog_admin_posts_path, notice: "Post created!"
    end
  end

  def edit
    render Blog::Admin::Posts::Edit.new(post: @post)
  end

  def update
    if @post.update(post_params)
      redirect_to blog_admin_posts_path, notice: "Post updated!"
    else
      render Blog::Admin::Posts::Edit.new(post: @post)
    end
  end

  def destroy
    @post.destroy
    redirect_to blog_admin_posts_path, notice: "Post deleted!"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authenticate_blog_admin!
    redirect_to blog_login_path, alert: "Please log in as admin" unless current_blog_user&.admin?
  end
end
