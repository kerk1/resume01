with open('api_link.txt') as f:
    url = f.readlines()
    
url = url[0][23:-2]
url = '"'+url+'/get-counter"'
print(url)
f = open('api.js','w')
message = ''' function newGet() {{
			fetch({url})
			.then(response => response.json())
			.then(data => document.getElementById('output1').innerHTML = data);
			}}			'''.format(url=url)

f.write(message)
f.close()