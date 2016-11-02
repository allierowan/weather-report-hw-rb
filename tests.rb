Dir.glob("*_test.rb").each do |file|
  require_relative file
end
