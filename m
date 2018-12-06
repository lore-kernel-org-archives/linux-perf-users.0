From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/75] perf top: Set the 'session_done' volatile variable when exiting
Date: Thu,  6 Dec 2018 18:25:39 -0300
Message-ID: <20181206212602.20474-53-acme@kernel.org>
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

So we can get out of hist processing ASAP on user request.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-r8aufbgbixr2f85s3wcoaw9v@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aad58643102e..50ec01eb7f57 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -577,6 +577,12 @@ static void perf_top__sort_new_samples(void *arg)
 	perf_top__reset_sample_counters(t);
 }
 
+static void stop_top(void)
+{
+	session_done = 1;
+	done = 1;
+}
+
 static void *display_thread_tui(void *arg)
 {
 	struct perf_evsel *pos;
@@ -613,13 +619,13 @@ static void *display_thread_tui(void *arg)
 				      !top->record_opts.overwrite,
 				      &top->annotation_opts);
 
-	done = 1;
+	stop_top();
 	return NULL;
 }
 
 static void display_sig(int sig __maybe_unused)
 {
-	done = 1;
+	stop_top();
 }
 
 static void display_setup_sig(void)
@@ -672,7 +678,7 @@ static void *display_thread(void *arg)
 
 			if (perf_top__handle_keypress(top, c))
 				goto repeat;
-			done = 1;
+			stop_top();
 		}
 	}
 
-- 
2.19.2
