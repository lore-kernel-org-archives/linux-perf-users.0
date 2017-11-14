From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf test fix check open filename arg using perf trace on s390x
Date: Tue, 14 Nov 2017 08:18:46 +0100
Message-ID: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752510AbdKNHSz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 02:18:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAE7EPWp101873
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 02:18:54 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e7uwv0642-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 02:18:53 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Tue, 14 Nov 2017 07:18:51 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, linux-perf-users@vger.kernel.org
Cc: brueckner@linux.vnet.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

This perf test case fails on s390x. The touch command on s390x uses
the openat system call to open the file named on the command line:

[root@s35lp76 perf]# ./perf probe -l
  probe:vfs_getname    (on getname_flags:72@fs/namei.c with pathname)
[root@s35lp76 perf]# ./perf trace -e open touch /tmp/abc
     0.400 ( 0.015 ms): touch/27542 open(filename:
		/usr/lib/locale/locale-archive, flags: CLOEXEC         ) = 3
[root@s35lp76 perf]#

There is no open system call for file /tmp/abc. Instead openat
system call is used:

[root@s35lp76 perf]# strace touch /tmp/abc
    execve("/usr/bin/touch", ["touch", "/tmp/abc"], 0x3ffd547ec98
			/* 30 vars */) = 0
    [...]
    openat(AT_FDCWD, "/tmp/abc", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666) = 3
    [...]

On s390x the egrep command does not find a matching pattern and returns
an error.

Fix this for the s390x platform and create a platform dependend command
line to enable the perf probe to listen to openat system call on s390x
and get the correct perf trace output.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 2e68c5f120da..2a9ef080efd0 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,8 +17,10 @@ skip_if_no_perf_probe || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	perf trace -e open touch $file 2>&1 | \
-	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open\(filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
+
+	perf trace -e ${svc:-open} touch $file 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
-- 
2.13.4
