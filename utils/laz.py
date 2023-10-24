import laspy
import numpy as np
import open3d as o3d


# Define a colormap for labels
def label_to_color(label):
    # Define your colormap here
    colormap = [
        # [0, 0, 0],     # Label 0 (background) as black
        [255, 0, 0],   # Label 1 as red
        [0, 255, 0],   # Label 2 as green
        [0, 0, 255],   # Label 3 as blue
        # [255, 0, 255],
        # [255, 255, 0],
        # [0, 255, 255],
        # [0, 128, 255],
        # [255, 128, 0],
        # [0, 255, 128],
        # [0, 128, 0],
        [0, 0, 128],
        [128, 0, 0],
        [128, 128, 0],
        [128, 0, 128],
        [128, 128, 0],
        # Add more colors for additional labels as needed
    ]
    if label < len(colormap):
        return colormap[label]
    else:
        return [255, 255, 255]  # Default to white for unknown labels



def o3d_viz(cloud, annotated=False):
    points = np.vstack((cloud.x, cloud.y, cloud.z)).T

    # Create an Open3D PointCloud object with colors
    pcd = o3d.geometry.PointCloud()
    pcd.points = o3d.utility.Vector3dVector(points)
    if annotated:
        # labels = cloud.label
        # print(np.unique(labels))
        labels = cloud.classification
        print(np.unique(cloud.classification))
        colors = np.array([label_to_color(label) for label in labels])  # Map labels to colors
        pcd.colors = o3d.utility.Vector3dVector(colors / 255.0)  # Normalize colors to [0, 1]

    # Visualize the merged point cloud with colors
    # o3d.visualization.draw_geometries([pcd])
    o3d.visualization.draw_plotly([pcd])

if __name__ == '__main__':
    # Load all the .las file
    ls = ['A','B','C','D','E']
    input_file_ls = [f'../../Data/Orchard/Orchard_0913_labelled_{i}.laz' for i in ls]
    for input_file in input_file_ls:
        point_cloud = laspy.read(input_file)
        print(point_cloud.x)
        #print(np.unique(point_cloud.segment_id))

        # lists column names in las file.
        point_format = point_cloud.point_format
        print(list(point_format.dimension_names))

        for each in list(point_format.dimension_names):
            print(each, np.min(point_cloud[each]), np.mean(point_cloud[each]), np.max(point_cloud[each]))

        # vis_open3d
        # o3d_viz(point_cloud, annotated=False)
        o3d_viz(point_cloud, annotated=True)
    