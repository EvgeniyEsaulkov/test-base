class TodoPresenter
  MAX_TAGS_ALLOWED = 4

  attr_reader :todo

  def initialize(todo)
    @todo = todo
  end

  def display_text
    return todo.title unless todo.tags.any?

    todo_title_with_tags(todo)
  end

  private

  def todo_title_with_tags(todo)
    if (1..MAX_TAGS_ALLOWED).cover? todo.tags.count
      [todo.title, tags_list(todo.tags)].join(" ")
    else
      [todo.title, tags_list(todo.tags.first(MAX_TAGS_ALLOWED)), "and more..."].join(" ")
    end
  end

  def tags_list(tags)
    tags.join(", ")
  end
end
