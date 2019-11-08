# spending_tracker
Solo Project using Ruby, interact with a PostgreSQL database and Sinatra server.


Spending Tracker
Build an app that allows a user to track their spending.

Inspired by:
Monzo, MoneyDashboard, lots of mobile/online banking apps

User Stories / Acceptance Criteria - MVP
As a User	
  I want to be able to specify who I am spending money with 
  So that I can track who I frequently shop with

As a User
  I want to be able to use tags to categorise my spending	
  So that I can easily see what I’m spending money on

As a User
  I want to be able to add tags, merchants, and amount spent to transactions	
  So that I can easily view full details about a transaction
  
As a User
  I want to be able to view all of my transactions in a single page	
  So that I can easily view the full details of all of my transactions in one place

Acceptance Criteria - MVP
User should be able to:
  
  Create, edit and delete merchants, e.g. Tesco, Amazon, ScotRail
  
  Create, edit and delete tags for their spending, e.g. groceries, entertainment, transport
  
  Assign tags and merchants to a transaction, as well as an amount spent on each transaction.
  
  The app should display all the transactions a user has made in a single view, with each     transaction's amount, merchant and tag, and a total for all transactions.

User Stories - Possible Extensions:

As a User
  I want to be able to set a budget on my app	
  So that I don’t overspend

As a User
  I want to be able to view my transactions based on month/category	
  So that I can get a clearer view of my outgoings over a specific period/to a specific category

#### Acceptance Criteria - Possible Extensions:

  Transactions should have a timestamp, and the user should be able to view transactions sorted by the time they took place.
  
  The user should be able to supply a budget, and the app should alert the user somehow when when they are nearing this budget or have gone over it.
  
  The user should be able to filter their view of transactions, for example, to view all transactions in a given month, or view all spending on groceries.
