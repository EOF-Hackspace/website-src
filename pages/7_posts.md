---
layout: page
title: Blog
# description: >
#   -
hide_description: true
menu: true
order: 2
permalink: /posts/
---

See what's been happening in our community.

{% if site.posts.size > 0 %}
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }} ({{post.date | date: "%d %b %Y"}})</a>
    </li>
  {% endfor %}
</ul>
{% else %}
  <p>There are no posts available right now. Come back soon!</p>
{% endif %}

