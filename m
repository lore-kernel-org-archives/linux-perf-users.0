From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 58/83] perf test shell: Fix check open filename arg using 'perf trace' on s390x
Date: Fri, 17 Nov 2017 17:15:36 -0300
Message-ID: <20171117201601.24110-59-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

This 'perf test' case fails on s390x. The 'touch' command on s390x uses
the 'openat' system call to open the file named on the command line:

[root@s35lp76 perf]# perf probe -l
  probe:vfs_getname    (on getname_flags:72@fs/namei.c with pathname)
[root@s35lp76 perf]# perf trace -e open touch /tmp/abc
     0.400 ( 0.015 ms): touch/27542 open(filename:
		/usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
[root@s35lp76 perf]#

There is no 'open' system call for file '/tmp/abc'. Instead the 'openat'
system call is used:

[root@s35lp76 perf]# strace touch /tmp/abc
    execve("/usr/bin/touch", ["touch", "/tmp/abc"], 0x3ffd547ec98
			/* 30 vars */) = 0
    [...]
    openat(AT_FDCWD, "/tmp/abc", O_WRONLY|O_CREAT|O_NOCTTY|O_NONBLOCK, 0666) = 3
    [...]

On s390x the 'egrep' command does not find a matching pattern and
returns an error.

Fix this for s390x create a platform dependent command line to enable
the 'perf probe' call to listen to the 'openat' system call and get the
expected output.

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
LPU-Reference: 20171114071847.2381-1-tmricht@linux.vnet.ibm.com
Link: http://lkml.kernel.org/n/tip-3qf38jk0prz54rhmhyu871my@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.13.6
