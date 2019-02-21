From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/17] perf tools: Add numa_topology object
Date: Wed, 20 Feb 2019 22:25:36 -0300
Message-ID: <20190221012549.4069-5-acme@kernel.org>
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

Add the numa_topology object to return the list of numa nodes together
with their cpus. It will replace the numa code in header.c and will be
used from 'perf record' in the following patches.

Add the following interface functions to load numa details:

  struct numa_topology *numa_topology__new(void);
  void numa_topology__delete(struct numa_topology *tp);

And replace the current (copied) local interface, with no functional
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190219095815.15931-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cputopo.c | 118 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  16 +++++
 tools/perf/util/header.c  | 119 +++++++++-----------------------------
 3 files changed, 160 insertions(+), 93 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 84470ed4e707..83ffca2ea9ee 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <sys/param.h>
+#include <inttypes.h>
 
 #include "cputopo.h"
 #include "cpumap.h"
 #include "util.h"
+#include "env.h"
 
 
 #define CORE_SIB_FMT \
@@ -142,3 +144,119 @@ struct cpu_topology *cpu_topology__new(void)
 	}
 	return tp;
 }
+
+static int load_numa_node(struct numa_topology_node *node, int nr)
+{
+	char str[MAXPATHLEN];
+	char field[32];
+	char *buf = NULL, *p;
+	size_t len = 0;
+	int ret = -1;
+	FILE *fp;
+	u64 mem;
+
+	node->node = (u32) nr;
+
+	sprintf(str, "/sys/devices/system/node/node%d/meminfo", nr);
+	fp = fopen(str, "r");
+	if (!fp)
+		return -1;
+
+	while (getline(&buf, &len, fp) > 0) {
+		/* skip over invalid lines */
+		if (!strchr(buf, ':'))
+			continue;
+		if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
+			goto err;
+		if (!strcmp(field, "MemTotal:"))
+			node->mem_total = mem;
+		if (!strcmp(field, "MemFree:"))
+			node->mem_free = mem;
+		if (node->mem_total && node->mem_free)
+			break;
+	}
+
+	fclose(fp);
+	fp = NULL;
+
+	sprintf(str, "/sys/devices/system/node/node%d/cpulist", nr);
+
+	fp = fopen(str, "r");
+	if (!fp)
+		return -1;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto err;
+
+	p = strchr(buf, '\n');
+	if (p)
+		*p = '\0';
+
+	node->cpus = buf;
+	fclose(fp);
+	return 0;
+
+err:
+	free(buf);
+	if (fp)
+		fclose(fp);
+	return ret;
+}
+
+struct numa_topology *numa_topology__new(void)
+{
+	struct cpu_map *node_map = NULL;
+	struct numa_topology *tp = NULL;
+	char *buf = NULL;
+	size_t len = 0;
+	u32 nr, i;
+	FILE *fp;
+	char *c;
+
+	fp = fopen("/sys/devices/system/node/online", "r");
+	if (!fp)
+		return NULL;
+
+	if (getline(&buf, &len, fp) <= 0)
+		goto out;
+
+	c = strchr(buf, '\n');
+	if (c)
+		*c = '\0';
+
+	node_map = cpu_map__new(buf);
+	if (!node_map)
+		goto out;
+
+	nr = (u32) node_map->nr;
+
+	tp = zalloc(sizeof(*tp) + sizeof(tp->nodes[0])*nr);
+	if (!tp)
+		goto out;
+
+	tp->nr = nr;
+
+	for (i = 0; i < nr; i++) {
+		if (load_numa_node(&tp->nodes[i], node_map->map[i])) {
+			numa_topology__delete(tp);
+			tp = NULL;
+			break;
+		}
+	}
+
+out:
+	free(buf);
+	fclose(fp);
+	cpu_map__put(node_map);
+	return tp;
+}
+
+void numa_topology__delete(struct numa_topology *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->nr; i++)
+		free(tp->nodes[i].cpus);
+
+	free(tp);
+}
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 4b5f4112b6f8..47a97e71acdf 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -3,6 +3,7 @@
 #define __PERF_CPUTOPO_H
 
 #include <linux/types.h>
+#include "env.h"
 
 struct cpu_topology {
 	u32	  core_sib;
@@ -11,7 +12,22 @@ struct cpu_topology {
 	char	**thread_siblings;
 };
 
+struct numa_topology_node {
+	char		*cpus;
+	u32		 node;
+	u64		 mem_total;
+	u64		 mem_free;
+};
+
+struct numa_topology {
+	u32				nr;
+	struct numa_topology_node	nodes[0];
+};
+
 struct cpu_topology *cpu_topology__new(void);
 void cpu_topology__delete(struct cpu_topology *tp);
 
+struct numa_topology *numa_topology__new(void);
+void numa_topology__delete(struct numa_topology *tp);
+
 #endif /* __PERF_CPUTOPO_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 80ac57e6d38f..a2323d777dae 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -639,112 +639,45 @@ static int write_total_mem(struct feat_fd *ff,
 	return ret;
 }
 
-static int write_topo_node(struct feat_fd *ff, int node)
-{
-	char str[MAXPATHLEN];
-	char field[32];
-	char *buf = NULL, *p;
-	size_t len = 0;
-	FILE *fp;
-	u64 mem_total, mem_free, mem;
-	int ret = -1;
-
-	sprintf(str, "/sys/devices/system/node/node%d/meminfo", node);
-	fp = fopen(str, "r");
-	if (!fp)
-		return -1;
-
-	while (getline(&buf, &len, fp) > 0) {
-		/* skip over invalid lines */
-		if (!strchr(buf, ':'))
-			continue;
-		if (sscanf(buf, "%*s %*d %31s %"PRIu64, field, &mem) != 2)
-			goto done;
-		if (!strcmp(field, "MemTotal:"))
-			mem_total = mem;
-		if (!strcmp(field, "MemFree:"))
-			mem_free = mem;
-	}
-
-	fclose(fp);
-	fp = NULL;
-
-	ret = do_write(ff, &mem_total, sizeof(u64));
-	if (ret)
-		goto done;
-
-	ret = do_write(ff, &mem_free, sizeof(u64));
-	if (ret)
-		goto done;
-
-	ret = -1;
-	sprintf(str, "/sys/devices/system/node/node%d/cpulist", node);
-
-	fp = fopen(str, "r");
-	if (!fp)
-		goto done;
-
-	if (getline(&buf, &len, fp) <= 0)
-		goto done;
-
-	p = strchr(buf, '\n');
-	if (p)
-		*p = '\0';
-
-	ret = do_write_string(ff, buf);
-done:
-	free(buf);
-	if (fp)
-		fclose(fp);
-	return ret;
-}
-
 static int write_numa_topology(struct feat_fd *ff,
 			       struct perf_evlist *evlist __maybe_unused)
 {
-	char *buf = NULL;
-	size_t len = 0;
-	FILE *fp;
-	struct cpu_map *node_map = NULL;
-	char *c;
-	u32 nr, i, j;
+	struct numa_topology *tp;
 	int ret = -1;
+	u32 i;
 
-	fp = fopen("/sys/devices/system/node/online", "r");
-	if (!fp)
-		return -1;
+	tp = numa_topology__new();
+	if (!tp)
+		return -ENOMEM;
 
-	if (getline(&buf, &len, fp) <= 0)
-		goto done;
+	ret = do_write(ff, &tp->nr, sizeof(u32));
+	if (ret < 0)
+		goto err;
 
-	c = strchr(buf, '\n');
-	if (c)
-		*c = '\0';
+	for (i = 0; i < tp->nr; i++) {
+		struct numa_topology_node *n = &tp->nodes[i];
 
-	node_map = cpu_map__new(buf);
-	if (!node_map)
-		goto done;
-
-	nr = (u32)node_map->nr;
+		ret = do_write(ff, &n->node, sizeof(u32));
+		if (ret < 0)
+			goto err;
 
-	ret = do_write(ff, &nr, sizeof(nr));
-	if (ret < 0)
-		goto done;
+		ret = do_write(ff, &n->mem_total, sizeof(u64));
+		if (ret)
+			goto err;
 
-	for (i = 0; i < nr; i++) {
-		j = (u32)node_map->map[i];
-		ret = do_write(ff, &j, sizeof(j));
-		if (ret < 0)
-			break;
+		ret = do_write(ff, &n->mem_free, sizeof(u64));
+		if (ret)
+			goto err;
 
-		ret = write_topo_node(ff, j);
+		ret = do_write_string(ff, n->cpus);
 		if (ret < 0)
-			break;
+			goto err;
 	}
-done:
-	free(buf);
-	fclose(fp);
-	cpu_map__put(node_map);
+
+	ret = 0;
+
+err:
+	numa_topology__delete(tp);
 	return ret;
 }
 
-- 
2.19.1
