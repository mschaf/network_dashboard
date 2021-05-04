class WifiClient < ApplicationRecord

  belongs_to :wifi_access_point
  belongs_to :mac

end