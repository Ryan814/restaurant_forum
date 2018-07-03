class AddAttributesToUserModel < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :intro, :text
    #掛載 CarrierWave 的 Uploader
    add_column :users, :avatar, :string
  end
end
