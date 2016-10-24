import psycopg2
conn = psycopg2.connect(database="uber", user="postgres", host="127.0.0.1", port="5432")
conn.autocommit = True
cur = conn.cursor()

print('''//////////////////////////////////////////////////////////////////////////////
        We are adding $20 of ride credit
        per referral a rider (in this case R001) has made.''')
print('''
        Of course, this should only be run once,
        but for yout testing purpose
        if you run it multiple times
        you should see an icrement of $40 in credit every time
//////////////////////////////////////////////////////////////////////////////''')

sample1 = '''
SELECT count(*)
  FROM Rider
WHERE referrer = '%s'
'''
rid = 'R001'
getRef = sample1 % rid

cur.execute(getRef)

rows = cur.fetchall()
count = rows[0][0]

# for each referrals a rider made, he/she gets 20 credit
def getCredit(numRef):
  return numRef * 20

newCred = getCredit(count)


# get current credit for rider
sample2 = '''
SELECT ride_credit
  FROM Rider
 WHERE rid = '%s'
'''

getCred = sample2 % rid

cur.execute(getCred)

rows = cur.fetchall()
curCred = rows[0][0]
print("Current Credit For",rid,":",curCred)

# gives rider credit for referrals
def updateCred(curCred, addCred, rid):
    newCred = curCred + addCred
    print("Updated Credit For",rid,":",newCred)
    sample = '''
    UPDATE Rider
       SET ride_credit = %d 
     WHERE rid = '%s'
    '''

    update = sample % (newCred, rid)
    return update

update = updateCred(curCred,newCred,rid)

cur.execute(update)

