class ProgramDaysController < ApplicationController

  before_action :get_item,   only: [:show, :edit, :destroy, :update]
  before_action :get_parent, only: [:show, :edit, :destroy, :update]
  before_action :set_chapter, only: [:edit]

  def index
    @items = ProgramDay.all
  end

  def create
    respond_to do |format|
      format.json do
        parent = Program.find(params[:parent_id])
        item = parent.program_days.create({order: parent.program_days.count+1})
        render json: item
      end
    end
  end


  def edit
    @chapters.push({title: "Редактировать день #{@item.order}", src: "#"})
    @exercies_json = @item.day_exercises.order('day_exercises.order ASC').to_json
    @all_exercises_json = Exercise.all.map{|e| {label: e.title, value: e.id}}.to_json
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


  def set_chapter
    @chapters = [
        {title: 'Программы', src: programs_path},
        {title: @parent.try(:title), src: edit_program_path(@parent, anchor: 'days')}
    ]
  end

  private

  def get_parent
    @parent = @item.program if @item
  end

  def get_item
    @item = ProgramDay.find(params[:id])
  end



end
