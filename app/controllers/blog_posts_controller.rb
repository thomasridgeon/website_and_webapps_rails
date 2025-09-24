class BlogPostsController < ApplicationController
  def index
    posts = Post.order(created_at: :desc)
    render Blog::Posts::Index.new(posts: posts)
  end

  def show
    post = Post.find(params[:id])
    render Blog::Posts::Show.new(post: post)
  end
end
