class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :number, :integer
    add_column :users, :gender, :intiger
  end
end
