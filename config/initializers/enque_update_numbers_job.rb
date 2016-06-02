# print "\n***********\nHello World\n***********\n"
UpdateNumbersJob.perform_later
UpdateMeanSampleJob.set(wait: 1.minute).perform_later
TweetStatusJob.set(wait: 3.minutes).perform_later
