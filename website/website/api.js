 function newGet() {
			fetch("https://657tev8vxb.execute-api.eu-central-1.amazonaws.com/serverless_lambda_stage/get-counter")
			.then(response => response.json())
			.then(data => document.getElementById('output1').innerHTML = data);
			}			