class ExercisesController < ApplicationController

  before_action :set_chapter

  def index
    @exercises = Exercise.all
  end

  def create

  end

  def update

  end

  def new
    @exercise = Exercise.new
  end

  def destroy

  end

  def set_chapter
    @chapter = {title: 'Упражнения', src: exercises_path}
  end

end
