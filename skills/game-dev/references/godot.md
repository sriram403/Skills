# Godot 4 notes (from a 3-week co-op game build)

Load when working in Godot. Each line: the trap, then what to do.

## Running and testing

- **A parse error hangs the game** on its failed load. Run tests under a timeout and kill stray
  processes afterwards (`taskkill //F //IM "Godot*"`). Compile first so a typo stops the run in ~5 s:
  `godot --headless --check-only --script res://scripts/<file>.gd`.
- **Headless:** `frame_post_draw` never fires (screenshots return early), viewport textures are null,
  MultiMesh transforms read back as zero. Without `--fixed-fps` a slow CPU runs physics behind
  real-time waits and timing checks fail at random. With `--fixed-fps 60` game time runs faster than
  real time: measure in physics frames.
- **New `class_name` scripts:** Godot only learns them on an import. A launcher that doesn't import
  first greys out after a merge; import (or start once in the editor) after merging.
- **Class names must not clash with Godot's** (`class_name Noise` hid Godot's `Noise`, every user
  failed to parse).
- **Movie Maker** records a run: `--write-movie x.avi --fixed-fps 25` (before the `--`), then ffmpeg to
  mp4. It runs at 68–87% of real time (Godot prints the real speed); leave deadlines slack.
- **Never edit scripts while a test run is going:** later segments load the files fresh.
- **Keep user data off C:** `user://` is under `%APPDATA%`; set `APPDATA`/`LOCALAPPDATA` in the launch
  scripts if the user wants everything inside the project. `custom_user_dir_name` alone doesn't move it.
- The editor rewrites `project.godot` (drops comments/defaults) when opened: that's fine.

## GDScript

- Can't infer types from Variant sources (`var x := dict["k"]`, `get_node`, ternaries with an untyped
  side, untyped members): give explicit types, or the whole script fails to parse.
- **A freed object compares equal to null** in Godot 4: `x != null and not is_instance_valid(x)` never
  fires. Keep a flag that there was a target. A freed object fails a typed argument: take it untyped.
- Timers that outlive a node: a tween owned by the node, not `create_timer().connect(lambda)`.
- Overlays on their own `CanvasLayer`; full-screen controls need `set_anchors_and_offsets_preset`.

## Physics and 3D

- **Input:** poll in `_physics_process`; latch quick taps from events. Per-render-frame polling lost
  taps at 144 Hz. Test helpers that re-send a held key every tick read as 60 taps a second.
- **Physics interpolation:** cameras in `_process` from `get_global_transform_interpolated()`; call
  `reset_physics_interpolation()` after every teleport, on the object *and every child*, and wake it.
- **Never reparent seated players into a vehicle** (it launched the van at 19 000 km/h); snap them to
  seat markers each tick with collision off.
- **VehicleBody3D:** positive `engine_force` pushes toward +Z; steering positive-left. A vehicle
  dropped on a slope needs ~2 s to settle on its springs.
- **`global_transform` before the node is in the tree is garbage:** use `transform` while building.
- **A ray that starts inside a collider doesn't hit it.** Keep colliders upright round tilted visuals.
- **Invisible walls block rays too:** put body-only walls on their own layer that rays skip.
- **CharacterBody:** keep the intended horizontal velocity, not the post-collision one, or you can't
  jump onto something you're touching.
- **Contact callbacks report the speed after the bounce.**
- **`Label3D` text faces +Z; `looking_at` points −Z at the target** (signs faced away). With
  `fixed_size`, `pixel_size` is screen size (0.0006 at font 48 ≈ 17 px).
- **SpotLight shines along −Z**: check every new light in a dark shot.
- **Every SubViewport camera re-renders the world** incl. shadow cascades: 3 mirrors every frame took
  144 fps to 58; take turns / every other frame.
- **Build-time:** thousands of shapes added to one body then moved is O(n²); create per-tile bodies.
- **Terrain on a grid:** anything narrower than a grid step needs the terrain lowered a step either
  side; triangle winding decides which way normals face (wrong order = lit from below).
- **Interactables:** a single convention (metas like `prompt`, `callback`) and a lookup that walks up
  to it; the nearer of a person and an object wins the look ray.
- Audio can't be heard by the model: verify by state (playing, gain, pitch) and ask for the user's ears.
- Long runs on NVIDIA can crash in `nvoglv64.dll` now and then: resume rather than chase it first.
