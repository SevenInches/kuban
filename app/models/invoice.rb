class Invoice < ApplicationRecord
  has_many :line_items
  belongs_to :contract

  def sum_items
    total = 0.0
    line_items.each do |item|
      total += item.total
    end
    self.update(total: total)
  end
end
