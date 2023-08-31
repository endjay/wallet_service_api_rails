class WalletsController < ApplicationController
    
    def index
        @wallets = Wallet.all
        render json: @wallets, status: :ok 
    end

    def create 

        if Wallet.exists?(user_id: wallet_param[:user_id])
            head(:unprocessable_entity)
        else
             @wallet = Wallet.new(wallet_param)
             @wallet.save
             render json: @wallet, status: :created
        end
    end

    def destroy 
        @user = Wallet.where(id: params[:id]).first

        if @user.destroy 
            head(:ok)
        else 
            head(:unprocessable_entity)
        end
    end

    private 
    def wallet_param
        params.require(:wallet).permit(:user_id, :amount)
    end
end
