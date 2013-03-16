require 'jrjackson_r' unless defined?(::JrJackson)
require 'multi_json/convertible_hash_keys'

module MultiJson
  module Adapters
    class Jrjackson < ThickAdapter
      include ConvertibleHashKeys
      ParseError = ::Java::OrgCodehausJackson::JsonParseException

      def load(string, options={})
        string = string.read if string.respond_to?(:read)
        result = ::JrJackson::Json.parse(string)
        options[:symbolize_keys] ? symbolize_keys(result) : result
      end

      def dump(object, options={})
        ::JrJackson::Json.generate(stringify_keys(prepare_object(object)))
      end
    end
  end
end
