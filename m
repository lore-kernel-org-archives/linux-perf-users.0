From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/15] perf parse: Use YYABORT to clear stack after failure, plugging leaks
Date: Tue, 12 Nov 2019 15:37:57 -0300
Message-ID: <20191112183757.28660-16-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

Using return rather than YYABORT means that the stack isn't cleared up
following a failure. The change to YYABORT means the return value is 1
rather than -1, but the callers just check for a result of 0 (success).
Add missing free of a list when an error occurs in event_pmu.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191109075840.181231-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4cac830015be..e2eea4e601b4 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -284,6 +284,7 @@ PE_NAME opt_pmu_config
 	do {						\
 		parse_events_terms__delete($2);		\
 		parse_events_terms__delete(orig_terms);	\
+		free(list);				\
 		free($1);				\
 		free(pattern);				\
 		YYABORT;				\
@@ -550,7 +551,7 @@ tracepoint_name opt_event_config
 	free($1.event);
 	if (err) {
 		free(list);
-		return -1;
+		YYABORT;
 	}
 	$$ = list;
 }
-- 
2.21.0
