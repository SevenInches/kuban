class ContractsController < ApplicationController
  def index

  end

  def create
    @contract = Contract.generate_contract(params[:start_date], params[:start_date], params[:phases])
  end

  def show
    contract = Contract.find(params[:id])
    @invoices = contract.generate_invoices
  end
end