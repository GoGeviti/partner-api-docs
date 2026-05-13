#!/usr/bin/env ruby

require "json"
require "net/http"

ROOT = File.expand_path("..", __dir__)
ENV_PATH = File.join(ROOT, ".env.gitbook.local")
SPEC_PATH = ARGV[0] || File.join(ROOT, "docs/openapi/partner-api.openapi.yaml")

def load_local_env(path)
  return unless File.exist?(path)

  File.readlines(path, chomp: true).each do |line|
    next if line.strip.empty? || line.start_with?("#")

    key, value = line.split("=", 2)
    next if key.nil? || value.nil?

    ENV[key] = value
  end
end

def required_env(key)
  value = ENV[key].to_s.strip
  abort "#{key} is required" if value.empty?
  value
end

load_local_env(ENV_PATH)

token = required_env("GITBOOK_TOKEN")
organization_id = required_env("GITBOOK_ORGANIZATION_ID")
spec_slug = required_env("GITBOOK_OPENAPI_SLUG")
spec = File.read(SPEC_PATH)

uri = URI("https://api.gitbook.com/v1/orgs/#{organization_id}/openapi/#{spec_slug}")
request = Net::HTTP::Put.new(uri)
request["Authorization"] = "Bearer #{token}"
request["Accept"] = "application/json"
request["Content-Type"] = "application/json"
request.body = JSON.generate(source: { text: spec })

response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
  http.request(request)
end

unless response.code.to_i.between?(200, 299)
  abort "GitBook OpenAPI publish failed with #{response.code}: #{response.body}"
end

body = JSON.parse(response.body)
puts "Published OpenAPI spec #{body.fetch("slug")} (#{body.fetch("id")})"
puts "Processing state: #{body.fetch("processingState")}"
puts "App URL: #{body.dig("urls", "app")}"
