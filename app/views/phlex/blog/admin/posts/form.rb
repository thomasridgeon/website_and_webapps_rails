class Blog::Admin::Posts::Form < Phlex::HTML
  def initialize(post:, url:, method: "post")
    @post = post
    @url = url
    @method = method
  end
end
