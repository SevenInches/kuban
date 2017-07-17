# == Schema Information
#
# Table name: line_items
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  start_date    :date
#  end_date      :date
#  unit_price    :float
#  unit          :integer
#  total         :float
#  cate          :integer
#  invoice_id    :integer
#
class LineItem < ApplicationRecord
  belongs_to :invoice

  MONTH_CATE = 1 #月账单
  DAY_CATE   = 2 #日账单

  #单位名称
  def unit_word
    cate == MONTH_CATE ? '月' : '天'
  end
end
