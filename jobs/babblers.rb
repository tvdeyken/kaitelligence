require 'net/https'
require 'json'
require 'time'

# babbler ID for this job

babbler_ids = ["G7VJSALKBF","GBKBTZBNNN","GLWSMK7AHI","GMDHXRORLU","H72N553G7I"].freeze

SCHEDULER.every '1m', :first_in => 0 do |job|
  babbler_ids.each do |babbler_id|
    http = Net::HTTP.new("api.babbler.io", 1026)
    http.use_ssl = false
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(Net::HTTP::Get.new("/v2/entities/#{babbler_id}"))

    babbler = JSON.parse(response.body)  

    
    if babbler["temperature"]
      babbler_temperature=babbler["temperature"]["value"].to_f.round
    else
      babbler_temperature="??"
    end

    if babbler["baseTemperature"]
      babbler_baseTemperature=babbler["baseTemperature"]["value"].to_f.round(2)  
    else
      babbler_baseTemperature="NO Temp"
    end

    if babbler["degreeDays"]
      babbler_degreeDayse=babbler["degreeDays"]["value"].to_f.round(2)
    else
      babbler_degreeDayse="NO base"
    end
  
    babbler_lastSeen=Time.iso8601(babbler["lastSeen"]["value"]).strftime("Last Seen on %m/%d/%Y at %H:%M:%S") 
    babbler_location=babbler["location"]["value"]
    
    if babbler["sealDate"]
      if babbler["sealDate"]["value"] == "NA" 
        babbler_sealDate="Unsealed"
        seal_status = "Unsealed"        
      else
        babbler_sealDate=Time.iso8601(babbler["sealDate"]["value"]).strftime("Sealed on %m/%d/%Y at %H:%M:%S")
        if babbler["sealBrokenDate"]["value"] != "NA"
          babbler_sealBrokenDate=Time.iso8601(babbler["sealBrokenDate"]["value"]).strftime("Seal broken %m/%d/%Y at %H:%M:%S")
          babbler_sealBy="BROKEN"
          seal_status = "Broken"
        else    
          babbler_sealBy=babbler["sealDate"]["createdBy"]["value"]
          seal_status = "Sealed"
        end
      end
    else
      babbler_sealDate="Never sealed"
      seal_status = "Unsealed"
    end
    
    
    send_event(babbler_id, { 
      babbler_lastSeen: "#{babbler_lastSeen}  ", 
      babbler_temperature: "#{babbler_temperature}&deg;", 
      babbler_location: "#{babbler_location}", 
      babbler_sealBrokenDate: "#{babbler_sealBrokenDate}",
      babbler_sealDate: "#{babbler_sealDate}",
      babbler_sealBy: "#{babbler_sealBy}", 
      seal_status: "#{seal_status}",
      babbler_temperature: "#{babbler_temperature}&deg;", 
      babbler_baseTemperature: "#{babbler_baseTemperature}&deg;"})
    end
  end
