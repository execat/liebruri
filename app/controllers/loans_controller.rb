class LoansController < ApplicationController
  def index
  end

  def create
    @response = issue
  end

  def show
    @response = deposit_search_result
  end

  def update
    @response = deposit
  end

  private
  def issue
    param = loan_create_params
    card_no = param[:card_no]
    copies_id = Copies.find_by(book_id: Book.find_by(isbn: param[:isbn]).id, branch_id: param[:branch_id]).id

    borrower = Borrower.find_by(card_no: card_no)
    return "Invalid borrower card no: #{card_no}" unless borrower
    return "You already have 3 books. Deposit at least 1 book to check out more books" if borrower.loans.count >= 3

    copies = Copies.find(copies_id)
    return "Invalid copies ID: #{copies_id}" unless copies
    total_copies = copies.no_of_copies
    loaned_copies = Loan.where(book_id: copies.book_id, branch_id: copies.branch_id).where(date_in: nil).count
    available_copies = total_copies - loaned_copies
    return "This book has all of its copies checked out from this branch. Sorry!" if available_copies <= 0

    issue_hash = {
      book_id: copies.book_id,
      branch_id: copies.branch_id,
      borrower_id: borrower.id,
      date_out: Date.today,
      due_date: Date.today + 14.days,
    }
    loan = Loan.new issue_hash
    return loan.errors.full_messages unless loan.save
    loan
  end

  def deposit_search_result
    param = loan_search_params
    borrower_name = param[:borrower_name]
    sanitized_borrower_name = "%#{borrower_name}%"

    isbn = param[:isbn]
    books = Book.where('isbn LIKE ?', "%#{isbn}%")

    card_no = param[:card_no]
    sanitized_card_no = "%#{card_no}%"

    by_card = Borrower.where('card_no LIKE ?', sanitized_card_no).pluck(:id) unless card_no.blank?
    by_name = Borrower.where('fname LIKE ? OR lname LIKE ?', sanitized_borrower_name, sanitized_borrower_name).pluck(:id) unless borrower_name.blank?
    by_isbn = books.map { |b| b.borrowers }.flatten.pluck(:id) unless books.blank?
    {
      by_card: Loan.where(borrower_id: by_card),
      by_name: Loan.where(borrower_id: by_name),
      by_isbn: Loan.where(borrower_id: by_isbn),
    }
  end

  def deposit
    param = loan_update_params
    id = param[:loan_id]
    date = param[:date_in] || Date.today
    loan = Loan.find(id)
    return loan.errors.full_messages unless loan.update({ date_in: date })
    loan
  end

  def loan_create_params
    params.permit(:card_no, :isbn, :branch_id)
  end

  def loan_search_params
    params.permit(:card_no, :borrower_name, :isbn)
  end

  def loan_update_params
    params.permit(:loan_id, :date_in)
  end
end
