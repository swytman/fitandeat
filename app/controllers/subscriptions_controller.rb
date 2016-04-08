class SubscriptionsController < ApplicationController

    def index
      @items = ProgramDay.all
    end

    def create
      return(head :bad_request) unless params[:telegram_id] || params[:program_id]
      respond_to do |format|
        format.json do

          program = Program.find(params[:program_id])
          return unless program
          subscription = Program.subscriptions.create(telegram_id: params[:telegram_id])
          item = parent.program_days.create({order: parent.program_days.count+1})
          render json: item
        end
      end
    end


    def update
      respond_to do |format|
        format.json do
          parent = Program.find(params[:parent_id])
          item = parent.program_days.create({order: parent.program_days.count+1})
          render json: item
        end
      end
    end


    def destroy
      respond_to do |format|
        format.json do
          parent = Program.find(params[:parent_id])
          item = ProgramDay.find(params[:id])
          if item.destroy
            items= parent.program_days.order('program_days.order ASC')
            items.each_with_index do |item, i|
              item.update({order: i+1})
            end
            render json: { :success => true }
          else
            render json: { :success => false }
          end
        end
      end
    end


end