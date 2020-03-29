import psycopg2
import creds

print('woo0')
#connect to the db
con = psycopg2.connect(
    host = creds.host,
    database = creds.database,
    user = creds.user,
    password = creds.password,
    port = creds.port
)

print('woo1')
cur = con.cursor()

# insert into db
cur.execute("insert into branch (branch_id, country, location) values (%s, %s, %s);", (1257, 'Canada', 'uOttawa'))

# execute query
cur.execute('select * from branch')

rows = cur.fetchall()

for r in rows:
    print (r)

# commit the transaction
con.commit()

cur.close()
print('woo2')
#close the connection
con.close()

print('woo3')