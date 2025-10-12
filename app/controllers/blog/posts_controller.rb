module Blog
  class PostsController < ApplicationController
    def index
      posts = ::BlogPost.order(created_at: :desc)
      render Blog::Posts::Index.new(posts: posts)
    end

    def show
      post = ::BlogPost.find_by!(slug: params[:id]) # params[:id] will not contain the slug
      render Blog::Posts::Show.new(post: post)
    end
  end
end
