import psycopg2
import creds

# connect to the db
con = psycopg2.connect(
    host=creds.host,
    database=creds.database,
    user=creds.user,
    password=creds.password,
    port=creds.port
)

cur = con.cursor()

# insert into db
# cur.execute("insert into branch (branch_id, country, location) values (%s, %s, %s);", (1257, 'Canada', 'uOttawa'))
#execute the query
# cur.execute('select * from branch')
# rows = cur.fetchall()
# for r in rows:
#     print (r)
# commit the transaction
# con.commit()


def q1_guestListQuery():
    '''Give the details of all the guests who rented properties.
    Please display the columns as guest name, rental type, rental
    price, signing date, branch, payment type and payment status.
    Sort by the payment type in ascending order and signing date in descending order.
    '''
    query = """ SELECT first_name, last_name, property_type, price, signing_date, property.country, payment_type, status FROM(guest inner join rental_agreement
                ON guest.username= rental_agreement.guest_username) 
                JOIN property USING (property_id) 
                NATURAL JOIN  price 
                NATURAL JOIN  payment 
                ORDER BY  payment_type ASC ,signing_date DESC"""

    cur.execute(query)
    return cur.fetchall()

def q2_guestListView():
    '''Create a view named GuestListView that gives the details of
     all the guests. Please, sort the guests by the branch id and then by guest id.
    '''
    query = """SELECT * FROM GuestListView"""

    cur.execute(query)
    return cur.fetchall()


def q3_cheapestRental():
    '''Display the details of the cheapest (completed) rental.'''
    query = """WITH min_price(value) AS (SELECT MIN(price) FROM price) 
            SELECT guest.first_name AS Guest_first_name, guest.last_name  AS Guest_last_name,
			host.first_name AS Host_first_name, host.last_name AS Host_last_name,
			property_type, start_date, end_date, price 
            FROM (((price NATURAL JOIN property) JOIN host ON  property.host_username = host.username) NATURAL JOIN rental_agreement ) JOIN guest ON rental_agreement.guest_username = guest.username, 
            min_price
            WHERE price.price = min_price.value AND end_date < CURRENT_TIMESTAMP
            """

    cur.execute(query)
    return cur.fetchall()


def q4_allProperties():
    '''List all the properties rented and sort based on the branch id and review rating.'''
    query = """
            SELECT averageratings.avg_rating, rented_props.*
            FROM (SELECT DISTINCT property.*
	        FROM property INNER JOIN rental_agreement USING (property_id)) as rented_props
            LEFT JOIN (SELECT property_id, CAST(AVG(rating) AS DECIMAL(10,2)) AS avg_rating
			FROM review
			GROUP BY property_id) AS averageratings 
            USING (property_id)
            ORDER BY rented_props.country, averageratings.avg_rating;
            """

    cur.execute(query)
    return cur.fetchall()


def q5_propertiesNotRented():
    '''Find the properties that are already listed but not yet rented. Please, avoid duplications. '''
    query = """
            SELECT DISTINCT property.* 
            FROM property
            WHERE property_id NOT IN (
            SELECT property_id FROM rental_agreement);
            """

    cur.execute(query)
    return cur.fetchall()


def q6_rented10th():
    '''List all the details of all properties rented on the 10 th day of any month.
    Ensure to insert dates in your table that correspond in order to run your query. '''
    query = """
            SELECT property.*  FROM property NATURAL JOIN  rental_agreement
	        WHERE 10 BETWEEN EXTRACT (DAY FROM start_date) AND EXTRACT (DAY FROM end_date)
            """

    cur.execute(query)
    return cur.fetchall()


def q7_employee15k():
    '''List all the managers and the employees with salary greater than or
    equal to $15000 by their ids, names, branch ids, branch names and salary.
    Sort by manager id and then by employee id. '''
    query = """
           SELECT username, first_name, middle_name, last_name, branch_id, salary
            FROM employee
            WHERE salary >= 15000
            ORDER BY position DESC, username
            """

    cur.execute(query)
    return cur.fetchall()


def q8_guestBill(username):
    '''Consider creating a simple bill for a guest stating the property type, host, address, amount paid and payment type. '''
    query = """
           SELECT guest.first_name AS Guest_first_name, guest.last_name  AS Guest_last_name,
			host.first_name AS Host_first_name, host.last_name AS Host_last_name,
			property_type,property.street, property.city, property.province, property.country, amount, payment_type
			FROM ((rental_agreement NATURAL JOIN payment NATURAL JOIN property) JOIN host
            ON property.host_username = host.username)
            JOIN guest ON guest.username = rental_agreement.guest_username
            WHERE guest_username = '{0}'

            """

    cur.execute(query.format(username))
    return cur.fetchall()


def q9_guestPhoneUpdate(phone_number, username):
    '''Update the phone number of a guest. '''
    query = """
           UPDATE user_phone_guest SET phone_number = {0} WHERE username = '{1}'
            """

    cur.execute(query.format(phone_number, username))


# note here i am only calling the function without creating it


def q10_firstNameFirst():
    '''Create and test a user-defined function named FirstNameFirst that combines
    two attributes of the guest named firstName and lastName into a concatenated
    value named fullName [e.g., James and Brown will be combined to read James Brown].'''
    query = """
          SELECT username, FirstNameFirst(guest.username) AS Name FROM guest
            """

    cur.execute(query)
    return cur.fetchall()

def main():
    print(q1())

    cur.close()

    # close the connection
    con.close()

if __name__ == '__main__':
    main()
    