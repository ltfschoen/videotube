# README

---
Videotube
---

# Table of Contents
  * [Chapter 0 - Setup Dependencies](#chapter-0)
  * [Chapter 1 - Setup Ruby on Rails App](#chapter-1)
  * [Chapter 2 - Run RSpec Tests](#chapter-2)
  * [Chapter 3 - Configure IntelliJ IDE](#chapter-3)
  * [Chapter 4 - Configure Routes and Model View Controller (MVC)](#chapter-4)
  * [Chapter 5 - Configure Views with Bootstrap Theme](#chapter-4)

## Chapter 0 - Setup Dependencies <a id="chapter-0"></a>

* Homebrew
    ```
    brew doctor
    brew update
    sudo gem update --system
    ```

* Configure globally ignored files
    ```
    git config --global core.excludesfile ~/.gitignore
    printf "vendor/bundle\n.DS_Store\n" >> ~/.gitignore
    ```

* Configure default path for `bundle`
    ```
    mkdir -p ~/.bundle
    printf -- "---\nBUNDLE_PATH: vendor/bundle" >> ~/.bundle/config
    ```

* Setup RVM and configure to instantiate with shell sessions
    * Setup
        ```
        \curl -sSL https://get.rvm.io | bash -s stable --ruby
        echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bash_profile
        source ~/.bash_profile
        gem pristine --all
        bundle show rails
        rvm install ruby-2.4.1
        rvm use ruby-2.4.1
        rvm gemset create videotube
        ```

    * Set up RVM workflow with Gemsets to create a .ruby-version file and a .ruby-gemset file for the project so RVM will detect the ruby version and gem set automatically
        ```
        rvm --ruby-version use 2.4.1@videotube
        ```

    * Check Ruby version and location installed
        ```
        ruby -v; which ruby
        ```

* Configure IRB Autocompletion
    ```
    touch ~/.irbrc
    printf "require 'irb/completion'" >> ~/.irbrc
    ```

## Chapter 1 - Setup Ruby on Rails App <a id="chapter-1"></a>

* Create App with Static pages.
    * Note: Use PostgreSQL instead of SQLite3
    * Note: Use RSpec instead of Test Unit

    ```
    rails new videotube --database=postgresql --skip-test-unit
    ```

* Setup RSpec
    * Add RSpec Rails Gem to Gemfile. Install the Gem. Generate RSpec `spec/` directory
    ```
    echo 'gem "rspec-rails", :group => [:development, :test]' >> Gemfile
    bundle install
    rails generate rspec:install
    ```

* [Install Boostrap for Ruby on Rails](https://github.com/twbs/bootstrap-rubygem)
    * Add Bootstrap and jQuery Rails Gems to Gemfile. Install the Gem. Rename Stylesheets from .css to .scss and replace contents.
    ```
    echo "gem 'jquery-rails'" >> Gemfile
    echo "gem 'bootstrap', '~> 4.0.0.beta'" >> Gemfile
    echo "@import 'bootstrap';" > app/assets/stylesheets/application.scss
    bundle install
    mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
    ```

    * Update app/assets/javascripts/application.js with the following just above `//= require_tree .`
        ```
        //= require jquery3
        //= require popper
        //= require bootstrap-sprockets
        ```

* Create Static pages
    * Note: Generate SCSS instead of CSS files
    * Note: Generate RSpec instead ot Test Unit files
    * Note: Generate JavaScript instead of CoffeeScript
    ```
    rails g controller Pages index about \
        --stylesheet-engine=scss --test-framework=rspec \
        --javascript-engine=js
    ```

## Chapter 2 - Run RSpec Tests <a id="chapter-2"></a>

* Database Creation and Migration
    ```
    open -a "Postgres"
    rails db:create db:migrate && rake db:test:prepare
    rails spec
    ```

## Chapter 3 - Configure IntelliJ IDE <a id="chapter-3"></a>

* Guides and Troubleshooting
  * https://stackoverflow.com/questions/30141740/rubymine-rails-server-launcher-wasnt-found-in-the-project/44922746#44922746
  * https://stackoverflow.com/questions/5816419/intellij-does-not-show-project-folders/39500351#39500351

## Chapter 4 - Configure Routes and Model View Controller (MVC) <a id="chapter-4"></a>

    * Check [Routes](http://guides.rubyonrails.org/routing.html)
        ```
        rails routes
        ```

    * Add root route `root to: 'pages#index'` to routes.rb

## Chapter 5 - Configure Views with Bootstrap Theme <a id="chapter-5"></a>

    * Add [Responsive meta tag]([Bootstrap components](https://getbootstrap.com/docs/4.0/getting-started/introduction/)
) to layout.html.erb
    * Add [Bootstrap theme](https://startbootstrap.com/)
    * Update views with [Bootstrap components](https://getbootstrap.com/docs/4.0/getting-started/introduction/)