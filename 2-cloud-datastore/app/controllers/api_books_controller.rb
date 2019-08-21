class ApiBooksController < BaseApiController
    before_filter :show_book, only: [:show]

    def list
        render json: Book.all
    end

    def show
        render json: @book
    end

private
   def show_book
     @book = Book.find(params[:id])
     render nothing: true, status: :not_found unless @book.present?
   end
end
