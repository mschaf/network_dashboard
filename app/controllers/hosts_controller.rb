class HostsController < ApplicationController

  def index
    load_hosts
  end

  private

  def load_hosts
    @hosts = Host.all.joins(:ipv4).order('inet(address)')
  end

end