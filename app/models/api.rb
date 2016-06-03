class Api
    def self.post(uri, web_motors_id = nil)   
        begin  

            if web_motors_id.nil?
                response = Net::HTTP.post_form(uri, {})
            else
                response = Net::HTTP.post_form(uri, { marca: web_motors_id })
            end

            json = JSON.parse response.body  

        return json
        rescue Exception => e  
            # handles error
            Rails.logger.info "MESSAGEM: #{e.inspect}"
            Rails.logger.info "BACKTRACE: #{e.backtrace.inspect}"
        return nil
        end
    end  
end