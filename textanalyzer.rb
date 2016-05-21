#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  attr_reader :content, :line_number, :highest_wf_words, :highest_wf_count
  # CONSTRUCTOR
  def initialize(line, number)
    @content = line
    @line_number = number
    @highest_wf_words = []
    calculate_word_frequency
  end

  # INSTANCE METHOD
  def calculate_word_frequency
    mapa = Hash.new(0)
    @highest_wf_words = []

    content.split.each { |word| mapa[word.downcase] += 1 }
    @highest_wf_count = mapa.values.max

    mapa.each_pair do |k,v|
      if v == @highest_wf_count
        @highest_wf_words << k
      end
    end
  end
end

#  Implement a class called Solution. 
class Solution
  attr_reader :analyzers, 
              :highest_count_across_lines, 
              :highest_count_words_across_lines

  def initialize
    @analyzers = [] 
  end

  def analyze_file
    File.foreach('test.txt') do |line|
      @analyzers << LineAnalyzer.new(line.chomp,@analyzers.length+1)
    end 
    #puts "#{analyzers}"
  end
  
  def calculate_line_with_highest_frequency
    @highest_count_words_across_lines = []
    @index = []
    @highest_count_across_lines = @analyzers.map(&:highest_wf_count).max

    for i in 0..@analyzers.length-1 do
      if @analyzers[i].highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines << @analyzers[i].highest_wf_words
        @index << i
      end
    end
    @highest_count_words_across_lines = @highest_count_words_across_lines.flatten   
  end

  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:";
    @index.each{ |i| puts "#{@analyzers[i].highest_wf_words} (appears in line #{i+1})"}
  end
end
