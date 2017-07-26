From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/40] perf report: Make --branch-history work without callgraphs(-g) option in perf record
Date: Wed, 26 Jul 2017 11:17:26 -0300
Message-ID: <20170726141730.30750-37-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

  perf record -b -g <command>
  perf report --branch-history

This merges the LBRs with the callgraphs.

However it would be nice if it also works without callgraphs (-g) set in
perf record, so that only the LBRs are displayed.  But currently perf
report errors in this case. For example,

  perf record -b <command>
  perf report --branch-history

  Error:
  Selected -g or --branch-history but no callchain data. Did
  you call 'perf record' without -g?

This patch displays the LBRs only even if callgraphs(-g) is not enabled
in perf record.

Change log:

v2: According to Milian Wolff's comment, change the obsolete error
message. Now the error message is:

                 ┌─Error:─────────────────────────────────────┐
                 │Selected -g or --branch-history.            │
                 │But no callchain or branch data.            │
                 │Did you call 'perf record' without -g or -b?│
                 │                                            │
                 │                                            │
                 │Press any key...                            │
                 └────────────────────────────────────────────┘

When passing the last parameter to hists__fprintf,
changes "|" to "||".

  hists__fprintf(hists, !quiet, 0, 0, rep->min_percent, stdout,
                 symbol_conf.use_callchain || symbol_conf.show_branchflag_count);

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1494240182-28899-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 12 +++++++-----
 tools/perf/util/callchain.c |  7 ++++---
 tools/perf/util/hist.c      |  2 ++
 tools/perf/util/machine.c   | 13 ++++++++++++-
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 983b238d5eea..bace3429c030 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -279,10 +279,11 @@ static int report__setup_sample_type(struct report *rep)
 				    "'perf record' without -g?\n");
 			return -EINVAL;
 		}
-		if (symbol_conf.use_callchain) {
-			ui__error("Selected -g or --branch-history but no "
-				  "callchain data. Did\n"
-				  "you call 'perf record' without -g?\n");
+		if (symbol_conf.use_callchain &&
+			!symbol_conf.show_branchflag_count) {
+			ui__error("Selected -g or --branch-history.\n"
+				  "But no callchain or branch data.\n"
+				  "Did you call 'perf record' without -g or -b?\n");
 			return -1;
 		}
 	} else if (!callchain_param.enabled &&
@@ -417,7 +418,8 @@ static int perf_evlist__tty_browse_hists(struct perf_evlist *evlist,
 
 		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
 		hists__fprintf(hists, !quiet, 0, 0, rep->min_percent, stdout,
-			       symbol_conf.use_callchain);
+			       symbol_conf.use_callchain ||
+			       symbol_conf.show_branchflag_count);
 		fprintf(stdout, "\n\n");
 	}
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 02130e2e72c7..1f536418dfb5 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1010,11 +1010,11 @@ int sample__resolve_callchain(struct perf_sample *sample,
 			      struct perf_evsel *evsel, struct addr_location *al,
 			      int max_stack)
 {
-	if (sample->callchain == NULL)
+	if (sample->callchain == NULL && !symbol_conf.show_branchflag_count)
 		return 0;
 
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain ||
-	    perf_hpp_list.parent) {
+	    perf_hpp_list.parent || symbol_conf.show_branchflag_count) {
 		return thread__resolve_callchain(al->thread, cursor, evsel, sample,
 						 parent, al, max_stack);
 	}
@@ -1023,7 +1023,8 @@ int sample__resolve_callchain(struct perf_sample *sample,
 
 int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample)
 {
-	if (!symbol_conf.use_callchain || sample->callchain == NULL)
+	if ((!symbol_conf.use_callchain || sample->callchain == NULL) &&
+		!symbol_conf.show_branchflag_count)
 		return 0;
 	return callchain_append(he->callchain, &callchain_cursor, sample->period);
 }
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 2f6c5e6c16f9..9453b2e27015 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1759,6 +1759,8 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 	else
 		use_callchain = symbol_conf.use_callchain;
 
+	use_callchain |= symbol_conf.show_branchflag_count;
+
 	output_resort(evsel__hists(evsel), prog, use_callchain, NULL);
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 79d08ea694da..d4df353051af 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1902,13 +1902,16 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 {
 	struct branch_stack *branch = sample->branch_stack;
 	struct ip_callchain *chain = sample->callchain;
-	int chain_nr = chain->nr;
+	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	int i, j, err, nr_entries;
 	int skip_idx = -1;
 	int first_call = 0;
 	int nr_loop_iter;
 
+	if (chain)
+		chain_nr = chain->nr;
+
 	if (perf_evsel__has_branch_callstack(evsel)) {
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
 						   root_al, max_stack);
@@ -1946,6 +1949,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		for (i = 0; i < nr; i++) {
 			if (callchain_param.order == ORDER_CALLEE) {
 				be[i] = branch->entries[i];
+
+				if (chain == NULL)
+					continue;
+
 				/*
 				 * Check for overlap into the callchain.
 				 * The return address is one off compared to
@@ -2000,6 +2007,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			if (err)
 				return err;
 		}
+
+		if (chain_nr == 0)
+			return 0;
+
 		chain_nr -= nr;
 	}
 
-- 
2.9.4
