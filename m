From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/32] perf util: Allocate time slices buffer according to number of comma
Date: Wed, 17 Jan 2018 13:12:19 -0300
Message-ID: <20180117161222.15611-30-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Previously we use a magic number 10 to limit the number of time slices.
It's not very good.

This patch creates a new function perf_time__range_alloc() to allocate
time slices buffer. The number of buffer entries is determined by the
number of comma in string but at least it will allocate one entry even
if no comma is found.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1515596433-24653-7-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/time-utils.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 5769f972c23e..6193b46050a5 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -325,6 +325,34 @@ int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
 	return -1;
 }
 
+struct perf_time_interval *perf_time__range_alloc(const char *ostr, int *size)
+{
+	const char *p1, *p2;
+	int i = 1;
+	struct perf_time_interval *ptime;
+
+	/*
+	 * At least allocate one time range.
+	 */
+	if (!ostr)
+		goto alloc;
+
+	p1 = ostr;
+	while (p1 < ostr + strlen(ostr)) {
+		p2 = strchr(p1, ',');
+		if (!p2)
+			break;
+
+		p1 = p2 + 1;
+		i++;
+	}
+
+alloc:
+	*size = i;
+	ptime = calloc(i, sizeof(*ptime));
+	return ptime;
+}
+
 bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp)
 {
 	/* if time is not set don't drop sample */
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 34d5eba26bf5..70b177d2b98c 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -16,6 +16,8 @@ int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr);
 int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
 				 const char *ostr, u64 start, u64 end);
 
+struct perf_time_interval *perf_time__range_alloc(const char *ostr, int *size);
+
 bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
 
 bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
-- 
2.14.3
