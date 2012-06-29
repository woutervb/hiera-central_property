# Property Central Backend for Hiera
# heavely based on the Foreman Backend for Hiera by torrancew 

class Hiera
  module Backend
    class Property_central_backend
      attr_reader :url

      def initialize
        require 'net/http'

        @url = Config[:property_central][:url]
        Hiera.debug("Property Central backend starting")
      end

      def lookup(key, scope, order_override, resolution_type)
        Hiera.debug("Looking up #{key} in Property Central backend")

        new_key = key.split("::").last
        Hiera.debug("Looking up using #{new_key}")

        answer = nil
        fqdn = scope['fqdn'] if scope.has_key?('fqdn')

        property_central_uri      = URI.parse("#{@url}/hiera/#{fqdn}")
        http             = Net::HTTP.new(property_central_uri.host, property_central_uri.port)
        request          = Net::HTTP::Get.new(property_central_uri.request_uri)
        node_definition  = YAML.load(http.request(request).body)

        new_answer = Backend.parse_answer(node_definition['parameters'][new_key], scope)
        case resolution_type
        when :array
          answer ||= []
          answer << new_answer
        when :hash
          answer ||= {}
          answer = new_answer.merge answer
        else
          answer = new_answer
        end
        Hiera.debug("Answer is #{answer}")

        return answer
      end
    end
  end
end

