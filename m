From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Fix test trace+probe_vfs_getname.sh
Date: Mon, 20 Jan 2020 14:20:11 +0100
Message-ID: <20200120132011.64698-3-tmricht@linux.ibm.com>
References: <20200120132011.64698-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120132011.64698-1-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

This test places a kprobe to function getname_flags() in the kernel
which has the following prototype:

  struct filename *
  getname_flags(const char __user *filename, int flags, int *empty)

Variable filename points to a filename located in user space memory.
Looking at
commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
the kprobe should indicate that user space memory is accessed.

Fix this with a patch to specify user space memory access to
parameter 'filename' and 'string' is replaced by 'ustring'.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 7cb99b433888..7ecf117651dd 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,8 +13,8 @@ add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
-		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
+		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
 	fi
 }
 
-- 
2.21.0
