# SimplePaginator

This is a useful pagination library especially building APIs.

## Feature
- Does not issue `count`.
- You can set max page.
- You can set number of records par page.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_paginator'

And then execute:

    $ bundle

## Usage

Include SimplePaginator into your models like below.

```
class Post < ActiveRecord::Base
  include SimplePaginator
end
```

You can get paginated records using `Post.paged(page)` method.

Default is 25 records / page, maximum page number is 10.
You will get 26 (par_page + 1) records when you can get next page.

```
Post.paged(1) #=> returns 26 records at most.
Post.paged(11) #=> returns 0 records if page is more than max_page.
```

You can use `set_par_page`, `set_max_page` to change default behavior.

```
class Post < ActiveRecord::Base
  include SimplePaginator
  set_par_page 10
  set_max_page 5
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
