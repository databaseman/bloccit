
Title:  blocit

Description:  a Reddit replica to teach the fundamentals of web development and Rails. 

Technology:  HTML, CSS, Ruby on Rails.

Install on Cloud9:
  Go to your Cloud9 dashboard  
  Create new workspace
    Workspace name:  bloc-it  
    Choose Ruby template
    Clone from Git URL: https://github.com/databaseman/bloccit.git

Run on Cloud9:
  Start web server by running the following command:
     rails server -b $IP -p $PORT
  Wait for web server to start
  Go to URL: https://bloc-jams-angular-<c9username>.c9users.io

Install on Heroku (all works are done from Cloud9):
  $ git add -A
  $ git commit -m "Setup for Heroku"
  $ git push
  $ heroku create
  $ git push heroku master
  $ heroku run rake db:migrate
  $ heroku run rake db:seed   (optional)
  Go to web site returned from push command.  For example
     https://secure-springs-93236.herokuapp.com/index.html

  You can rename the url by doing the following:
    $ heroku apps:rename minh-blocit
    Go to new URL: https://minh-blocit.herokuapp.com

Git remote heroku updated
 ?    Don't forget to update git remotes for all other local checkouts of the app.
