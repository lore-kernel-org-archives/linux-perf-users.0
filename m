From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 65/83] perf evsel: Say which PMU Hardware event doesn't support sampling/overflow-interrupts
Date: Fri, 17 Nov 2017 17:15:43 -0300
Message-ID: <20171117201601.24110-66-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Help identify to the user the event with the unsupported sampling error.
Also suggest a corrective action.

BEFORE:

$ sudo ./oldperf record -e armv8_pmuv3/mem_access/,ccn/cycles/,armv8_pmuv3/l2d_cache/ true
Error:
PMU Hardware doesn't support sampling/overflow-interrupts.

AFTER:

$ sudo ./newperf record -e armv8_pmuv3/mem_access/,ccn/cycles/,armv8_pmuv3/l2d_cache/ true
Error:
ccn/cycles/: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171114150452.e846f2e23684c7d7d8ee706f@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cb9bcdb065ea..b8e9def77f44 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2745,8 +2745,9 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 		break;
 	case EOPNOTSUPP:
 		if (evsel->attr.sample_period != 0)
-			return scnprintf(msg, size, "%s",
-	"PMU Hardware doesn't support sampling/overflow-interrupts.");
+			return scnprintf(msg, size,
+	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
+					 perf_evsel__name(evsel));
 		if (evsel->attr.precise_ip)
 			return scnprintf(msg, size, "%s",
 	"\'precise\' request may not be supported. Try removing 'p' modifier.");
-- 
2.13.6
