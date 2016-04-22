Welcome to Contact List Project!
===================

This project is here because of a code challenge. 

Tests
------------------
**Tested with:**  Ruby2.2 and above  
**Coverage:**  >%90 (client side not tested)
You can use `rspec` to run tests

Installation
------------------
Project uses sqlite3 to simplify installation. You don't need to install any third party db software to use this project. 

- Clone the repo `git clone https://github.com/codem4ster/contact_list.git`
- `cd contact_list`
- `bundle install`
- be sure that `tmp`, `log`, `db` directories are writable to web server

for test

- `bundle exec rake db:migrate RAILS_ENV=test`
- `bundle exec rspec`

for development

- `bundle exec rake db:migrate RAILS_ENV=development`
- `bundle exec thin start` or your favorite server

for production

- `bundle exec rake db:migrate RAILS_ENV=production`
- `bundle exec rake assets:precompile RAILS_ENV=production`
- configure your web server

Usage
------------------
You can start from the root path (/). All clickable pages are already in the main page.
You can look to all routes with `bundle exec rake routes`

I didn't tested the client side but you can see api (backend) tests to get an opinion about my testing skills.