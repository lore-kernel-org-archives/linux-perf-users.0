From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/18] perf report: Group stat values on global event id
Date: Tue, 29 Aug 2017 16:42:45 -0300
Message-ID: <20170829194254.1338-10-acme@kernel.org>
References: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no big value on displaying counts for every event ID, which is
one per every CPU. Rather than that, displaying the whole sum for the
event.

  $ perf record -c 100000 -e cycles:u -s test
  $ perf report -T

Before:
  #  PID   TID  cycles:u  cycles:u  cycles:u  cycles:u  ... [20 more columns of 'cycles:u']
    3339  3339         0         0         0         0
    3340  3340         0         0         0         0
    3341  3341         0         0         0         0
    3342  3342         0         0         0         0

Now:
  #  PID   TID  cycles:u
    3339  3339     19678
    3340  3340     18744
    3341  3341     17335
    3342  3342     26414

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170824162737.7813-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 +-
 tools/perf/util/values.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9e4004b08f55..f9dff652dcbd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -241,7 +241,7 @@ static int process_read_event(struct perf_tool *tool,
 		const char *name = evsel ? perf_evsel__name(evsel) : "unknown";
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
-					   event->read.id,
+					   evsel->idx,
 					   name,
 					   event->read.value);
 
diff --git a/tools/perf/util/values.c b/tools/perf/util/values.c
index 3b56aeaa8cbb..8a32bb0095e5 100644
--- a/tools/perf/util/values.c
+++ b/tools/perf/util/values.c
@@ -192,7 +192,7 @@ int perf_read_values_add_value(struct perf_read_values *values,
 	if (cindex < 0)
 		return cindex;
 
-	values->value[tindex][cindex] = value;
+	values->value[tindex][cindex] += value;
 	return 0;
 }
 
-- 
2.13.5
