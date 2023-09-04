class TransactionsController < ApplicationController
    def index
        @transactions = Transaction.all
        render json: @transactions, status: :ok 
    end

    def create
        #check if user_id is valid
        if !User.exists?(id: transaction_param[:user_id])
            head(:unprocessable_entity)
        else 
            if transaction_param[:status] == Transaction.TRANSFER
                #check user for receiver
                if !User.exists?(id: transaction_param[:to_user])
                    head(:unprocessable_entity)
                else
                    @transaction = Transaction.new(transaction_param)
                    @transaction.save
                    render json: @transaction, status: :created
                end
            else 
                @transaction = Transaction.new(transaction_param)
                @transaction.save
                render json: @transaction, status: :created
            end
        end 
    end

    def update
        @id = params[:id]

        if !Transaction.exists?(id: @id)
            head(:unprocessable_entity)
        else 

            if transaction_param[:status] == "SUCCESS"
                # do transactions
                ActiveRecord::Base.transaction do 
                    begin 
                        transac = Transaction.find(@id)
                        if transac.status == "SUCCESS"
                            head(:unprocessable_entity)
                        end
                        transac.update(status: transaction_param[:status])

                        sender = Wallet.where(user_id: transac.user_id).first
                        receiver = Wallet.where(user_id: transac.to_user).first

                        sender_amount = sender.amount - transac.amount
                        receiver_amount = receiver.amount + transac.amount
                        
                        logger.info sender_amount
                        logger.info receiver_amount

                        sender.update(amount: sender_amount)
                        receiver.update(amount: receiver_amount)

                        render json: transac, status: :created
                    rescue StandardError => e 

                        raise ActiveRecord::Rollback
                        head(:unprocessable_entity)
                    end
                end
            else
                transac = Transaction.find(@id)
                transac.update(status: transaction_param[:status])
                render json: transac, status: :created
            end
        end
    end

    private
    def transaction_param
        params.require(:transaction).permit(:user_id, :status, :tx_type, :amount, :to_user)
    end
end
