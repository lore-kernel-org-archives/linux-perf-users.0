From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: perf buildild-list -H dumps core
Date: Fri, 13 Oct 2017 09:33:55 +0200
Message-ID: <6ec683e8-f23e-0595-5674-d5ef20ae03f5@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750722AbdJMHeB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Oct 2017 03:34:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9D7Xcdv087915
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2017 03:34:00 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2djjjpycq3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Oct 2017 03:34:00 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Fri, 13 Oct 2017 08:33:58 +0100
Content-Language: en-IE
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Maybe this has been fixed already, but I hit a core dump when I do this:

[root@s35lp76 docker]# uname -a
Linux s35lp76 4.14.0-rc3tmr1+ #5 SMP Thu Oct 5 10:05:43 CEST 2017 s390x s390x s390x GNU/Linux
[root@s35lp76 docker]# ~/linux/tools/perf/perf buildid-list -i 333.perf.data 
15dd27179a5fe664c0778b7871989c101b1ac506 /lib/modules/4.14.0-rc3tmr1+/build/vmlinux
4d16d00bd6ed5969f2ef3176d3e52801c85ed9d8 [vdso]
0a751d08365dbbca4ac4deb7ed2b8107d42bad80 /lib/libc.so.6
5c0a120336206d0483d3d8112207fbb54ba00a44 /bin/find
a70676b1cdcc5575e4c5e34a5b80746dca120f75 /bin/ls
[root@s35lp76 docker]# ~/linux/tools/perf/perf buildid-list -H -i 333.perf.data 
Segmentation fault (core dumped)

[root@s35lp76 docker]# 

Shouldn't I specify option -H ?

I have not tried this on Intel, maybe it is platform related?

Thanks for your help
-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
