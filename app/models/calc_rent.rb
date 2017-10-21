
def calc_area(hist,stack,top,index)
  puts "calc inputs"
  puts "#{hist.inspect}, #{stack.inspect}, #{top.inspect}, #{index.inspect}"
  if stack.any?
    area = hist[top] * (index - stack.last - 1)
  else
    area = hist[top] * index
  end
  puts area
  gets.chomp()
  area
end

def maxarea(hist = [])
  puts "IN"
   stack = []
   top = nil
   maxa = -1
   ca = -1
   index = nil
   hist.length.times do |i|
     puts "Iteraiting stack -> #{stack.inspect} | i -> #{i}"
     if stack.empty?
       puts "EMPTY"
       stack << i
     else
       puts "NOT EMPTY stack -> #{stack.inspect} | top -> #{stack.last} | val in top -> #{hist[stack.last]} | i -> #{i} | hist[i] -> #{hist[i]}"
       if hist[i] >= hist[stack.last]
         puts "ADDING TO STACK"
         stack << i
       else
         puts "CALC AREA"
         while stack.any? and hist[i] < hist[stack.last]
           ca = calc_area(hist, stack, stack.pop, i)
           maxa < ca ? maxa = ca : maxa
         end
       end
     end
   end
   puts "END FIRST PHASE"
   index = hist.length
   while stack.any?
     top = stack.pop
     ca = calc_area(hist, stack, top, index)
     maxa < ca ? maxa = ca : maxa
   end
   puts "RESULT " + maxa.to_s
end



maxarea( [2,1,2,3,1 ])
