class UpdateNumbersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    agent = Mechanize.new

    html = agent.get('http://www.oddschecker.com/politics/us-politics/us-presidential-election-2016/winner').body
    source_row = Nokogiri::HTML(html).css('thead tr.eventTableHeader').css('td')

    sources = []
    table = Nokogiri::HTML(html).css('tbody#t1')

    rows = table.css("tr")

    source_row.each_with_index do |source, row_index|
      if source.css('aside a').blank?
        sources << ''
      else
        tds = table.css("tr").css('td')
        oddsmaker = source.css('aside a')[0]['title']
        unless %w(Betdaq Matchbook).include? oddsmaker
          chance_hash = {}
          rows.each_with_index do |row, index|
            tds = row.css("td")
            if !tds[row_index].text.blank? && !tds[row_index]['data-o'].blank?
              probability = convert_payout_to_probability(tds[row_index]['data-o'])
              chance_hash[tds[0].css('a')[0]['data-name']] = (probability * 100).round(1) if probability > 0.01
            end
          end
          adjust_probability(chance_hash, oddsmaker) unless chance_hash.empty?
        end
      end
    end
    UpdateNumbersJob.set(wait: 10.minutes).perform_later
  end

  def adjust_probability(chance_hash, source)
    total_score = 0
    chance_hash.each do |key, value|
      total_score = total_score + value
    end
    total_score = 100 if total_score < 100
    chance_hash.each do |key, value|
      probability = value / total_score
      Sample.create(time_added: Time.now, source: Source.find_or_create_by(name: source), probability: probability.round(3), candidate: Candidate.find_or_create_by(name: key))
    end
  end

  def convert_payout_to_probability(payout)
    payout << '/1' unless payout.include? '/'
    payout = payout.split('/')
    payout[1].to_f / (payout[0].to_f + payout[1].to_f)
  end
end
