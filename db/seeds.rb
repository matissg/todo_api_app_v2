Tag.create!(title: "Today")

task = ResourceWithTag.new(Task)
task.params = { title: "Wash laundry", tags: ["Today"] }
task.save
