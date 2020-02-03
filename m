From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Fix test trace+probe_vfs_getname.sh
Date: Mon,  3 Feb 2020 13:48:56 +0100
Message-ID: <20200203124856.53492-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
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

So I suggest the following patch to specify user space memory access.
Try type 'ustring' first and use type 'string' in case 'ustring'
is not supported.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 7cb99b433888..30c1eadbc5be 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -13,7 +13,9 @@ add_probe_vfs_getname() {
 	local verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
-		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
+		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:ustring" || \
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || \
+		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->uptr:string" || \
 		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
 	fi
 }
-- 
2.21.0
