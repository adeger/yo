'''Quickie smoke test for the yo site'''

import unittest
import requests
import random

SITE_BASE = "http://yo-spring-dev-11617100.us-west-2.elb.amazonaws.com"
SITE_LIST_URL = SITE_BASE + "/v1/user/list"
SITE_ADD_URL_TEMPLATE = SITE_BASE + "/v1/user/add?name=%s&email=%s" 


random.seed()
def rand_str():
    result = ''

    length = random.randrange(3, 14)
    char_index = range(65, 91) + range(97, 123)

    for i in range(0, length): 
        r = random.randrange(len(char_index))
        result += unichr(char_index[r])
    return result


class TestSite(unittest.TestCase):
    def test_list(self):
        resp = requests.get(SITE_LIST_URL) 
        self.assertEqual(resp.status_code, 200)

        # next will raise an error if we don't get json
        resp.json()

    def test_add(self):

        name = rand_str()

        resp = requests.get(SITE_LIST_URL) 
        emails = [x['email'] for x in resp.json()]

        while(True):
            email = "%s@%s.com" % (rand_str(), rand_str())
            if (email not in emails): break

        
        url = SITE_ADD_URL_TEMPLATE % (name, email)
        resp = requests.get(url)
        self.assertEquals("success", resp.json()["result"])
        
        
        resp = requests.get(SITE_LIST_URL) 
        emails = [x['email'] for x in resp.json()]
        self.assertTrue(email in emails)


    def test_404(self):
        resp = requests.get(SITE_BASE)
        self.assertEqual(resp.status_code, 404)


if __name__ == '__main__':
    unittest.main()
