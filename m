From: Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 4/5] perf list: allow plurals for metric, metricgroup
Date: Thu, 19 Sep 2019 15:43:05 -0500
Message-ID: <20190919204306.12598-4-kim.phillips@amd.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919204306.12598-1-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kim.phillips@amd.com, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>, Luke Mujica <lukemujica@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Enhance usability by allowing the same plurality used in the output title, for
the command line parameter.

BEFORE, perf deceitfully acts as if there are no metrics to be had:

  $ perf list metrics

  List of pre-defined events (to be used in -e):

  Metric Groups:

  $

But singular 'metric' shows a list of metrics:

$ perf list metric

List of pre-defined events (to be used in -e):

Metrics:

  IPC
       [Instructions Per Cycle (per logical thread)]
  UPI
       [Uops Per Instruction]

AFTER, when asking for 'metrics', we actually see the metrics get listed:

$ perf list metrics

List of pre-defined events (to be used in -e):

Metrics:

  IPC
       [Instructions Per Cycle (per logical thread)]
  UPI
       [Uops Per Instruction]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Martin Liska <mliska@suse.cz>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Fixes: 71b0acce78d1 ("perf list: Add metric groups to perf list")
---
 tools/perf/builtin-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e290f6b348d8..08e62ae9d37e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -81,9 +81,9 @@ int cmd_list(int argc, const char **argv)
 						long_desc_flag, details_flag);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
-		else if (strcmp(argv[i], "metric") == 0)
+		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
 			metricgroup__print(true, false, NULL, raw_dump, details_flag);
-		else if (strcmp(argv[i], "metricgroup") == 0)
+		else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
 			metricgroup__print(false, true, NULL, raw_dump, details_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
-- 
2.23.0
