UpdateNumbersJob.perform_later
UpdateMeanSampleJob.perform_later
TweetStatusJob.set(wait: 5.minutes).perform_later
TweetAnswersJob.set(wait: 10.minutes).perform_later