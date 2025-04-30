# frozen_string_literal: true

class ShortUrl # rubocop:disable Style/Documentation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :accesses,     type: Integer, default: 0
  field :original_url, type: String
  field :slug,         type: String

  validates :original_url, url: true
  validates :slug, uniqueness: true

  # When defining an index, the first hash object contains the field you want to index and its direction. 1 represents
  # an ascending index, and -1 represents a descending index. The second hash object contains index options.
  # after declarate the index you need to ran Model.create_indexes, in this case, ShortUrl.create_indexes
  # https://www.mongodb.com/docs/mongoid/current/data-modeling/indexes/#declare-and-create-an-index
  index({ slug: 1 }, { name: 'short_url_slug_index', unique: true })
end
