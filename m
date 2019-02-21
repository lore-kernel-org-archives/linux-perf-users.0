From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/17] perf tools: Use sysfs__mountpoint() when reading cpu topology
Date: Wed, 20 Feb 2019 22:25:37 -0300
Message-ID: <20190221012549.4069-6-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use sysfs__mountpoint() when reading sysfs files to obtain cpu/numa
topologies.

Also use scnprintf instead of sprintf as suggested by Namhyung.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190219095815.15931-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cputopo.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 83ffca2ea9ee..ece0710249d4 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/param.h>
 #include <inttypes.h>
+#include <api/fs/fs.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
@@ -9,9 +10,15 @@
 
 
 #define CORE_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
+	"%s/devices/system/cpu/cpu%d/topology/core_siblings_list"
 #define THRD_SIB_FMT \
-	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+#define NODE_ONLINE_FMT \
+	"%s/devices/system/node/online"
+#define NODE_MEMINFO_FMT \
+	"%s/devices/system/node/node%d/meminfo"
+#define NODE_CPULIST_FMT \
+	"%s/devices/system/node/node%d/cpulist"
 
 static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 {
@@ -23,7 +30,8 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	u32 i = 0;
 	int ret = -1;
 
-	sprintf(filename, CORE_SIB_FMT, cpu);
+	scnprintf(filename, MAXPATHLEN, CORE_SIB_FMT,
+		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto try_threads;
@@ -50,7 +58,8 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_threads:
-	sprintf(filename, THRD_SIB_FMT, cpu);
+	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+		  sysfs__mountpoint(), cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto done;
@@ -157,7 +166,8 @@ static int load_numa_node(struct numa_topology_node *node, int nr)
 
 	node->node = (u32) nr;
 
-	sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);
+	scnprintf(str, MAXPATHLEN, NODE_MEMINFO_FMT,
+		  sysfs__mountpoint(), nr);
 	fp = fopen(str, "r");
 	if (!fp)
 		return -1;
@@ -179,7 +189,8 @@ static int load_numa_node(struct numa_topology_node *node, int nr)
 	fclose(fp);
 	fp = NULL;
 
-	sprintf(str, "/sys/devices/system/node/node%d/cpulist", nr);
+	scnprintf(str, MAXPATHLEN, NODE_CPULIST_FMT,
+		  sysfs__mountpoint(), nr);
 
 	fp = fopen(str, "r");
 	if (!fp)
@@ -207,13 +218,17 @@ struct numa_topology *numa_topology__new(void)
 {
 	struct cpu_map *node_map = NULL;
 	struct numa_topology *tp = NULL;
+	char path[MAXPATHLEN];
 	char *buf = NULL;
 	size_t len = 0;
 	u32 nr, i;
 	FILE *fp;
 	char *c;
 
-	fp = fopen("/sys/devices/system/node/online", "r");
+	scnprintf(path, MAXPATHLEN, NODE_ONLINE_FMT,
+		  sysfs__mountpoint());
+
+	fp = fopen(path, "r");
 	if (!fp)
 		return NULL;
 
-- 
2.19.1
