From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/27] perf tools: Create function to parse time percent
Date: Wed, 10 Jan 2018 18:28:26 -0300
Message-ID: <20180110212844.12441-10-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Current perf report/script/... have a --time option to limit the time
range of output. But right now it only supports absolute time, add
support for time percentage.

For example:

1. Select the second 10% time slice
   perf report --time 10%/2

2. Select from 0% to 10% time slice
   perf report --time 0%-10%

It also support the multiple time ranges.

3. Select the first and second 10% time slices
   perf report --time 10%/1,10%/2

4. Select from 0% to 10% and 30% to 40% slices
   perf report --time 0%-10%,30%-40%

Changelog:

v4: An issue is found. Following passes.
    perf script --time 10%/10x12321xsdfdasfdsafdsafdsa

    Now it uses strtol to replace atoi.

Committer notes:

This just puts in place the infrastructure, so the examples in this cset
comment will only work later, after more patches in this series are
applied.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512738826-2628-4-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 205 ++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/time-utils.h |   3 +
 2 files changed, 196 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 81927d027417..61c46022de0b 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -6,6 +6,7 @@
 #include <time.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <math.h>
 
 #include "perf.h"
 #include "debug.h"
@@ -60,11 +61,10 @@ static int parse_timestr_sec_nsec(struct perf_time_interval *ptime,
 	return 0;
 }
 
-int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr)
+static int split_start_end(char **start, char **end, const char *ostr, char ch)
 {
 	char *start_str, *end_str;
 	char *d, *str;
-	int rc = 0;
 
 	if (ostr == NULL || *ostr == '\0')
 		return 0;
@@ -74,25 +74,35 @@ int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr)
 	if (str == NULL)
 		return -ENOMEM;
 
-	ptime->start = 0;
-	ptime->end = 0;
-
-	/* str has the format: <start>,<stop>
-	 * variations: <start>,
-	 *             ,<stop>
-	 *             ,
-	 */
 	start_str = str;
-	d = strchr(start_str, ',');
+	d = strchr(start_str, ch);
 	if (d) {
 		*d = '\0';
 		++d;
 	}
 	end_str = d;
 
+	*start = start_str;
+	*end = end_str;
+
+	return 0;
+}
+
+int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr)
+{
+	char *start_str = NULL, *end_str;
+	int rc;
+
+	rc = split_start_end(&start_str, &end_str, ostr, ',');
+	if (rc || !start_str)
+		return rc;
+
+	ptime->start = 0;
+	ptime->end = 0;
+
 	rc = parse_timestr_sec_nsec(ptime, start_str, end_str);
 
-	free(str);
+	free(start_str);
 
 	/* make sure end time is after start time if it was given */
 	if (rc == 0 && ptime->end && ptime->end < ptime->start)
@@ -104,6 +114,177 @@ int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr)
 	return rc;
 }
 
+static int parse_percent(double *pcnt, char *str)
+{
+	char *c;
+
+	c = strchr(str, '%');
+	if (c)
+		*c = '\0';
+	else
+		return -1;
+
+	*pcnt = atof(str) / 100.0;
+
+	return 0;
+}
+
+static int percent_slash_split(char *str, struct perf_time_interval *ptime,
+			       u64 start, u64 end)
+{
+	char *p, *end_str;
+	double pcnt, start_pcnt, end_pcnt;
+	u64 total = end - start;
+	int i;
+
+	/*
+	 * Example:
+	 * 10%/2: select the second 10% slice and the third 10% slice
+	 */
+
+	/* We can modify this string since the original one is copied */
+	p = strchr(str, '/');
+	if (!p)
+		return -1;
+
+	*p = '\0';
+	if (parse_percent(&pcnt, str) < 0)
+		return -1;
+
+	p++;
+	i = (int)strtol(p, &end_str, 10);
+	if (*end_str)
+		return -1;
+
+	if (pcnt <= 0.0)
+		return -1;
+
+	start_pcnt = pcnt * (i - 1);
+	end_pcnt = pcnt * i;
+
+	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
+	    end_pcnt < 0.0 || end_pcnt > 1.0) {
+		return -1;
+	}
+
+	ptime->start = start + round(start_pcnt * total);
+	ptime->end = start + round(end_pcnt * total);
+
+	return 0;
+}
+
+static int percent_dash_split(char *str, struct perf_time_interval *ptime,
+			      u64 start, u64 end)
+{
+	char *start_str = NULL, *end_str;
+	double start_pcnt, end_pcnt;
+	u64 total = end - start;
+	int ret;
+
+	/*
+	 * Example: 0%-10%
+	 */
+
+	ret = split_start_end(&start_str, &end_str, str, '-');
+	if (ret || !start_str)
+		return ret;
+
+	if ((parse_percent(&start_pcnt, start_str) != 0) ||
+	    (parse_percent(&end_pcnt, end_str) != 0)) {
+		free(start_str);
+		return -1;
+	}
+
+	free(start_str);
+
+	if (start_pcnt < 0.0 || start_pcnt > 1.0 ||
+	    end_pcnt < 0.0 || end_pcnt > 1.0 ||
+	    start_pcnt > end_pcnt) {
+		return -1;
+	}
+
+	ptime->start = start + round(start_pcnt * total);
+	ptime->end = start + round(end_pcnt * total);
+
+	return 0;
+}
+
+typedef int (*time_pecent_split)(char *, struct perf_time_interval *,
+				 u64 start, u64 end);
+
+static int percent_comma_split(struct perf_time_interval *ptime_buf, int num,
+			       const char *ostr, u64 start, u64 end,
+			       time_pecent_split func)
+{
+	char *str, *p1, *p2;
+	int len, ret, i = 0;
+
+	str = strdup(ostr);
+	if (str == NULL)
+		return -ENOMEM;
+
+	len = strlen(str);
+	p1 = str;
+
+	while (p1 < str + len) {
+		if (i >= num) {
+			free(str);
+			return -1;
+		}
+
+		p2 = strchr(p1, ',');
+		if (p2)
+			*p2 = '\0';
+
+		ret = (func)(p1, &ptime_buf[i], start, end);
+		if (ret < 0) {
+			free(str);
+			return -1;
+		}
+
+		pr_debug("start time %d: %" PRIu64 ", ", i, ptime_buf[i].start);
+		pr_debug("end time %d: %" PRIu64 "\n", i, ptime_buf[i].end);
+
+		i++;
+
+		if (p2)
+			p1 = p2 + 1;
+		else
+			break;
+	}
+
+	free(str);
+	return i;
+}
+
+int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
+				 const char *ostr, u64 start, u64 end)
+{
+	char *c;
+
+	/*
+	 * ostr example:
+	 * 10%/2,10%/3: select the second 10% slice and the third 10% slice
+	 * 0%-10%,30%-40%: multiple time range
+	 */
+
+	memset(ptime_buf, 0, sizeof(*ptime_buf) * num);
+
+	c = strchr(ostr, '/');
+	if (c) {
+		return percent_comma_split(ptime_buf, num, ostr, start,
+					   end, percent_slash_split);
+	}
+
+	c = strchr(ostr, '-');
+	if (c) {
+		return percent_comma_split(ptime_buf, num, ostr, start,
+					   end, percent_dash_split);
+	}
+
+	return -1;
+}
+
 bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp)
 {
 	/* if time is not set don't drop sample */
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 15b475c50ccf..23087231785a 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -13,6 +13,9 @@ int parse_nsec_time(const char *str, u64 *ptime);
 
 int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr);
 
+int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
+				 const char *ostr, u64 start, u64 end);
+
 bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
 
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
-- 
2.14.3
