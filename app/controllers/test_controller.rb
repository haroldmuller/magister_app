class TestController < ApplicationController
  before_action :set_breadcrumbs

  respond_to :html, :json

  def index
    @course   = Course.sample
    @homework = Homework.sample

    @users    = []
    @current  = 0
    @total    = 0

    @students = @course.users.where(role: 0)
    @answers  = Answer
                  .includes(:user)
                  .where(homework_id: @homework.id)
                  .has_answered([:responder, :argumentar, :rehacer].sample)
    @users    = User.where(id: @answers.map(&:user_id))
    @total    = @students.count
    @current  = @users.count
  end

  def create
    render json: { hello: "world", key: "value", date: Time.now }
  end
end
