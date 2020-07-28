from datetime import datetime, timedelta

now = datetime.now()


def date2str(delta):
    return str(now + timedelta(days=delta)).split(' ')[0]


day1 = date2str(0)
day2 = date2str(2)
day4 = date2str(4)
day7 = date2str(7)
day15 = date2str(15)

day_list = '\n'.join([
    day1,
    day2,
    day4,
    day7,
    day15
])

print(day_list)

