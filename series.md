---
title: Series
permalink: /series/
layout: page
excerpt:
comments: false
---

{% assign grouped =  site.posts | sort: 'date' | reversed | group_by: 'series' %}

<div>
{% for series in grouped %}
    {% capture name %}{{ series.name }}{% endcapture %}
    {% capture size %}{{ series.size }}{% endcapture %}
    {% if name != '' %}
        <h4>{{ name }} ({{size}})</h4>
        <ul>
            {% for item in series.items %}
                <li><a href="{{ item.url }}">{{ item.title }}</a></li>
            {% endfor %}
        </ul>
    {% endif %}
{% endfor %}
</div>


{% for item in posts %}
{{ item.title }}
{% endfor %}
