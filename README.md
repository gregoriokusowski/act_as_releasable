# ActAsReleasable

A simple way to manage approval of ActiveRecord models.
Using ActAsReleasable you can keep track of changed data by creating a candidate without modifying your current model.
When you need, you can just approve the changes and all data will be updated to your model.

## TL;DR

```.act_as_releasable :collections => [:name_if_any]``` on your model.
```#generate_new_candidate``` to apply changes to candidate(without saving).
```#release_candidate``` to get candidate from model.
```#release_version!``` to apply candidate changes to model.
```#has_changes_to_be_approved?``` to check if there is any candidate.

## Installation

Add this line to your application's Gemfile:

    gem 'act_as_releasable'

And then execute (the second step is used to create the gem migrations):

    $ bundle
	$ rails generate act_as_releasable:install

## Usage

In order to make your model releasable, your must call the ```act_as_releasable``` method on your model, like this:

	class Article
	  act_as_releasable
	end

After created, any model who act as releasable is able to generate a candidate.

	article = Article.find(5) # <Article id: 5, title: "Whoa! ActAsReleasable is live!", ...>
	article.title = "ActAsRelesable just received some care :)"
	article.generate_new_candidate

Every ActiveRecord::Base model will work as usual, unless you specify it to behave like releasable(I mean, no AR method is overrided).

After creating a new candidate, you can load it by doing the following.

	article = Article.find(5) # <Article id: 5, title: "Whoa! ActAsReleasable is live!", ...>
	# ...
	article.release_candidate.title # "ActAsRelesable just received some care :)"

To approve a candidate, you should use the ```release_version!``` method.

	article = Article.find(5) # <Article id: 5, title: "Whoa! ActAsReleasable is live!", ...>
	# ...
	article.release_version!
	article = Article.find(5) # <Article id: 5, title: "ActAsRelesable just received some care :)", ...>

###The last but not the least:

You can have candidates for collections, by specifying them like this:

	class Article
	  act_as_releasable :collections => [:comments]
	end

And check if the model has any change to be approved.

	article.has_changes_to_be_approved?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
