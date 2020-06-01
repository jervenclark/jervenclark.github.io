---
title: Archive
permalink: /archive/
layout: page
comments: false
---

<h4 class="posts-item-note">Recent Posts</h4>
{% for post in site.posts %}
{% if post.archived %}
<article class="post-item">
    <span class="post-item-date">{{ post.date | date: "%b %d, %Y - %r" }}</span>
    <h4 class="post-item-title" style="font-size: 16px">
        <a href="{{ post.url }}">{{ post.title | escape }}</a>
    </h4>
</article>
{% endif %}
{% endfor %}
