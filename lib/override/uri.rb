# encoding: utf-8
require 'uri'

module URI
  class << self
    alias_method :old_encode_www_form_component, :encode_www_form_component
    def encode_www_form_component(str)
      str = old_encode_www_form_component str
      str.gsub!(/\*/, TBLENCWWWCOMP_)
      str
    end
  end
end
