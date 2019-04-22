---
layout: default
---
{% for post in site.posts %}
  <article>
    <time datetime="{{ post.date | date: "%Y-%m-%d" }}">{{ post.date | date_to_long_string }}</time>
    <h2>
      <a href="{{ post.url }}">
      {{ post.title }}
      </a>
    </h2>
    <hr>
  </article>
{% endfor %}
