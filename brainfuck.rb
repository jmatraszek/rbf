memory = Array.new(300, 0)
$/ = "\0"
program = String.new("\0")
program = STDIN.gets
i = 0
mp = 0
# 8.times do
  # for i in 0..9 do
    # print i
  # end
# end
print "\n"
puts program
loop_address = Array.new
while program[i].to_s =~ /\S|$\s/ do 
  instruction = program[i].chr
  case instruction
  when "<":
    mp -= 1
    #print "<"
  when ">":
    mp += 1
    #print ">"
  when "+":
    memory[mp] = memory[mp] + 1
    #print '+'
  when "-":
    memory[mp] = memory[mp] - 1
    #print '-'
  when ".":
    print memory[mp].chr
    #print '.'
  when ",":
    #print ','
    begin
      system("stty -raw echo")
      memory[mp] = STDIN.getc
    ensure
      system("stty raw -echo")
    end
  when "[":
    #print "["
    if memory[mp] == 0 
      j = program.index(']', i)
      tmp = program.slice(i+1,j-i-1)
      found = tmp.scan("[")
      n = found.length
      #print "n = #{n}\n"
      if n > 0
        n.times do
          i = j
          j = program.index(']', i + 1)
        end
      end
      i = j
    else #wchodzimy w petle
      loop_address.push(i)
    end
  when "]":
    #print "]\n"
    i = loop_address.pop.to_i - 1
  else
    #p instruction
  end
  #print "\n"
  i += 1
end
print "\n"