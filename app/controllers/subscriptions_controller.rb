class SubscriptionsController < ApplicationController

  def schedule
    respond_to do |format|
      format.json do
        result = []
        Subscription.all.each do |s|
          day_today = s.program_day_today
          if day_today.class == ProgramDay
            exercises = day_today.day_exercises.order('day_exercises.order ASC')
            response = render_to_string(:template => 'telegram/subscriptions/today',
                                        :layout => false,
                                        :locals => {exercises: exercises, day_number: day_today.order})
            result << {id: s.user.telegram_id, message: response}
          end
        end
        render json: result
      end
    end
  end

  def signs
    respond_to do |format|
      format.json do
        return(head :bad_request) unless params[:telegram_id]

          user = User.get_or_create_by_telegram_id(params[:telegram_id])
          return (head :bad_request) unless user
          subscriptions = user.subscriptions
          if subscriptions.length == 0
            response = 'Вы не подписаны ни на одну программу'
          else
            response = render_to_string(:template => 'telegram/subscriptions/signs',
                                        :layout => false,
                                        :locals => {s: subscriptions})
          end
        render json: {message: response}
      end
    end
  end


  def sign
    return(head :bad_request) unless params[:telegram_id] || params[:program_id]
    respond_to do |format|
      format.json do
        program = Program.find_by(id: params[:program_id])
        unless program
          response = render_to_string(:template => 'telegram/programs/no_program',
                                      :layout => false,
                                      :locals => {id: params[:program_id]})

        else
          user = User.get_or_create_by_telegram_id(params[:telegram_id])
          return (head :bad_request) unless user
           subscription = program.subscriptions.where(user_id: user.id)
          if subscription.length > 0
            response = 'Вы уже подписаны на эту программу'
          elsif user.subscriptions.count == 1
            response = 'Вы можете быть подписаны только на одну программу'
          else
            subscription = program.subscriptions.create({
              user_id: user.id,
              start_date: Time.now.to_date + 1.day,
              telegram_id: params[:telegram_id]
            })
            response = render_to_string(:template => 'telegram/subscriptions/sign',
                                        :layout => false,
                                        :locals => {s: subscription})
          end
        end
        render json: {message: response}
      end
    end
  end

  def unsign
    return(head :bad_request) unless params[:telegram_id] || params[:program_id]
    respond_to do |format|
      format.json do
        program = Program.find(params[:program_id])
        unless program
          response = render_to_string(:template => 'telegram/programs/no_program',
                                      :layout => false,
                                      :locals => {id: params[:program_id]})
        else
          user = User.get_or_create_by_telegram_id(params[:telegram_id])
          return (head :bad_request) unless user
          subscription = program.subscriptions.where(user_id: user.id)

          if subscription.length == 0
            response = "Вы не подписаны на программу с ID: #{params[:program_id]}"

          else
            subscription.destroy_all
            response = "Вы отписаны от програмы ID: #{params[:program_id]}"
          end
        end

        render json: {message: response}
      end
    end
  end

  def today
    respond_to do |format|
      format.json do
        return(head :bad_request) unless params[:telegram_id]
        user = User.get_or_create_by_telegram_id(params[:telegram_id])
        return (head :bad_request) unless user
        subscriptions = user.subscriptions

        if subscriptions.length == 0
          response = 'Вы не подписаны ни на одну программу'
        else
          s = subscriptions[0]
          day_today = s.program_day_today
          if day_today == 0
            response = 'Начнем завтра!'
          elsif day_today == -1
            response = 'Программа уже закончена'
          else
            exercises = day_today.day_exercises.order('day_exercises.order ASC')
            response = render_to_string(:template => 'telegram/subscriptions/today',
                                        :layout => false,
                                        :locals => {exercises: exercises, day_number: day_today.order})
          end
        end
        render json: {message: response}
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