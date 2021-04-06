class Search < ApplicationRecord
  def self.search(search)
    if search
      Book.where(['content LIKE ?', "%#{search}%"])
    else
      Book.all
    end
  end

end
