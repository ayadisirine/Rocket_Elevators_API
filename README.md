<img align="center" src="https://rocketelevators-yt.com/assets/RocketElevators_images/clear_logo.png"  alt="Logo" width="850" height="200">


## Rocket Elevators Information System ##

This week converted our static website into a Ruby on Rails application.

The first step was to use the Assett Pipeline to provide the JS, CSS and HTML files needed to run the website. 

We implemented Embeded Ruby Syntax to the HTML code.

We created a database which contained multiple tables :

The employee table is used to assign permissions to access the Backoffice. It is also used to store e-mails and passwords of said employees.

If you want to access the Backoffice use these credentials:

- username: nicolas.genest@codeboxx.biz
- password: newdog1


![](2021-02-19-19-06-57.png)


The users table is used to store login information for employees. It also assigns an ID to each one in order to link the tables together.


![](2021-02-19-19-09-22.png)


In order to create a Backoffice, we first had to implement an authentication process. To achieve this, we used Gem Devise which took care of all the controllers necessary for user creation and user sessions. We then used RailsAdmin that provided us with a Backoffice interface for managing our data, such as the Employee table, the Users table and a Quote table which is used to store all the quote requests made on the website.


![](2021-02-19-19-31-26.png)


Here is a screenshot of what the list of quotes looks like :

![](2021-02-19-19-30-54.png)


We then deployed the website to AWS Ubuntu Server using Cloudflare to secure it.


The Backoffice was updated to include more data from Mysql as well as adding a Data Warehouse.

![](2021-02-26-17-48-58.png)

It is now possible to Query the database and show the results in a graph :

![](2021-02-26-17-52-10.png)

We can also group multiple Graphs at the same time using a Dashboard :

![](2021-02-26-17-53-32.png)

In order to link the two databases together and to keep them up to date, we had to create tasks :

![](2021-02-26-17-55-30.png)
