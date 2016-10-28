class Task
  attr_reader :id, :title, :done

  def initialize(title)
    @id     = ID.generate
    @title  = title
    @done   = false
  end

  def toggle
    done ? uncomplete : complete
  end

  def complete
    @done = true
  end

  def uncomplete
    @done = false
  end
end
