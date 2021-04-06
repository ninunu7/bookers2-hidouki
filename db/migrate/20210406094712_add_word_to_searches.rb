class AddWordToSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :searches, :word, :string
  end
end
