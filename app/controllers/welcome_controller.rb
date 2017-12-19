class WelcomeController < ApplicationController
  def index
    flash[:alert]="alert!"
  end
end
