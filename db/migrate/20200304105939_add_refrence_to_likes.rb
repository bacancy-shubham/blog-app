class AddRefrenceToLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :likes, :article, null: true, foreign_key: true
  end
end
