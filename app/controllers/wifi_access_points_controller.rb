class WifiAccessPointsController < ApplicationController

  def index
    load_wifi_access_points
  end

  def new
    build_wifi_access_point
  end

  def create
    build_wifi_access_point
    if @wifi_access_point.save
      redirect_to wifi_access_points_path
    else
      render 'new'
    end
  end

  def edit
    load_wifi_access_point
  end

  def update
    load_wifi_access_point
    build_wifi_access_point
    if @wifi_access_point.save
      redirect_to wifi_access_points_path
    else
      render 'edit'
    end
  end

  private

  def load_wifi_access_points
    @wifi_access_points = wifi_access_point_scope.all
    @lose_ips = Ip.where(mac: nil)
  end

  def load_wifi_access_point
    @wifi_access_point ||= wifi_access_point_scope.find(params[:id])
  end

  def build_wifi_access_point
    @wifi_access_point ||= wifi_access_point_scope.build
    @wifi_access_point.attributes = wifi_access_point_params
  end

  def wifi_access_point_params
    wifi_access_point_params = params[:wifi_access_point]
    wifi_access_point_params ? wifi_access_point_params.permit(:ip_id, :name, :password, :type) : {}
  end

  def wifi_access_point_scope
    WifiAccessPoint.all
  end

end