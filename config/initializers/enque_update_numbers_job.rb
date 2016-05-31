UpdateNumbersJob.set(wait: 1.minute).perform_now
UpdateMeanSampleJob.set(wait: 2.minutes).perform_now
TweetStatusJob.set(wait: 3.minutes).perform_now
