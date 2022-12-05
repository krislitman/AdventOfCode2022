# frozen_string_literal: true

class Generator
  def self.create_ranges(input)
    {
      elf_1: create_range(input.first),
      elf_2: create_range(input.last)
    }
  end

  def self.create_range(input)
    s = input.split("-").first.to_i
    e = input.split("-").last.to_i

    (s..e).to_a
  end
end

class Evaluator
  def self.complete_compare(elf_1, elf_2)
    {
      one: elf_1 - elf_2,
      two: elf_2 - elf_1
    }
  end

  def self.overlap_compare(elf_1, elf_2)
    (elf_1 & elf_2).any?
  end
end

complete_count = 0
overlap_count = 0

# open text file and grab input for each elf
File.open("day4/input.txt").each_line do |line|
  range = Generator.create_ranges(line.chomp.split(","))
  complete_results = Evaluator.complete_compare(range[:elf_1], range[:elf_2])
  overlap_results = Evaluator.overlap_compare(range[:elf_1], range[:elf_2])

  # results will return empty if all of the
  # numbers are contained in both ranges
  if complete_results.any? {|k,v| v.empty?}
    complete_count += 1
  end

  # overlap results will return true
  # if there is any overlap between assignments
  if overlap_results
    overlap_count += 1
  end
end

puts "There are #{complete_count} amount of assignment pairs that fully contain the other"
puts "There are #{overlap_count} amount of assignment pairs that partially contain the other"

