From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 79/85] perf time-utils: Make perf_time__parse_for_ranges() more logical
Date: Tue, 11 Jun 2019 15:59:05 -0300
Message-ID: <20190611185911.11645-80-acme@kernel.org>
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

Explicit time ranges never contain a percent sign whereas percentage
ranges always do, so it is possible to call the correct parser.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-18-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 9a463752dba8..d942840356e3 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -402,6 +402,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				struct perf_time_interval **ranges,
 				int *range_size, int *range_num)
 {
+	bool has_percent = strchr(time_str, '%');
 	struct perf_time_interval *ptime_range;
 	int size, num, ret = -EINVAL;
 
@@ -409,7 +410,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (!ptime_range)
 		return -ENOMEM;
 
-	if (perf_time__parse_str(ptime_range, time_str) != 0) {
+	if (has_percent) {
 		if (session->evlist->first_sample_time == 0 &&
 		    session->evlist->last_sample_time == 0) {
 			pr_err("HINT: no first/last sample time found in perf data.\n"
@@ -427,6 +428,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 		if (num < 0)
 			goto error_invalid;
 	} else {
+		if (perf_time__parse_str(ptime_range, time_str))
+			goto error_invalid;
 		num = 1;
 	}
 
-- 
2.20.1
