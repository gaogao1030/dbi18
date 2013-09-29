require "spec_helper"

describe I18n do
	describe "i18n_test" do
		context "when model can't use db_i18n" do
			before(:each) do
				@sub2 = Sub2.last
			end

			it "should @sub2.name is @sub2.name " do
					(@sub2.name == "normal").should be_true
			end
			
			it "should @sub2.name_en isn't exist " do
				(!@sub2.methods.include? "name_en").should be_true
			end

			it "should @sub2.name_zh isn't exist " do
				(!@sub2.methods.include? "name_zh").should be_true
			end
		end

		context "when model use db_i18n" do
			before(:each) do
				@sub1 = Sub1.last
			end

			it "should @sub1.name is equal @s.name_en when I18n.locale is :en " do
				I18n.locale = :en
				(@sub1.name == "english").should be_true
			end
			
			it "should @sub1.name is equal @s.name_zh when I18n.locale is :zh " do
				I18n.locale = :zh
				(@sub1.name == "你好").should be_true
			end

			it "should @sub1.name is equal @s.name_jp when I18n.locale is :jp " do
				I18n.locale = :jp
				(@sub1.name == "").should be_true
			end

			it "should @sub1.des is equal @s.des_en when I18n.locale is :en " do
				I18n.locale = :en
				(@sub1.des == "des").should be_true
			end

			it "should @sub1.des is equal @s.des_zh when I18n.locale is :zh " do
				I18n.locale = :zh
				(@sub1.des == "描述").should be_true
			end

			it "should @sub1.des is equal @s.des_jp when I18n.locale is :jp " do
				I18n.locale = :jp
				(@sub1.des == "japan").should be_true
			end

			it "when @sub1 is delete" do
				id = @sub1.id
				class_name = @sub1.class.name
				@sub1.delete
				Cimu.where(:class_id => id, :class_name => class_name).blank? .should be_true
			end
		end

		context "when model use db_i18n with save" do
			before(:each) do
				@sub3 = Sub3.new
				@sub3.name_en = "english"
				@sub3.name_zh = "你好"
			end

			it "should @sub3.name is equal @sub3.name_en when I18n.locale is :en " do
				I18n.locale = :en
				(@sub3.name == "english").should be_true
			end
			
			it "should @sub3.name is equal @sub3.name_zh when I18n.locale is :zh " do
				I18n.locale = :zh
				(@sub3.name == "你好").should be_true
			end

			it "should @sub3.dbi18_type isn't in Cimu when @sub3 with save" do
				class_name = @sub3.class.name
				@sub3.save
				id = @sub3.id
				Cimu.where(:class_id => id, :class_name => class_name).blank? .should be_false
			end
		end

	end
end
