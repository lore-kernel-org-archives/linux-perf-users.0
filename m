From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 72/75] perf ordered_events: Add ordered_events__flush_time interface
Date: Thu,  6 Dec 2018 18:25:59 -0300
Message-ID: <20181206212602.20474-73-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dmitry Levin <ldv@altlinux.org>, Eugene Syromiatnikov <esyr@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@uudg.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add OE_FLUSH__TIME flush type, to be able to flush only certain amount
of the queue based on the provided timestamp. It will be used in the
following patches.

Link: http://lkml.kernel.org/n/tip-a3na77vemwr1g92lfhlrztg5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181205160509.1168-7-jolsa@kernel.org
[ Fix the build on older systems such as centos 5 and 6 where 'time' shadows a global declaration ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 23 +++++++++++++++++++----
 tools/perf/util/ordered-events.h |  2 ++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index c5412db05683..46965643020b 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -219,8 +219,7 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 	return 0;
 }
 
-static int __ordered_events__flush(struct ordered_events *oe,
-				   bool show_progress)
+static int do_flush(struct ordered_events *oe, bool show_progress)
 {
 	struct list_head *head = &oe->events;
 	struct ordered_event *tmp, *iter;
@@ -263,7 +262,8 @@ static int __ordered_events__flush(struct ordered_events *oe,
 	return 0;
 }
 
-int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
+static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
+				   u64 timestamp)
 {
 	static const char * const str[] = {
 		"NONE",
@@ -302,6 +302,11 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		break;
 	}
 
+	case OE_FLUSH__TIME:
+		oe->next_flush = timestamp;
+		show_progress = false;
+		break;
+
 	case OE_FLUSH__ROUND:
 	case OE_FLUSH__NONE:
 	default:
@@ -312,7 +317,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		   str[how], oe->nr_events);
 	pr_oe_time(oe->max_timestamp, "max_timestamp\n");
 
-	err = __ordered_events__flush(oe, show_progress);
+	err = do_flush(oe, show_progress);
 
 	if (!err) {
 		if (how == OE_FLUSH__ROUND)
@@ -328,6 +333,16 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	return err;
 }
 
+int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
+{
+	return __ordered_events__flush(oe, how, 0);
+}
+
+int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp)
+{
+	return __ordered_events__flush(oe, OE_FLUSH__TIME, timestamp);
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 0c6e26aec0e3..f352af20e167 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -19,6 +19,7 @@ enum oe_flush {
 	OE_FLUSH__ROUND,
 	OE_FLUSH__HALF,
 	OE_FLUSH__TOP,
+	OE_FLUSH__TIME,
 };
 
 struct ordered_events;
@@ -55,6 +56,7 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 			  u64 timestamp, u64 file_offset);
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event);
 int ordered_events__flush(struct ordered_events *oe, enum oe_flush how);
+int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp);
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
-- 
2.19.2
