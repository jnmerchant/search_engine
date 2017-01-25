# search_engine
Let's build a "search engine" Ruby CLI program that allows you to add data into a SQL database and also search on certain criteria.

Objectives
Understand fundamentals of Database Schema design.
Understand basic SQL syntax to:
create tables
query for data
insert data
Create helper functions to allow for easier interaction with your database.
Deliverables
Build a program that when run will ask if you'd like to search for data or create data.

It is up to you to make your search as flexible as you would like. Make an option for whatever you think best fits your data.

And for inserting new data - make it a convenient experience. Prompt for every column value and validate the user input.

Normal Mode
Design a database structure (schema) that will fit your data model.
Create a Ruby file that will insert a sample of data into your database using INSERT statements. This .rb file does not also need to contain the logic for your main program. Just allow it to be run by itself to create initial data.
Write a program that connects to the database and asks the user to search, sort, and filter the data using SQL statements. You will need to research a little bit in how to select and order by certain columns for this to work. Or you can perform the searching, sorting, and filtering in Ruby - but it's faster if you do it in SQL.
For a given result set, have the program display the results in a clean manner to the user.
Then, add features to your program that allows a user to...

Insert new data into the database. Prompt the user for every column that you will need them to provide custom information on and validate their input.
Edit and update existing data in the database. Prompt the user to be able to search the data and then update some of the information.
Delete data from the database.
