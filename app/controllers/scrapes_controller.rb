require 'open-uri'
require 'nokogiri'
require 'date'

class ScrapesController < ApplicationController
  def index
  end

  def new
    @day_time = DateTime.now
    root_url = "https://news.yahoo.co.jp/"

    charset = nil
    html = open(root_url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    site_list = doc.css("ul.toptopics_list")
    data = []
    num = 0
    count = 0
    8.times do
      url = site_list.css("a")[num][:href]
      data.push(url)
      num += 1
      count += 1
    end

    title_data = []
    summary_data = []
    time_data = []

    data.each do |topic_url|
      charset = nil
      topic_html = open(topic_url) do |f|
        charset = f.charset
        f.read
      end
      topic_doc = Nokogiri::HTML.parse(topic_html, nil, charset)
      topic_url_title = topic_doc.css("h2.newsTitle")
      title_data.push(topic_url_title.css("a").text)

      topic_url_summary = topic_doc.css("p.hbody")
      summary_data.push(topic_url_summary.text)

      topic_url_time = topic_doc.css(".topicsName")
      time_data.push(topic_url_time.css("span.date").text)
    end

    @title_datas = title_data
    @summary_datas = summary_data
    @time_datas = time_data
  end
end
