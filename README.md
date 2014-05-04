# SimplePaginator

[![Gem Version](https://badge.fury.io/rb/simple_paginator.png)](http://badge.fury.io/rb/simple_paginator)
[![Build Status](https://travis-ci.org/satococoa/simple_paginator.png?branch=master)](https://travis-ci.org/satococoa/simple_paginator)
[![Dependency Status](https://gemnasium.com/satococoa/simple_paginator.png)](https://gemnasium.com/satococoa/simple_paginator)
[![Code Climate](https://codeclimate.com/github/satococoa/simple_paginator.png)](https://codeclimate.com/github/satococoa/simple_paginator)

This is a useful pagination library especially building APIs.

## Feature
- Does not issue `count`.
- You can set max page.
- You can set number of records per page.

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
You will get 26 (per_page + 1) records when you can get next page.

```
Post.paged(1) #=> returns 26 records at most.
Post.paged #=> same as above.
Post.paged(11) #=> returns 0 records if page (argument) > max_page.
```

You can use `per_page`, `max_page` to change default behavior.

```
class Post < ActiveRecord::Base
  include SimplePaginator
  per_page 10
  max_page 5
end
```

You are also be able to change them at `.paged` option.
These parameters will override `per_page`, `max_page` values.

```
Post.paged(1, per_page: 5, max_page: 10)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
