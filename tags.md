---
title: Tags
permalink: /tags/
layout: page
excerpt: Sorted article by tags.
---

{% for tag in site.tags %} {% capture name %}{{ tag | first }}{% endcapture %}

<h4 class="post-header" id="{{ name | downcase | slugify }}">
    {{ name }}
</h4>
{% for post in site.tags[name] %}
<article class="posts">
    <span style="font-size: 14spx">{{ post.date | date: "%b %d" }}
        <a href="{{ post.url }}">{{ post.title | escape }}</a>
    </span>
</article>
{% endfor %} {% endfor %}
