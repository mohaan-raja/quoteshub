class ApplicationController < ActionController::Base

    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, 'heyexbu') 
    end

    def decoded_token
        header = request.headers['Authorization']
        puts header
        if header
            token = header.split(" ")[1]
            begin
                JWT.decode(token, 'heyexbu')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if !!session[:user_id]
        # dt = decoded_token
        # puts dt
        # if decoded_token
        #     user_id = decoded_token[0]['user_id']
        #     @user = User.find_by(id: user_id)
        # end
    end

    def authorized
        # unless !!current_user
        unless !!session[:user_id]
        render json: { message: 'Please log in' }, status: :unauthorized
        end
    end

    class UserSerializer < ActiveModel::Serializer
        attributes :id, :username, :bio
    end


end
