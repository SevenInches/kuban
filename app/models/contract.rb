class Contract < ApplicationRecord

  has_many :invoices
  has_many :renting_phases

  #生成并保存合同
  def self.generate_contract(start_date, end_date, phases)
    current = self.create(start_date: start_date, end_date: end_date)
    if current.present?
      begin
        phases.each do |phase|
          rent = RentingPhase.create(phase)
          rent.update(contract_id: current.id)
        end
        return current
      rescue => err
        Rails.logger.info err
      end
    end
  end

  #一次生成所有账单
  def generate_invoices
    renting_phases.each do |phase|
      monthes, days = phase.try(:differ)
      if phase.try(:cycles) && phase.cycles > 0
        origin_date = phase.try(:start_date)
        (1..monthes/phase.cycles.to_i).to_a.each do |i|
          invoice = Invoice.create(start_date: origin_date, end_date: (origin_date >> phase.cycles)-1, due_date: due(origin_date), contract_id: id)
          if invoice.present?
            line_start = invoice.start_date
            (1..phase.cycles.to_i).to_a.each do |j|
              if invoice.end_date >= line_start.next_month-1
                LineItem.create(start_date: line_start, end_date: line_start.next_month-1, unit_price: phase.price, units: phase.cycles, total: phase.price, invoice_id: invoice.id, cate: LineItem::MONTH_CATE)
                line_start = line_start.next_month
              else
                line_diff = (invoice.end_date - line_start).to_i
                LineItem.create(start_date: line_start, end_date: invoice.end_date, unit_price: phase.day_price, units: line_diff, total: phase.day_price * line_diff, invoice_id: invoice.id, cate: LineItem::DAY_CATE)
              end
            end
            invoice.sum_items
          end
          origin_date = origin_date >> phase.cycles
        end
      end
      if days > 0
        begin_date = phase.end_date - days
        day_invoice = Invoice.create(start_date: begin_date, end_date: phase.end_date, due_date: due(begin_date), total: phase.day_price * days, contract_id: id)
        LineItem.create(start_date: day_invoice.start_date, end_date: day_invoice.end_date, unit_price: phase.day_price, units: days, total: day_invoice.total, invoice_id: day_invoice.id, cate: LineItem::DAY_CATE)
      end
    end
    invoices
  end

  def renting_phases_count
    renting_phases.present? ? renting_phases.count : 0
  end

  def due(date)
    last = date.last_month
    Date.new(last.year, last.month, 15)
  end
end
