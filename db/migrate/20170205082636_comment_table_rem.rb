class CommentTableRem < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :username
    add_column :comments, :username, :string, null: false
  end
end
