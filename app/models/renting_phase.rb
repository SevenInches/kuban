# == Schema Information
#
# Table name: renting_phases
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  start_date    :date
#  end_date      :date
#  price         :float
#  cycles        :integer
#  contract_id   :integer
#

class RentingPhase < ApplicationRecord
  belongs_to :contract

  #月份差值和天数差值
  def differ
    month_diff = end_date.month - start_date.month
    month_diff >= 0 ? month_diff : month_diff+12
    day_diff = end_date.day + 1 - start_date.day
    if day_diff >= 0
      return month_diff, day_diff
    else
      last = (end_date << cycles) - day_diff
      diff = (end_date - last).to_i
      return month_diff - cycles, diff
    end
  end

  #日租金
  def day_price
    (price * 12 / 365.0).round(1)
  end
end
