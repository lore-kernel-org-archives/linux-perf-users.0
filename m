From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/27] perf tools: Create function to perform multiple time range checking
Date: Wed, 10 Jan 2018 18:28:27 -0300
Message-ID: <20180110212844.12441-11-acme@kernel.org>
References: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753449AbeAJV3Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Jan 2018 16:29:25 -0500
In-Reply-To: <20180110212844.12441-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jin Yao <yao.jin@linux.intel.com>

Previous patch supports the multiple time range.

For example, select the first and second 10% time slices.
perf report --time 10%/1,10%/2

We need a function to check if a timestamp is in the ranges of
[0, 10%) and [10%, 20%].

Note that it includes the last element in [10%, 20%] but it doesn't
include the last element in [0, 10%). It's to avoid the overlap.

This patch implments a new function perf_time__ranges_skip_sample
for this checking.

Change log:

v4: Let perf_time__ranges_skip_sample be compatible with
    perf_time__skip_sample when only one time range.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512738826-2628-5-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/time-utils.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 61c46022de0b..3f7f18f06982 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -300,6 +300,34 @@ bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp)
 	return false;
 }
 
+bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
+				   int num, u64 timestamp)
+{
+	struct perf_time_interval *ptime;
+	int i;
+
+	if ((timestamp == 0) || (num == 0))
+		return false;
+
+	if (num == 1)
+		return perf_time__skip_sample(&ptime_buf[0], timestamp);
+
+	/*
+	 * start/end of multiple time ranges must be valid.
+	 */
+	for (i = 0; i < num; i++) {
+		ptime = &ptime_buf[i];
+
+		if (timestamp >= ptime->start &&
+		    ((timestamp < ptime->end && i < num - 1) ||
+		     (timestamp <= ptime->end && i == num - 1))) {
+			break;
+		}
+	}
+
+	return (i == num) ? true : false;
+}
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 {
 	u64  sec = timestamp / NSEC_PER_SEC;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 23087231785a..34d5eba26bf5 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -18,6 +18,9 @@ int perf_time__percent_parse_str(struct perf_time_interval *ptime_buf, int num,
 
 bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
 
+bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
+				   int num, u64 timestamp);
+
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
-- 
2.14.3
