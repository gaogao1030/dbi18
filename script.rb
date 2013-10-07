# -*- encoding : utf-8 -*-
p "staring uninstall dbi18 gem"
system "sudo rm -r dbi18-0.0.0.gem"
system "gem uninstall dbi18"
p "uninstall done"
system "gem build dbi18.gemspec"
system "gem install dbi18 -l"
