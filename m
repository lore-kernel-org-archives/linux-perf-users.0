From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 74/85] perf time-utils: Treat time ranges consistently
Date: Tue, 11 Jun 2019 15:59:00 -0300
Message-ID: <20190611185911.11645-75-acme@kernel.org>
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

Currently, options allow only 1 explicit (non-percentage) time range.
In preparation for adding support for multiple explicit time ranges,
treat time ranges consistently.

Instead of treating some time ranges as inclusive and some as excluding
the end time, treat all time ranges as inclusive. This is only a 1
nanosecond change but is necessary to treat multiple explicit time
ranges in a consistent manner.

Note, there is a later patch that adds a test for time-utils.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 20663a460df3..1d67cf1216c7 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -389,13 +389,12 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 		ptime = &ptime_buf[i];
 
 		if (timestamp >= ptime->start &&
-		    ((timestamp < ptime->end && i < num - 1) ||
-		     (timestamp <= ptime->end && i == num - 1))) {
-			break;
+		    (timestamp <= ptime->end || !ptime->end)) {
+			return false;
 		}
 	}
 
-	return (i == num) ? true : false;
+	return true;
 }
 
 int perf_time__parse_for_ranges(const char *time_str,
-- 
2.20.1
