javascript: (function() {
    console.log('start');
    var jsCode = document.createElement('script');
    jsCode.setAttribute('src', 'https://cdn.jsdelivr.net/gh/mozilla/readability@49d345a4/Readability.js');
    window.cleanHtml = (function() {
        var oldTitle = document.title;
        var oldUrl = document.location.href;
        var loc = document.location;
        console.log( { loc } );
        var uri = {
            spec: loc.href,
            host: loc.host,
            prePath: loc.protocol + '//' + loc.host,
            scheme: loc.protocol.substr(0, loc.protocol.indexOf(':')),
            pathBase: loc.protocol + '//' + loc.host + loc.pathname.substr(0, loc.pathname.lastIndexOf('/') + 1)
        };
        var article = new Readability(uri, document).parse();
        document.children[0].innerHTML = article.content;
        var metaViewPort = document.createElement('meta');
        metaViewPort.setAttribute('name', 'viewport');
        metaViewPort.setAttribute('content', 'width=device-width, initial-scale=1.0, user-scalable=yes');
        document.head.appendChild(metaViewPort);
        var cleanStyle = document.createElement('link');
        cleanStyle.setAttribute('href',
        'https://cdn.jsdelivr.net/gh/phlummox-dev/readability-bookmarklets@0.1.0/clean.css');
        cleanStyle.setAttribute('rel', 'stylesheet');
        document.head.appendChild(cleanStyle);
        history.replaceState({}, oldTitle, oldUrl)
    });
    jsCode.onload = cleanHtml;
    document.body.appendChild(jsCode);
}());


