function D = distance_to_line(x0, y0, z0, phi, theta, x1, y1, z1)
    
    % 计算方向向量 d
    dx = cos(phi) * sin(theta);
    dy = sin(phi) * sin(theta);
    dz = cos(theta);
    
    % 计算向量 v (从 P0 到 P1)
    v = [x1 - x0, y1 - y0, z1 - z0];
    
    % 计算 v 和 d 的叉乘，得到向量 n
    n = cross(v, [dx, dy, dz]);
    
    % 计算距离 D
    D = norm(n) / norm([dx, dy, dz]);
end