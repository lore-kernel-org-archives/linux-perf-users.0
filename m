From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/91] perf stat: Improve runtime stat for interval mode
Date: Wed,  6 May 2020 12:21:09 -0300
Message-ID: <20200506152234.21977-7-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

For interval mode, the metric is printed after the '#' character if it
exists. But it's not calculated by the counts generated in this
interval.

See the following examples:

  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
  #           time             counts unit events
       1.000422803            764,809      inst_retired.any          #      2.9 CPI
       1.000422803          2,234,932      cycles
       2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
       2.001464585          4,022,591      cycles

The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)

  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
  #           time             counts unit events
       1.000429493          2,869,311      cycles
       1.000429493            816,875      instructions              #    0.28  insn per cycle
       2.001516426          9,260,973      cycles
       2.001516426          5,250,634      instructions              #    0.87  insn per cycle

The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is
0.57).

The current code uses a global variable 'rt_stat' for tracking and
updating the std dev of runtime stat. Unlike the counts, 'rt_stat' is not
reset for interval. While the counts are reset for interval.

  perf_stat_process_counter()
  {
          if (config->interval)
                  init_stats(ps->res_stats);
  }

So for interval mode, the 'rt_stat' variable should be reset too.

This patch resets 'rt_stat' before read_counters(), so the runtime stat
is only calculated by the counts generated in this interval.

With this patch:

  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
  #           time             counts unit events
       1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
       1.000420924          5,010,111      cycles
       2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
       2.001448579          4,599,861      cycles

  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
  #           time             counts unit events
       1.000428555          2,769,714      cycles
       1.000428555            774,462      instructions              #    0.28  insn per cycle
       2.001471562          3,595,904      cycles
       2.001471562          1,243,703      instructions              #    0.35  insn per cycle

Now the second 'insn per cycle' and CPI are calculated by the counts
generated in this interval.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-By: Kajol Jain <kjain@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200420145417.6864-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt | 2 ++
 tools/perf/builtin-stat.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4d56586b2fb9..3fb5028aef08 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,6 +176,8 @@ Print count deltas every N milliseconds (minimum: 1ms)
 The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
 	example: 'perf stat -I 1000 -e cycles -a sleep 5'
 
+If the metric exists, it is calculated by the counts generated in this interval and the metric is printed after #.
+
 --interval-count times::
 Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9207b6c45475..3f050d85c277 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -359,6 +359,7 @@ static void process_interval(void)
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
+	perf_stat__reset_shadow_per_stat(&rt_stat);
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
-- 
2.21.1
