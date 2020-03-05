class LineItem < ApplicationRecord
    belongs_to :game
    belongs_to :cart
    belongs_to :order, optional: true

  # LOGIC
  def total_price
    self.quantity * self.game.price
  end
end
