class EquipmentController < ApplicationController

  before_action :set_chapter
  before_action :get_item, only: [:show, :edit, :destroy, :update]

  def index
    @items = Equipment.all
  end

  def create
    @item = Equipment.new(equipment_params)
    if @item.save
      redirect_to equipment_index_path, notice: 'Создано'
    else
      render action: 'new', error: 'Ошибка при добавлении'
    end
  end

  def edit
    @chapters.push({title: "Редактировать \"#{@item.title}\"", src: "#"})
  end

  def update
    if @item.update(equipment_params)
      redirect_to edit_equipment_path(@item), notice: 'Сохранено'
    else
      render action: 'edit', error: 'Ошибка сохранения'
    end
  end

  def new
    @item = Equipment.new
    @chapters.push({title: "Добавить инвентарь", src: "#"})
  end

  def destroy
    if @item.destroy
      redirect_to equipment_index_path(@item), notice: 'Удалено'
    else
      render action: 'edit', error: 'Ошибка удаления'
    end
  end

  def set_chapter
    @chapters = [{title: 'Ед. изм.', src: equipment_index_path}]
  end

  private

  def equipment_params
    params[:equipment].permit( :title, :description )
  end

  def get_item
    @item = Equipment.find(params[:id])
  end

end
