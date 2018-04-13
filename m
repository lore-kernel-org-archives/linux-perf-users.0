From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/17] perf record: Change warning for missing sysfs entry to debug
Date: Fri, 13 Apr 2018 11:01:08 -0300
Message-ID: <20180413140111.25313-15-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Using perf on 4.16.0 kernel on s390 shows this warning:

   failed: can't open node sysfs data

each time I run command perf record ... for example:

  [root@s35lp76 perf]# ./perf record -e rB0000 -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  failed: can't open node sysfs data
  [ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
  [root@s35lp76 perf]#

It turns out commit e2091cedd51bf ("perf tools: Add MEM_TOPOLOGY feature
to perf data file") tries to open directory named /sys/devices/system/node/
which does not exist on s390.

This is the call stack:
 __cmd_record
 +---> perf_session__write_header
       +---> perf_header__adds_write
             +---> do_write_feat
	           +---> write_mem_topology
		         +---> build_mem_topology
			       prints warning

The issue starts in do_write_feat() which unconditionally loops over all
features and now includes HEADER_MEM_TOPOLOGY and calls write_mem_topology().

Function record__init_features() at the beginning of __cmd_record() sets
all features and then turns off some of them.

Fix this by changing the warning to a level 2 debug output statement.

So it is only shown when debug level 2 or higher is set.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180412133246.92801-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 121df1683c36..a8bff2178fbc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1320,7 +1320,8 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: can't open node sysfs data\n");
+		pr_debug2("%s: could't read %s, does this arch have topology information?\n",
+			  __func__, path);
 		return -1;
 	}
 
-- 
2.14.3
