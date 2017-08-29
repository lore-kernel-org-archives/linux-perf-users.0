From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/18] perf report: Add dump_read function
Date: Tue, 29 Aug 2017 16:42:41 -0300
Message-ID: <20170829194254.1338-6-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding dump_read function to gather all the dump output of read
function. Adding output of enabled and running times and id if enabled
(3 new lines with '...' prefix below).

  $ perf record -s ...
  $ perf report -D

  958358311769 0x91f8 [0x40]: PERF_RECORD_READ: 3339 3339 cycles:u 0
  ... time enabled : 958358313731
  ... time running : 958358313731
  ... id           : 80

Committer note:

Do not use 'read' as a variable name as it breaks the build on older
systems, such as RHEL6:

    CC       /tmp/build/perf/util/session.o
  cc1: warnings being treated as errors
  util/session.c: In function 'dump_read':
  util/session.c:1132: error: declaration of 'read' shadows a global declaration
  /usr/include/bits/unistd.h:35: error: shadowed declaration is here
  mv: cannot stat `/tmp/build/perf/util/.session.o.tmp': No such file or directory

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170824162737.7813-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c |  4 ----
 tools/perf/util/session.c   | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bace3429c030..9e4004b08f55 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -249,10 +249,6 @@ static int process_read_event(struct perf_tool *tool,
 			return err;
 	}
 
-	dump_printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
-		    evsel ? perf_evsel__name(evsel) : "FAIL",
-		    event->read.value);
-
 	return 0;
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dc453f84a14c..ac863691605f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1127,6 +1127,30 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 		sample_read__printf(sample, evsel->attr.read_format);
 }
 
+static void dump_read(struct perf_evsel *evsel, union perf_event *event)
+{
+	struct read_event *read_event = &event->read;
+	u64 read_format;
+
+	if (!dump_trace)
+		return;
+
+	printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
+	       evsel ? perf_evsel__name(evsel) : "FAIL",
+	       event->read.value);
+
+	read_format = evsel->attr.read_format;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		printf("... time enabled : %" PRIu64 "\n", read_event->time_enabled);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		printf("... time running : %" PRIu64 "\n", read_event->time_running);
+
+	if (read_format & PERF_FORMAT_ID)
+		printf("... id           : %" PRIu64 "\n", read_event->id);
+}
+
 static struct machine *machines__find_for_cpumode(struct machines *machines,
 					       union perf_event *event,
 					       struct perf_sample *sample)
@@ -1271,6 +1295,7 @@ static int machines__deliver_event(struct machines *machines,
 			evlist->stats.total_lost_samples += event->lost_samples.lost;
 		return tool->lost_samples(tool, event, sample, machine);
 	case PERF_RECORD_READ:
+		dump_read(evsel, event);
 		return tool->read(tool, event, sample, evsel, machine);
 	case PERF_RECORD_THROTTLE:
 		return tool->throttle(tool, event, sample, machine);
-- 
2.13.5
