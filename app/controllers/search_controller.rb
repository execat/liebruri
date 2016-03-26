class SearchController < ApplicationController
  def index
  end

  def show
    # Take all, or ISBN, or title, or authors
    # and return
    # - branch_info
    # - branch_id
    # - branch_name
    # - copies owned by each branch
    # - availability at each branch

    params = search_params

    # For all
    if params[:all]
      all_param = "%#{params[:all]}%"
      all_results = Book.joins(:authors).where('authors.full_name LIKE ? OR
                              books.isbn LIKE ? OR
                              books.title LIKE ?',
                              all_param, all_param, all_param).pluck(:id).uniq
    end

    # For ISBN
    if params[:isbn]
      isbn_param = "%#{params[:isbn]}%"
      isbn_results = Book.where('isbn LIKE ?', isbn_param).pluck(:id).uniq
    end

    # For title
    if params[:title]
      title_param = "%#{params[:title]}%"
      title_results = Book.where('title LIKE ?', title_param).pluck(:id).uniq
    end

    # For authors
    if params[:authors]
      author_param = "%#{params[:authors]}%"
      author_results= Book.joins(:authors).
        where('full_name LIKE ?', author_param).pluck(:id).uniq
    end

    @response = {
      all: fetch_records_for(all_results),
      isbn: fetch_records_for(isbn_results),
      title: fetch_records_for(title_results),
      authors: fetch_records_for(author_results),
    }
  end

  private
  def fetch_records_for(ids)
    return {} unless ids
    ids.map do |id|
      book = Book.find(id)
      {
        isbn: book.isbn,
        title: book.title,
        authors: book.authors,
        branch_info: book.copies.map { |copy|
          branch_id = copy.branch_id
          total_copies = copy.no_of_copies
          loaned_copies = Loan.where(book_id: id, branch_id: branch_id).
            where(date_in: nil).count
          available_copies = total_copies - loaned_copies
          {
            branch_id: copy.branch_id,
            branch_name: copy.branch.name,
            total_copies: total_copies,
            avaiable_copies: available_copies,
          }
        },
      }
    end
  end

  def search_params
    params.permit(:all, :isbn, :title, :authors)
  end
end
