class Node
  attr_accessor :level, :position, :value, :parent
  def initialize(value=nil, parent=nil)
    if parent.nil?
      @level = 0
    else #it has parent
      @level = parent.level+1 
    end
    @value = value
    @parent = parent
    @children = 0
    @position = nil
    p "NEW NODE FROM NODE CLASS: #{self.inspect}"
  end
  
  def spawnChild(value)
    if @children == 0
      left_child = Node.new(value, self)
      left_child.position = 0
      @children+=1
      return left_child
    elsif @children == 1
      right_child = Node.new(value, self)
      right_child.position = 1
      @children+=1
      return right_child
    else return "Too many children"
    end

  end
end

class Tree
  def initialize(arr)
    @root = nil
    @left_sub, @right_sub = nil, nil
    @arr = arr.uniq.sort
  end

  def median(arr)
    #gets left-most median in even cases
    return (arr[((arr.length-1)/2)])
  end

  def build_tree(arr=@arr)
    ####################################### SOLVES LEFT HALF, REWORK TO TAKE WHOLE THING
    if @root.nil? 
        @root = Node.new(median(arr.uniq.sort)) 
        @parent = @root
    elsif arr.length == 2 #if theres two in array, spawn child which spawns another child
        p "CASE 1 arr: #{arr}"
        child = @parent.spawnChild(arr[0])
        grandchild = child.spawnChild(arr[1])
        @parent = child.parent
        return child.parent
    elsif arr.length > 2  #spawn child from current parent, calls again from more left half
        p "CASE 2 arr: #{arr}"
        p @parent.inspect
        @parent = @root if child.nil? 
        child = @parent.spawnChild(median(arr)) 
        @parent = child
    end

    build_tree(arr[0...(arr.length/2).floor])
    p "STARTING RIGHT HALF..."
    build_tree(arr[(arr.length/2).floor+1..arr.length])

    return @root
  end

end

Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]).build_tree