import open3d as o3d


def visualize_ply(ply_file):
    # Read the PLY file
    cloud = o3d.io.read_point_cloud(ply_file)

    # Create a visualization window
    vis = o3d.visualization.Visualizer()
    vis.create_window()

    # Add the point cloud to the visualization
    vis.add_geometry(cloud)

    # Set the view control
    vis.get_render_option().point_size = 1
    vis.get_render_option().show_coordinate_frame = True
    vis.get_view_control().rotate(0.0, -45.0)

    # Run the visualization
    vis.run()
    vis.destroy_window()


# Example usage
ply_file = "test/Light_KPFCNN/predictions/Area_5.ply"
# ply_file = '/Users/matiurrahmanminar/Documents/Minar/AlteredVerse/Research/data/av_buildings/11_AUSM/NHB_AUSM.ply'
# ply_file = "/Users/matiurrahmanminar/Documents/Minar/AlteredVerse/Research/Output/Takashimaya-pcd-Nerfacto/point_cloud.ply"
# ply_file = "../sunyatseng-pcd-mesh/sunyatseng-pcd-nerfacto/point_cloud.ply"
# ply_file = "../sunyatseng-pcd-mesh/sunyatseng-mesh-nerfacto/poisson_mesh.ply"
# ply_file = "../samples/YFKK_Right_Small_Lion_Statue.ply"
visualize_ply(ply_file)