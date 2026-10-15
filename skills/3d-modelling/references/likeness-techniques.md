# Likeness techniques that worked (and the traps)

Free tools: MediaPipe (landmarks, segmenters), OpenCV (PnP), numpy, Blender.

## Landmarks (MediaPipe Face Landmarker, 478 points)

- Works on game renders and photos up to ~45° yaw; **fails on true profiles (~90°) and backs**: use
  silhouette/profile curves there.
- Small faces in full-body shots: sliding square windows upscaled to 768 px.
- **Contour and cheek points are view-biased** (the same vertex drifts 5–7 px at 30–45°). Never compare
  a ref's oval landmarks to fixed vertices: render the model in the ref's camera and compare **detector
  with detector**. Offsets that agree across many refs are shape; one-offs are expression/pose noise.
- MediaPipe's own head yaw is about half the true yaw at 30–45°: use the PnP pose.
- Mapping landmarks to mesh: ray-cast from the render camera onto the skin; eyelid points' rays pass
  through the eye opening (cast against the eyes too, snap to the nearest lid skin); drop grazing hits.
- Check every picked landmark's depth: front picks near concavities (subnasale, inner eye corners,
  mouth corners) land on the wrong surface.

## Camera solve (PnP)

- OpenCV `SOLVEPNP_SQPNP` asserts on tiny point variance: object points in **mm**, not metres. Refine
  with `SOLVEPNP_ITERATIVE`; drop outliers above 3× the median.
- **Focal length is barely constrained by a face** (rms flat from ~50 to 400 mm): take the one nearest
  85 mm within 2% of the best rms, and record the range.

## Fitting shape

- **Exact Gaussian RBF** with close constraints is ill-conditioned (wild swings). **Weighted
  averaging** never overshoots but smooths sharp features away.
- **What works: per-axis damped RBF** `(K + λI) w = d`, σ ≈ 10 mm, λ ≈ 0.2 for sparse picks / 0.5 for
  ~470 dense landmarks, ~8–10 iterations, each axis solved only over the constraints that fix it.
  Store as a shape key; move proxies (eyes) rigidly with the field.
- Dynamic constraints for curves: each iteration, pin the widest/frontmost vertex at each height.
- **Multi-view triangulation:** per view, 2D target = proj(model point) + (ref detection − model-render
  detection); per-landmark Gauss-Newton over all views with a prior toward the model (3 mm).
  **Gauge: translation only** (a similarity fit on near-collinear eyes + bridge tilted the cloud and
  swung the chin 6 mm). **Depth from ±30–45° views is untrustworthy:** fit x/z, keep depth from the
  profile. Re-running passes accumulates bias (the prior restarts at the current shape).
- Mirror-symmetrise shifts; ref asymmetry is mostly expression and pose.
- **Converged ≠ likeness:** landmarks don't measure lips, lids, cheek volume or tip shape.

## Forms by eye with code brushes

- Brush = Gaussian falloff (σ = radius/2), 1–3.5 mm useful; push volumes along the centre normal
  computed from the **mixed** shape. A brush may take a centre offset to reach areas without landmarks.
- Lips touch: clip brushes by side of the lip slit. Mirrored brushes near the midline cancel their x
  moves: aim side brushes well off the midline.
- x-only "broaden" brushes make lumps seen from below: use normal pushes elongated along the form.
- **Gaussians can't remove a crease, they add bumps:** Taubin smoothing (λ 0.5 / μ −0.53, Gaussian-
  weighted region) softens creases without shrinking convex forms.
- Fast loop: render only ~6 key ref cameras in parallel with the profile compare (~45 s per change);
  the full sheet only at the gate.

## Hair silhouette by measurement

- Ref masks: MediaPipe `hair_segmenter.tflite` + `selfie_multiclass_256x256.tflite` (class 1 = hair);
  mean of both > 0.5 was clean on game renders. Masks come back (H, W, 1): squeeze.
- Model masks: flat emission render (hair white, everything else black). Alpha tells outer silhouette
  from hairline. Face-crop renders cut off the crown: crop ~2.3× the face box, shifted up.
- **Back-projected silhouette fit:** for each outer edge pixel, the signed distance to the ref mask edge
  along the normal → radial move via the per-camera px-per-unit Jacobian → average per 10° direction
  bin across refs → smooth on the sphere → gain 0.7 → accumulate. 4 loops beat 3 stalled parameter
  loops (IoU 0.56 → 0.68).
- Fade lift to 0 near the hairline; give lower hair the same volume where it starts (no shelf).
- **Masks can't see in front of / behind the ear or the interior flow:** judge those in side views and
  beauty renders.

## Measuring comparisons

- Aligned compare images (ref | model | 50/50 blend); measure outlines per row/column rather than
  reading the blend by eye. Skin-colour silhouettes fail on shadowed edges and light hair.
- Turn impressions into ratios (feature width / IPD, ref vs model, same camera) before reshaping.
- A contact sheet of every ref next to the model in its camera is the recognition gate; zoomed A/Bs
  for each change.
