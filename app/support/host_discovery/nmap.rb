module HostDiscovery
  module Nmap

    def self.ping_scan
      Host.transaction do

        nmap_output = `sudo nmap -PR -PP -PM -sn 192.168.1.0/24 -oX -`
        nmap_doc = Nokogiri::XML(nmap_output)
        updated_host_ids = []
        (nmap_doc % 'nmaprun' / 'host').each do |host_node|
          state = host_node.at('status').attr('state')
          hostname = host_node.search('hostname').first&.attr('name')
          addresses = host_node.search('address').map { |a| [a['addrtype'].to_sym, a['addr']] }.to_h
          mac = Mac.find_or_initialize_by(address: addresses[:mac]) if addresses[:mac].present?
          ipv4 = Ip.find_or_initialize_by(address: addresses[:ipv4]) if addresses[:ipv4].present?
          hostname = Hostname.find_or_initialize_by(name: hostname) if hostname.present?


          puts "#########################################################"
          puts "MAC      : #{mac&.address}"
          puts "IP       : #{ipv4&.address}"
          puts "Hostname : #{hostname&.name}"
          puts "#########################################################"

          if mac.present?
            mac.last_seen_by_arp = Time.now
            mac.host = Host.create! unless mac.host
            mac.save!
          end

          if ipv4.present?
            ipv4.last_seen_by_ping = Time.now
            ipv4.mac = mac if mac.present?
            ipv4.save!
          end

          if hostname.present?
            hostname.ip = ipv4 if ipv4.present?
            hostname.save!
          end

        end

      end
    end

  end
end