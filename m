From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/44] perf report: Add --percent-type option
Date: Thu,  9 Aug 2018 11:58:10 -0300
Message-ID: <20180809145822.21391-33-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Set annotation percent type from following choices:

  global-period, local-period, global-hits, local-hits

With following report option setup the percent type will be passed to
annotation browser:

  $ perf report --percent-type period-local

The local/global keywords set if the percentage is computed in the scope
of the function (local) or the whole data (global).  The period/hits
keywords set the base the percentage is computed on - the samples period
or the number of samples (hits).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 9 +++++++++
 tools/perf/builtin-report.c              | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 917e36fde6d8..474a4941f65d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -477,6 +477,15 @@ include::itrace.txt[]
 	Display monitored tasks stored in perf data. Displaying pid/tid/ppid
 	plus the command string aligned to distinguish parent and child tasks.
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 02f7a3c27761..143542ffac20 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1124,6 +1124,9 @@ int cmd_report(int argc, const char **argv)
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
 		    "Show inline function"),
+	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
 	OPT_END()
 	};
 	struct perf_data data = {
-- 
2.14.4
