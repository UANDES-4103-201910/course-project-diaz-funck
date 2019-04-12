class PostAttachment < ApplicationRecord
  belongs_to :post
  belongs_to :file_type
  validates :file_path, presence: true
end
