# Dbi18

数据库中的dbi18 
支持rails3 但不支持rails4 
目前mysql与sqlite3数据库测试可用

## Installation

Add this line to your application's Gemfile:

    gem 'dbi18'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dbi18

## Usage

    rails g dbi18 table_name [option] #生成表名与model名字

    rails g model name

    bundle exec rake db:migrate
Model/name.rb

    db_i18n(:name,:des)
    #设置需要多语种属性
    validate :name_en, :presence => true
    #支持验证回调函数

config/initialzer/dbi18.rb

    Dbi18.configure do |config|

        # For the time being, maybe in the long term, it only support ActiveRecord...

        # models and database tables

        # config.language_type = [:en,:zh] #语种设置属性

	  config.model = model_name # model的名字 生成表名的情况下会自动生成model的名字 这个选项推荐不要修改

    end

console

    n = Name.new 

    n.name_en = "english" 

    n.name_zh = "china" 

    n.des_zh = "des_zh" 

    n.des_en = "des_en" 

    n.save 


    #i18n.locale = :en	

    n.name

    #=> "english"

    n.des

    #=> "des_zh"

    #如果model里添加了db_i18n的方法会根据I18n.locale的值来判断当前的值,
    如果没加则会取出原有的name属性.否则就会提示未定义的方法

    #如果想取出自定义的值可以用以下的方式

    n.name_en

    #=> "english"

    n.name_zh

    #=> "china"

    n.des_en
    
    #=> "des_en"

    n.des_zh

    #=> "des_zh"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
