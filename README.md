# Dbi18

this is my first gem

## Installation

Add this line to your application's Gemfile:

    gem 'dbi18'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dbi18

## Usage

    rails g dbi18 任意参数

    rails g model language name:string

language.rb

    db_i18n(:name,[:en,:zh])

    在model里加入这个方法后会生成name_en和name_zh的方法

console
    n = Name.new 

    n.name_en = "english" 

    n.name_zh = "china" 

    n.save 


    #i18n.locale = :en	

    n.name

    #=> "english"

    #如果model里添加了db_i18n的方法会根据I18n.locale的值来判断当前的值,
    如果没加则会取出原有的name属性.否则就会提示未定义的方法

    #如果想取出自定义的值可以用以下的方式

    n.name_en
    #=> "english"

    n.name_zh
    #=> "china"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
