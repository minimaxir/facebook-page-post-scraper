# Facebook Page Post Scraper

![](/examples/fb_scraper_data.png)

A tool for gathering *all* the posts of a Facebook Page and related metadata, including post message, post links, and counts of each reaction on the post. For more information on how the script was originally created, see my blog post [How to Scrape Data From Facebook Page Posts for Statistical Analysis](http://minimaxir.com/2015/07/facebook-scraper/).

## Usage

The data scraper is implemented as a Python 2.7 script in `get_fb_posts_fb_pages.py`; fill in the App ID and App Secret of a Facebook app you control (I strongly recommend creating an app just for this purpose) and the Page ID of the Facebook Page you want to scrape at the beginning of the file. Note that this script *cannot* be used to scrape user profiles. (and the Facebook API specifically blocks that use case!).

The CSVs for CNN and BuzzFeed data are not included in this repository due to size; you can download [CNN data here](https://dl.dropboxusercontent.com/u/2017402/cnn_facebook_statuses.csv.zip) [2.7MB ZIP], [BuzzFeed data here](https://dl.dropboxusercontent.com/u/2017402/buzzfeed_facebook_statuses.zip) [2.1MB ZIP], and [NYTimes data here](https://dl.dropboxusercontent.com/u/2017402/nytimes_facebook_statuses.csv.zip).

## Privacy

This scraper can only scrape public Facebook data which is available to anyone, even those who are not logged into Facebook. No personally-identifiable data is collected. Additionally, the script only uses officially-documented Facebook APIs.

## Credits

Peeter Tintis, whose [fork](https://github.com/Digitaalhumanitaaria/facebook-page-post-scraper/blob/master/get_fb_posts_fb_page.py) of this repo implements code for finding separate reaction counts per [this Stack Overflow answer](http://stackoverflow.com/a/37239851).

## License

MIT

If you do find this script useful, a link back to this repository would be appreciated. Thanks!
