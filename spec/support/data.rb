# -*- encoding : utf-8 -*-
Sub1.destroy_all
Sub2.destroy_all

#Sub1 with dbi18n method
sub1 = Sub1.new
sub1.name_en = "english"
sub1.name_zh = "你好"
sub1.des_en = "des"
sub1.des_zh = "描述"
sub1.des_jp = "japan"
sub1.save

#Sub2 without dbi18n method
sub2 = Sub2.new
sub2.name = "normal"
sub2.save
