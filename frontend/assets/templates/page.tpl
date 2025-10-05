<!DOCTYPE html>
<html lang="en-US">
<head>
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="renderer" content="webkit">
<title>{{ html .Title }}</title>
<link rel="stylesheet" href="/static/css/bootstrap.min.css">
<style>
@media { min-width: 768px }
.form {	min-width: 400px; }
.active { color:forestgreen !important; }
</style>
<meta name="robots" content="noindex, nofollow">
</head>
<body>

<nav class="navbar navbar-expand-lg sticky-top bg-body-tertiary">
	<div class="container-fluid">
	<a class="navbar-brand" href="{{ .BrandURL }}"><img src="/static/img/cdubs-2.png" width="113" height="57" alt="logo"></a>
	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		{{ $option := .URLOption }}
		{{ $server := .URLServer }}
		{{ $target := .URLCommand }}
		{{ if .IsWhois }}
			{{ $option = "summary" }}
			{{ $server = .AllServersURL }}
			{{ $target = "" }}
		{{ end }}
		<ul class="navbar-nav d-flex flex-wrap me-auto">
			<li class="nav-item">
				{{ if eq .AllServersURLCustom "all" }}
				<a class="nav-link ms-1{{ if .AllServersLinkActive }} active{{ end }}"
					href="/{{ $option }}/{{ .AllServersURL }}/{{ $target }}"> {{ .AllServerTitle }} </a>
				{{ else }}
				<a class="nav-link active"
					href="{{ .AllServersURLCustom }}"> {{ .AllServerTitle }} </a>
				{{ end }}
			</li>
			{{ $length := len .Servers }} 
			{{ range $k, $v := .Servers }}
			<li class="nav-item">
				{{ if gt $length 1 }}
				<a class="nav-link ms-1{{ if eq $server $v }} active{{ end }}"
					href="/{{ $option }}/{{ $v }}/{{ $target }}">{{ html (index $.ServersDisplay $k) }}</a>
				{{ else }}
				<a class="nav-link ms-1{{ if eq $server $v }} active{{ end }}"
					href="/">{{ html (index $.ServersDisplay $k) }}</a>
				{{ end }}
			</li>
			{{ end }}
		</ul>
		{{ if .IsWhois }}
			{{ $target = .WhoisTarget }}
		{{ end }}
	</div>
  </div>
</nav>

<div class="container">

	<div class="form">
	   <form name="goto" class="form-inline" action="javascript:goto();">
                        <div class="input-group mt-3 mb-3">
                                <select name="action" class="form-select">
                                        {{ range $k, $v := .Options }}
                                        <option value="{{ html $k }}"{{ if eq $k $.URLOption }} selected{{end}}>{{ html $v }}</option>
                                        {{ end }}
                                </select>
                                <input name="server" class="d-none" value="{{ html ($server | pathescape) }}">
                                <input name="target" class="form-control" placeholder="Target" aria-label="Target" value="{{ html $target }}">
                                <div class="input-group-append">
                                        <button class="btn btn-outline-success" type="submit">&raquo;</button>
                                </div>
                        </div>
                </form>
		</div>
	{{ .Content }}
</div>

<script src="/static/jquery/jquery.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/sortTable.js"></script>

<script>
function goto() {
	let action = $('[name="action"]').val();
	let server = $('[name="server"]').val();
	let target = $('[name="target"]').val();
	let url = "";

	if (action == "whois") {
		url = "/" + action + "/" + target;
	} else if (action == "summary") {
		url = "/" + action + "/" + server + "/";
	} else {
		url = "/" + action + "/" + server + "/" + target;
	}

	window.location.href = url;
}
</script>
</body>
</html>
