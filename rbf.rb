memory = Array.new(300, 0)
$/ = "\0"
program = String.new("\0")
program = STDIN.gets
i = 0
mp = 0
loop_address = Array.new
while program[i].to_s =~ /\S|$\s/ do 
  instruction = program[i].chr
  case instruction
  when "<":
    mp -= 1
  when ">":
    mp += 1
  when "+":
    memory[mp] = memory[mp] + 1
  when "-":
    memory[mp] = memory[mp] - 1
  when ".":
    print memory[mp].chr
  when ",":
    begin
      system("stty -raw echo")
      memory[mp] = STDIN.getc
    ensure
      system("stty raw -echo")
    end
  when "[":
    if memory[mp] == 0
      n = 0
      m = 0
      j = i
      while (n==0 && m==0) || n!=m do
        j = program.index(']', j+1)
        m += 1
        tmp = program.slice(i,j-i+1)
        found = tmp.scan("[")
        n = found.length
      end
      i = j
    else #wchodzimy w petle
      loop_address.push(i)
    end
  when "]":
    i = loop_address.pop.to_i - 1
  else
    #p instruction
  end
  i += 1
end
print "\n"
