# Gathering material from the web (images, video frames, downloads)

Techniques that worked on this machine (Windows, the agent's built-in browser pane, bash/curl).
Everything is free; nothing bypasses a site's protections.

## Downloads

- Downloads go in their **own folder inside the project** (`downloads/`, `refs/`), never next to
  scripts and never outside the project. Use **absolute `-o` paths** with curl.
- `cd X && curl a & curl b & wait`: the `cd` applies **only to the first** backgrounded command; the
  others write to the old folder. Use absolute paths or a subshell `( cd X && ... )`.
- A download sending zero bytes for minutes means a dead mirror. Check first with
  `curl -I --max-time 20 <url>` before waiting. Try another mirror.
- Some hosts return an HTML error page with a 200: check with `file *` and delete non-images.
- Verify installers against a published hash (SHA-256) when one exists; keep the installer for
  reinstalls.
- Sites behind Cloudflare "Just a moment..." checks: don't try to get past them. Find the same image
  elsewhere (Google Images usually has the original).

## Google Images: full-size originals

- With the browser pane wide (about 1500×950), clicking a thumbnail opens a side panel whose `<img>`
  holds the **full-size source URL**.
- A JS loop that clicks thumbnails and collects `img.src` values that aren't `encrypted-tbn` /
  `gstatic` lists the originals; then curl them.

## YouTube: frames, not videos

Don't download videos (YouTube ToS). Grab frames on the watch page instead:
1. **Mute immediately** (the user hears it):
   `document.querySelectorAll('video,audio').forEach(m=>{m.muted=true;m.volume=0})` plus
   `movie_player.mute()`. Ads use the same element, so they're muted too. Re-mute after every
   navigation: autoplay jumps to another, unmuted, video at the end.
2. Max quality: `movie_player.setPlaybackQualityRange('hd2160','hd2160')` gives real 4K frames.
   4K seeks can hang: survey at 720p, switch to 4K only for the frames you keep.
3. Seek with `video.currentTime`, wait for `seeked` (give each seek a ~3 s timeout), then draw the
   frame (or a crop) onto a full-viewport `<canvas>` overlay; YouTube's MSE video doesn't taint it.
4. **Survey first:** draw a mosaic of frames every N seconds, screenshot it, pick timestamps. Keep
   each JS call under ~40 s; run long loops async and poll a `window.__done` flag.
5. Pane screenshots **lag one frame**: after drawing, wait 1 s, then screenshot. The screenshot is
   ~800×506, so crop to the subject first.
- Dead ends: POSTing frames to a localhost receiver (blocked by YouTube's CSP); `window.open` in the
  built-in browser (replaces the tab).

## Browser hygiene

- **Mute all audio and video on any page at once.** The built-in browser can't install ad blockers.
- Pause videos you aren't using; don't leave autoplay running.

## What makes a good reference (visual work)

- Official sheets and in-engine viewers, matched render sets of one model, professional reviews.
- Reject other versions, ages, real people (for a fictional character) and fan models, or mark them.
- Telephoto (≈85–150 mm) shots are the most reliable for proportions; wide angles distort.
- Raking light shows forms; flat light only colour. Note expressions (they aren't the neutral shape).
- Cover every angle: front, both 3/4, both profiles, high, low, back 3/4.
