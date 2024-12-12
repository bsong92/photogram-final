class HomeController < ApplicationController

  def launch

    render({ :template => "home"})
  end
end
