Sub1.destroy_all
Sub2.destroy_all

#Sub1 with dbi18n method
sub1 = Sub1.new
sub1.name_en = "english"
# sub1.name_zh = "english"
sub1.save

#Sub2 without dbi18n method
sub2 = Sub2.new
sub2.save
