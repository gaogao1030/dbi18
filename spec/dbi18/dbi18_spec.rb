require "spec_helper"

describe I18n do
	describe "i18n_test" do
		context "when model isn't extend I18n" do
			before(:each) do
				@s = Sub2.new
				@s.name = "nomal"
			end

			it "should @s.name is @s.name " do
					(@s.name == "nomal").should be_true
			end
			
			it "should @s.name_en isn't exist " do
				(!@s.methods.include? "name_en").should be_true
			end

			it "should @s.name_zh isn't exist " do
				(!@s.methods.include? "name_zh").should be_true
			end
		end

		context "when model extend I18n" do
			before(:each) do

				Sub.class_eval do
					require "module/i18"
					extend I18n
					db_i18n(:name,[:en,:zh,:jp])
					db_i18n(:des,[:en,:zh,:jp])
				end

				@s = Sub.new
				@s.name_en = "hello"
				@s.name_zh = "你好"
				@s.des_en = "des"
				@s.des_zh = "描述"
				@s.des_jp = "japan"
			end

			it "should @s.name is equal @s.name_en when I18n.locale is :en " do
				I18n.locale = :en
				(@s.name == "hello").should be_true
			end
			
			it "should @s.name is equal @s.name_zh when I18n.locale is :zh " do
				I18n.locale = :zh
				(@s.name == "你好").should be_true
			end

			it "should @s.name is equal @s.name_jp when I18n.locale is :jp " do
				I18n.locale = :jp
				(@s.name == "").should be_true
			end

			it "should @s.des is equal @s.des_en when I18n.locale is :en " do
				I18n.locale = :en
				(@s.des == "des").should be_true
			end

			it "should @s.des is equal @s.des_zh when I18n.locale is :zh " do
				I18n.locale = :zh
				(@s.des == "描述").should be_true
			end

			it "should @s.des is equal @s.des_jp when I18n.locale is :jp " do
				I18n.locale = :jp
				(@s.des == "japan").should be_true
			end

			it "@s.name_go.jsoncontent is hash " do
				@hash = eval @s.name_go.jsoncontent
				(@hash["en"] == "hello").should be_true
				(@hash["zh"] == "你好").should be_true
			end

			it "@s.des_go.jsoncontent is hash " do
				@hash = eval @s.des_go.jsoncontent
				(@hash["en"] == "des").should be_true
				(@hash["zh"] == "描述").should be_true
				(@hash["jp"] == "japan").should be_true
			end

			it "should @s.name_go isn't in GO when @s isn't save" do
				id = @s.id
				class_name = @s.class.name
				property = "name"
				text = "{\"en\"=>\"hello\", \"zh\"=>\"你好\", \"jp\"=>\"\"}"
				(Go.where(:id => id, :classname => class_name, :property => property ).blank?).should be_true
			end

			it "should @s.name_go in GO when @s.save" do
				@s.save
				id = @s.id
				class_name = @s.class.name
				property = "name"
				text = "{\"en\"=>\"hello\", \"zh\"=>\"你好\", \"jp\"=>\"\"}"
				(Go.where(:id => id, :classname => class_name, :property => property ).blank?).should be_false
			end

			it "when @s is delete" do
				id = @s.id
				class_name = @s.name
				@s.delete
				Go.where(:id => id, :classname => class_name).blank? .should be_true
			end

		end

	end
end
