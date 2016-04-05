class UnitsController < ApplicationController
  
    before_action :set_chapter
    before_action :get_item, only: [:show, :edit, :destroy, :update]

    def index
      @items = Unit.all
    end

    def create
      @item = Unit.new(unit_params)
      if @Sitem.save
        redirect_to units_path, notice: 'Создано'
      else
        render action: 'new', error: 'Ошибка при добавлении'
      end
    end

    def edit
      @chapters.push({title: "Редактировать \"#{@item.title}\"", src: "#"})
    end

    def update
      if @item.update(unit_params)
        redirect_to edit_unit_path(@item), notice: 'Сохранено'
      else
        render action: 'edit', error: 'Ошибка сохранения'
      end
    end

    def new
      @item = Unit.new
      @chapters.push({title: "Добавить ед.изм", src: "#"})
    end

    def destroy
      if @item.destroy
        redirect_to units_path(@item), notice: 'Удалено'
      else
        render action: 'edit', error: 'Ошибка удаления'
      end
    end

    def set_chapter
      @chapters = [{title: 'Ед. изм.', src: units_path}]
    end

    private

    def unit_params
      params[:unit].permit(:title, :short_title, :few_title, :many_title)
    end

    def get_item
      @item = Unit.find(params[:id])
    end
    
end
