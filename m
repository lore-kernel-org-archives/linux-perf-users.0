From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/47] perf header: Replace MAX_NR_CPUS with cpu__max_cpu()
Date: Sun,  1 Sep 2019 09:22:46 -0300
Message-ID: <20190901122326.5793-8-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Russ Anderson <russ.anderson@hpe.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

The function cpu__max_cpu() returns the possible number of CPUs as
defined in the sysfs and can be used as an alternative for MAX_NR_CPUS
in write_cache.

MAX_CACHES is replaced by cpu__max_cpu() * MAX_CACHE_LVL.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-7-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0a842d9eff22..dd2bb0861ab1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1122,16 +1122,17 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES (MAX_NR_CPUS * 4)
+#define MAX_CACHE_LVL 4
 
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
-	struct cpu_cache_level caches[MAX_CACHES];
+	u32 max_caches = cpu__max_cpu() * MAX_CACHE_LVL;
+	struct cpu_cache_level caches[max_caches];
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, MAX_CACHES, &cnt);
+	ret = build_caches(caches, max_caches, &cnt);
 	if (ret)
 		goto out;
 
-- 
2.21.0
