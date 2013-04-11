class AddAvatar < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :avatar_crop_x, :integer
    add_column :users, :avatar_crop_y, :integer
    add_column :users, :avatar_crop_w, :integer
    add_column :users, :avatar_crop_h, :integer
  end
end
