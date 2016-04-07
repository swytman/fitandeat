class DayExercisesController < ApplicationController

  def create
    respond_to do |format|
      format.json do
        parent = ProgramDay.find(params[:parent_id])
        item = parent.day_exercises.create({order: parent.day_exercises.count+1})
        render json: item
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        item = DayExercise.find(params[:id])
        if item.update(item_params)
          render json: item
        else
          render json: { :success => false }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        parent = ProgramDay.find(params[:parent_id])
        item = DayExercise.find(params[:id])
        if item.destroy
          items= parent.day_exercises.order('day_exercises.order ASC')
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


  private
  def item_params
    params.permit(:exercise_id, :count, :description)
  end
end
