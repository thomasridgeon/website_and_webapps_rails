class BlogPost < ApplicationRecord
  belongs_to :blog_user
  validates :slug, presence: true, uniqueness: true
  has_rich_text :body

  # automatically generate a slug before validation
  before_validation :generate_slug, on: :create

  # to_param tells Rails to use `slug` instead of `id` when generating URLs.
  def to_param
    slug
  end

  private

  def generate_slug
    return if title.blank?
    # parameterize makes "My First Post" "my-first-post"
    self.slug ||= title.parameterize
    # ||= is short hand for self.slug = self.slug || title.parameterize. So if self.slug is not already set (if it's nil or false), then do title.parameterize
  end
end
