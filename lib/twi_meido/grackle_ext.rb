# encoding: utf-8
module Grackle
  module Handlers
    class JSON2MashHandler
      def decode_response(res)
        json_result = JSON.parse(res) rescue res
        if json_result.respond_to?(:each_pair)
          Hashie::Mash.new(json_result)
        elsif json_result.respond_to?(:collect)
          json_result.collect {|item| decode_response item }
        else
          res
        end
      end
    end
  end
end
