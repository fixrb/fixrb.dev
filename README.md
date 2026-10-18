# fixrb.dev

The website of the Fixrb project: Fix, Matchi and the gems around them.

Hand-written HTML5 and one stylesheet. No build step, no JavaScript, and nothing loaded from another site. Only the highlighting of Ruby code is written by a script, `bin/check --fix`, with the standard library.

## Layout

| Path | Content |
|---|---|
| `index.html` | Home: Fix, the gems, the latest posts |
| `gems/NAME/index.html` | One page per gem |
| `gems/NAME/img/` | A gem's drawing and its icons, used by its page |
| `blog/index.html`, `feed.xml` | The list of posts and its Atom feed |
| `sitemap.xml`, `robots.txt` | For search engines: every page but the 404, and the files kept out of results |
| `CATEGORIES/YYYY/MM/DD/SLUG.html` | Posts, at the URLs of the former Jekyll blog |
| `examples/` | Every code example shown on a page, as a Ruby file |
| `404.html` | Served by GitHub Pages for any unknown address |
| `style.css`, `fonts/`, `logo.svg`, `favicon.ico`, `icon.png` | Style and images |
| `bin/check`, `bin/examples` | The checks, and the runner of the examples |
| `.github/` | CI, which runs `bin/check`, and Dependabot, for the actions |
| `.ruby-version` | The Ruby of CI and of the highlighting |
| `.gitattributes` | LF line endings in every checkout |
| `.nojekyll` | Tells GitHub Pages to serve the files as they are |
| `LICENSE.md` | MIT License |

GitHub Pages publishes every file of the repository, so `bin/check` accepts only the files above: anything new must be added to its list.

## Rules

- Semantic HTML5, element names in lowercase: no `div`, no `span`, no `class`, no inline style or script. The stylesheet targets elements, ids, ARIA attributes and, in code blocks only, the five token classes below.
- One exception: inside `<pre><code>`, Ruby tokens are wrapped in `<span>` elements with one of five classes, `comment`, `keyword`, `constant`, `string` and `number`. They are never written by hand: `bin/check --fix` writes them from Ruby's own tokenizer, Ripper, and `bin/check` fails if they differ in any way from what it would write.
- A `<pre>` holds either Ruby code, in one `<code>`, or a terminal session: `<kbd>` for what is typed, `<samp>` for what the computer prints, text, and no other element. A `<pre>` never contains another.
- Every page starts with the same lines, up to the content security policy (`default-src 'none'`, then `'self'` for styles, images and fonts) and the referrer policy. Except `404.html`, each has a description, a canonical URL, the Open Graph tags that repeat them, `og:site_name`, and an `og:image` served by the site.
- The site header and footer are the same on every page; only the menu link to the page itself carries `aria-current="page"`.
- Element and attribute names are in lowercase, and no attribute appears twice. Attributes and `rel` values come from a short list in `bin/check`: nothing that would contact another site (`preconnect`, `ping`, `srcset`) or open a window (`target`).
- `sitemap.xml` lists every page but `404.html` by its canonical URL, without dates. `robots.txt` announces it and keeps the tooling (`bin/`, `examples/`, dotfiles, `README.md`, `LICENSE.md`) out of search results, never a page, the feed, the style, a font or an image.
- Files a browser could run when opened directly are checked too. An SVG file may only hold `svg`, `title`, `g`, `rect` and `path`, with attributes from a short list and values without a colon or a slash, so that none holds a URL; `logo.svg` is also pinned by its SHA-256, as fixrb/logo publishes it. `feed.xml` may only hold Atom elements, from a short list, linking to the site. A `CNAME` file contains `fixrb.dev`.
- Links inside the site start with `/` and lead to a file of the repository. Stylesheets, images and fonts are served by the site. No file is a symbolic link.
- A code block shows a file of `examples/`, character for character: `<pre data-example="examples/gem/name.rb"><code>…</code></pre>`, with `<` and `&` escaped. To add or change one, edit the file, write `<pre data-example="…"><code></code></pre>` the first time, and run `bin/check --fix`. Examples end their lines with LF. A line that ends with `# => VALUE` must evaluate to an object whose `inspect` is `VALUE`.
- The five posts published before Fix 1.0 are kept as they were written, with a note saying so. Their code is not run but is highlighted like the rest; they are listed in `bin/check`.

## Checking

```sh
bin/check
```

Checks the rules above, the internal links and anchors, the feed, and that every code block matches its file and its highlighting. It needs git and the Ruby standard library only, and looks at the files git tracks or would add (ignored files are left out). CI runs it on pushes to `main` and on pull requests, with the Ruby of `.ruby-version`.

```sh
bin/check --fix
```

Rewrites the code blocks of every page, and nothing else, then checks. A block that is not well formed, or code that Ripper cannot read back exactly (such as data after `__END__`), is left as it is and reported. Ripper may split some code differently from one version of Ruby to another, so the highlighting is the one of the Ruby in `.ruby-version`, which CI uses too: run `bin/check --fix` with it.

```sh
RUBYLIB=../matchi/lib bin/examples examples/matchi
```

Runs the examples, each in its own Ruby process, with the gems found on the load path, and prints the file each `require` loaded, so that the version under test is visible. Before a release of a gem, run its examples against the code to be released.

`bin/examples` runs the code of the examples, and `bin/check --fix` copies it into pages: run neither on a branch you have not read.

## Markup

The stylesheet relies on this structure, which every page follows.

- `body > header`: a link to `/` with the logo and the site name, then `nav[aria-label="Main"] > ul`. `body > footer`: a paragraph, then a list of links. `main` in between.
- Home: `section#intro` (logo, `hgroup`, paragraph, `figure` with the example, `ul` of two links), then `section#gems` holding `section#stack` and `section#others`. A gem card is `li > h4 > a`, a `p`, and in the stack a status in `p > small`.
- Gem pages: `main > article`, whose `header` holds the gem's drawing, `img`, then the `hgroup`.
- Lists of posts: `ul > li > article`, with a title `h2 > a` or `h3 > a`, a date `p > time`, and a description `p`.
- Posts: `article > header` (the `h1`, then `p` with the date and author), `p[role="note"]` for a note, `article > footer`.
- Pixelify Sans sets `h1`, the `h2` of sections and posts, the site name, menus and gem names only: at small sizes its C reads as an O. Titles in lists of posts, `h3`, dates and running text use the system font.

## Preview

```sh
python3 -m http.server 8000
```

Then open <http://localhost:8000/>. Pages use root-relative links, so opening a file directly does not load the stylesheet. `ruby -run -e httpd . -p 8000` works as well once the `webrick` gem is installed.

## Adding a post

1. Write the page at `/CATEGORIES/YYYY/MM/DD/SLUG.html`, starting from an existing post, without the note about Fix 1.0.
2. Add it at the top of `blog/index.html` and of the latest posts on `index.html` (three at most), and to `sitemap.xml`.
3. Add an entry at the top of `feed.xml`: `id` is the URL without `.html`, as for the former posts. Update the feed's `updated`.
4. Put its code in `examples/`, then run `bin/check --fix` and `bin/examples`.

## Adding a gem page

Write `gems/NAME/index.html` from `gems/matchi/index.html`: what the gem does, how to install it, examples from `examples/NAME/`, the version the page documents, and links to its README, API reference and source at that version. Link it from the gem's card on `index.html`, and add it to `sitemap.xml`.

A gem may have its own drawing and icons, in `gems/NAME/img/`, which `bin/check` requires a page to use:

- A pixel drawing, shown in the header with `alt=""`, its `width` and `height` set to 4 screen pixels per pixel of the drawing. Its pixels fall on whole units of its `viewBox`, which keeps every pixel whole on screen. Letters, if any, are set in Pixelify Sans, at its regular weight: its strokes are one pixel wide, where the bold of the titles is wider than a pixel.
- `favicon.ico`, `icon.svg` and `apple-touch-icon.png`, which replace the site's three icons in the page's head. The Apple icon is opaque, since iOS fills transparency with black, and keeps a margin for the rounded corners. For matchi, whose icon is 31 × 32 pixels drawn 8 times larger, it was exported with Inkscape at 4 screen pixels per pixel:

  ```sh
  LC_ALL=C inkscape gems/matchi/img/icon.svg \
    --export-area=-56:-48:304:312 --export-width=180 --export-height=180 \
    --export-background='#fffef8' --export-background-opacity=1 \
    --export-filename=gems/matchi/img/apple-touch-icon.png
  ```

  `--export-area` is in document pixels, not in units of the `viewBox`.

## Releasing a gem

When a gem is released, update its card on `index.html` (version and status) and its page (the version documented, and its links at that version), check that those links resolve, and run its examples against the release with `bin/examples`.

## Hosting

GitHub Pages serves `fixrb.dev` from the `main` branch, root folder: `CNAME` names the domain, and `.nojekyll` makes Pages serve the files as they are. The domain is verified for the `fixrb` organization (organization settings, Pages, verified domains), so that no other repository can claim it. It was served from `docs/` in `fixrb/fix`, by Jekyll, until October 2026.

Pages publishes every push to `main`, checked or not. To publish only what passes `bin/check`, protect `main` in the repository settings: changes through pull requests, with the Check status required.

For search engines, `fixrb.dev` is to be a domain property in Google Search Console (a DNS TXT record) and in Bing Webmaster Tools (imported from Search Console), with `https://fixrb.dev/sitemap.xml` submitted to both.

## License

The site, its code and its text are released under the [MIT License](LICENSE.md), like the gems, with two exceptions described below: the logo and the font.

## Credits

- Logo: [fixrb/logo](https://github.com/fixrb/logo), public domain (CC0).
- The jester of matchi (`gems/matchi/img/`): drawn by Cyril Kato, with its letters set in Pixelify Sans, under the MIT License like the rest of the site.
- [Pixelify Sans](https://github.com/eifetx/Pixelify-Sans) by Stefie Justprince, under the SIL Open Font License 1.1 (`fonts/OFL.txt`). `fonts/pixelify-sans.woff2` is a subset of `PixelifySans[wght].ttf` from [google/fonts](https://github.com/google/fonts/tree/main/ofl/pixelifysans) (SHA-256 `9ba86cd010a4de309d263ceff8e8044092c9db7efda869620cb9ff1c4389e8a5`), made with:

  ```sh
  pyftsubset "PixelifySans[wght].ttf" \
    --unicodes="U+0020-007E,U+00A0-00FF,U+2013-2014,U+2018-201A,U+201C-201E,U+2022,U+2026,U+2039-203A" \
    --layout-features=kern --flavor=woff2 --output-file=fonts/pixelify-sans.woff2
  ```

  Only kerning is kept: the font's `fi` ligature looks like an `A` at small sizes.
