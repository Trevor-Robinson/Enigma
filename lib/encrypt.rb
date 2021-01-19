require './lib/enigma'
enigma = Enigma.new
file = File.open("./lib/#{ARGV[0]}")
enigma.encrypt(file.readline)
new_file = File.open("./lib/#{ARGV[1]}", "w")
new_file.write(enigma.output_hash[:encryption])
puts "Created '#{ARGV[1]}' with the key #{enigma.output_hash[:key]} and date #{enigma.output_hash[:date]}"
