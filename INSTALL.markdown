> _おかえりなさいませ、ご主人様！_

# 依赖

## Ubuntu

    # apt-get install git ruby1.8 ruby1.8-dev rubygems1.8 \
    > build-essential libxml2-dev libxslt1-dev libreadline-dev
    # gem install bundle

# 源码

    $ git clone git://github.com/jimmyxu/twimeido.git
    $ cd twimeido/

# 配置

    $ /var/lib/gems/1.8/bin/bundle install
    $ cp config.example.yml config.yml
    $ $EDITOR config.yml

# 运行

    $ while true; do ./bin/twi_meido.rb; done
