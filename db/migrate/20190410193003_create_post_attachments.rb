class CreatePostAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_attachments do |t|
      t.references :post, foreign_key: true
      t.references :file_type, foreign_key: true
      t.string :file_path

      t.timestamps
    end
  end
end
