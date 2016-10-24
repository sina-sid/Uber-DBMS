import psycopg2
conn = psycopg2.connect(database="uber", user="postgres", host="127.0.0.1", port="5432")
conn.autocommit = True
cur = conn.cursor()

print('''//////////////////////////////////////////////////////////////////////////////
        We are deducting tide_credit from a rider for a particular trip (in this case 17892) 
//////////////////////////////////////////////////////////////////////////////''')

#identify the cost and rid of a particular trip
sample1 = '''
SELECT cost, rid
  FROM Trip
 WHERE tid = '%s'
'''

getCostAndRid = sample1 % ('17892')

cur.execute(getCostAndRid)

rows = cur.fetchall()
cost = rows[0][0] # cost of trip 17892
rid = rows[0][1] # rid of trip 17892

#get the current ride_credit the particular rider has

sample2 = '''
SELECT ride_credit
  FROM Rider
 WHERE rid = '%s';
        '''

getCurrentCred = sample2 % (rid)

cur.execute(getCurrentCred)

rows = cur.fetchall()
current_credit = rows[0][0] 

print("Current Credit For",rid,":",current_credit)


# This function calculates the corresponding new Cost of trip 17897 and
# newCred for rider of 17897 after applying the credit to pay for the trip
def getNewCostAndCred(rideCost, riderCred):
  if rideCost <= riderCred: (newCost,newCred) = (0, riderCred - rideCost)
  else: (newCost,newCred) = (rideCost - riderCred, 0)
  return (newCost, newCred)


(newCost,newCred) = getNewCostAndCred(cost,current_credit)

# update corresponding cost and credit
def updateCost(newCost,newCred,rid):
    s1 = '''
    UPDATE Trip
       SET cost = %d
     WHERE rid = '%s'
     ''' % (newCost,rid)

    print("Updated Cost For",rid,":",int(newCost))

    s2 = '''
    UPDATE Rider
       SET ride_credit = %d
     WHERE rid = '%s'
     ''' % (newCred,rid)

    return (s1,s2)


(update1,update2) = updateCost(newCost, newCred, rid)

# executes this credit update
cur.execute(update1)
cur.execute(update2)

# The rider on this trip originally had $40 in is account already as ride credit.
# We now subtract the trip of that cost

