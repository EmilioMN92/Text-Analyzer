class LineAnalyzer
	attr_reader :content, :line_number

	# CONSTRUCTOR
	def initialize(line, number)
		@content = line
		@line_number = number
		calculate_word_frequency
	end

	# INSTANCE METHOD
	def calculate_word_frequency
		mapa = Hash.new(0)
		@highest_wf_words = []
		content.split.each { |word| mapa[word.downcase] += 1 }
		@highest_wf_count = mapa.values[0]
		mapa.each_pair do |k,v|
			if v == @highest_wf_count
				@highest_wf_words << k
			end
		end
		#puts "Línea: #{@content}"
		#puts "Palabras: #{@highest_wf_words}"
	end

end

class Solution < LineAnalyzer
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
		@highest_count_across_lines = @analyzers.max_by do 
			|a| a.instance_variable_get(:@highest_wf_count)
		end .instance_variable_get(:@highest_wf_count)
		
		@highest_count_words_across_lines << @analyzers.each do
			|a| a.instance_variable_get(:@highest_wf_count) == @highest_count_across_lines
		end
		p @highest_count_words_across_lines
		p @highest_count_words_across_lines[1]
	end

	def print_highest_word_frequency_across_lines
		puts "The following words have the highest word frequency per line: 
			\n #{} (appears in line #{})"
	end

end

#ex = LineAnalyzer.new("Aqui de que estamos aqui de watilpei", 777)
s = Solution.new
s.analyze_file
s.calculate_line_with_highest_frequency