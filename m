From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 74/75] perf ordered_events: Add first_time() method
Date: Thu,  6 Dec 2018 18:26:01 -0300
Message-ID: <20181206212602.20474-75-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dmitry Levin <ldv@altlinux.org>, Eugene Syromiatnikov <esyr@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@uudg.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To get the timestamp in the first event in the queue.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/n/tip-appp27jw1ul8kgg872j43r5o@git.kernel.org
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 11 +++++++++++
 tools/perf/util/ordered-events.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 46965643020b..897589507d97 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -343,6 +343,17 @@ int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp)
 	return __ordered_events__flush(oe, OE_FLUSH__TIME, timestamp);
 }
 
+u64 ordered_events__first_time(struct ordered_events *oe)
+{
+	struct ordered_event *event;
+
+	if (list_empty(&oe->events))
+		return 0;
+
+	event = list_first_entry(&oe->events, struct ordered_event, list);
+	return event->timestamp;
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index f352af20e167..0920fb0ec6cc 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -61,6 +61,7 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
 void ordered_events__reinit(struct ordered_events *oe);
+u64 ordered_events__first_time(struct ordered_events *oe);
 
 static inline
 void ordered_events__set_alloc_size(struct ordered_events *oe, u64 size)
-- 
2.19.2
