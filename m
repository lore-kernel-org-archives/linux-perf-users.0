From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v5 10/15] perf tools: Add utility function to print ns time stamps
Date: Fri,  8 Mar 2019 21:56:23 -0800
Message-ID: <20190309055628.21617-11-andi@firstfloor.org>
References: <20190309055628.21617-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309055628.21617-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a utility function to print nanosecond timestamps.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/time-utils.c | 8 ++++++++
 tools/perf/util/time-utils.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 6193b46050a5..a63bdf4cfd1b 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -404,6 +404,14 @@ int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 	return scnprintf(buf, sz, "%"PRIu64".%06"PRIu64, sec, usec);
 }
 
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz)
+{
+	u64  sec = timestamp / NSEC_PER_SEC;
+	u64 nsec = timestamp % NSEC_PER_SEC;
+
+	return scnprintf(buf, sz, "%"PRIu64".%09"PRIu64, sec, nsec);
+}
+
 int fetch_current_timestamp(char *buf, size_t sz)
 {
 	struct timeval tv;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 70b177d2b98c..9266cf4a8e58 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -24,6 +24,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 				   int num, u64 timestamp);
 
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
 
-- 
2.20.1
