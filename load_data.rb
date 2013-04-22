#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'net/http'

@solr_endpoint = "/solr/#{ARGV[0]}/update?commit=true"
@solr_host = 'localhost'
@solr_port = 8011
documents_directory = ARGV[1]

def post_json(json)
        request = Net::HTTP::Post.new(@solr_endpoint, initheader = {'Content-type' => 'application/json'})
        request.body = json
        response = Net::HTTP.new(@solr_host, @solr_port).start { |http|
            http.request(request)
        }
        if (response.code != "200") then
            p "An issue occurred while uploading #{json['title']}"
        end
end

idx = 0
post_json({"delete" => { "query" => "*:*" }}.to_json)
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

        post_json(json_to_submit)

        idx += 1
    }
end
