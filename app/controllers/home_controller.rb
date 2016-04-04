class HomeController < ApplicationController
  def index
    if user_signed_in?
      render "user_dashboard"
    end
  end
end
