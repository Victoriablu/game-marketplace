class Game < ApplicationRecord
    validates :title, :platform, :description, presence: true,
    length: { minimum: 5 }
    validates :condition, :price, presence: true,
    length: { minimum: 2 }
    
    belongs_to :user
    has_one_attached :picture
end
