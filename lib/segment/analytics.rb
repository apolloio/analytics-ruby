require 'stupidsegment/analytics/defaults'
require 'stupidsegment/analytics/utils'
require 'stupidsegment/analytics/version'
require 'stupidsegment/analytics/client'
require 'stupidsegment/analytics/worker'
require 'stupidsegment/analytics/request'
require 'stupidsegment/analytics/response'
require 'stupidsegment/analytics/logging'

module Stupidsegment
  class Analytics
    def initialize options = {}
      Request.stub = options[:stub] if options.has_key?(:stub)
      @client = Stupidsegment::Analytics::Client.new options
    end

    def method_missing message, *args, &block
      if @client.respond_to? message
        @client.send message, *args, &block
      else
        super
      end
    end

    def respond_to? method_name, include_private = false
      @client.respond_to?(method_name) || super
    end

    include Logging
  end
end
