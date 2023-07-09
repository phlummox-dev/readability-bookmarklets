# readability-bookmarklets

Looking for a bookmarklet which improves readability on mobile devices. Such
bookmarklets are sometimes called
"declutterers" or "simplifiers".

[`readable`](http://readable.tastefulwords.com) from tastefulwords.com is one of the best-known examples.

Here is a [modified and customised version](https://gist.github.com/akaleeroy/855be4a4a690ff9dafa05234f2f35928)
of it by @akaleeroy and others.

But I've found the Mozilla customization of it tends to work better:
<https://github.com/mozilla/readability>.

That's a whole GitHub repo, but the following JavaScript code allows it to be
used as a bookmarklet[^1]:

```javascript
javascript: (function() {
    console.log('start');
    var jsCode = document.createElement('script');
    jsCode.setAttribute('src', 'https://cdn.jsdelivr.net/gh/mozilla/readability@49d345a4/Readability.js');
    window.cleanHtml = (function() {
        var loc = document.location;
        var uri = {
            spec: loc.href,
            host: loc.host,
            prePath: loc.protocol + '//' + loc.host,
            scheme: loc.protocol.substr(0, loc.protocol.indexOf(':')),
            pathBase: loc.protocol + '//' + loc.host + loc.pathname.substr(0, loc.pathname.lastIndexOf('/') + 1)
        };
        var article = new Readability(uri, document).parse();
        document.children[0].innerHTML = article.content;
        var cleanStyle = document.createElement('link');
        cleanStyle.setAttribute('href', 'https://readability.now.sh/clean.css');
        cleanStyle.setAttribute('rel', 'stylesheet');
        document.head.appendChild(cleanStyle);
    });
    jsCode.onload = cleanHtml;
    document.body.appendChild(jsCode);
}());
```

What does the bookmarklet code do?

- It adds a `<script>` element, setting its source to <https://cdn.jsdelivr.net/gh/mozilla/readability@49d345a4/Readability.js>.

  [jsDelivr](https://www.jsdelivr.com) is a free CDN which gives you access to fast, free
  copies of files source from GitHub repositories, NPM projects, and more. The
  `gh/mozilla/readability@49d345a4/Readability.js` portion of the URL says that
  
  - the URL is serving up content from a GitHub repo, with owner `mozilla` and repo name
    `readability`;
  - within that repo, it's using Git commit 49d345a4, and the file `Readability.js`.
- It gets the original URI, using `document.location.href` and so on
- It creates new HTML content, using the `Readability(uri, document)` constructor - this
  new content should have had a lot of the clutter removed. (The full API documentation
  for the `Readability` class is
  [here](https://github.com/mozilla/readability/tree/main#new-readabilitydocument-options).)
- That content gets spliced in, in place of the original, and is given a new stylesheet
  link, with href <https://readability.now.sh/clean.css>.

I've added a few of my own preferences to the JavaScript and CSS (e.g. setting a "viewport"
meta-element).

To use the bookmarklet: visit [this link][dist] and follow the instructions.

[dist]: https://htmlpreview.github.io/?https://github.com/phlummox-dev/readability-bookmarklets/blob/master/dist.html

## Limitations

Probably won't work on pages that have been careful to declare what scripts they allow
via [Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
– but most of the worst readability offenders are also fairly careless about CSP, so will probably allow it.

[^1]: I can't recall where I originally got it from, unfortunately, or I'd credit the creator.


