class LineItem < ApplicationRecord
  belongs_to :invoice

  MONTH_CATE = 1 #月账单
  DAY_CATE   = 2 #日账单

  def unit_word
    cate == MONTH_CATE ? '月' : '天'
  end
end
