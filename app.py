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
            choise= int(input("please chose one of the following functionalities\n   1-Properties that are not rented yet.\n   2-Create my bill\n   3-Update my phone number\n   4-Exit\nYour choice is: "))
        except:
            print("Please insert an integer ")
       
       
        if choise ==1:
            displayQuery(queries.q5_propertiesNotRented())
        
        
        
        elif choise==2:
            username= input("please enter your user name: ")
            result=queries.q8_guestBill(username)
            if result:
                displayQuery(result)
            else:
                print("there was an error in your syntax")
                
                
        elif choise==3:
            username= input("please enter your user name: ")
            phone=input("please enter your new phone number: ")
            
            result=queries.q9_guestPhoneUpdate(phone,username)
            if result:
                displayQuery(result)
            else:
                print("there was an error in your syntax")
                
        elif choise==4:
            break

def employeeInterface():
    while True:
        try:
            choise= int(input("please chose one of the following functionalities:\n    1-Info of guests who rented properties.\n    2-detailed view of all the guests\n    3-Display the details of the cheapest (completed) rental.\n    4-Display rented properties \n    5-Properties that are not rented yet.\n    6-List, with detail, all properties rented on the 10 th day of any month.\n    7-List all managers and employees with salaries >= $15000\n    8-Create user bill\n    9-Update user phone number\n    10-List users full names\n    11-exit\nYour choice is: "))
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
            username= input("please enter the user name")
            result=queries.q8_guestBill(username)
            if result:
                displayQuery(result)
            else:
                print("there was an error in your syntax")
        
        elif choise==9:
            username= input("please enter your user name: ")
            phone=input("please enter your new phone number: ")
            
            result=queries.q9_guestPhoneUpdate(phone,username)
            if result:
                displayQuery(result)
            else:
                print("there was an error in your syntax")
           
        elif choise==10:
            first= input("please enter the first name: ")
            last = input("please enter the last name: ")
            displayQuery(queries.q10_firstNameFirst(first,last))
        
        
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
        user= int(input("For Authorization purposes please specify you identity \nPlease choose one of the following options:\n     1-Administrator\n     2-Host/guest\n     3-Branch employee\n     4-Exit\n your choice is:  "))
        
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
    