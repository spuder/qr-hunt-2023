require 'pdf-reader'

def extract_text_from_pdf(file_path)
  reader = PDF::Reader.new(file_path)
  text = ""
  
  reader.pages.each do |page|
    text += page.text
  end
  
  text
end

def find_word(text, word, offset)
  # Regular expression pattern for standard punctuation
  punctuation_pattern = /[.,'"?;:!`]/

  words = text.split(/\s+/).map do |w|
    w.gsub(punctuation_pattern, '') # Remove standard punctuation from each word
  end
  
  # Check if the word exists in the text
  index = words.map(&:downcase).index(word.downcase)
  
  return "XXXXXXX" if index.nil?
  
  target_index = index + offset
  
  # Check if target index is within the bounds of the words array
  return "EEEEEEEE" if target_index < 0 || target_index >= words.length
  
  words[target_index]
end

pdf_file_path = ARGV[0]

text = extract_text_from_pdf(pdf_file_path)

mappings = {
  "BAND" => 8,
  "OATH" => -14,
  "EXISTENCE" => -12,
  "BRIDE" => -6,
  "IGNORANT" => 6,
  "IMPRESSION" => -18,
  "PURPOSE" => 6,
  "NOTICE" => -11,
  "POSSIBILITIES" => 17,
  "CHESS" => 10,
  "STOLEN" => -9,
  "TOGETHER" => 11,
  "WEALTHIER" => -11,
  "CLIFF" => 2,
  "SPENT" => -4,
  "COMPARED" => -10,
  "HUMILIATED" => -9
}

special_mappings = {
  "BRIDE" => {"X EQUALS" => 1},
  "IGNORANT" => {"X TRANSIT" => 11},
  "HUMILIATED" => {"X HANDLED" => -4}
}

mappings.each do |word, offset|
  result = find_word(text, word, offset)
  puts "#{word}: #{result}"
end

# This adjusted section handles special mappings
special_mappings.each do |word, offsets|
    combined_results = []
    
    main_offset = mappings[word]
    
    # If the main word isn't in the regular mappings, set it to XXXXXXX and continue
    if main_offset.nil?
      combined_results << "XXXXXXX"
    else
      main_result = find_word(text, word, main_offset)
      combined_results << main_result
    end
    
    # Next, get the results for its special mappings
    keyword_results = []
    offsets.each do |key, offset|
      keyword = key.split(" ").last
      result = find_word(text, word, offset)
      keyword_results << keyword
      combined_results << result
    end
    
    puts "#{word} x #{keyword_results.join(' x ')}: #{combined_results.join(' - ')}"
  end