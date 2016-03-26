class BorrowersController < ApplicationController
  def create
    @response = create_borrower
  end

  private
  def create_borrower
    borrower = Borrower.new
    borrower.assign_attributes(borrower_hash)
    return borrower.errors.full_messages unless borrower.valid?
    borrower.save
    borrower
  end

  def borrower_hash
    param = borrowers_create_params
    parser = People::NameParser.new
    binding.pry
    name = parser.parse(param[:name])
    {
      card_no: Borrower.maximum(:card_no).next,
      ssn: param[:ssn],
      fname: name[:first],
      lname: name[:last],
      address: param[:address],
      email: param[:email],
      city: param[:city],
      state: param[:state],
      phone: param[:phone],
    }
  end

  def borrowers_create_params
    params.permit(:ssn, :name, :address, :email, :city, :state, :phone)
  end
end
