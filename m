From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/32] perf report: Add an indication of what time slices are used
Date: Wed, 17 Jan 2018 13:12:18 -0300
Message-ID: <20180117161222.15611-29-acme@kernel.org>
References: <20180117161222.15611-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117161222.15611-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Add a time slices indication to the perf report header.

For example,

  # perf report --stdio --time 10%

  # Total Lost Samples: 0
  #
  # Samples: 9K of event 'cycles:ppp' (time slices: 10%)
  # Event count (approx.): 8951288803

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested--by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1515596433-24653-6-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 7d4f0a5de326..4aaaa37262a8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -404,6 +404,9 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	if (evname != NULL)
 		ret += fprintf(fp, " of event '%s'", evname);
 
+	if (rep->time_str)
+		ret += fprintf(fp, " (time slices: %s)", rep->time_str);
+
 	if (symbol_conf.show_ref_callgraph &&
 	    strstr(evname, "call-graph=no")) {
 		ret += fprintf(fp, ", show reference callgraph");
-- 
2.14.3
