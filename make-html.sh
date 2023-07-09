#!/usr/bin/env bash

# generate the "dist.html" HTML file we use to display a nice bookmarklet button.

readable_js="$1"

# light minifying of js supplied on stdin
minify_js() {
  tr '\n' ' ' | \
    sed 's/\s\+/ /g; s/ \?\([{;)=,+]\) \?/\1/g;'
}


# strip trailing newline with linux `head`
# (non-POSIX)
head -c -1 <<END
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
  <title>readability bookmarklet</title>
  <style>
  :root {
    --color-h: 201; /* hue    */
    --color-s: 72%; /* sat    */
    --color-l: 46%; /* light  */
  }

  .bookmarklet {
    display: inline-block;
    color: white;
    text-decoration: none;
    font-family: Helvetica, Arial, sans-serif;
    padding: 0.5rem 30px;
    line-height: 30px;
    margin: 0 auto;
    border-radius: 20px;
    background-image:
      linear-gradient(
                      hsl( var(--color-h), var(--color-s), var(--color-l)) 45%,
                      hsl( var(--color-h), var(--color-s), calc(var(--color-l) * 0.8)) 55%
      );
    box-shadow: 0 2px 2px #888888;
    transition: color 0.3s, background-image 0.5s, ease-in-out;
  }

  .bookmarklet:hover {
    background-image:
      linear-gradient(
                      hsl( var(--color-h), var(--color-s), calc(var(--color-l)* 1.2)) 45%,
                      hsl( var(--color-h), var(--color-s), calc(var(--color-l) * 1)) 55%
      );
  }

  svg {
    padding: 0;
    margin: 0;
    line-height: 1rem;
  }    

  svg .button-text {
     -webkit-user-select: none;
     -moz-user-select: none;
     -ms-user-select: none;
     user-select: none;
  }

  </style>
<body>
Click and drag the button below to your bookmarks bar:
<div><p>
  <a class="bookmarklet" href="
END
minify_js < "$readable_js"
cat <<END
" title="MakeReadable">
  <!-- using svg seems to allow more button for user to "grab on" to -->
  <svg id="search-icon" class="search-icon" viewBox="0 0 120 20" height="2rem" width="12rem" xmlns="http://www.w3.org/2000/svg">
    <style>
      .button-text {
        fill: white;
      }
    </style>
    <text x="0" y="17" class="button-text">MakeReadable</text>
  </svg>
</a></p>

<br>
Or if that doesn't work – right-click on it and choose "Add bookmark for this link".</a>
END

