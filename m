From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/32] perf util: Support no index time percent slice
Date: Wed, 17 Jan 2018 13:12:17 -0300
Message-ID: <20180117161222.15611-28-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously, the time percent slice needs an index to specify which one
the user wants.

It may be easier to use if the index can be omitted.  So with this
patch, for example,

perf report --stdio --time 10%/1 should be equivalent to
perf report --stdio --time 10%

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1515596433-24653-5-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 88510ab6450e..5769f972c23e 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -261,6 +261,37 @@ static int percent_comma_split(struct perf_time_interval *ptime_buf, int num,
 	return i;
 }
 
+static int one_percent_convert(struct perf_time_interval *ptime_buf,
+			       const char *ostr, u64 start, u64 end, char *c)
+{
+	char *str;
+	int len = strlen(ostr), ret;
+
+	/*
+	 * c points to '%'.
+	 * '%' should be the last character
+	 */
+	if (ostr + len - 1 != c)
+		return -1;
+
+	/*
+	 * Construct a string like "xx%/1"
+	 */
+	str = malloc(len + 3);
+	if (str == NULL)
+		return -ENOMEM;
+
+	memcpy(str, ostr, len);
+	strcpy(str + len, "/1");
+
+	ret = percent_slash_split(str, ptime_buf, start, end);
+	if (ret == 0)
+		ret = 1;
+
+	free(str);
+	return ret;
+}
+
 int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
 				 const char *ostr, u64 start, u64 end)
 {
@@ -270,6 +301,7 @@ int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
 	 * ostr example:
 	 * 10%/2,10%/3: select the second 10% slice and the third 10% slice
 	 * 0%-10%,30%-40%: multiple time range
+	 * 50%: just one percent
 	 */
 
 	memset(ptime_buf, 0, sizeof(*ptime_buf) * num);
@@ -286,6 +318,10 @@ int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
 					   end, percent_dash_split);
 	}
 
+	c = strchr(ostr, '%');
+	if (c)
+		return one_percent_convert(ptime_buf, ostr, start, end, c);
+
 	return -1;
 }
 
-- 
2.14.3
