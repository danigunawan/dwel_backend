class CommentTableAdd < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :username, :integer, null: false
  end
end
