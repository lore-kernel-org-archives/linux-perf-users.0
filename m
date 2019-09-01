From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/47] perf pmu: Change convert_scale from static to global
Date: Sun,  1 Sep 2019 09:23:17 -0300
Message-ID: <20190901122326.5793-39-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The function convert_scale() can be used to convert string to unit and
scale. For example,

  s = "6000000000ns";
  convert_scale(s, &unit, &scale);

unit = "ns", scale = 6000000000.

Currently this function is static. This patch renames the function to
perf_pmu__convert_scale and changes the function to global.  No
functional change.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190828055932.8269-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 +++---
 tools/perf/util/pmu.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6b3448f6eb94..fb597fa94234 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -102,7 +102,7 @@ static int pmu_format(const char *name, struct list_head *format)
 	return 0;
 }
 
-static int convert_scale(const char *scale, char **end, double *sval)
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 {
 	char *lc;
 	int ret = 0;
@@ -165,7 +165,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
 	else
 		scale[sret] = '\0';
 
-	ret = convert_scale(scale, NULL, &alias->scale);
+	ret = perf_pmu__convert_scale(scale, NULL, &alias->scale);
 error:
 	close(fd);
 	return ret;
@@ -373,7 +373,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				desc ? strdup(desc) : NULL;
 	alias->topic = topic ? strdup(topic) : NULL;
 	if (unit) {
-		if (convert_scale(unit, &unit, &alias->scale) < 0)
+		if (perf_pmu__convert_scale(unit, &unit, &alias->scale) < 0)
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 3f8b79b1dd85..f36ade6df76d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -96,4 +96,6 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
+
 #endif /* __PMU_H */
-- 
2.21.0
