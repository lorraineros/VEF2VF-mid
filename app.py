from flask import Flask, flash, redirect, render_template, request, json
import os
import urllib.request
from math import inf
from jinja2 import ext
from datetime import datetime

app = Flask(__name__)


with urllib.request.urlopen("https://apis.is/petrol") as url:
    gogn =json.loads(url.read().decode())

def format_time(gogn):
    return datetime.strptime(gogn, '%Y-%m-%dT%H:%M:%S.%f').strftime('%d/%m/%Y Klukkan %H:%M')

app.jinja_env.add_extension(ext.do)
app.jinja_env.filters['format_time'] = format_time

def find_lowest_prices(gogn):
    lowest_petrol_price = [min(gogn['results'], key=lambda x: x['bensin95']), min(gogn['results'], key=lambda x: x[
        'bensin95_discount'] if x['bensin95_discount'] is not None else inf)]
    lowest_diesel_price = [min(gogn['results'], key=lambda x: x['diesel']), min(gogn['results'],
                           key=lambda x: x['diesel_discount'] if x['diesel_discount'] is not None else inf)]

    lowest_petrol_price = lowest_petrol_price[0] if lowest_petrol_price[0]['bensin95'] <= lowest_petrol_price[1]['bensin95_discount'] else lowest_petrol_price[1]
    lowest_diesel_price = lowest_diesel_price[0] if lowest_diesel_price[0]['diesel'] <= lowest_diesel_price[1]['diesel_discount'] else lowest_diesel_price[1]

    return lowest_petrol_price, lowest_diesel_price

@app.route('/')
def index():
    return render_template('index.tpl', gogn=gogn, lowestPrices=find_lowest_prices(gogn))
    
@app.route('/company/<company>')
def comp(company):
    return render_template('company.tpl', gogn=gogn, com=company)

@app.route('/moreinfo/<key>')
def info(key):
    return render_template('moreinfo.tpl', gogn=gogn, k=key)

@app.errorhandler(404)
def not_found(error):
    return render_template("error.tpl"),404


if __name__ == '__main__':
    app.run(debug=True)