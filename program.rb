#!/usr/bin/env ruby

require_relative 'app/conference'
require_relative 'app/exceptions/impossible_to_schedule_talk_exception'
require_relative 'app/exceptions/invalid_file_exception'

if __FILE__ == $0

  @file_name = "default-talks.txt"

  ARGV.each do|argument|
    @file_name = argument
  end

  begin
    conference = Conference.new(@file_name)
    conference.schedule
  rescue ImpossibleToScheduleTalkException, InvalidFileException => e
    abort("Conference shedule terminated. #{e.message}")    
  end


  schedule_result = open("conference-output.txt", 'w')
  schedule_result.write(conference.print_schedule)
  schedule_result.close

  abort("File #{@file_name} read, output file 'conference-output.txt' created!!!")
end

