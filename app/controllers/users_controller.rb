class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create, :new]
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

    def new
        @user = User.new
    end

    def create 
        user_info = user_params[:user]
        @user = User.create!(user_info)
        session[:user_id] = @user.id if !!@user
        @token = encode_token(user_id: @user.id)
        render json: {
            user: UserSerializer.new(@user), 
            token: @token
        }, status: :created
    end

    private

    def user_params 
        params.permit(user: {})
    end

    def handle_invalid_record(e)
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

end
