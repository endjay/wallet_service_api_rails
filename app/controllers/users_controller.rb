class UsersController < ApplicationController
    def index
        @users = User.all

        render json: @users, status: :ok
    end

    def create 
        @user = User.new(user_param)

        @user.save
        render json: @user, status: :created
    end

    def destroy 
        @user = User.where(id: params[:id]).first

        if @user.destroy 
            head(:ok)
        else 
            head(:unprocessable_entity)
        end
    end

    private     

    def user_param 
        params.require(:user).permit(:name)
    end
end
