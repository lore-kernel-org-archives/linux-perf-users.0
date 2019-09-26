From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/66] perf list: Allow plurals for metric, metricgroup
Date: Wed, 25 Sep 2019 21:31:44 -0300
Message-ID: <20190926003244.13962-7-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Borislav Petkov <bp@suse.de>, Janakarajan Natarajan <janakarajan.natarajan@amd.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Luke Mujica <lukemujica@google.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Enhance usability by allowing the same plurality used in the output
title, for the command line parameter.

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

Fixes: 71b0acce78d1 ("perf list: Add metric groups to perf list")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <janakarajan.natarajan@amd.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190919204306.12598-4-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0
