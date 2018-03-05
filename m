From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/28] perf test: Switch to new perf_mmap__read_event() interface for switch-tracking
Date: Mon,  5 Mar 2018 11:29:30 -0300
Message-ID: <20180305142932.16921-27-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'switch-tracking' still use the legacy interface.

No functional change.

Committer testing:

  # perf test switch
  32: Track with sched_switch                               : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-12-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/switch-tracking.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 33e00295a972..10c4dcdc2324 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -258,16 +258,23 @@ static int process_events(struct perf_evlist *evlist,
 	unsigned pos, cnt = 0;
 	LIST_HEAD(events);
 	struct event_node *events_array, *node;
+	struct perf_mmap *md;
+	u64 end, start;
 	int i, ret;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			cnt += 1;
 			ret = add_event(evlist, &events, event);
-			perf_evlist__mmap_consume(evlist, i);
+			 perf_mmap__consume(md, false);
 			if (ret < 0)
 				goto out_free_nodes;
 		}
+		perf_mmap__read_done(md);
 	}
 
 	events_array = calloc(cnt, sizeof(struct event_node));
-- 
2.14.3
