import psycopg2
conn = psycopg2.connect(database="uber", user="postgres", host="127.0.0.1", port="5432")
conn.autocommit = True
cur = conn.cursor()

print('''//////////////////////////////////////////////////////////////////////////////
        We are giving a rider on a particular trip (in this case 17894) 
        $20 in ride credit as well as a refund for a nergative ride experience'
//////////////////////////////////////////////////////////////////////////////''')

#grab how much the certain trip cost and who the rider was

cur.execute('''
    SELECT cost, rid
      FROM Trip
     WHERE tid = '17894';
''')

rows = cur.fetchall()
cost = rows[0][0] #grabs cost of trip so you can eventually reset to 0
rid = rows[0][1] #grabs the rider's id

#get the current ride_credit the particular rider has

sample = '''
SELECT ride_credit
  FROM Rider
 WHERE rid = '%s';
        '''

getCurrentCred = sample % (rid)

cur.execute(getCurrentCred)

rows = cur.fetchall()
current_credit = rows[0][0] #grabs credit val

print("Current Credit For",rid,":",current_credit)

#add the free $20 credit compensation to w/e rider's current balance is
def updateCost(cost,rid,current_credit):
    s1 = '''
    UPDATE Trip
       SET cost = 0
     WHERE rid = '%s'
     ''' % (rid)

    newcred = cost + current_credit
    print("Updated Credit For",rid,":",int(newcred))

    s2 = '''
    UPDATE Rider
       SET ride_credit = %d
     WHERE rid = '%s'
     ''' % (newcred,rid)

    return (s1,s2)

#goes ahead and executes this credit update
(update1,update2) = updateCost(cost, rid, current_credit)

#The rider on this trip originally had $20 in is account already as ride credit.
#The rider was then given $20 in ride credit as compensation for a bad ride, thus
#the rider now has $40 is credit total

cur.execute(update1)
cur.execute(update2)
