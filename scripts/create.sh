echo -e "---\nlayout: default\ntitle: \"$*\"\ncategories: []\n---" > "${PWD}/_posts/$(date +%Y-%m-%d)-$*.md"
