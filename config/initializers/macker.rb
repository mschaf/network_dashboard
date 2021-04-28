Macker.configure do |config|
  config.oui_full_url = 'http://linuxnet.ca/ieee/oui.txt'                                       # Full URL of OUI text file
  config.user_agent = 'Mozilla/5.0 (X11; Linux x86_64; rv:54.0) Gecko/20100101 Firefox/54.0'  # A common user agent
  config.ttl_in_seconds = 86_400                                                                  # Will expire the vendors in one day
  config.cache = File.expand_path(File.dirname(__FILE__) + '/../../tmp/oui_*.txt')      # Can be a string, pathname or proc
  config.auto_expire = true                                                                    # Expiration can be checked manually
  config.auto_stale = true                                                                    # Stale can be checked manually
end