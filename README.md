# AirAOA

A trial of resembling the mobile app Airbnb (as a web app) this trial only concerns the database aspect of it, with minimal interface.

Ahmed Gawish --> 7962047
Omar Radwan Mohsen --> 300013569
Ahmed Abdelrehim --> 8394971

The application is using the python library Psycopg2. This specific library requires a C compiler to be enabled. One way to overcome this issue is to run the python file using pyCharm, allowing the IDE to do all the necessary imports for you.

Another way is to use an executable version of the library by installing “psycopg2-binary”
This would allow it to work without the need of a C compiler.
To do this is through python environment that uses psycopg2-binary.

In creds.py credentials for a database on the university server should be entered in order to have a database server to work on.
Then run app.py in a terminal.
