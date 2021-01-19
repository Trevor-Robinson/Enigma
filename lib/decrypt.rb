require './lib/enigma'
decrypter = Enigma.new
file = File.open("./lib/#{ARGV[0]}")
decrypter.decrypt(file.readline, ARGV[2], ARGV[3])
new_file = File.open("./lib/#{ARGV[1]}", "w")
new_file.write(decrypter.output_hash[:decryption])
puts "Created '#{ARGV[1]}' with the key #{decrypter.output_hash[:key]} and date #{decrypter.output_hash[:date]}"
