package com.zyn.crm.util;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class JsonResult {
    private boolean success = true;
    private String msg;

    public void mark(String msg) {
        this.success = false;
        this.msg = msg;
    }

}
