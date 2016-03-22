class FinesController < ApplicationController
  def update
    secret_token = update_params[:secret_token]
    return false unless secret_token == "rabindranath_tagore!"
    historic_late_books = Loan.where('due_date < date_in')
    current_late_books = Loan.where('due_date < ?', Date.today).where(date_in: nil)
    update_entries(historic_late_books)
    update_entries(current_late_books)
  end

  private
  def update_entries(arr)
    arr.map do |loan|
      fine = Fine.create(loan_id: loan.id) unless loan.fine
      fine = loan.fine
      days_late = ((loan.date_in || Date.today) - loan.due_date).to_i
      binding.pry
      fine.update_attributes({ amount: 0.25 * days_late }) unless days_late < 0
    end
  end

  def update_params
    params.permit(:secret_token)
  end
end
