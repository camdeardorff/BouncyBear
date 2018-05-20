//
//  Gradient.fsh
//  BouncyBear
//
//  Created by Cameron Deardorff on 5/19/18.
//  Copyright © 2018 Cameron Deardorff. All rights reserved.
//

void main() {
    vec4 color = texture2D(u_texture, v_tex_coord);
    gl_FragColor = color * vec4(mix(bottomColor, topColor, v_tex_coord.y));
}
