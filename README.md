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

    rails g model language

Model/language.rb

    db_i18n(:name,:des,[:en,:zh])

    #在model里加入这个方法后会生成name_en,name_zh,des_en,des_zh的方法

    #使用默认配置方法

    db_i18n(*Dbi18.attributes,Dbi18.language_type)

    #Dbi18具体的属性可以在config/initialzer/dbi18.rb下配置

    config/initialzer/dbi18.rb

        Dbi18.configure do |config|

        # For the time being, maybe in the long term, it only support ActiveRecord...

        # models and database tables

        # config.attributes = :name,:des

        # config.language_type = [:en,:zh]
    end

    若没设置属性 则默认属性为:

    config.attributes = :name,:des # 设置属性

    config.language_type = [:en,:zh] #设置语种

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
