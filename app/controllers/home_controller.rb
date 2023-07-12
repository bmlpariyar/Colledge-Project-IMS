class HomeController < ApplicationController
  def index
        
    if user_signed_in?
        redirect_to ims_main_path
    else
        render 'index'
    end
    
end
end
