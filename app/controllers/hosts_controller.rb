class HostsController < ApplicationController

  def index
    load_hosts
  end

  private

  def load_hosts
    @hosts = Host.all
  end

end