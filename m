From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/75] perf ordered_events: Rework show_progress for __ordered_events__flush
Date: Thu,  6 Dec 2018 18:25:33 -0300
Message-ID: <20181206212602.20474-47-acme@kernel.org>
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

Decide to use the progress bar one level higher, we will need this in
following patch.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-ocjdukp2a8ujikkmafd0j5zv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 1904e7f6ec84..28f0f5c95024 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -219,13 +219,13 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 	return 0;
 }
 
-static int __ordered_events__flush(struct ordered_events *oe)
+static int __ordered_events__flush(struct ordered_events *oe,
+				   bool show_progress)
 {
 	struct list_head *head = &oe->events;
 	struct ordered_event *tmp, *iter;
 	u64 limit = oe->next_flush;
 	u64 last_ts = oe->last ? oe->last->timestamp : 0ULL;
-	bool show_progress = limit == ULLONG_MAX;
 	struct ui_progress prog;
 	int ret;
 
@@ -272,6 +272,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		"HALF ",
 	};
 	int err;
+	bool show_progress = false;
 
 	if (oe->nr_events == 0)
 		return 0;
@@ -279,6 +280,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	switch (how) {
 	case OE_FLUSH__FINAL:
 		oe->next_flush = ULLONG_MAX;
+		show_progress = true;
 		break;
 
 	case OE_FLUSH__HALF:
@@ -308,7 +310,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		   str[how], oe->nr_events);
 	pr_oe_time(oe->max_timestamp, "max_timestamp\n");
 
-	err = __ordered_events__flush(oe);
+	err = __ordered_events__flush(oe, show_progress);
 
 	if (!err) {
 		if (how == OE_FLUSH__ROUND)
-- 
2.19.2
