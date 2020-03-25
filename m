From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/24] perf report: Allow specifying event to be used as sort key in --group output
Date: Wed, 25 Mar 2020 09:41:06 -0300
Message-ID: <20200325124124.32648-7-acme@kernel.org>
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

When performing "perf report --group", it shows the event group
information together. By default, the output is sorted by the first
event in group.

It would be nice for user to select any event for sorting. This patch
introduces a new option "--group-sort-idx" to sort the output by the
event at the index n in event group.

For example,

Before:

  # perf report --group --stdio

  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, BR_MISP_RETIRED.ALL_BRANCHES:pp, cpu/event=0xc0,umask=1,cmask=1,
  # Event count (approx.): 6451235635
  #
  #                         Overhead  Command    Shared Object            Symbol
  # ................................  .........  .......................  ...................................
  #
      92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
       3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
       1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
       1.56%   0.01%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
       1.56%   0.00%   0.00%   0.00%  mgen       [kernel.kallsyms]        [k] task_tick_fair
       0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
       0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
       0.00%   0.03%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] g_main_context_check
       0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] apic_timer_interrupt
       ...

After:

  # perf report --group --stdio --group-sort-idx 3

  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, BR_MISP_RETIRED.ALL_BRANCHES:pp, cpu/event=0xc0,umask=1,cmask=1,
  # Event count (approx.): 6451235635
  #
  #                         Overhead  Command    Shared Object            Symbol
  # ................................  .........  .......................  ...................................
  #
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
       0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] scheduler_tick

Now the output is sorted by the fourth event in group.

 v7:
 ---
 Rebase to latest perf/core, no other change.

 v4:
 ---
 1. Update Documentation/perf-report.txt to mention
    '--group-sort-idx' support multiple groups with different
    amount of events and it should be used on grouped events.

 2. Update __hpp__group_sort_idx(), just return when the
    idx is out of limit.

 3. Return failure on symbol_conf.group_sort_idx && !session->evlist->nr_groups.
    So now we don't need to use together with --group.

 v3:
 ---
 Refine the code in __hpp__group_sort_idx().

 Before:
   for (i = 1; i < nr_members; i++) {
        if (i == idx) {
                ret = field_cmp(fields_a[i], fields_b[i]);
                if (ret)
                        goto out;
        }
   }

 After:
   if (idx >= 1 && idx < nr_members) {
        ret = field_cmp(fields_a[idx], fields_b[idx]);
        if (ret)
                goto out;
   }

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200220013616.19916-2-yao.jin@linux.intel.com
[ Renamed pair_fields_alloc() to hist_entry__new_pair() and combined decl + assignment of vars ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  5 ++
 tools/perf/builtin-report.c              | 10 +++
 tools/perf/ui/hist.c                     | 93 ++++++++++++++++++++----
 tools/perf/util/symbol_conf.h            |  1 +
 4 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index bd0a029d4c08..e56e3f1344a7 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -377,6 +377,11 @@ OPTIONS
 	Show event group information together. It forces group output also
 	if there are no groups defined in data file.
 
+--group-sort-idx::
+	Sort the output by the event at the index n in group. If n is invalid,
+	sort by the first event. It can support multiple groups with different
+	amount of events. WARNING: This should be used on grouped events.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 5f4045df76f4..fa21c5ae3a51 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1227,6 +1227,10 @@ int cmd_report(int argc, const char **argv)
 		    "Show a column with the sum of periods"),
 	OPT_BOOLEAN_SET(0, "group", &symbol_conf.event_group, &report.group_set,
 		    "Show event group information together"),
+	OPT_INTEGER(0, "group-sort-idx", &symbol_conf.group_sort_idx,
+		    "Sort the output by the event at the index n in group. "
+		    "If n is invalid, sort by the first event. "
+		    "WARNING: should be used on grouped events."),
 	OPT_CALLBACK_NOOPT('b', "branch-stack", &branch_mode, "",
 		    "use branch records for per branch histogram filling",
 		    parse_branch_mode),
@@ -1369,6 +1373,12 @@ int cmd_report(int argc, const char **argv)
 
 	setup_forced_leader(&report, session->evlist);
 
+	if (symbol_conf.group_sort_idx && !session->evlist->nr_groups) {
+		parse_options_usage(NULL, options, "group-sort-idx", 0);
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (itrace_synth_opts.last_branch)
 		has_br_stack = true;
 
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index f73675500061..025f4c7f96bf 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -151,15 +151,90 @@ static int field_cmp(u64 field_a, u64 field_b)
 	return 0;
 }
 
+static int hist_entry__new_pair(struct hist_entry *a, struct hist_entry *b,
+				hpp_field_fn get_field, int nr_members,
+				u64 **fields_a, u64 **fields_b)
+{
+	u64 *fa = calloc(nr_members, sizeof(*fa)),
+	    *fb = calloc(nr_members, sizeof(*fb));
+	struct hist_entry *pair;
+
+	if (!fa || !fb)
+		goto out_free;
+
+	list_for_each_entry(pair, &a->pairs.head, pairs.node) {
+		struct evsel *evsel = hists_to_evsel(pair->hists);
+		fa[perf_evsel__group_idx(evsel)] = get_field(pair);
+	}
+
+	list_for_each_entry(pair, &b->pairs.head, pairs.node) {
+		struct evsel *evsel = hists_to_evsel(pair->hists);
+		fb[perf_evsel__group_idx(evsel)] = get_field(pair);
+	}
+
+	*fields_a = fa;
+	*fields_b = fb;
+	return 0;
+out_free:
+	free(fa);
+	free(fb);
+	*fields_a = *fields_b = NULL;
+	return -1;
+}
+
+static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry *b,
+				 hpp_field_fn get_field, int idx)
+{
+	struct evsel *evsel = hists_to_evsel(a->hists);
+	u64 *fields_a, *fields_b;
+	int cmp, nr_members, ret, i;
+
+	cmp = field_cmp(get_field(a), get_field(b));
+	if (!perf_evsel__is_group_event(evsel))
+		return cmp;
+
+	nr_members = evsel->core.nr_members;
+	if (idx < 1 || idx >= nr_members)
+		return cmp;
+
+	ret = hist_entry__new_pair(a, b, get_field, nr_members, &fields_a, &fields_b);
+	if (ret) {
+		ret = cmp;
+		goto out;
+	}
+
+	ret = field_cmp(fields_a[idx], fields_b[idx]);
+	if (ret)
+		goto out;
+
+	for (i = 1; i < nr_members; i++) {
+		if (i != idx) {
+			ret = field_cmp(fields_a[i], fields_b[i]);
+			if (ret)
+				goto out;
+		}
+	}
+
+out:
+	free(fields_a);
+	free(fields_b);
+
+	return ret;
+}
+
 static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		       hpp_field_fn get_field)
 {
 	s64 ret;
 	int i, nr_members;
 	struct evsel *evsel;
-	struct hist_entry *pair;
 	u64 *fields_a, *fields_b;
 
+	if (symbol_conf.group_sort_idx && symbol_conf.event_group) {
+		return __hpp__group_sort_idx(a, b, get_field,
+					     symbol_conf.group_sort_idx);
+	}
+
 	ret = field_cmp(get_field(a), get_field(b));
 	if (ret || !symbol_conf.event_group)
 		return ret;
@@ -169,22 +244,10 @@ static int __hpp__sort(struct hist_entry *a, struct hist_entry *b,
 		return ret;
 
 	nr_members = evsel->core.nr_members;
-	fields_a = calloc(nr_members, sizeof(*fields_a));
-	fields_b = calloc(nr_members, sizeof(*fields_b));
-
-	if (!fields_a || !fields_b)
+	i = hist_entry__new_pair(a, b, get_field, nr_members, &fields_a, &fields_b);
+	if (i)
 		goto out;
 
-	list_for_each_entry(pair, &a->pairs.head, pairs.node) {
-		evsel = hists_to_evsel(pair->hists);
-		fields_a[perf_evsel__group_idx(evsel)] = get_field(pair);
-	}
-
-	list_for_each_entry(pair, &b->pairs.head, pairs.node) {
-		evsel = hists_to_evsel(pair->hists);
-		fields_b[perf_evsel__group_idx(evsel)] = get_field(pair);
-	}
-
 	for (i = 1; i < nr_members; i++) {
 		ret = field_cmp(fields_a[i], fields_b[i]);
 		if (ret)
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 10f1ec3e0349..b916afb95ec5 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -73,6 +73,7 @@ struct symbol_conf {
 	const char	*symfs;
 	int		res_sample;
 	int		pad_output_len_dso;
+	int		group_sort_idx;
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.21.1
