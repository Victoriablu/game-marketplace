class Game < ApplicationRecord
    validates :title, :platform, :description,:condition, :price, presence: true,
    length: { minimum: 2 }
    
    belongs_to :user
    has_one_attached :picture
    has_many :line_items, dependent: :destroy

    def self.search(search)
        if search
            where("title LIKE ?","%#{search}%")
        else
            all
        end
    end
end
