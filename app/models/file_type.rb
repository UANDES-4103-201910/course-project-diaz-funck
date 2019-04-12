class FileType < ApplicationRecord
  has_many :post_attachments
  validates :name, presence: true
end
