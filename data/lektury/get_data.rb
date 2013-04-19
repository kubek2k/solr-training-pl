require 'net/http'
require 'rubygems'
require 'json'

main_json_string = Net::HTTP.get(URI('http://wolnelektury.pl/api/books/'))

json = JSON.parse(main_json_string)
p json.size

i = 0
json.each { |book|
    if (i > 100) then 
        break
    end

    book_api = book['href']

    book_json = JSON.parse(Net::HTTP.get(URI(book['href'])))
    book_file_name = (/^.*\/([^\/]+)\/$/.match(book['href']))[1]
    book_txt = Net::HTTP.get(URI(book_json['txt']))

    epochs = book_json['epochs'].collect { |e| e['name'] }
    authors = book_json['authors'].collect { |a| a['name'] }
    kinds = book_json['kinds'].collect { |k| k['name'] }
    genres = book_json['genres'].collect { |g| g['name'] }
    url = book['url']

    p "#{i} Saving document: #{book_file_name}"
    open("documents/#{book_file_name}.json", "w") { |file|
        file.write(JSON.pretty_generate({
            :id => i,
            :text => book_txt, 
            :title => book_json['title'],

            :epoch => epochs,
            :author => authors,
            :genre => genres,
            :kind => kinds,
            :url => url,
        }))
    }

    i += 1
    sleep(rand())
}
