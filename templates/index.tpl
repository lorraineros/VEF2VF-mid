{% extends "base.html" %}

{% block title %}{% endblock %}
{% block content %}
<div class="wrapper">
    {% set oneCo = [] %}
    {% for item in gogn['results'] %}
        {% if item.company not in oneCo %}
            {% do oneCo.append(item.company) %}
            <div class="box">
                <a href="/company/{{ item.company }}">
                    <img src="static/{{ item.company }}.png" title="{{ item.company }}">
                </a>
            </div>
        {% endif %}
    {% endfor %}
</div>
{% endblock %}