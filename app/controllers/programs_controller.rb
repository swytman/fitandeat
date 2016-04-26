class ProgramsController < ApplicationController
  
  before_action :set_chapter
  before_action :get_item, only: [:show, :edit, :destroy, :update]

  def index
    @items = Program.includes(:subscriptions)
  end

  def create
    @item = Program.new(program_params)
    if @item.save
      if params[:days_count].present?
        params[:days_count].to_i.times do |day|
          @item.program_days.create({order: day+1})
        end
      end
      redirect_to programs_path, notice: 'Создано'
    else
      render action: 'new', error: 'Ошибка при добавлении'
    end
  end

  def edit
    @days = @item.program_days.order('program_days.order ASC').to_a
    @program_days_json = @days.map do |day|
      day.as_indexed_json.values[0]
    end.to_json

    @chapters.push({title: "Редактировать \"#{@item.title}\"", src: "#"})
  end

  def update
    if @item.update(program_params)
      redirect_to edit_program_path(@item), notice: 'Сохранено'
    else
      render action: 'edit', error: 'Ошибка сохранения'
    end
  end

  def new
    @item = Program.new
    @chapters.push({title: "Добавить программу", src: "#"})
  end

  def destroy
    if @item.destroy
      redirect_to programs_path(@item), notice: 'Удалено'
    else
      render action: 'edit', error: 'Ошибка удаления'
    end
  end

  def set_chapter
    @chapters = [{title: 'Программы', src: programs_path}]
  end

  private

  def program_params
    params[:program].permit(:title, :description, :cycle)
  end

  def get_item
    @item = Program.find(params[:id])
  end
  
  
end
