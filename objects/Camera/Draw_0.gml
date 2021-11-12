/// @description Draw the 3D world

draw_clear(c_black);

// 3D projections require a view and projection matrix
var camera = camera_get_active();
var camera_distance = 160;

#region shadowmap surface
var xfrom = sun_x;
var yfrom = sun_y;
var zfrom = sun_z;
var xto = sun_x + sun_dx;
var yto = sun_y + sun_dy;
var zto = sun_z + sun_dz;

shader_set(shd_depth);
surface_set_target(shadowmap_surface);

draw_clear(c_black);

// You need to do this AFTER setting the surface target,
// otherwise the camera will be in the wrong place
view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
proj_mat = matrix_build_projection_ortho(shadowmap_size, -shadowmap_size, znear, zfar);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

scr_draw_all_the_stuff();

surface_reset_target();
#endregion

#region the actual 3D scene
shader_set(shd_basic_3d_stuff);
shader_set_uniform_f(shader_get_uniform(shd_basic_3d_stuff, "lightDirection"), sun_dx, sun_dy, sun_dz);
var xfrom = Player.x;
var yfrom = Player.y;
var zfrom = Player.z + 64;
var xto = xfrom - camera_distance * dcos(Player.look_dir) * dcos(Player.look_pitch);
var yto = yfrom + camera_distance * dsin(Player.look_dir) * dcos(Player.look_pitch);
var zto = zfrom + camera_distance * dsin(Player.look_pitch);

// You need to do this AFTER setting the surface target,
// otherwise the camera will be in the wrong place
view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), znear, zfar);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

scr_draw_all_the_stuff();

shader_reset();
#endregion