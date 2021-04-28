class DashboardController < ApplicationController

  def show
    @hosts = Host.all
  end

end