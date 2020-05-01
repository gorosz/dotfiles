#!/usr/bin/env fish

function review_links_for_topic --description "Get all the review links for the given topic"
    curl "https://review.balabit/changes/?q=status:open+project:scb/scb-master+topic:$argv&n=25&O=81" \
        -s\
 -H 'Pragma: no-cache'\
 -H 'Sec-Fetch-Site: same-origin'\
 -H 'DNT: 1'\
 -H 'Accept-Encoding: gzip, deflate, br'\
 -H 'Accept-Language: en-US,en;q=0.9'\
 -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.87 Safari/537.36'\
 -H 'Sec-Fetch-Mode: cors'\
 -H 'Accept: application/json'\
 -H 'Cache-Control: no-cache'\
 -H 'Referer: https://review.balabit/'\
 -H 'Cookie: GERRIT_UI=GWT; GerritAccount=aPIfprr65ZC-cOY12HFtoY40pYzPuzbioq'\
 -H 'Connection: keep-alive' --compressed | sed 's/)]}\'//' | jq '.[] | "https://review.balabit/c/\(.project)/+/\(._number)"' | sed -e 's/"//g'
end
