import psycopg2
import creds
import queries
# connect to the db
con = psycopg2.connect(
    host=creds.host,
    database=creds.database,
    user=creds.user,
    password=creds.password,
    port=creds.port
)

cur = con.cursor()




def displayQuery(query):
    cur.execute(query)
    
    try:
        output=cur.fetchall()
    except:
        return

    num_fields = len(cur.description)
    field_names = [i[0] for i in cur.description]

    row_line_len = len(field_names) * 15
    print("")
    print("-" * (int(1.25 * row_line_len)))
    for item in field_names:
        print(" | ", str(item).strip(), end="")
        rest = 15 - len(str(item).strip())
        print(" " * rest, end="")
    print("|", end="")

    for row in output:
        row_line_len= len(row)*15
        print("")
        print("-"*(int(1.25*row_line_len)))
        for item in row:
            
            print(" | ",str(item).strip(),end="" )
            rest= 15-len(str(item).strip())
            print(" "*rest, end="" )
        print("|",end="")
    print("")   
    print("-"*(int(1.25*row_line_len)))


def adminInterface():
    while True:
        try:
            choise= int(input("please chose one of the following functionalities\n   1-List all managers and employees with salaries >= $15000\n   2-Enter costom SQL\n   3-Exit\nYour choice is: "))
        except:
            print("Please insert an integer ")
            continue
        if choise ==1:
            displayQuery(queries.q7_employee15k())
        elif choise==2:
            print("Please enter desired Query ")
            sql= input("->")
            try:
                displayQuery(sql)
            except:
                print("your query had a syntax error!")
                pass
        elif choise==3:
            break
        else:
            print("")
            print("")
            print("please insert only one of these three integers.")
            print("")
            print("")
            continue 

def hostInterface():
    while True:
        try:
            choise= int(input("please chose one of the following functionalities\n   1-Properties that are not rented yet.\n   2-Create my bill\n   3-Update my phone number\n   4-Add listings\n   5-Exit\nYour choice is: "))
        except:
            print("Please insert an integer ")
       
       
        if choise ==1:
            displayQuery(queries.q5_propertiesNotRented())
        
        
        
        elif choise==2:
            username= input("please enter your user name: ")
            result=queries.q8_guestBill(username)
            if result:
                try:
                    displayQuery(result)
                    
                except:
                    print("User name is incorrect")
                    pass
            else:
                print("there was an error in your syntax")
                
                
        elif choise==3:
            username= input("please enter your user name: ")
            phone=input("please enter your new phone number: ")
            
            result=queries.q9_guestPhoneUpdate(phone,username)
            if result:
                try:
                    displayQuery(result)
                    con.commit()
                except:
                    print("user name is incorrect! ")
            else:
                print("there was an error in your syntax")
                
        elif choise==4:
            property_id=input("please enter the property ID desired \n (this should be atleast a three digit integer)\n you Property ID is: ")
            host_username=input("please enter your User name\n(this must be an existing user name ex: Ahmed_Gawi, Omar_Rad)\n your username is : ")
            house_number= input("please enter your house number \n(this should also be and integer)\n your house number is : ")
            st=input("please enter your street name \n(this should be a string)\n your street name is : ")
            city=input("please name the city the property is located: ")
            prov= input("please enter the province name the property is located: ")
            country=input("please enter the country name\n(ex: Canada, Egypt, Zimbabwe)\n> ")
            type_= input("please enter the type of the property \n (ex: Condo,House,Apartment)\n your property type is : ")
            room_type= input("please enter the room type included\n (ex: Regular, Master):\n your room type is: ")
            accom= input("please enter the number of visitors allowed per night\n(this should be an integer)\n The number of visitors is:  ")
            bathrooms= input("please enter the number of bathrooms included\n(this should be an integer)\n The number of BR is: ")
            bedrooms=input("please enter the number of bedrooms included\n(this should be an integer)\n The number of bedrooms is: ")
            beds=input("please enter the total number of beds: ")
            price= input("please enter the desired price per night\n(this could be a float up to two decimel points)\n The price: ")
            allowed_guests= accom
            home_type=type_
            rules= input("please enter special instructions that you have. \n(this should be a string of 255 characters)\n> ")
            ameneties= input("please enter any added aminities to your properties\n (ex: wifi, NA)\n> ")
            prop_class=input("please enter the class of your property\n(this should be a string)\n> ")
            # try:    
            displayQuery(queries.q11_insertIntoProperties(property_id, host_username, house_number, st, city, prov, country, type_, room_type, accom, bathrooms, bedrooms,
                        beds, price, allowed_guests, home_type, rules, ameneties, prop_class))
            con.commit()
            print("** your property has been listed succesfully **")
            # except:
            #     print("** One of your entries did not corespond to the instructions please try again carefully **")
            #     pass
            
        
                
        elif choise==5:
            break

def employeeInterface():
    while True:
        try:
            choise= int(input("please chose one of the following functionalities:\n    1-Info of guests who rented properties.\n    2-Detailed view of all the guests\n    3-Display the details of the cheapest (completed) rental.\n    4-Display rented properties \n    5-Properties that are not rented yet.\n    6-List, with detail, all properties rented on the 10 th day of any month.\n    7-List all managers and employees with salaries >= $15000\n    8-Create user bill\n    9-Update user phone number\n    10-List users full names\n    11-exit\nYour choice is: "))
        except:
            print("Please insert an integer ")
        
        if choise ==1:
            displayQuery(queries.q1_guestListQuery())
        
        elif choise==2:
            displayQuery(queries.q2_guestListView())
    
        elif choise==3:
            displayQuery(queries.q3_cheapestRental())
        
        elif choise==4:
            displayQuery(queries.q4_allProperties())
        
        elif choise==5:
            displayQuery(queries.q5_propertiesNotRented())
        
        
        elif choise==6:
            displayQuery(queries.q6_rented10th())
        
        elif choise==7:
            displayQuery(queries.q7_employee15k())
        
        
        elif choise==8:

            username= input("please enter the user name please: ")

            result=queries.q8_guestBill(username)
            if result:
                try:
                    displayQuery(result)
                except:
                    print("please inter correct username")
            else:
                print("there was an error in your syntax")
        
        elif choise==9:
            username= input("please enter your user name: ")
            phone=input("please enter your new phone number: ")
            
            result=queries.q9_guestPhoneUpdate(phone,username)
            if result:
                try:    
                    displayQuery(result)
                    con.commit()
                except:
                    print("please enter correct user name and password!")
                    pass
            else:
                print("there was an error in your syntax")
           
        elif choise==10:
            first= input("please enter the first name: ")
            last = input("please enter the last name: ")
            
            try:    
                displayQuery(queries.q10_firstNameFirst(first,last))
            except:
                print("Either first or last name is incorrect")
                pass
        
        elif choise==11:
            break

        else :
            print("")
            print("")
            print("please insert only one of these Eleven integers.")
            print("")
            print("")
            continue 






def main():
    while True:
        user= int(input("For Authorization purposes please specify your identity \nPlease choose one of the following options:\n     1-Administrator\n     2-Host/guest\n     3-Branch employee\n     4-Exit\n your choice is:  "))
        
        if user == 1:
           adminInterface()
        elif user == 2:
            hostInterface()
        elif user ==3:
            employeeInterface()
        elif user==4:
            break

        
        else :
            print("")
            print("")
            print("please insert only one of these four integers.")
            print("")
            print("")
            continue 
        
        
        
        
        
    # output= q1_guestListQuery()
    # displayQuery(output)

    cur.close()

    # close the connection
    con.close()

if __name__ == '__main__':
    main()
    