class BaseApiController < ApplicationController
    # before_filter :authenticate_user_from_token!

    # private
    #     def authenticate_user_from_token!
    #         valid_keys = ["veryS3cr4tT0kun", "f4variteS3cre7"]
    #         token = request.headers["X-Api-Key"]
    #         if !request.headers["X-Api-Key"]
    #             render json: {status: "unauthorized", message: "No API key given in header."}, status: :unauthorized
    #         else
    #             if !valid_keys.include?(request.headers["X-Api-Key"])
    #                 render json: {status: "unauthorized", message: "Invalid API key."}, status: :unauthorized
    #             end
    #         end
    #     end

end