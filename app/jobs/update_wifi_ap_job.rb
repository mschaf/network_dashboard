class UpdateWifiApJob < ApplicationJob
  queue_as :default

  def perform(wifi_ap)
    wifi_ap.update_clients!
  end

end