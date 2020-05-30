---
title: Series
permalink: /series/
layout: page
excerpt: Sorted article by series.
---

{{ site.series }}

```

{% for item in site.series %} {% capture name %}{{ item | first }}{% endcapture %}


<h4 class="post-header" id="{{ name | downcase | slugify }}">
  {{ name }}
</h4>
{% for post in site.series[name] %}
<article class="posts">
  <span class="posts-date">{{ post.date | date: "%b %d" }}</span>
  <header class="posts-header">
    <h4 class="posts-title">
      <a href="{{ post.url }}">{{ post.title | escape }}</a>
    </h4>
  </header>
</article>
{% endfor %} {% endfor %}
```

{% for post in site.series reversed  %}
asdfa
{% endfor %}
