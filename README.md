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
  * [Chapter 5 - Configure Views with Bootstrap Theme](#chapter-5)
  * [Chapter 6 - Configure View Partials](#chapter-6)
  * [Chapter 7 - Configure Live Reload](#chapter-7)
  * [Chapter 8 - Configure Mailer for Static Pages](#chapter-8)
  * [Chapter 9 - Deploy Specific Branch to Heroku](#chapter-9)

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

    * Setup Rails in global Gemset
        ```
        rvm @global do gem install rails
        ```

    * Set up RVM workflow with Gemsets to create a .ruby-version file and a .ruby-gemset file for the project so RVM will detect the ruby version and gem set automatically
        ```
        rvm --ruby-version use 2.4.1@videotube
        ```

    * Setup .rvmrc
        ```
        echo "rvm --create use ruby-2.4.1; rvm reload;" > .rvmrc
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
    rails g controller Pages index about contact \
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
  * Add to Gitignore `git rm -f .idea/workspace.xml`

## Chapter 4 - Configure Routes and Model View Controller (MVC) <a id="chapter-4"></a>

* Check [Routes](http://guides.rubyonrails.org/routing.html)
    ```
    rails routes
    ```

* Add root route `root to: 'pages#index'` to routes.rb

## Chapter 5 - Configure Views with Bootstrap Theme <a id="chapter-5"></a>

* Add to layout.html.erb [Responsive meta tag]([Bootstrap components](https://getbootstrap.com/docs/4.0/getting-started/introduction/)
)
* Add [Bootstrap theme](https://startbootstrap.com/)
* Update views with [Bootstrap components](https://getbootstrap.com/docs/4.0/getting-started/introduction/)

## Chapter 6 - Configure Views Partials <a id="chapter-6"></a>

* Add [Partials](http://guides.rubyonrails.org/layouts_and_rendering.html)

## Chapter 7 - Configure Live Reload <a id="chapter-7"></a>

* Add [Guard LiveReload](https://github.com/guard/guard)
    ```
    echo "gem 'guard', :group => [:development, :test]" >> Gemfile; bundle install;
    echo "gem 'rb-readline', :group => [:development, :test]" >> Gemfile; bundle install;
    echo "gem 'guard-rspec', require: false, :group => [:development, :test]" >> Gemfile; bundle install;
    echo "gem 'guard-livereload', '~> 2.5', require: false, :group => [:development, :test]" >> Gemfile; bundle install;
    ```

* Generate Empty Guardfile
    ```
    bundle exec guard init rspec
    ```

* Customise Guardfile by reading the [Guard DSL on its Wiki](https://github.com/guard/guard/wiki/Guardfile-DSL---Configuring-Guard)

* Install, Enable, and Run LiveReload Extension [LiveReload browser extension](http://livereload.com/extensions/#installing-sections)

* Copy [example Guard LiveReload code](https://github.com/guard/guard-livereload) into your Guardfile

* Run Rails Server

* Run Guard `bundle exec guard` in separate Terminal tab

* Open http://localhost:3000. Turn on LiveReload in browser by clicking the browser extension icon.

* Modify a .html.erb file in the views directory and wait for the webpage to automatically refresh

## Chapter 8 - Configure Mailer and Dotenv for Static Pages<a id="chapter-8"></a>

* Guides
    * [Contact Form using Mail Form](https://github.com/plataformatec/simple_form/wiki/Contact-Form-using-Mail_Form)

* Check Routes
    ```
    rails routes
    ```
* Add Rails URL Helper to link to Contact page
    ```
    <%= link_to "Contact", pages_contact_path, class: "nav-link" %>
    ```

* Add [Dotenv Rails](https://github.com/bkeepers/dotenv). Move above any Gems that depend on Dotenv
    ```
    echo "gem 'dotenv-rails', require: 'dotenv/rails-now', groups: [:development, :test]" >> Gemfile;
    bundle install;
    printf "# Mailer settings\nMAILER_FROM='ltfschoen@gmail.com'\nGMAIL_USERNAME='ltfschoen@gmail.com'\nGMAIL_PASSWORD=''" >> .env
    ```

* Test it works in a View
    ```
    <%= ENV['GMAIL_USERNAME'] %>
    ```

* Add `.env` file to Gitignore

* Restart Rails server

* Add [Mail Form](https://github.com/plataformatec/mail_form)
    ```
    echo "gem 'mail_form'" >> Gemfile;
    bundle install;
    ```

* Add [Simple Form](https://github.com/plataformatec/simple_form/wiki/Contact-Form-using-Mail_Form)
    ```
    echo "gem 'simple_form'" >> Gemfile;
    bundle install;
    rails generate simple_form:install --bootstrap
    ```

    * Note: Below is output to screen
        ```
              create  config/initializers/simple_form.rb
              create  config/initializers/simple_form_bootstrap.rb
               exist  config/locales
              create  config/locales/simple_form.en.yml
              create  lib/templates/erb/scaffold/_form.html.erb
        ===============================================================================

          Be sure to have a copy of the Bootstrap stylesheet available on your
          application, you can get it on http://getbootstrap.com/.

          Inside your views, use the 'simple_form_for' with one of the Bootstrap form
          classes, '.form-horizontal' or '.form-inline', as the following:

            = simple_form_for(@user, html: { class: 'form-horizontal' }) do |form|
        ```

* Generate Controller for Contacts
    ```
    rails g controller Contacts new create \
        --stylesheet-engine=scss --test-framework=rspec \
        --javascript-engine=js
    ```

* Generate Model for Contacts
    ```
    rails g model contact name:string email:uniq message:text
    ```

* Migrate the Database Schema
    ```
    rails db:migrate RAILS_ENV=development
    ```

* Check Rails server runs

* Open PostgreSQL application
    ```
    open -a "Postgres"
    ```

* Within PostgreSQL Shell check the database table
    ```

    # Run PostgreSQL (or `rails db`, [Link](http://guides.rubyonrails.org/command_line.html))
    psql

    # Show Help
    \h

    # Show List of Databases
    \l

    # Change between Databases
    \c videotube_development

    # Show List of Tables
    \d

    # Query Table
    SELECT * FROM contacts;

    # Quit
    \q
    ```

* Copy [Example](https://github.com/plataformatec/simple_form/wiki/Contact-Form-using-Mail_Form) code into Routes, Controller, Models, and Views

    * Add whitelisted parameters to Contacts Controller
    * Remove the `contact` action from the Pages Controller
    * Update Routes to point GET requests from URL `'/pages/contact', to: 'contacts#new'`
    * Add redirect `get "/contacts" => redirect("/contacts/new")`
    * Add padding to contacts/new View
    * Configure [Flash](http://guides.rubyonrails.org/action_controller_overview.html) and create Partial for Flash messages

* [Configure Action Mailer Configuration for Gmail](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration-for-gmail)
    * Add to config/environments/development.rb
    ```
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      user_name: ENV['GMAIL_USERNAME'],
      password: ENV['GMAIL_PASSWORD'],
      domain: 'gmail.com',
      address: 'smtp.gmail.com',
      port: 587,
      host: 'localhost:3000',
      authentication: 'login', # plain
      enable_starttls_auto: true
    }
    ```

* Go to http://localhost:3000/contacts/new. Submit the Contact Form.
* Watch the Rails Server logs
* Check your email


## Chapter 9 - Deploy Specific Branch to Heroku<a id="chapter-9"></a>

```
heroku login
heroku git:remote -a ceenos
git push heroku ceenos:master
```