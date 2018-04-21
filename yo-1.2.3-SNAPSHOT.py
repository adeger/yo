'''A quickie rest server that minimally interacts with a database

tests:
curl 'localhost:8080/v1/user/add?name=First&email=someemail@someemailprovider.com'
curl 'localhost:8080/v1/user/list' ; echo
'''

#!flask/bin/python
from flask import Flask, jsonify, abort, request, make_response, url_for
#from flask.ext.httpauth import HTTPBasicAuth
#from flask_restful import reqparse
import pymysql
import os


USER="youser"
PASSWORD="yoimcool"
DB="yo"
db_table_checked=False

app = Flask(__name__, static_url_path = "")


def db_get_cursor():
    global db_table_checked
    mc = pymysql.connect(host=os.getenv('DB_SERVER'),
                         user=USER, 
                         passwd=PASSWORD, 
                         db=DB)
    curs = mc.cursor()
    if not db_table_checked:
        sql =  """CREATE TABLE IF NOT EXISTS 
             `new` (`id` int(11) NOT NULL AUTO_INCREMENT, 
             `email` varchar(255) DEFAULT NULL,   
             `name` varchar(255) DEFAULT NULL,   
              PRIMARY KEY (`id`)) 
              ENGINE=MyISAM DEFAULT CHARSET=latin1;"""
        curs.execute(sql)
    db_table_checked=False
    return curs

#@app.route('/v1/user/add<str:input>', methods = ['GET'])
@app.route('/v1/user/add', methods = ['GET'])
def db_add():
    #try:
    name = request.args.get('name')
    email = request.args.get('email')
    name = request.args.get('name')
    
    try:
        sql = '''INSERT INTO new (email, name) VALUES ('%s', '%s')''' %(email, name)
        curs = db_get_cursor()
        curs.execute(sql)
    except Exception as e:
        abort(500)
    curs.close()
    
    return jsonify({'result' : 'success'}), 200


@app.route('/v1/user/list', methods = ['GET'])
def db_get_list():
    curs = db_get_cursor()
    curs.execute("SELECT * FROM new LIMIT 20")
    results = []
    for row in curs.fetchall():
        results.append({'name' : row[2], 'email' : row[1]})
    curs.close()
    return jsonify(results), 200


@app.errorhandler(400)
def not_found(error):
    return make_response(jsonify( { 'error': 'Bad request' } ), 400)


@app.errorhandler(404)
def not_found(error):
    return make_response(jsonify( { 'error': 'Not found' } ), 404)


if __name__ == '__main__':
    #app.run(port=8080)
    app.run(debug = True, host='0.0.0.0', port=8080)
