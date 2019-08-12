package net.wanho.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Created by Administrator on 2019/8/1/001.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Role {
    private Integer roleid;
    private String rolename;
    private Integer statuc;

}
