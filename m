From: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf record: Remove unnecessary warning for missing sysfs entry
Date: Thu, 12 Apr 2018 13:47:23 +0200
Message-ID: <20180412114723.48550-1-tmricht@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Using perf on 4.16.0 kernel on s390 shows warning
   failed: can't open node sysfs data
each time I run command perf record ... for example:

[root@s35lp76 perf]# ./perf record -e rB0000 -- sleep 1
[ perf record: Woken up 1 times to write data ]
failed: can't open node sysfs data
[ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
[root@s35lp76 perf]#

BTW: I find this error message not very informative.

It turns out commit e2091cedd51bf ("perf tools: Add MEM_TOPOLOGY
feature to perf data file") tries to open directory named
/sys/devices/system/node/ which does not exist on s390.

This is the call stack:
 __cmd_record
 +---> perf_session__write_header
       +---> perf_header__adds_write
             +---> do_write_feat
	           +---> write_mem_topology
		         +---> build_mem_topology
			       prints warning
The issue starts in do_write_feat() which unconditionally
loops over all features and now includes HEADER_MEM_TOPOLOGY and calls
write_mem_topology().
Function record__init_features() at the beginning of __cmd_record()
sets all features and then turns off some.

Fix this by removed the warning, if the directory is not present
memory node information is not available and won't be displayed.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/header.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 121df1683c36..4a3bfc900a68 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1320,7 +1320,6 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: can't open node sysfs data\n");
 		return -1;
 	}
 
-- 
2.14.3
