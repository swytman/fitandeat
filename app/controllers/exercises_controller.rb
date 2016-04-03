class ExercisesController < ApplicationController

  before_action :set_chapter
  before_action :get_item, only: [:show, :edit, :destroy, :update]

  def index
    @items = Exercise.all
  end

  def create
    @item = Exercise.new(exercise_params)
    if @item.save
      redirect_to exercises_path, notice: 'Создано'
    else
      render action: 'new', error: 'Ошибка при добавлении'
    end
  end

  def edit


  end

  def update
    if @item.update(exercise_params)
      redirect_to edit_exercise_path(@item), notice: 'Сохранено'
    else
      render action: 'edit', error: 'Ошибка сохранения'
    end
  end

  def new
    @item = Exercise.new
  end

  def destroy
    if @item.destroy
      redirect_to exercises_path(@item), notice: 'Удалено'
    else
      render action: 'edit', error: 'Ошибка удаления'
    end
  end

  def set_chapter
    @chapter = {title: 'Упражнения', src: exercises_path}
  end

  private

  def exercise_params
    params[:exercise].permit(:title, :description, :unit_id)
  end

  def get_item
    @item = Exercise.find(params[:id])
  end

end
