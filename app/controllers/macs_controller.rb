class MacsController < ApplicationController

  def edit
    load_mac
  end

  def update
    load_mac
    build_mac
    if @mac.save
      redirect_to hosts_url
    else
      render 'edit'
    end
  end

  private

  def load_mac
    @mac ||= mac_scope.find(params[:id])
  end

  def build_mac
    @mac ||= mac_scope.build
    @mac.attributes = mac_params
  end

  def mac_params
    mac_params = params[:mac]
    mac_params ? mac_params.permit(:host_id) : {}
  end

  def mac_scope
    Mac.all
  end

end