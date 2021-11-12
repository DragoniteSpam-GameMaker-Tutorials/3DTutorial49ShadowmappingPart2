function scr_draw_all_the_stuff() {
    gpu_set_tex_repeat(true);
    
    // Everything must be drawn after the 3D projection has been set
    vertex_submit(ground, pr_trianglelist, sprite_get_texture(spr_grass, 0));
    
    gpu_set_tex_repeat(false);
    
    matrix_set(matrix_world, matrix_build(250, 250, 40, 0, 0, 0, 1, 1, 1));
    vertex_submit(vb_merry, pr_trianglelist, -1);
    
    matrix_set(matrix_world, matrix_build(250, 300, 0, 0, 0, 0, 1, 1, 1));
    vertex_submit(vb_sphere, pr_trianglelist, -1);
    matrix_set(matrix_world, matrix_build(250, 350, 0, 0, 0, 0, 1, 1, 1));
    vertex_submit(vb_sphere, pr_trianglelist, -1);
    matrix_set(matrix_world, matrix_build(250, 400, 0, 0, 0, 0, 1, 1, 1));
    vertex_submit(vb_sphere, pr_trianglelist, -1);
    
    for (var i = 0, n = array_length(tree_positions); i < n; i++) {
        matrix_set(matrix_world, matrix_build(tree_positions[i].x, tree_positions[i].y, 0, 0, 0, 0, 1, 1, 1));
        vertex_submit(tree_positions[i].vbuff, pr_trianglelist, -1);
    }
    
    // the "sun"
    matrix_set(matrix_world, matrix_build(sun_x, sun_y, sun_z, 0, 0, 0, 1, 1, 1));
    vertex_submit(vb_sphere, pr_trianglelist, -1);
    
    // the "player"
    matrix_set(matrix_world, matrix_build(Player.x, Player.y, Player.z, 0, 0, 0, 1, 1, 1));
    vertex_submit(vb_trees[0], pr_trianglelist, -1);
    
    matrix_set(matrix_world, matrix_build_identity());
    
    shader_reset();
}