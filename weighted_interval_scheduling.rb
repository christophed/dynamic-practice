# A class representing an event request

class Request
  attr_accessor :start, :finish, :weight

  def initialize(start, finish, weight)
    raise "Finish cannot be before start" unless finish >= start

    @start = start
    @finish = finish
    @weight = weight
  end
end

# A class representing a scheduler
class Schedule
  def initialize(requests=[])
    @dirty = false
    @requests = requests
  end

  def sort!
    if @dirty
      requests.sort! {|x, y| x.finish <=> y.finish }
      @dirty = false
    end
  end

  def print_table
    printf("Start | Finish |  Weight\n")
    printf("------+--------+--------\n")
    requests.each do |x|
      printf("%5d | %6d | %6d\n", x.start, x.finish, x.weight)
    end
  end

  def print_diagram
    printf("Weight|\n")
    printf("------+\n")
    requests.each do |x|
      printf("%6d|#{" " * x.start}#{"+" * (x.finish - x.start)}\n", x.weight)
    end
  end

  def print
    print_diagram
  end

  def <<(item)
    @dirty = true
    requests << item
  end

  def requests
    @requests ||= []
  end

  def total_weight
    requests.reduce(0) do |sum,x| sum + x.weight end
  end

  def schedule; end
  def best_weight; return 0; end
  private
  
  def previous_fit(i)
    sort!
    if i >= requests.length || i < 0
      raise "Out of bounds"
    end
   
    attempt = i
    while(attempt > 0)
      attempt-=1
      if requests[attempt].finish < requests[i].start
        return attempt 
      end
    end

    return -1
  end
  
  def opt_i(i)
    if i == -1
      0
    else
      [requests[i].weight + opt_i(previous_fit(i)), opt_i(i-1)].max
    end
  end
end

# TODO -- not yet implemented
class BruteSchedule < Schedule
  def best_weight
    opt_i(requests.length-1)
  end

end

class MemoizedSchedule < Schedule
  def best_weight
    memoize! unless @memoized
    return @memoized[@requests.length - 1]
  end

  def memoize!
    @memoized = []
    
    requests.length.times do |i|
      if i == 0
        @memoized[i] = [0, requests.first.weight].max
      else
        @memoized[i] = [requests[i].weight + opt_i(previous_fit(i)), opt_i(i-1)].max
      end
    end
  end
end

class MainTest
  def initialize(test=1)
    @test = test
  end

  def perform
    self.__send__(:"test#{@test}")
  end

  def test1
    requests = []
    10.times do |time|
      start = rand
      finish = start + 1 + rand(10)
      weight = rand
      requests << Request.new(start, finish, weight)
    end

    schedule = Schedule.new(requests)
    brute_schedule = BruteSchedule.new(requests)
    memoized_schedule = MemoizedSchedule.new(requests)
    
    puts "Before sorting:"
    schedule.print
    schedule.sort!
    puts "\nAfter sorting:"
    schedule.print

    puts "Best weight: #{brute_schedule.best_weight}/#{brute_schedule.total_weight}"
    raise "Answers do not match" unless brute_schedule.best_weight == memoized_schedule.best_weight
  end

  def rand(max=100)
    Kernel.rand(max)
  end
end

MainTest.new.perform
