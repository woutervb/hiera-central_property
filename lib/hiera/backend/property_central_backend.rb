# Property Central Backend for Hiera
# heavely based on the Foreman Backend for Hiera by torrancew 

class Hiera
  module Backend
    class Property_central_backend
      attr_reader :url

      def initialize
        require 'pry'
        require 'net/http'

        @url = Config[:property_central][:url]
        Hiera.debug("Property Central backend starting")
      end

      def lookup(key, scope, order_override, resolution_type)
        Hiera.debug("Looking up #{key} in Property Central backend")
        answer = Backend.empty_answer(resolution_type)
        
        fqdn = scope['fqdn'] if scope.has_key?('fqdn')

        property_central_uri      = URI.parse("#{@url}/hiera/#{fqdn}")
        http             = Net::HTTP.new(property_central_uri.host, property_central_uri.port)
        request          = Net::HTTP::Get.new(property_central_uri.request_uri)

        YAML.load(http.request(request).body)['parameters'][key]
      end
    end
  end
end

