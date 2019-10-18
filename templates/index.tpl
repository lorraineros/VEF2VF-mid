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
<div class="kort">
	<h2>Besta verðið</h2>
    {% if lowestPrices.0.bensin95_discount == None %}
        <h4>Bensín: {{ lowestPrices.0.bensin95 }} krónur hjá {{ lowestPrices.0.company }}</h4>
    {% elif lowestPrices.0.bensin95 <= lowestPrices.0.bensin95_discount %}
        <h4>Bensín: {{ lowestPrices.0.bensin95 }} krónur hjá {{ lowestPrices.0.company }}</h4>
    {% else %}
        <h4>Bensín: {{ lowestPrices.0.bensin95_discount }} krónur hjá {{ lowestPrices.0.company }}</h4>
    {% endif %}
    {% if lowestPrices.1.diesel_discount == None %}
        <h4>Díesel: {{ lowestPrices.1.diesel }} krónur hjá {{ lowestPrices.1.company }}</h4>
    {% elif lowestPrices.1.diesel <=  lowestPrices.1.diesel_discount %}
        <h4>Díesel: {{ lowestPrices.1.diesel }} krónur hjá {{ lowestPrices.1.company }}</h4>
    {% else %}
        <h4>Díesel: {{ lowestPrices.1.diesel_discount }} krónur hjá {{ lowestPrices.1.company }}</h4>
    {% endif %}
    <p>Síðast uppfært: {{ gogn.timestampPriceCheck|format_time }}</p>
</div>
{% endblock %}