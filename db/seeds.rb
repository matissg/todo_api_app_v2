Tag.create!(title: "Today")

task = TaskWithTag.new(Task)
task.params = { title: "Wash laundry", tags: ["Today"] }
task.save
