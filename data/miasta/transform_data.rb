#!/usr/bin/ruby

require 'rubygems'
require 'json/ext'

def transform_to_fraction(degrees_string) 
    match = /([0-9]{2})..([0-9]{2}).*/.match(degrees_string)
    return match[1].to_f + (match[2].to_f * 1.0/60.0)
end

open(ARGV[0], 'r') { |file|
    content = file.read()

    JSON.parse(content).each { |city|
        file_name = city['nazwa'].downcase.gsub(/[^a-z]/, '_')
        p file_name

        geolat = transform_to_fraction(city['szerokosc'])
        geolon = transform_to_fraction(city['dlugosc'])
        open("documents/#{file_name}.json", "w") { |out|
            out.write({
                :name => city['nazwa'],
                :url => city['link'],
                :coordinates => geolat.to_s + "," + geolon.to_s,
                :population => city['ludnosc'],
            }.to_json)
        }

    }
}
