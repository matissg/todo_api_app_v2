# README

This demo Rails 6.0 API app is prepared by Matiss Gaigals.

A simple TODO application that allows to:
* Add new task (at least 3 characters for task title)
* Edit existing task
* List all tasks
* Tag a task (at least 3 letters for tag and up to 30 tags allowed)
* Delete existing task

Demo app functionality is extended in order to demonstrate some of OOP principles:
* Polymorphism - tag can be added not only to task, but to post as well by using same Tagging model
* Inheritance - tasks and posts controllers inherit from same class Api::V1::ResourceWithTagsController
* Encapsulation - tasks and posts title together can be created / updated with class ResourceWithTag which does only that
* Abstraction - there is certain level of abstraction used not only in controllers, but tests as well, for example spec/support/shared_examples
