From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 78/85] perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
Date: Tue, 11 Jun 2019 15:59:04 -0300
Message-ID: <20190611185911.11645-79-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Simplify perf_time__parse_for_ranges() error paths slightly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 3e87c21c293c..9a463752dba8 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -403,7 +403,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				int *range_size, int *range_num)
 {
 	struct perf_time_interval *ptime_range;
-	int size, num, ret;
+	int size, num, ret = -EINVAL;
 
 	ptime_range = perf_time__range_alloc(time_str, &size);
 	if (!ptime_range)
@@ -415,7 +415,6 @@ int perf_time__parse_for_ranges(const char *time_str,
 			pr_err("HINT: no first/last sample time found in perf data.\n"
 			       "Please use latest perf binary to execute 'perf record'\n"
 			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			ret = -EINVAL;
 			goto error;
 		}
 
@@ -425,11 +424,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 				session->evlist->first_sample_time,
 				session->evlist->last_sample_time);
 
-		if (num < 0) {
-			pr_err("Invalid time string\n");
-			ret = -EINVAL;
-			goto error;
-		}
+		if (num < 0)
+			goto error_invalid;
 	} else {
 		num = 1;
 	}
@@ -439,6 +435,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 	*ranges = ptime_range;
 	return 0;
 
+error_invalid:
+	pr_err("Invalid time string\n");
 error:
 	free(ptime_range);
 	return ret;
-- 
2.20.1
