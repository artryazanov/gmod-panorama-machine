Panorama Machine
Copyright (c) 2010 sk89q <http://www.sk89q.com>
Licensed under the GNU General Public License v2
http://github.com/sk89q/panomach

Introduction
------------

Panorama Machine allows you to generate cubic and rectilinear panorama projections,
as well as a set of images that can be stitched together to create a higher
resolution panorama.

There are three methods of operation:
- Change the user's view for every view that needs to be captured. This has problems
  with objects moving while the panorama is being captured.
- Render all the views to render targets instantly, and then change the user's view
  to each render target and then save a screenshot. The issue with this method is
  that anti-aliasing is disabled.
- Use the gm_image binary module to render all views instantly and write them to
  disk instantly. This requires that you install an additional module, but it is
  the recommended option.

There is also a video panorama generation feature that generates all views of
the cubic projection on the screen for capture.

Usage
-----

Panorama Machine can be used from the tool menu, under the "Utilities" tab.

It is highly recommended that you download and install gm_image, which allows
Panorama Machine to take screenshots by itself. You can enable or disable
use of gm_image (once installed) under the "Settings" panel. To install gm_image,
please see http://wiki.github.com/sk89q/panomach/installation

To use the render targets, you must rename the "render_targets_disabled" folder in
the "settings" folder of Panorama Machine to "render_targets". You must also
change the console variable "panomach_rt_count" to 6 and check the appropriate
checkbox under the "Settings" panel.

To turn on the video panorama display, use panomach_cubic_view in console
to toggle it. There is an alternative view that places the views slightly
differently -- toggle that using panomach_alt_cubic_view.