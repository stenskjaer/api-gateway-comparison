class ApiBooksController < BaseApiController
    before_filter :show_book, only: [:show]

    def list
        render json: {status: "success", data: Book.all}
    end

    def show
        render json: {status: "success", data: @book}
    end

private
    def show_book
        @book = Book.find(params[:id])
        render json: {status: "error"}, status: :not_found unless @book.present?
    end
end
