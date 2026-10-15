# Blender + Python notes

## This machine (check they still hold)

| Thing | Value (2026-10-15) |
|---|---|
| Blender | 5.2.2 LTS at `Z:/app/blender/blender.exe` (Python 3.13, numpy bundled) |
| GPU | RTX 3060, OptiX works; Cycles 96 samples at 900×1100 ≈ 10 s |
| MPFB2 | extension in repo `user_default`: `from bl_ext.user_default.mpfb.services.humanservice import HumanService` |
| MPFB data | `%APPDATA%/Blender Foundation/Blender/5.2/extensions/.user/user_default/mpfb/data` |
| Python for ML tools | a project venv: `py -3.11 -m venv tools/.venv`, pip with `--cache-dir tools/.pip-cache` (stays in the project) |

## Workflow

- **Everything from a build script**; renders to `<project>/renders/<stage>/`, refs to `refs/`.
- **Live view for the user:** a watcher script opens Blender and re-runs the build script on every save
  (`blender -P tools/live_watch.py -- <project>/<name>_build.py`). Keep it open; launch it detached if
  it isn't running. Inside the watcher, the script runs via `exec`: don't rely on `__file__`.
- Headless: `blender -b -P script.py -- args`. Units metres, character faces −Y, up +Z.
- Blender can call the ML venv: `subprocess.run([venv_python, "-I", script, ...])`.
- An extension installed while Blender is open isn't loaded in that session: restart.

## Scripting gotchas

- After setting `obj.location`/`rotation`, `matrix_world` is **stale** until
  `bpy.context.view_layer.update()` (ray casts fired from the old pose).
- Save generated images with `img.save_render(path)`; `filepath_raw` + `save()` silently did nothing.
- `bpy.data.images.load()` resolves relative paths against Blender's cwd: pass absolute paths.
- `image.pixels` are bottom-up: flip with `[::-1]`.
- `frame_change_post` handler: `scene.camera` may still be the previous camera; pick it from markers.
- Project points **before** `bpy.ops.render.render` if a handler changes resolution during the render.
- Render crops: scale resolution, then `use_border` + `use_crop_to_border`.
- Resolution set by one script can be reset by build handlers: set it right before each render.
- OpenCV → Blender camera: `R_b = R.T @ diag(1,-1,-1)`, location `-R.T @ t`; lens = f_px·36/max(W,H)
  with sensor_fit AUTO.
- Flat masks: emission white for the target, black for occluders, `film_transparent`, view transform
  Standard, 4 samples.
- Interior surfaces (mouth, nostrils) get dragged by warp fields: move teeth/tongue rigidly.

## MPFB / MakeHuman

- Build with `HumanService.deserialize_from_dict(info, settings)`; keys from
  `HumanService._create_default_human_info_dict()`; assets by basename (`"eyebrow001.mhclo"`).
- `age` macro: 0.1875 = 11 y, 0.5 = 25 y (linear); lowering age shrinks height: compensate.
- `eyebrows-angle-down` makes a frown; `-up` a calm/worried look.
- The `joint-mouth` group sits ~1 cm above the real lip line; find lips from the mid-face profile.
- Helper geometry (eye helpers, joint cubes) is hidden by a Mask modifier: exclude it from BVHs (keep
  triangles whose vertices are all in the `body` group).
- Skin is one node group; insert per-vertex tints after `Bright/Contrast → Base Color`.
- Default eye whites are too bright (staring look): ~(0.62, 0.56, 0.52). The eyeball object is named
  `<human>.high-poly` (filters on "eye" miss it).
- Once landmarks drive the shape, remove expression sliders that move the same features.

## Hair curves

- `bpy.data.hair_curves.new()`, `add_curves([n]*S)`, positions via
  `attributes["position"].data.foreach_set("vector", ...)`, plus a `radius` attribute;
  `ShaderNodeBsdfHairPrincipled` (melanin).
- Bristles/halo at the silhouette: start strands on a raised base layer (climb within the first ~10%);
  re-project noisy points to `radial(dir) + h`; keep flyaways ~1%.
- White rim: Coat 0, roughness ~0.5, radial roughness ~0.55, weak rim lights.
- Locks turn into a solid bob when many strands share a path: clump by root position, vary length
  (0.55–1.0), tighten to the clump centre near the tips.
- Root predicates must tile the whole hairline band (or bald gaps at the temples).
- A step/bare band between hair sections: start the lower section at the upper shell's height.
- In grey clay, thicken strands (×3) so the mass reads; judge strands only in beauty renders.
- Vectorise with a scalp-distance lookup grid (ray-cast once on a θ×φ grid).
- Brows/lashes as strands (ray-cast onto the skin along a measured curve) beat fixed cards.
- Freckles: Voronoi distance × cell colour × noise × a per-vertex density attribute
  (`ShaderNodeAttribute(attribute_type='GEOMETRY')`).
