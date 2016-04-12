class SubscriptionsController < ApplicationController

    def sign
      return(head :bad_request) unless params[:telegram_id] || params[:program_id]
      respond_to do |format|
        format.json do
          program = Program.find(params[:program_id])
          return (head :bad_request) unless program
          user = User.get_or_create_by_telegram_id(params[:telegram_id])
          return (head :bad_request) unless user
          subscription = program.subscriptions.create({
            user_id: user.id,
            start_date: Time.now.to_date + 1.day,
            telegram_id: params[:telegram_id]
          })
          render json: subscription
        end
      end
    end


    def update
      respond_to do |format|
        format.json do

        end
      end
    end


    def destroy
      respond_to do |format|
        format.json do

        end
      end
    end


end