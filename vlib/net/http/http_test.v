import net.http

fn test_http_get() {
//	$if !network ? { return }
	assert http.get_text('https://vlang.io/version') == '0.1.5'
	println('http ok')
}

fn test_http_get_from_vlang_utc_now() {
//	$if !network ? { return }
	urls := ['http://vlang.io/utc_now', 'https://vlang.io/utc_now']
	for url in urls {
		println('Test getting current time from $url by http.get')
		res := http.get(url) or { panic(err) }
		assert 200 == res.status_code
		assert res.text.len > 0
		assert res.text.int() > 1566403696
		println('Current time is: ${res.text.int()}')
	}
}

fn test_public_servers() {
//	$if !network ? { return }
	urls := [
		'http://github.com/robots.txt',
		'http://google.com/robots.txt',
		'http://yahoo.com/robots.txt',
		'https://github.com/robots.txt',
		'https://google.com/robots.txt',
		'https://yahoo.com/robots.txt',
	]
	for url in urls {
		println('Testing http.get on public url: $url ')
		res :=  http.get( url ) or { panic(err) }
		assert 200 == res.status_code
		assert res.text.len > 0
	}
}
