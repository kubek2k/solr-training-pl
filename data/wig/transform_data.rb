#!/usr/bin/ruby

require 'rubygems'
require 'json'

open('pslaski_WIG20.json', 'r') { |file|
    json = JSON.parse(file.read)
    json['dane_historyczne_wig20'].each { |entry|
        open("documents/wig-#{entry['Data']}.json", 'w') { |out|
            out.write({
                :date => entry['Data'] + "T00:00:00Z",
                :open => entry['Otwarcie'],
                :close => entry['Zamkniecie'],
                :max => entry['Najwyzszy'],
                :min => entry['Najnizszy'],
            }.to_json)
        }
    }
}
