class TestController < ApplicationController
  before_action :set_context
  before_action :set_breadcrumbs

  respond_to :html, :json

  def index
    @users    = []
    @current  = 0
    @total    = 0

    @students = @course.users.where(role: 0)
    @answers  = Answer
                  .includes(:user)
                  .where(homework_id: @homework.id)
                  .has_answered(%w{responder argumentar rehacer}.sample)
    @users    = User.where(id: @answers.map(&:user_id))
    @total    = @students.count
    @current  = @users.count

    @count    = $redis.incr("test:counter")
  end

  def create
    render json: { hello: "world", key: "value", date: Time.now }
  end

  private
  def set_context
    @course   = Course.all.sample
    @homework = @course.homeworks.sample || Homework.all.sample
  end

  def set_breadcrumbs
    ["Mis Cursos", @course.name, "Mis Tareas", @homework.name]
  end
end
