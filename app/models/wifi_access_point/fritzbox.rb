class WifiAccessPoint::Fritzbox < WifiAccessPoint

  validates :password, presence: true

  protected

  def get_clients
    FritzboxWebApi.new(ip.address, password).get_clients
  end

end