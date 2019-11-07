From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/63] perf hist: Count the total cycles of all samples
Date: Thu,  7 Nov 2019 16:00:07 -0300
Message-ID: <20191107190011.23924-60-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We can get the per sample cycles by hist__account_cycles(). It's also
useful to know the total cycles of all samples in order to get the
cycles coverage for a single program block in further. For example:

  coverage = per block sampled cycles / total sampled cycles

This patch creates a new argument 'total_cycles' in hist__account_cycles(),
which will be added with the cycles of each sample.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-4-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 2 +-
 tools/perf/builtin-diff.c     | 3 ++-
 tools/perf/builtin-report.c   | 2 +-
 tools/perf/builtin-top.c      | 3 ++-
 tools/perf/util/hist.c        | 6 +++++-
 tools/perf/util/hist.h        | 3 ++-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8db8fc9bddef..6ab0cc45b287 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -201,7 +201,7 @@ static int process_branch_callback(struct evsel *evsel,
 	if (a.map != NULL)
 		a.map->dso->hit = 1;
 
-	hist__account_cycles(sample->branch_stack, al, sample, false);
+	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
 
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 	return ret;
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 6728568fe5c4..376dbf10ad64 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -426,7 +426,8 @@ static int diff__process_sample_event(struct perf_tool *tool,
 			goto out_put;
 		}
 
-		hist__account_cycles(sample->branch_stack, &al, sample, false);
+		hist__account_cycles(sample->branch_stack, &al, sample, false,
+				     NULL);
 	}
 
 	/*
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3bbad039abf2..bc15b9dcccd6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -292,7 +292,7 @@ static int process_sample_event(struct perf_tool *tool,
 
 	if (ui__has_annotation() || rep->symbol_ipc) {
 		hist__account_cycles(sample->branch_stack, &al, sample,
-				     rep->nonany_branch_mode);
+				     rep->nonany_branch_mode, NULL);
 	}
 
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d96f24c8770d..14c52e4d47f6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -725,7 +725,8 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
-		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY));
+		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
+		     NULL);
 	return 0;
 }
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index a7fa061987e4..0e27d6830011 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2572,7 +2572,8 @@ int hists__unlink(struct hists *hists)
 }
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
-			  struct perf_sample *sample, bool nonany_branch_mode)
+			  struct perf_sample *sample, bool nonany_branch_mode,
+			  u64 *total_cycles)
 {
 	struct branch_info *bi;
 
@@ -2599,6 +2600,9 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
 				prev = &bi[i].to;
+
+				if (total_cycles)
+					*total_cycles += bi[i].flags.cycles;
 			}
 			free(bi);
 		}
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 6a186b668303..4d87c7b4c1b2 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -527,7 +527,8 @@ unsigned int hists__sort_list_width(struct hists *hists);
 unsigned int hists__overhead_width(struct hists *hists);
 
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
-			  struct perf_sample *sample, bool nonany_branch_mode);
+			  struct perf_sample *sample, bool nonany_branch_mode,
+			  u64 *total_cycles);
 
 struct option;
 int parse_filter_percentage(const struct option *opt, const char *arg, int unset);
-- 
2.21.0
