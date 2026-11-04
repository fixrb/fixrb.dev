# fixrb.dev

The website of the Fixrb project: Fix, Matchi and the gems around them.

Hand-written HTML5 and one stylesheet. No build step, no JavaScript, and nothing loaded from another site. Only the highlighting of Ruby code is written by a script, `bin/check --fix`, with the standard library.

## Layout

| Path | Content |
|---|---|
| `index.html` | Home: Fix, the gems, the latest posts |
| `gems/NAME/index.html` | One page per gem |
| `gems/NAME/img/` | A gem's drawing, illustration and icons, used by a page or by `style.css` |
| `img/` | The drawings of the site's own design, in SVG, used by `style.css` or a page: the night, the crystals and the signs of the home page, the levels, the print shop of the blog, the empty setting of the 404 |
| `blog/index.html`, `feed.xml` | The list of posts and its Atom feed |
| `sitemap.xml`, `robots.txt` | For search engines: every page but the 404, and the files kept out of results |
| `CATEGORIES/YYYY/MM/DD/SLUG.html` | Posts, at the URLs of the former Jekyll blog |
| `examples/` | Every code example shown on a page, as a Ruby file or a manifest of brutal |
| `404.html` | Served by GitHub Pages for any unknown address |
| `style.css`, `fonts/`, `logo.svg`, `favicon.ico`, `icon.png`, `card.png` | Style, images, and the card shown where the home or a post is shared |
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
- A `<pre>` holds either a file of `examples/`, in one `<code>` (Ruby code highlighted, or a manifest of brutal as it is), or a terminal session: `<kbd>` for what is typed, `<samp>` for what the computer prints, text, and no other element. A `<pre>` never contains another.
- A terminal session that shows output is run by `bin/examples`, so that the page shows what the command writes: `<pre data-directory="examples/gem"><kbd>COMMAND</kbd>` then a line break and `<samp>OUTPUT</samp></pre>`. COMMAND is `ruby FILE` or `fix` with its options and paths, plain ones (letters, digits, `_`, `-`, `/`), and runs in the directory named; a session of `fix --random` shows first the command that runs the files in the same order again, `fix --random=SEED`. The examples a session runs count as shown. A session without output, such as `gem install fix`, takes no attribute.
- Every page starts with the same lines, up to the content security policy (`default-src 'none'`, then `'self'` for styles, images and fonts) and the referrer policy. Except `404.html`, each has a description, a canonical URL, the Open Graph tags that repeat them, `og:site_name`, and an `og:image` served by the site.
- The site header and footer are the same on every page; only the menu link to the page itself carries `aria-current="page"`.
- Element and attribute names are in lowercase, and no attribute appears twice. Attributes and `rel` values come from a short list in `bin/check`: nothing that would contact another site (`preconnect`, `ping`, `srcset`) or open a window (`target`).
- `sitemap.xml` lists every page but `404.html` by its canonical URL, without dates. `robots.txt` announces it and keeps the tooling (`bin/`, `examples/`, dotfiles, `README.md`, `LICENSE.md`) out of search results, never a page, the feed, the style, a font or an image.
- Files a browser could run when opened directly are checked too. An SVG file may only hold `svg`, `title`, `g`, `rect` and `path`, with attributes from a short list and values without a colon or a slash, so that none holds a URL; `logo.svg` is also pinned by its SHA-256, as fixrb/logo publishes it. `feed.xml` may only hold Atom elements, from a short list, linking to the site. A `CNAME` file contains `fixrb.dev`.
- Links inside the site start with `/` and lead to a file of the repository, and so does every `url()` of `style.css`, written as a path in double quotes, `url("/gems/NAME/img/FILE.svg")`, in a comment or not; `style.css` holds no `@import`, `image-set()`, `src()` or backslash, which could load a file another way. Stylesheets, images and fonts are served by the site. No file is a symbolic link.
- A code block shows a file of `examples/`, character for character: `<pre data-example="examples/gem/name.rb"><code>…</code></pre>`, with `<` and `&` escaped. To add or change one, edit the file, write `<pre data-example="…"><code></code></pre>` the first time, and run `bin/check --fix`. Examples end their lines with LF. A line that ends with `# => VALUE` must evaluate to an object whose `inspect` is `VALUE`. A manifest of brutal, `NAME_brutal.yaml`, is shown without highlighting, and the test file next to it, `test_NAME.rb`, is the one brutal writes from it.
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

Runs the examples, each in its own Ruby process, with the gems found on the load path, and prints the file each `require` loaded, so that the version under test is visible. A manifest of brutal is checked with `brutal --check`: `RUBYLIB=../brutal/lib:../aw/lib bin/examples examples/brutal`. Before a release of a gem, run its examples against the code to be released.

It then runs the terminal sessions of the pages that run one of these examples, in their directory, and compares what the command writes, standard output and error together, with the `<samp>` of the page, character for character. `fix` is run with the fix-command found on the load path. An example a session runs is checked by it, whatever its status, so that a page can show a specification that is not met; it is run on its own as well when it has `# =>` lines. The output is the one of the Ruby in `.ruby-version`: messages of Ruby, such as `undefined method 'peek'`, change from one version to another.

`bin/examples` runs the code of the examples, and `bin/check --fix` copies it into pages: run neither on a branch you have not read.

## Markup

The stylesheet relies on this structure, which every page follows.

- `body > header`: a link to `/` with the logo, 48 × 48 (3 screen pixels per pixel), and the site name, then `nav[aria-label="Main"] > ul`. `body > footer`: a paragraph, then a list of links. `main` in between.
- Home: `section#fix` (an `hgroup` whose first `p` is the eyebrow, a paragraph whose three `strong` are MUST, SHOULD and MAY, in this order, a `ul` with the link to the page of Fix, a `dl` of facts, and a `figure` with the example: from 62rem, the figure takes a second column), then `section#why` (a `ul` of three `li > h3 + p`, in a row from 56rem, each with its pictogram by its position: a document, the levels, the processes), then `section#gems` holding `section#extensions` (the gems around Fix), `section#libraries` (building blocks that do not depend on it) and `section#tools` (commands to run as they are). A gem card is `li > h4`, holding the gem's icon, if it has one, then `> a`; a `p`; and a status in `p > small`.
- Gem pages: `main > article`, whose `header` holds the gem's drawing, `img`, if it has one, then the `hgroup`. An illustration, if any, is a `figure` right after the first paragraph. The facts, a `dl`, come right after the first paragraph or after the illustration. A page with a design of its own is found by its drawing: `jester.svg` for matchi, `hero.svg` for aw, `scene.png` for brutal, `/logo.svg` in the `header` of the article for Fix, `movement.svg` for spectus, `letter.svg` for defi, `processes.svg` for fix-command, `loupe.svg` for fix-its, `pieces.svg` for matchi-fix. Its rules then read:
  - matchi: the ten matchers, `h2#matchers + dl`, in the order of their emblems (Be, Eq, BeAKindOf, BeAnInstanceOf, BeWithin, Match, Satisfy, Predicate, RaiseException, Change), five to a row from 62rem; `h2#expected-value`, which wears a crown; `h2#documentation + ul`.
  - aw: the `figure` and the `header`, shown in this order above the rest of the article, wherever they are in its markup; `h2#limits + ul`, `h2#documentation + ul`.
  - brutal: a manifest is a file whose name ends with `.yaml`; `h2#command`, which wears an axe; `h2#limits + ul`, `h2#documentation + ul`.
  - Fix: the three `strong` of the first paragraph, MUST, SHOULD and MAY, in this order; the table of outcomes, its rows MUST, SHOULD and MAY and its columns in the order of the README of fix, since the selectors carry the sign of each outcome.
  - spectus: as for Fix, the three `strong` of the first paragraph and the rows and columns of the table of outcomes; `h2#outcomes`, which wears a wheel, and `h2#results`, a crystal of frost; `h2#documentation + ul`. The balance of the movement is the background of its `img`, at offsets that follow the drawing: they change with it.
  - defi: `h2#exceptions`, which wears the arrow of a reply; `h2#documentation + ul`, the letter.
  - fix-command: `h2#random`, which wears a die showing the seed of the session under it, 2 (change them together), and `h2#status`, a lamp; `h2#documentation + ul`, a menu on the screen; its sessions, `pre[data-directory]`, are the same screen as its header.
  - fix-its: `h2#usage`, which wears the loupe; `h2#documentation + ul`, a tray of four stones, in this order: a round brilliant, an emerald cut, a pear and a marquise, one per item.
  - matchi-fix: `h2#usage`, which wears the two pieces that fit; `h2#documentation + ul`, four pieces that fit, ruby and blue like a checkerboard, each but the last with a knob into a neighbour.
- Guides, `gems/NAME/vN/` (the guide of Fix 1 is `gems/fix/v1/`): `main > article`, then `nav[aria-label="Guide"]`, which holds a `p > a` to the first page of the guide, its `index.html`, and an `ol` of its pages, a page not yet written being named without a link. That nav is the same on every page of the guide, but for the `aria-current` of the page's own link. The `hgroup` of the article starts with an eyebrow, `p > a` to the guide, and the article ends with `nav[aria-label="Pages"] > ul`, the links `rel="prev"` and `rel="next"` to the pages around it in the order of the guide; `bin/check` keeps both navs in order. From 62rem, the nav of the guide takes a column on the left, and stays in view.
- Lists of posts: `ul > li > article`, with a title `h2 > a` or `h3 > a`, a date `p > time`, and a description `p`.
- Posts: `article > header` (the `h1`, then `p` with the date and author), `p[role="note"]` for a note, `article > footer`. The design of the blog finds the list of posts by its structure, `main:has(> ul > li > article)`, and a post by the date in its header, `main > article:has(> header > p > time)`; from 34rem, the first letter of the first paragraph of the text, after the note and a title if there are, is set as an initial.
- The 404: `main` holds the `h1`, a `p` and a `ul` of links, one of them to `/`; the design of the 404 finds it by that structure, `main:has(> h1 + p + ul > li > a[href="/"])`, and shows its ring, the empty setting, at 4 screen pixels per pixel, 6 from 62rem.
- Pixelify Sans sets `h1`, the `h2` of sections and posts, the site name, menus, gem names and short labels (eyebrows, buttons, the numbers of the guide's stations) and the initial of a post only, at multiples of 11px and its regular weight: at small sizes its C reads as an O. Titles in lists of posts, `h3`, dates and running text use the system font.
- The drawings of the design are SVG files of `img/` (shared by several pages) and `gems/NAME/img/`, loaded by `style.css`. They follow the rules of SVG files above, and are drawn on a grid: one unit of their `viewBox` per pixel, shown at 4 screen pixels per pixel, or 2 for icons and small signs.

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

## Adding a gem

Give it a card on `index.html`: in `section#fix` if it extends Fix, in `section#tools` if it is a command to run rather than a library to build on, in `section#libraries` otherwise, right after the gem it extends, if any. Its description says which gems of the project it is built on, and its status which version is released or being prepared. Its `icon.svg` goes in the card's `h4`, before the name, at a whole number of screen pixels per pixel of the icon: 64 × 64 for a 32 × 32 icon, two per pixel, and 62 × 64 for matchi's; aw's, 104 pixels wide, at 64 × 64, smoothed. A gem without a page of its own, such as test_tube, still has its icon in `gems/NAME/img/`.

## Adding a gem page

Write `gems/NAME/index.html` from `gems/matchi/index.html`: what the gem does, how to install it, examples from `examples/NAME/`, the version the page documents, and links to its README, API reference and source at that version. Link it from the gem's card on `index.html`, and add it to `sitemap.xml`.

A gem may have its own drawing, illustration and icons, in `gems/NAME/img/`, which `bin/check` requires a page or `style.css` to use:

- A pixel drawing, shown in the header with `alt=""`, its `width` and `height` set to a whole number of screen pixels per pixel of the drawing: 4 for the jester of matchi, and for the movement of spectus, the letter of defi, the processes of fix-command, the loupe of fix-its and the pieces of matchi-fix, which `style.css` sets to 6 from 62rem (from 72rem for fix-command, fix-its and matchi-fix; for spectus, the movement and its balance alike); 2 for the hero of aw, whose pixels are finer. At 288 pixels wide at most, it keeps that size on a 320-pixel screen. Its pixels fall on whole units of its `viewBox`, which keeps every pixel whole on screen. Letters, if any, are set in Pixelify Sans, at its regular weight: its strokes are one pixel wide, where the bold of the titles is wider than a pixel.
- An illustration, if any, with an `alt` that says what it shows, and a `figcaption`. It may be a PNG, shown at half its width and height: a screen with 2 physical pixels per screen pixel then shows the file pixel for pixel, and `style.css` draws it with `image-rendering: pixelated`, which keeps it sharp at any other scale, at the cost of pixels one physical pixel wider than others. The scene of aw, 1206 × 726 and drawn at 3 pixels per pixel, is the screen of its page: 402 × 242 on a phone (cropped at the sides below 402px), 603 × 363 from 40rem and 804 × 484 from 56rem; the scene of brutal, 1280 × 960 at 4 pixels per pixel, is shown at 320 × 240 on a phone and 640 × 480 from 44rem.
- `favicon.ico`, `icon.svg` and `apple-touch-icon.png`, which replace the site's three icons in the page's head; without them, the page uses the site's icons. The Apple icon is opaque, since iOS fills transparency with black, and keeps a margin for the rounded corners. For matchi, whose icon is 31 × 32 pixels drawn 8 times larger, it was exported with Inkscape at 4 screen pixels per pixel:

  ```sh
  LC_ALL=C inkscape gems/matchi/img/icon.svg \
    --export-area=-56:-48:304:312 --export-width=180 --export-height=180 \
    --export-background='#fffef8' --export-background-opacity=1 \
    --export-filename=gems/matchi/img/apple-touch-icon.png
  ```

  `--export-area` is in document pixels, not in units of the `viewBox`.

  The icon of aw, 104 × 104 pixels, fits in 180 only at one pixel per pixel: its Apple icon has that scale, with a margin of 38. Its `favicon.ico` holds images of 48, 32 and 16 pixels, each pixel the exact average of the pixels of the icon it covers. Both were written from `icon.svg` by a Python script, with the standard library only. `icon.svg` leaves out `shape-rendering="crispEdges"`, which at 32 screen pixels would keep about one row and one column in three; `hero.svg`, shown at 2 screen pixels per pixel, keeps it.

  The icon of brutal is the lumberjack's face, 22 × 26 pixels cut out of the scene as they are, centered on a grid of 32 × 32: `icon.svg` has one unit of its `viewBox` per pixel, so that it is exact at 32 and 64 screen pixels; `favicon.ico` holds that image at 32 pixels, and at 16, each pixel the exact average of the four it covers; the Apple icon shows it at 6 pixels per pixel, with margins of 24 and 12. All three were written by a Python script, with the standard library only.

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
- The scene and the hero of aw (`gems/aw/img/`): `scene.png` is `img/aw.png`, the pixel-art illustration of aw's README, as it is; the hero comes from the same source, redrawn as SVG on a grid of 104 × 104 pixels, one unit of its `viewBox` per pixel. Both are under the MIT License like the rest of the site.
- The scene and the icons of brutal (`gems/brutal/img/`): `scene.png` is `img/brutal-driven-development.png`, the pixel-art illustration of brutal's README, 320 × 240 pixels drawn at 4 pixels per pixel, written again as a paletted PNG holding the image only (`IHDR`, `PLTE`, `IDAT`, `IEND`), pixel for pixel the same, and shown at 640 × 480; the icons are the lumberjack's face, cut out of it. Under the MIT License like the rest of the site.
- [Pixelify Sans](https://github.com/eifetx/Pixelify-Sans) by Stefie Justprince, under the SIL Open Font License 1.1 (`fonts/OFL.txt`). `fonts/pixelify-sans.woff2` is a subset of `PixelifySans[wght].ttf` from [google/fonts](https://github.com/google/fonts/tree/main/ofl/pixelifysans) (SHA-256 `9ba86cd010a4de309d263ceff8e8044092c9db7efda869620cb9ff1c4389e8a5`), made with:

  ```sh
  pyftsubset "PixelifySans[wght].ttf" \
    --unicodes="U+0020-007E,U+00A0-00FF,U+2013-2014,U+2018-201A,U+201C-201E,U+2022,U+2026,U+2039-203A" \
    --layout-features=kern --flavor=woff2 --output-file=fonts/pixelify-sans.woff2
  ```

  Only kerning is kept: the font's `fi` ligature looks like an `A` at small sizes.
- The drawings of the site's design (`img/`, the icons of the gems that had none, and the decors of `gems/matchi/img/`, `gems/aw/img/`, `gems/brutal/img/`, `gems/fix/img/`, `gems/spectus/img/`, `gems/defi/img/`, `gems/fix-command/img/`, `gems/fix-its/img/` and `gems/matchi-fix/img/`, but for the drawings credited above): drawn with Claude, Anthropic's AI model, for this site in November 2026, under the MIT License like the rest of the site. The scene of brutal and the hero of aw lend them their colours.
