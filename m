From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/28] perf top: Start display thread earlier
Date: Wed, 31 Oct 2018 13:45:05 -0300
Message-ID: <20181031164508.4784-26-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Miller <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Miller <davem@davemloft.net>

If events are coming in at a rate such that the event processing thread
can barely keep up, our initial run of the event ring will almost never
terminate and this delays the starting of the display thread.

The screen basically stays black until the event thread can get out of
it's endless loop.

Therefore, start the display thread before we start processing the ring
buffer.

This also make sure that we always have the user requested real time
setting engaged when processing the ring.

Signed-off-by: David S. Miller <davem@davemloft.net>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181030.223003.2242527041807905962.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8e29e0cc8626..b2838de13de0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1134,11 +1134,6 @@ static int __cmd_top(struct perf_top *top)
         if (!target__none(&opts->target))
                 perf_evlist__enable(top->evlist);
 
-	/* Wait for a minimal set of events before starting the snapshot */
-	perf_evlist__poll(top->evlist, 100);
-
-	perf_top__mmap_read(top);
-
 	ret = -1;
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
 							    display_thread), top)) {
@@ -1156,6 +1151,11 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	/* Wait for a minimal set of events before starting the snapshot */
+	perf_evlist__poll(top->evlist, 100);
+
+	perf_top__mmap_read(top);
+
 	while (!done) {
 		u64 hits = top->samples;
 
-- 
2.14.4
