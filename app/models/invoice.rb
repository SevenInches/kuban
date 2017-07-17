# == Schema Information
#
# Table name: invoices
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  start_date    :date
#  end_date      :date
#  due_date      :date
#  total         :float
#  contract_id   :integer
#

class Invoice < ApplicationRecord
  has_many :line_items
  belongs_to :contract

  #计算账单总价
  def sum_items
    total = 0.0
    line_items.each do |item|
      total += item.total
    end
    self.update(total: total)
  end
end
