From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/24] perf stat: Align the output for interval aggregation mode
Date: Wed, 25 Mar 2020 09:41:09 -0300
Message-ID: <20200325124124.32648-10-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

There is a slight misalignment in -A -I output.

For example:

 # perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000

 #           time CPU                    counts unit events
      1.000440863 CPU0               1,068,388      cpu/event=cpu-cycles/
      1.000440863 CPU1                 875,954      cpu/event=cpu-cycles/
      1.000440863 CPU2               3,072,538      cpu/event=cpu-cycles/
      1.000440863 CPU3               4,026,870      cpu/event=cpu-cycles/
      1.000440863 CPU4               5,919,630      cpu/event=cpu-cycles/
      1.000440863 CPU5               2,714,260      cpu/event=cpu-cycles/
      1.000440863 CPU6               2,219,240      cpu/event=cpu-cycles/
      1.000440863 CPU7               1,299,232      cpu/event=cpu-cycles/

The value of counts is not aligned with the column "counts" and
the event name is not aligned with the column "events".

With this patch, the output is,

 # perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000

 #           time CPU                    counts unit events
      1.000423009 CPU0                  997,421      cpu/event=cpu-cycles/
      1.000423009 CPU1                1,422,042      cpu/event=cpu-cycles/
      1.000423009 CPU2                  484,651      cpu/event=cpu-cycles/
      1.000423009 CPU3                  525,791      cpu/event=cpu-cycles/
      1.000423009 CPU4                1,370,100      cpu/event=cpu-cycles/
      1.000423009 CPU5                  442,072      cpu/event=cpu-cycles/
      1.000423009 CPU6                  205,643      cpu/event=cpu-cycles/
      1.000423009 CPU7                1,302,250      cpu/event=cpu-cycles/

Now output is aligned.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200218071614.25736-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 76c6052b12e2..9e757d18d713 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -115,11 +115,11 @@ static void aggr_printout(struct perf_stat_config *config,
 			fprintf(config->output, "S%d-D%d-C%*d%s",
 				cpu_map__id_to_socket(id),
 				cpu_map__id_to_die(id),
-				config->csv_output ? 0 : -5,
+				config->csv_output ? 0 : -3,
 				cpu_map__id_to_cpu(id), config->csv_sep);
 		} else {
-			fprintf(config->output, "CPU%*d%s ",
-				config->csv_output ? 0 : -5,
+			fprintf(config->output, "CPU%*d%s",
+				config->csv_output ? 0 : -7,
 				evsel__cpus(evsel)->map[id],
 				config->csv_sep);
 		}
-- 
2.21.1
