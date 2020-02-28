class Game < ApplicationRecord
    validates :title, presence: true,
    length: { minimum: 5 }
    validates :platform, presence: true,
    length: { minimum: 5 }
    validates :condition, presence: true,
    length: { minimum: 2 }
    validates :description, presence: true,
    length: { minimum: 5 }
    validates :price, presence: true,
    length: { minimum: 2 }

    belongs_to :user
end
