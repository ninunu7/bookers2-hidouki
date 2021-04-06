class RemoveWordFromSearches < ActiveRecord::Migration[5.2]
  def change
    remove_column :searches, :word, :string
  end
end
