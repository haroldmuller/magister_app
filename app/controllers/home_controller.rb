class HomeController < ApplicationController
  def home
    if user_signed_in?
      redirect_to users_path
    end
  end

  def index
  end
end
