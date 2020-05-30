---
title: Archive
permalink: /archive/
layout: page
comments: false
---

<h4 class="posts-item-note">Archived Posts</h4>
{% for post in site.posts %}
{% if post.archived %}
<article class="post-item">
    <span class="post-item-date">{{ post.date | date: "%b %d, %Y" }}</span>
    <h4 class="post-item-title">
        <a href="{{ post.url }}">{{ post.title | escape }}</a>
    </h4>
</article>
{% endif %}

{% endfor %}
