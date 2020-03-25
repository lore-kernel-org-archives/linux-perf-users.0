From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/24] perf report/top TUI: Support hotkeys to let user select any event for sorting
Date: Wed, 25 Mar 2020 09:41:08 -0300
Message-ID: <20200325124124.32648-9-acme@kernel.org>
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

When performing "perf report --group", it shows the event group information
together. In previous patch, we have supported a new option "--group-sort-idx"
to sort the output by the event at the index n in event group.

It would be nice if we can use a hotkey in browser to select a event
to sort.

For example,

  # perf report --group

 Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
                        Overhead  Command    Shared Object            Symbol
  92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
   3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
   1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
   1.56%   0.01%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
   1.56%   0.00%   0.00%   0.00%  mgen       [kernel.kallsyms]        [k] task_tick_fair
   0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
   0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
   0.00%   0.03%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] g_main_context_check
   0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] apic_timer_interrupt
   0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] check_preempt_curr

When user press hotkey '3' (event index, starting from 0), it indicates
to sort output by the forth event in group.

  Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
                        Overhead  Command    Shared Object            Symbol
  92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
   0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
   3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
   0.00%   0.00%   0.00%   0.06%  swapper    [kernel.kallsyms]        [k] hrtimer_start_range_ns
   1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
   0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] update_curr
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] apic_timer_interrupt
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] native_apic_msr_eoi_write
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] __update_load_avg_se

 v6:
 ---
 Jiri provided a good improvement to eliminate unneeded refresh.
 This improvement is added to v6.

 v2:
 ---
 1. Report warning at helpline when index is invalid.
 2. Report warning at helpline when it's not group event.
 3. Use "case '0' ... '9'" to refine the code
 4. Split K_RELOAD implementation to another patch.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200220013616.19916-4-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 9f3401fd2cf6..95ac5e2ea949 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2992,7 +2992,8 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"s             Switch to another data file in PWD\n"
 	"t             Zoom into current Thread\n"
 	"V             Verbose (DSO names in callchains, etc)\n"
-	"/             Filter symbol by name";
+	"/             Filter symbol by name\n"
+	"0-9           Sort by event n in group";
 	static const char top_help[] = HIST_BROWSER_HELP_COMMON
 	"P             Print histograms to perf.hist.N\n"
 	"t             Zoom into current Thread\n"
@@ -3053,6 +3054,31 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			 * go to the next or previous
 			 */
 			goto out_free_stack;
+		case '0' ... '9':
+			if (!symbol_conf.event_group ||
+			    evsel->core.nr_members < 2) {
+				snprintf(buf, sizeof(buf),
+					 "Sort by index only available with group events!");
+				helpline = buf;
+				continue;
+			}
+
+			if (key - '0' == symbol_conf.group_sort_idx)
+				continue;
+
+			symbol_conf.group_sort_idx = key - '0';
+
+			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {
+				snprintf(buf, sizeof(buf),
+					 "Max event group index to sort is %d (index from 0 to %d)",
+					 evsel->core.nr_members - 1,
+					 evsel->core.nr_members - 1);
+				helpline = buf;
+				continue;
+			}
+
+			key = K_RELOAD;
+			goto out_free_stack;
 		case 'a':
 			if (!hists__has(hists, sym)) {
 				ui_browser__warning(&browser->b, delay_secs * 2,
-- 
2.21.1
