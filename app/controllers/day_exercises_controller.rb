class DayExercisesController < ApplicationController

  def create
    respond_to do |format|
      format.json do
        program_day = ProgramDay.find(params[:parent_id])
        de = program_day.day_exercises.create({order: program_day.day_exercises.count+1})
        render json: de
      end
    end
  end

  def update
    respond_to do |format|
      format.json do
        de = DayExercise.find(params[:id])
        if de.update(de_params)
          render json: de
        else
          render json: { :success => false }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      format.json do
        de = DayExercise.find(params[:id])
        if de.destroy
          render json: de
        else
          render json: { :success => false }
        end
      end
    end
  end


  private
  def de_params
    params.permit(:exercise_id, :count, :description)
  end
end
