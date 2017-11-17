From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 77/83] perf ordered_events: Pass timestamp arg in perf_session__queue_event
Date: Fri, 17 Nov 2017 17:15:55 -0300
Message-ID: <20171117201601.24110-78-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161784AbdKQUU0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:20:26 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

There's no need to pass whole sample data, because it's only timestamp
that is used.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-xd1hpoze3kgb1rb639o3vehb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c         | 2 +-
 tools/perf/util/ordered-events.c | 3 +--
 tools/perf/util/ordered-events.h | 2 +-
 tools/perf/util/session.c        | 6 +++---
 tools/perf/util/session.h        | 2 +-
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 0c36f2ac6a0e..cd253db6917f 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -754,7 +754,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 			return -1;
 		}
 
-		err = perf_session__queue_event(kvm->session, event, &sample, 0);
+		err = perf_session__queue_event(kvm->session, event, sample.time, 0);
 		/*
 		 * FIXME: Here we can't consume the event, as perf_session__queue_event will
 		 *        point to it, and it'll get possibly overwritten by the kernel.
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 8e09fd2d842f..bad9e0296e9a 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -157,9 +157,8 @@ void ordered_events__delete(struct ordered_events *oe, struct ordered_event *eve
 }
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
-			  struct perf_sample *sample, u64 file_offset)
+			  u64 timestamp, u64 file_offset)
 {
-	u64 timestamp = sample->time;
 	struct ordered_event *oevent;
 
 	if (!timestamp || timestamp == ~0ULL)
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 96e5292d88e2..8c7a2948593e 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -45,7 +45,7 @@ struct ordered_events {
 };
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
-			  struct perf_sample *sample, u64 file_offset);
+			  u64 timestamp, u64 file_offset);
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event);
 int ordered_events__flush(struct ordered_events *oe, enum oe_flush how);
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5c412310f266..8976e417eab2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -873,9 +873,9 @@ static int process_finished_round(struct perf_tool *tool __maybe_unused,
 }
 
 int perf_session__queue_event(struct perf_session *s, union perf_event *event,
-			      struct perf_sample *sample, u64 file_offset)
+			      u64 timestamp, u64 file_offset)
 {
-	return ordered_events__queue(&s->ordered_events, event, sample, file_offset);
+	return ordered_events__queue(&s->ordered_events, event, timestamp, file_offset);
 }
 
 static void callchain__lbr_callstack_printf(struct perf_sample *sample)
@@ -1517,7 +1517,7 @@ static s64 perf_session__process_event(struct perf_session *session,
 		return ret;
 
 	if (tool->ordered_events) {
-		ret = perf_session__queue_event(session, event, &sample, file_offset);
+		ret = perf_session__queue_event(session, event, sample.time, file_offset);
 		if (ret != -ETIME)
 			return ret;
 	}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 80bc80de8362..5b1c32b3694a 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -53,7 +53,7 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 int perf_session__process_events(struct perf_session *session);
 
 int perf_session__queue_event(struct perf_session *s, union perf_event *event,
-			      struct perf_sample *sample, u64 file_offset);
+			      u64 timestamp, u64 file_offset);
 
 void perf_tool__fill_defaults(struct perf_tool *tool);
 
-- 
2.13.6
