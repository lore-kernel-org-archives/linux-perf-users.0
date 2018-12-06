From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 56/75] perf top: Move perf_top__reset_sample_counters() to after counts display
Date: Thu,  6 Dec 2018 18:25:43 -0300
Message-ID: <20181206212602.20474-57-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the perf_top__reset_sample_counters() call to right after we
display the counters so we can see the updated numbers for longer.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-o72pyiwt05f3p2juprwmz2jo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c       | 4 ----
 tools/perf/ui/browsers/hists.c | 3 +++
 tools/perf/util/top.c          | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f22c531be366..fe3ecfb2e64b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -273,8 +273,6 @@ static void perf_top__print_sym_table(struct perf_top *top)
 	perf_top__header_snprintf(top, bf, sizeof(bf));
 	printf("%s\n", bf);
 
-	perf_top__reset_sample_counters(top);
-
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
 	if (!top->record_opts.overwrite &&
@@ -573,8 +571,6 @@ static void perf_top__sort_new_samples(void *arg)
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-
-	perf_top__reset_sample_counters(t);
 }
 
 static void stop_top(void)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 36b262c49f51..ffac1d54a3d4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2229,8 +2229,11 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
+
+		perf_top__reset_sample_counters(top);
 	}
 
+
 	return printed;
 }
 
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 31a8dee9af69..4c8da8c4435f 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -107,6 +107,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 					top->evlist->cpus->nr > 1 ? "s" : "");
 	}
 
+	perf_top__reset_sample_counters(top);
 	return ret;
 }
 
-- 
2.19.2
