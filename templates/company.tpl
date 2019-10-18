{% extends "base.html" %}
{% block title %}Bensínstöðvar{% endblock %}
{% block content %}
<table>
    <h2>Allar Bensínstöðvar fyrirtækisins</h2>
    <tr>
        <th>Fyrirtæki</th><th>Staður</th>
    </tr>

    {% set cnt = [] %}
    {% for item in gogn['results'] %}
    <tr>
        {% if item.company == com %}
        {% do cnt.append(item.company) %}
        <td><a href="/moreinfo/{{item.key}}">{{item.company}}</a></td>
        <td>{{item.name}}</td>
        {% endif %}
    </tr>
    {% endfor %}
</table>
<h3>Fjöldi stöðva: {{ cnt | length }}</h3>
{% endblock %}