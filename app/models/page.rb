class Page < ActiveRecord::Base
  serialize :h1, Array
  serialize :h2, Array
  serialize :h3, Array
  serialize :links, Array

  # Alias for links
  alias_attribute :a, :links
end