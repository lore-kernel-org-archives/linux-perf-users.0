From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 49/75] perf top: Move lost events warning to helpline
Date: Thu,  6 Dec 2018 18:25:36 -0300
Message-ID: <20181206212602.20474-50-acme@kernel.org>
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

We can't display the UI box saying that we are slow in the reader
thread.  That will make 'perf top' even slower and the user even more
angry ;-)

Move the UI box message from the reader thread to the UI thread and
change it to a helpline, so there's no need to 'press any key'.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-x4k0iuw7tt6mywsaguq6jfwu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c02ea537d5a7..9fe835ba0697 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -553,8 +553,6 @@ static void perf_top__sort_new_samples(void *arg)
 	struct perf_evsel *evsel = t->sym_evsel;
 	struct hists *hists;
 
-	perf_top__reset_sample_counters(t);
-
 	if (t->evlist->selected != NULL)
 		t->sym_evsel = t->evlist->selected;
 
@@ -571,6 +569,11 @@ static void perf_top__sort_new_samples(void *arg)
 
 	hists__collapse_resort(hists, NULL);
 	perf_evsel__output_resort(evsel, NULL);
+
+	if (t->lost)
+		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
+
+	perf_top__reset_sample_counters(t);
 }
 
 static void *display_thread_tui(void *arg)
@@ -908,10 +911,8 @@ static void perf_top__mmap_read(struct perf_top *top)
 {
 	bool overwrite = top->record_opts.overwrite;
 	struct perf_evlist *evlist = top->evlist;
-	unsigned long long start, end;
 	int i;
 
-	start = rdclock();
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
 
@@ -922,13 +923,6 @@ static void perf_top__mmap_read(struct perf_top *top)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 	}
-	end = rdclock();
-
-	if ((end - start) > (unsigned long long)top->delay_secs * NSEC_PER_SEC)
-		ui__warning("Too slow to read ring buffer.\n"
-			    "Please try increasing the period (-c) or\n"
-			    "decreasing the freq (-F) or\n"
-			    "limiting the number of CPUs (-C)\n");
 }
 
 /*
-- 
2.19.2
