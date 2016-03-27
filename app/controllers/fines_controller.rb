class FinesController < ApplicationController
  def index
  end

  def update
    secret_token = update_params[:secret_token]
    return false unless secret_token == "rabindranath_tagore!"
    historic_late_books = Loan.where('due_date < date_in')
    historic_late_books.joins(:fine).map { |x| x.fine.update_attribute(:paid, true) }
    current_late_books = Loan.where('due_date < ?', Date.today).where(date_in: nil)
    update_entries(historic_late_books)
    update_entries(current_late_books)
    @response = {
      historic: historic_late_books,
      current: current_late_books,
    }
    @historic_fines = historic_late_books.joins(:fine).map { |loan| loan.fine.amount }.sum
    @current_fines = current_late_books.joins(:fine).map { |loan| loan.fine.amount }.sum
  end

  private
  def update_entries(arr)
    arr.map do |loan|
      fine = loan.fine ? loan.fine : Fine.create(loan_id: loan.id) 
      days_late = ((loan.date_in || Date.today) - loan.due_date).to_i
      fine.update_attributes({ amount: 0.25 * days_late }) unless days_late < 0
    end
  end

  def update_params
    params.permit(:secret_token)
  end
end
