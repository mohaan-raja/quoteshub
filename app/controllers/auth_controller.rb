class AuthController < ApplicationController

    skip_before_action :authorized, only: [:login, :new]
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def new
        @auth = User.new
    end

    def login
        puts login_params
        user = login_params[:user]
        puts user
        username = user[:username]
        password = user[:password]
        @user = User.find_by_username(username)
        if !!@user && @user.authenticate(password)
            session[:user_id] = @user.id
            @token = encode_token(user_id: @user.id)
            redirect_to quotes_path
            # render json: {
            #     user: UserSerializer.new(@user),
            #     token: @token
            # }
            
        else
            render json: {message: 'Incorrect password'}, status: :unauthorized
        end

    end

    def logout
        puts "logout"
        puts session[:user_id]
        session[:user_id] = nil
        redirect_to login_path
    end

    private 

    def login_params 
        params.permit(:authenticity_token, user: {})
    end

    def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
    end
    
end
