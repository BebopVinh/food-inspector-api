class UsersController < ApplicationController

   def set_allergen
      user = User.find_by(id: params[:user][:user_id])
      user.update(allergen: params[:user][:allergen])
      render json: user.as_json(only: :allergen), status: :ok
   end

   def sign_up
      user = User.new(user_params)
      if user.valid?
         user.save
         render json: user.as_json(only: [:id, :email, :authentication_token]), status: :created
      else
         head(:bad_request)
      end
   end


   private
      def user_params
         params.require(:user).permit(:email, :password, :password_confirmation)
      end
end
