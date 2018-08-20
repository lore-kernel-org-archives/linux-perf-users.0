From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/21] perf parser: Improve error message for PMU address filters
Date: Mon, 20 Aug 2018 13:15:43 -0300
Message-ID: <20180820161602.6830-3-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jack Henschel <jackdev@mailbox.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jack Henschel <jackdev@mailbox.org>

This is the second version of a patch that improves the error message of
the perf events parser when the PMU hardware does not support address
filters.

Previously, the perf returned the following error:

  $ perf record -e intel_pt// --filter 'filter sys_write'
  --filter option should follow a -e tracepoint or HW tracer option

This implies there is some syntax error present in the command line,
which is not true. Rather, notify the user that the CPU does not have
support for this feature.

For example, Intel chips based on the Broadwell micro-archticture have
the Intel PT PMU, but do not support address filtering.

Now, perf prints the following error message:

  $ perf record -e intel_pt// --filter 'filter sys_write'
  This CPU does not support address filtering

Signed-off-by: Jack Henschel <jackdev@mailbox.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180704121345.19025-1-jackdev@mailbox.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 15eec49e71a1..f8cd3e7c9186 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1991,8 +1991,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	int nr_addr_filters = 0;
 	struct perf_pmu *pmu = NULL;
 
-	if (evsel == NULL)
-		goto err;
+	if (evsel == NULL) {
+		fprintf(stderr,
+			"--filter option should follow a -e tracepoint or HW tracer option\n");
+		return -1;
+	}
 
 	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
 		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
@@ -2014,8 +2017,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 		perf_pmu__scan_file(pmu, "nr_addr_filters",
 				    "%d", &nr_addr_filters);
 
-	if (!nr_addr_filters)
-		goto err;
+	if (!nr_addr_filters) {
+		fprintf(stderr,
+			"This CPU does not support address filtering\n");
+		return -1;
+	}
 
 	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
@@ -2024,12 +2030,6 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
 	}
 
 	return 0;
-
-err:
-	fprintf(stderr,
-		"--filter option should follow a -e tracepoint or HW tracer option\n");
-
-	return -1;
 }
 
 int parse_filter(const struct option *opt, const char *str,
-- 
2.14.4
