From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/35] perf test shell: Fix check open filename arg using 'perf trace'
Date: Thu, 28 Dec 2017 11:30:20 -0300
Message-ID: <20171228143027.30547-29-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753394AbdL1Oc3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Dec 2017 09:32:29 -0500
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Michael Petlan <mpetlan@redhat.com>

Commit f231af789b11 ("perf test shell: Fix check open filename arg using
'perf trace' on s390x") added an exception for s390x to use openat()
instead of open() in the test that intercepts a open syscall to look for
the filename argument as obtained by the vfs_getname 'perf probe' it
puts in place at the getname_flags kernel function.

Its not just s390x that uses openat() instead of open(), so use 'perf
list' to look for the syscall:sys_enter_open(at)? present in the system
being tested instead of checking if the system is s390x.

In fact Namhyung pointed out that glibc 2.26 changed this behaviour, as
described in https://lwn.net/Articles/738694/, so systems where glibc is
>= 2.26 will need this patch for this test to work, which already took
place in some distros for architectures such as s390x, while Fedora 26
x86_64 is at glibc 2.25, i.e. still uses open().

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/ab23fe42-1080-a46b-503e-744e097f414f@linux.vnet.ibm.com
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
LPU-Reference: 1275675985.12835754.1513095723265.JavaMail.zimbra@redhat.com
Link: https://lkml.kernel.org/n/tip-j2wbz9av1rw3thr3t0g4dtuk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/trace+probe_vfs_getname.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 2a9ef080efd0..55ad9793d544 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -17,10 +17,9 @@ skip_if_no_perf_probe || exit 2
 file=$(mktemp /tmp/temporary_file.XXXXX)
 
 trace_open_vfs_getname() {
-	test "$(uname -m)" = s390x && { svc="openat"; txt="dfd: +CWD, +"; }
-
-	perf trace -e ${svc:-open} touch $file 2>&1 | \
-	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ ${svc:-open}\(${txt}filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
+	evts=$(echo $(perf list syscalls:sys_enter_open* |& egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
+	perf trace -e $evts touch $file 2>&1 | \
+	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
 }
 
 
-- 
2.13.6
