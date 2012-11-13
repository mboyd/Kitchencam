#!/bin/bash

cat <<HEAD_END
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="bootstrap.min.css" />
	
	<style>
	html {
		width: 600px;
		margin: auto;
	}

	h1 {
		position: relative;
		left: -50px;
	}

	div.date_vid {
		margin: 20px 0;
	}

	div.date_vid video {
		margin: auto;
	}

	div#footer {
		font-style: italic;
		font-size: 10pt;
	}

	div#footer pre {
		font-style: normal;
		font-size: 8pt;
	}
	</style>

	<title>1E KitchenCam v1.0</title>
</head>
<body>
	<h1>Kitchencam</h1>
HEAD_END

for date in $(ls *.mp4 | cut -d. -f1 | sort -r) ; do 
	cat <<DATE_END
	<div id="$date" class="date_vid">
		$date <br />
		<video controls width=600>
			<source src="$date.mp4" type="video/mp4">
			<source src="$date.webm" type="video/webm">
		</video>
	</div>
DATE_END
done

cat <<TAIL_END
	<div id="footer">
		<pre class="dinosuar">$(fortune | cowsay -W 80 -f stegosaurus)</pre>
		Kitchencam v2.0 by <a href="mailto:mboyd@mit.edu">Merritt Boyd</a> <br/>
		Late updated $(date)
	</div>

</body>
</html>
TAIL_END