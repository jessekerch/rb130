# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
  
  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end


# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.
class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(item)
    raise TypeError, 'can only add Todo objects' unless item.instance_of? Todo
    todos << item
  end
  alias_method :add, :<<
  
  def size
    p todos.size
  end
  
  def first
    puts todos.first
  end
  
  def last
    puts todos.last
  end
  
  def to_a
    todos.clone
  end
  
  def done?
    todos.all? {|item| item.done?}
  end
  
  def item_at(index)
    todos.fetch(index)
  end
  
  def remove_at(index)
    todos.delete(item_at(index))
  end
  
  def mark_done_at(index)
    if todos[index]
      todos[index].done!
    else
      raise(IndexError)
    end
  end
  
  def mark_undone_at(idx)
    item_at(idx).undone!
  end
  
  def done!
    todos.each_index do |idx|
      mark_done_at(idx)
    end
  end
  
  def to_s
    text = "---- Today's Todos ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end
  
  def shift
    todos.shift
  end

  def pop
    todos.pop
  end
  
  def each
    counter = 0
    
    while counter < todos.size do
      yield(todos[counter])
      counter += 1
    end
    
    self
  end
  
  def select
    selection = TodoList.new('Selected Todos')

    todos.each do |item|
      selection << item if yield(item)
    end
    
    selection
  end
  
  def find_by_title(select_title)
    todos.each do |item|
      return item if item.title == select_title
    end
  end
  
  def all_done
    select {|item| item.done? }
  end

  def all_not_done
    select {|item| !item.done? }
  end

  def mark_done(select_title)
    find_by_title(select_title) && find_by_title(select_title).done!
  end

  def mark_all_done
    each {|item| item.done!}
  end

  def mark_all_undone
    each {|item| item.undone!}
  end


  private 
  
  attr_reader :todos
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo2.done!

puts list.find_by_title('Buy milk')

puts list.all_done

puts list.all_not_done

list.mark_done('Go to gym')

puts list

list.mark_all_done

puts list

list.mark_all_undone

puts list

# todo1.done!

# results = list.select { |todo| todo.done? }    # you need to implement this method

# puts results.inspect

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# list.each do |todo|
#   puts todo                   # calls Todo#to_s
# end

# # given
# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")
# list = TodoList.new("Today's Todos")

# # ---- Adding to the list -----

# # add
# list.add(todo1)                 # adds todo1 to end of list, returns list
# list.add(todo2)                 # adds todo2 to end of list, returns list
# list.add(todo3)                 # adds todo3 to end of list, returns list
# # list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# # <<
# # same behavior as add

# # # ---- Interrogating the list -----

# # # size
# list.size                       # returns 3

# # # first
# # list.first                      # returns todo1, which is the first item in the list

# # # last
# # list.last                       # returns todo3, which is the last item in the list

# # #to_a
# # list.to_a                      # returns an array of all items in the list

# # #done?
# # p list.done?                     # returns true if all todos in the list are done, otherwise false

# # # ---- Retrieving an item in the list ----

# # # item_at
# # list.item_at                    # raises ArgumentError
# list.item_at(1)                 # returns 2nd item in list (zero based index)
# # list.item_at(100)               # raises IndexError

# # # ---- Marking items in the list -----

# # # mark_done_at
# # list.mark_done_at               # raises ArgumentError
# # list.mark_done_at(1)            # marks the 2nd item as done
# # list.item_at(1)                 # returns 2nd item in list (zero based index)
# # list.mark_done_at(100)          # raises IndexError

# # # mark_undone_at
# # list.mark_undone_at             # raises ArgumentError
# # list.mark_undone_at(1)          # marks the 2nd item as not done,
# # list.mark_undone_at(100)        # raises IndexError
# # list.item_at(1)                 # returns 2nd item in list (zero based index)

# # # done!
# list.done!                      # marks all items as done

# # # ---- Deleting from the list -----

# # # shift
# # puts list.shift                      # removes and returns the first item in list

# # # pop
# # puts list.pop                        # removes and returns the last item in list

# # # remove_at
# # list.remove_at                  # raises ArgumentError
# list.remove_at(1)               # removes and returns the 2nd item
# # list.remove_at(100)             # raises IndexError

# # # ---- Outputting the list -----

# # # to_s
# list.to_s                      # returns string representation of the list

# # ---- Today's Todos ----
# # [ ] Buy milk
# # [ ] Clean room
# # [ ] Go to gym

# # or, if any todos are done

# # ---- Today's Todos ----
# # [ ] Buy milk
# # [X] Clean room
# # [ ] Go to gym

