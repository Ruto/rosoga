module V1
  class UsersController < ApplicationController
   before_action :authenticate_user!, only: [:confirm_token, :resend_phone_token, :resend_email_token]
    def index
      user = User.all
       if user
         render json: { user: user }, status: :created
       else
         render json: { error: "There are no records of users" }, status: :not_found
       end
    end

    def unconfirmed_users
      user = User.where(:confirmed_at => nil)
       if user
         render json: { user: user }, status: :created
       else
         render json: { error: "There are no records of users" }, status: :not_found
       end
    end

    def create
      @user = User.new(user_params)
      device = params[:device] if params[:device]
      user = @user
      if @user.save
        token = WebToken.encode(user, device)
        UserMailer.with(user: @user).user_confirmation.deliver_later
        render :create, status: :created, locals: { token: token }
        #render json: { token: token }, status: :created
        #render json: @user.as_json(only: [:id, :email, :username]), status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :bad_request
      end
    end

    def login
      @user = User.find_by(email: params[:email].to_s.downcase)

      if @user && @user.authenticate(params[:password])
        device = params[:device] if params[:device]
        token = WebToken.encode(@user, device)
        #render json: {token: token}, status: :ok
        #render :login, status: :created, location: v1_user_url(@user, @token)
        render :login, status: :created, locals: { token: token }
      else
        render json: {error: 'Invalid username / password'}, status: :unauthorized
      end
    end

    def reset_password
      reset_token = params[:reset_password_token].to_s
      email = params[:email].to_s
       # @user = User.find_by_email!(email)
      @user = User.find_by_reset_password_token!(reset_token)
        if @user.nil?
          render json: {status: "error", code: 4004, message: "Token does not Exist"}
        #  render json: {status: "error", code: 4001, message: "Token is not valid"}
        elsif @user.reset_password_expires_at < Time.zone.now
          # resend new password_reset_token
          render json: {status: "error", code: 4002, message: "Token has expired, request for new token"}
        else
          @user.update(user_params)
          @user.empty_token_and_expiry!
          render :reset_password, status: :created, location: v1_user_url(@user)
          # 'Password has been reset!'
        end
    end

    def forgot_password
      @user = User.find_by_email(params[:email])
      if @user
        @user.send_password_reset_token
        render :forgot_password, status: :created, location: v1_user_url(@user) #, locals: { user: user }
      else
        render json: {status: "error", code: 4001, message: "Email not available"}
      end
    end

    def logout
     if params[:token]

     else

     end
    end

    def resend_phone_token
      if @current_user
        @user = @current_user
        @user.reset_phone_token!
        render :confirm_token, status: :created, location: v1_user_url(@user)
      else
        render json: {status: 'User not signed in'}, status: :not_found
      end
    end

    def resend_email_token
      @user = @current_user
       @user.reset_email_token!
      render :confirm_token, status: :created, location: v1_user_url(@user)
    end

    def confirm_token
        token = params[:token].to_s
        @user = @current_user
        if @current_user.phone_token == token  ##  && @current_user.confirmation_token_valid?
            @user.mark_as_phone_confirmed!
          #render json: {status: 'User confirmed successfully'}, status: :ok
          render :confirm_token, status: :created, location: v1_user_url(@user)
        elsif @user.email_token == token ##  && @current_user.confirmation_token_valid?
           @user.mark_as_email_confirmed!
          # render json: {status: 'User confirmed successfully'}, status: :ok
          render :confirm_token, status: :created, location: v1_user_url(@user)
        elsif @user.phone_token == nil
          # render json: {status: 'Invalid token or has already been used'}, status: :not_found
          render :confirm_token, status: :created, location: v1_user_url(@user)
        elsif @user.email_token == nil
          # render json: {status: 'Invalid token or has already been used'}, status: :not_found
          render :confirm_token, status: :created, location: v1_user_url(@user)
        else
          render json: {status: 'Invalid token'}, status: :not_found
        end
    end

    private

    def user_params
      params.permit(:username, :phone, :device, :device_desc, :email, :reset_password_token, :password, :password_confirmation, :phone_token, :email_token)
    end

  end
end
