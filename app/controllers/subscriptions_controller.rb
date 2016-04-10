class SubscriptionsController < ApplicationController

    def create
      return(head :bad_request) unless params[:telegram_id] || params[:program_id]
      respond_to do |format|
        format.json do
          program = Program.find(params[:program_id])
          return unless program
          user = User.get_or_create_by_telegram_id(params[:telegram_id])
          return unless user
          subscription = program.subscriptions.create({
            user_id: user.id,
            start_date: Time.now.to_date + 1.day
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