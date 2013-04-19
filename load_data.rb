#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'net/http'

solr_endpoint = "/solr/#{ARGV[0]}/update?commit=true"
solr_host = 'localhost'
solr_port = 8011
documents_directory = ARGV[1]

idx = 0
Dir.foreach(documents_directory) do |item|
    next if item == '.' or item == '..' or !(/.*\.json/ =~ item)

    open(documents_directory + "/" + item, "r") { |file|
        content = file.read
        content_json = JSON.parse(content)
        content_json['id'] = idx

        json_to_submit = {
            "add" => {
                "doc" => content_json
            }
        }.to_json

        request = Net::HTTP::Post.new(solr_endpoint, initheader = {'Content-type' => 'application/json'})
        request.body = json_to_submit
        response = Net::HTTP.new(solr_host, solr_port).start { |http|
            http.request(request)
        }
        if (response.code != "200") then
            p "An issue occurred while uploading #{content_json['title']}"
        end

        idx += 1
    }
end
