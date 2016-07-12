class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy]

  # GET /homeworks
  # GET /homeworks.json
  def index
    if current_user.role?
      @homeworks = Homework.all
    else
      @homeworks = Homework.where(upload:true)
    end
  end

  # GET /homeworks/1
  # GET /homeworks/1.json
  def show
    if current_user.role?
      @questions = Question.all
    else
      @answers = Answer.all
    end
  end

  # GET /homeworks/new
  def new
    @homework = Homework.new
  end

  # GET /homeworks/1/edit
  def edit
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    @homework = Homework.new(homework_params)

    respond_to do |format|
      if @homework.save
        format.html { redirect_to homework_questions_path(@homework), notice: 'La actividad ha sido creada.' }
        format.json { render :show, status: :created, location: @homework }
      else
        format.html { render :new }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homeworks/1
  # PATCH/PUT /homeworks/1.json
  def update
    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to homework_questions_path(@homework), notice: 'La actividad ha sido actualizada.' }
        format.json { render :show, status: :ok, location: @homework }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework.destroy
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'La actividad fue removida.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homework
      @homework = Homework.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homework_params
      params.require(:homework).permit(:name, :actual_phase, :upload)
    end
end
