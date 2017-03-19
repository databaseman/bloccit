
**Title**:  blocit

**Description**:  a Reddit replica to teach the fundamentals of web development and Rails. 

This is a self contain application except for the following part requiring email service:
A notification feature which emails users when one of their favorited posts receives a new comment.

**Technology**:  HTML, CSS, Ruby on Rails, Heroku Sendgrid mail server, ActionMailer client, Figaro to setup environment variables.

**Install Instruction**:

Instruction here is for replicating on Cloud9 for development; and Heroku for production; however, we will use the same Heroku Sendgrid 
email service for development and production...meaning no seperate email for development...that way it will be easier to push from Cloud9
to Heroku without having to update the id and password in config/application.yml file. The steps to get it completely working are as followed:

1. Clone to Cloud9
2. Clone to Heroku
3. Add Heroku Sendgrid email Addon.  
4. Config environments to send email. 

Without last two steps, you won't be able to send email from development or production.

**Clone to Cloud9**:
  * Go to your Cloud9 dashboard  
  * Create new workspace
  *  Workspace name:  bloc-it  
  *  Choose Ruby template
  *  Clone from Git URL: https://github.com/databaseman/bloccit.git

**Clone to Heroku** (all works are done from Cloud9):
  * $ git add -A
  * $ git commit -m "Setup for Heroku"
  * $ git push
  * $ heroku create
  * $ git push heroku master
  * $ heroku run rake db:migrate
  * $ heroku run rake db:seed   (optional)

**Rename Heroku url**
  * $ heroku apps:rename minh-blocit
  *  Go to new URL: https://minh-blocit.herokuapp.com
  *  
**Run on Cloud9**:
  * Start web server by running the following command:
     rails server -b $IP -p $PORT
  * Wait for web server to start
  * Go to URL: https://bloc-jams-angular-<c9username>.c9users.io

**Add Heroku Sendgrid email Addon to this application**
If you haven’t already added your credit card to your heroku account, then you should do so before continuing.  It is free until you reach 12k email.  You can find it under your account icon -> account setting -> Billing.
Run the following commands:
* $ heroku auth:logout
* $ heroku addons:create sendgrid:starter

You can tell whether sengrid is already setup or not by typing “heroku info” or "heroku addons" and see if sendgrid is already under Addons. 
You can get more info on your Sendgrid setup by going to heroku.com. 
Click on the application you want to check -> click on  “Sendgrid” icon next to your “Heroku Progress” icon

_Creating sendgrid:starter on ⬢ frozen-savannah-12384... free
Created sendgrid-fluffy-72149 as SENDGRID_PASSWORD, SENDGRID_USERNAME
Use heroku addons:docs sendgrid to view documentation_

**Get encoded Sendgrid username and password for this application**
$ heroku config:get SENDGRID_USERNAME
$ heroku config:get SENDGRID_PASSWORD

**Config environments to send email**
$ vi config/environments/development.rb 
  config.action_mailer.perform_deliveries = true
  config.raise_delivery_errors = true
  config.action_mailer.raise_delivery_errors = true   # comment out the one already there
  config.action_mailer.default_url_options = { host: 'localhost' }

$ vi config/environments/test.rb 
  config.action_mailer.perform_deliveries = true
  config.raise_delivery_errors = true
  config.action_mailer.raise_delivery_errors = true   # comment out the one already there
  config.action_mailer.default_url_options = { host: 'localhost' }

$ vi config/environments/production.rb 
  config.action_mailer.default_url_options = { host: 'minh-blocit.herokuapp.com' }


**Run on Heroku**:
  * Go to web site returned from push command.  For example
     https://minh-blocit.herokuapp.com



