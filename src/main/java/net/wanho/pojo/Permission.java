package net.wanho.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Created by Administrator on 2019/8/5/005.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Permission {
    private Integer permissionid;
    private String permissionname;
    private String url;
    private Integer paramid;

}
