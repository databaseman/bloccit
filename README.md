
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
We are using the same Heroku email server for all environments.


If you haven’t already added your credit card to your heroku account, then you should do so before continuing.  

It is free until you reach 12k email.  You can find it under your account icon -> account setting -> Billing.
Run the following commands:
* $ heroku auth:logout
* $ heroku addons:create sendgrid:starter

You can tell whether sengrid is already setup or not by typing “heroku info” or "heroku addons" and see if sendgrid is already under Addons. 
You can get more info on your Sendgrid setup by going to heroku.com. 
Click on the application you want to check -> click on  “Sendgrid” icon next to your “Heroku Progress” icon

_Creating sendgrid:starter on ⬢ frozen-savannah-12384... free
Created sendgrid-fluffy-72149 as SENDGRID_PASSWORD, SENDGRID_USERNAME
Use heroku addons:docs sendgrid to view documentation_

**Setup email**
Setup mail client configuration file
https://www.bloc.io/users/minh-nguyen/checkpoints/2127?roadmap_section_id=156

Modify configuration files to have the correct hostname. 
Add the following entries into their corresponding files.
Make sure you change all the "host:" entries below to the correct host:

$ vi config/environments/development.rb 
  config.action_mailer.perform_deliveries = true
  config.raise_delivery_errors = true
  config.action_mailer.raise_delivery_errors = true   # comment out the one already there
  config.action_mailer.default_url_options = { host: 'bloccit-databasedude.c9users.io'  }

$ vi config/environments/test.rb 
  config.action_mailer.perform_deliveries = true
  config.raise_delivery_errors = true
  config.action_mailer.raise_delivery_errors = true   # comment out the one already there
  config.action_mailer.default_url_options = { host: 'bloccit-databasedude.c9users.io'  }

$ vi config/environments/production.rb 
  config.action_mailer.default_url_options = { host: 'minh-blocit.herokuapp.com' }

$ touch config/initializers/setup_mail.rb
$ vi config/initializers/setup_mail.rb
if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      address:        'smtp.sendgrid.net',
      port:           '2525',
      authentication: :plain,
      user_name:      ENV['SENDGRID_USERNAME'],
      password:       ENV['SENDGRID_PASSWORD'],
      domain:         'heroku.com',
      enable_starttls_auto: true
    }
  end
````
The code in config/initialize runs when our app starts. We use this when want to set config options or application settings. In this case we need to configure some special settings to send emails.
Notice that we didn't explicitly state the SendGrid username and password. We want to mask these for security concerns, so we assign them to environment variables. Environment variables provide a reference point to information, without revealing the underlying data values.
Sensitive data, like API keys and passwords, should not be stored in GitHub. Complete our resource on how to use the Figaro gem to set up environment variables. Figaro allows you to safely store and access sensitive credentials using variables. Install the gem and add your SendGrid username and password to application.yml.

gem 'figaro', '1.0'
$ bundle

Create the config/application.yml and update the .gitignore not to send the application.yml file to github
$figaro install   

Setup email authentication. Get the email username and password setup by heroku when we installed Sendgrid

$ heroku config:get SENDGRID_USERNAME
app6716@heroku.com
$ heroku config:get SENDGRID_PASSWORD
pgmltdfzsq96

$ vi config/application.yml
SENDGRID_PASSWORD: pgmltdfzsq96
SENDGRID_USERNAME: app6716@heroku.com

Update your environment variables on production:
Make sure all files have been committed and pushed to master and heroku before doing this.
````
$ figaro heroku:set -e production
Verify everything is correct on Heroku by running the following command to see if the variables are set:
$ heroku config
````
Setup ActionMailer email client
````
$ rails generate mailer FavoriteMailer
$ vi app/mailers/favorite_mailer.rb
class FavoriteMailer < ApplicationMailer
  default from: 'minh.testing@gmail.com' # use a fake email here or DMARC security from email vendor will block you.
  def new_comment(user, post, comment)
    headers['Message-ID'] = "<comments/#{comment.id}@your-app-name.example>"
    headers['In-Reply-To'] = "<post/#{post.id}@your-app-name.example>"
    headers['References'] = "<post/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
````

**Run on Heroku**:
  * Go to web site returned from push command.  For example
     https://minh-blocit.herokuapp.com



