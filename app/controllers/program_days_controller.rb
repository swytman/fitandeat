class ProgramDaysController < ApplicationController

  before_action :get_item,   only: [:show, :edit, :destroy, :update]
  before_action :get_parent, only: [:show, :edit, :destroy, :update]
  before_action :set_chapter

  def index
    @items = ProgramDay.all
  end

  def create
    @item = ProgramDay.new(program_day_params)
    if @item.save
      redirect_to program_days_path, notice: 'Создано'
    else
      render action: 'new', error: 'Ошибка при добавлении'
    end
  end


  def edit
    @chapters.push({title: "Редактировать день #{@item.order}", src: "#"})
    @exercies_json = @item.day_exercises.order('day_exercises.order ASC').to_json
    @all_exercises_json = Exercise.all.map{|e| {label: e.title, value: e.id}}.to_json
  end

  def update
    if @item.update(program_day_params)
      redirect_to edit_program_day_path(@item), notice: 'Сохранено'
    else
      render action: 'edit', error: 'Ошибка сохранения'
    end
  end

  def new
    @item = ProgramDay.new
    @chapters.push({title: "Добавить упражнение", src: "#"})
  end

  def destroy
    if @item.destroy
      redirect_to program_days_path(@item), notice: 'Удалено'
    else
      render action: 'edit', error: 'Ошибка удаления'
    end
  end

  def set_chapter
    @chapters = [
        {title: 'Упражнения', src: programs_path},
        {title: @parent.try(:title), src: edit_program_path(@parent, anchor: 'days')}
    ]
  end

  private

  def program_day_params
    params[:program_day].permit(:title, :description, :unit_id)
  end

  def get_parent
    @parent = @item.program if @item
  end

  def get_item
    @item = ProgramDay.find(params[:id])
  end


  
end
