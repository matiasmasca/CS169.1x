require 'debugger'              # optional, may be helpful
require 'open-uri'              # allows open('http://...') to return body
require 'cgi'                   # for escaping URIs
require 'nokogiri'              # XML parser
require 'active_model'          # for validations

class OracleOfBacon

  class InvalidError < RuntimeError ; end
  class NetworkError < RuntimeError ; end
  class InvalidKeyError < RuntimeError ; end

  attr_accessor :from, :to
  attr_reader :api_key, :response, :uri
  
  include ActiveModel::Validations
  validates_presence_of :from
  validates_presence_of :to
  validates_presence_of :api_key
  validate :from_does_not_equal_to

  def from_does_not_equal_to
    errors.add(:from_does_not_equal_to, "cannot be the same as To") if from == to
  end

  def initialize(api_key='38b99ce9ec87', from='Kevin Bacon', to='Kevin Bacon')
     @from = from
     @to = to
     @api_key = api_key
   end

 def find_connections
  make_uri_from_arguments
  begin
    xml = URI.parse(uri).read
  rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
    Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
    Net::ProtocolError => e
    # convert all of these into a generic OracleOfBacon::NetworkError,
    # but keep the original error message
    raise OracleOfBacon::NetworkError
  end
    OracleOfBacon::Response.new(xml)
 end
 
  def make_uri_from_arguments
    @uri = "http://oracleofbacon.org/cgi-bin/xml?p=#{@api_key}&a=#{CGI.escape(@from)}&b=#{CGI.escape(@to)}"
  end
 
  class Response
    attr_reader :type, :data
    # create a Response object from a string of XML markup.
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
      parse_response
    end

    private
    def parse_response
      if ! @doc.xpath('/error').empty?
        parse_error_response
      elsif @doc.xpath('/spellcheck').any?
        parse_spellcheck_response
      elsif @doc.xpath('/link').any?
        parse_graph_response
      else
        parse_unknown_response
      end
    end

   def parse_error_response
      @type = :error
      @data = 'Unauthorized access'
   end

   def parse_spellcheck_response
      @type = :spellcheck
      @data = @doc.xpath('//match').collect{|m| m.text}
   end

   def parse_graph_response
      @type = :graph
      @data = @doc.xpath('//actor').collect{|a| a.text}.zip(@doc.xpath('//movie').collect{|m| m.text}).flatten.compact
   end
  
   def parse_unknown_response
     @type = :unknown
     @data = "unknown response"
   end
  end
end