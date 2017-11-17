From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 78/83] perf tools: Optimize sample parsing for ordered events
Date: Fri, 17 Nov 2017 17:15:56 -0300
Message-ID: <20171117201601.24110-79-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161793AbdKQUU3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:20:29 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Currently when using ordered events we parse the sample twice (the
perf_evlist__parse_sample function). Once before we queue the sample for
sorting:

  perf_session__process_event
    perf_evlist__parse_sample(sample)
    perf_session__queue_event(sample.time)

And then when we deliver the sorted sample:

  ordered_events__deliver_event
    perf_evlist__parse_sample
    perf_session__deliver_event

We can skip the initial full sample parsing by using
perf_evlist__parse_sample_timestamp function, which got introduced
earlier. The new path looks like:

  perf_session__process_event
    perf_evlist__parse_sample_timestamp
    perf_session__queue_event

  ordered_events__deliver_event
    perf_session__deliver_event
      perf_evlist__parse_sample

It saves some instructions and is slightly faster:

Before:
 Performance counter stats for './perf.old report --stdio' (5 runs):

    64,396,007,225      cycles:u                                                      ( +-  0.97% )
   105,882,112,735      instructions:u            #    1.64  insn per cycle           ( +-  0.00% )

      21.618103465 seconds time elapsed                                          ( +-  1.12% )

After:
 Performance counter stats for './perf report --stdio' (5 runs):

    60,567,807,182      cycles:u                                                      ( +-  0.40% )
   104,853,333,514      instructions:u            #    1.73  insn per cycle           ( +-  0.00% )

      20.168895243 seconds time elapsed                                          ( +-  0.32% )

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-cjp2tuk0qkjs9dxzlpmm34ua@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c  |  8 ++++----
 tools/perf/util/session.c | 41 ++++++++++++++++++-----------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index cd253db6917f..597c7de9bec9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -741,20 +741,20 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 				   u64 *mmap_time)
 {
 	union perf_event *event;
-	struct perf_sample sample;
+	u64 timestamp;
 	s64 n = 0;
 	int err;
 
 	*mmap_time = ULLONG_MAX;
 	while ((event = perf_evlist__mmap_read(kvm->evlist, idx)) != NULL) {
-		err = perf_evlist__parse_sample(kvm->evlist, event, &sample);
+		err = perf_evlist__parse_sample_timestamp(kvm->evlist, event, &timestamp);
 		if (err) {
 			perf_evlist__mmap_consume(kvm->evlist, idx);
 			pr_err("Failed to parse sample\n");
 			return -1;
 		}
 
-		err = perf_session__queue_event(kvm->session, event, sample.time, 0);
+		err = perf_session__queue_event(kvm->session, event, timestamp, 0);
 		/*
 		 * FIXME: Here we can't consume the event, as perf_session__queue_event will
 		 *        point to it, and it'll get possibly overwritten by the kernel.
@@ -768,7 +768,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 
 		/* save time stamp of our first sample for this mmap */
 		if (n == 0)
-			*mmap_time = sample.time;
+			*mmap_time = timestamp;
 
 		/* limit events per mmap handled all at once */
 		n++;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 8976e417eab2..df2857137908 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -27,7 +27,6 @@
 
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
-				       struct perf_sample *sample,
 				       struct perf_tool *tool,
 				       u64 file_offset);
 
@@ -107,17 +106,10 @@ static void perf_session__set_comm_exec(struct perf_session *session)
 static int ordered_events__deliver_event(struct ordered_events *oe,
 					 struct ordered_event *event)
 {
-	struct perf_sample sample;
 	struct perf_session *session = container_of(oe, struct perf_session,
 						    ordered_events);
-	int ret = perf_evlist__parse_sample(session->evlist, event->event, &sample);
-
-	if (ret) {
-		pr_err("Can't parse sample, err = %d\n", ret);
-		return ret;
-	}
 
-	return perf_session__deliver_event(session, event->event, &sample,
+	return perf_session__deliver_event(session, event->event,
 					   session->tool, event->file_offset);
 }
 
@@ -1328,20 +1320,26 @@ static int machines__deliver_event(struct machines *machines,
 
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
-				       struct perf_sample *sample,
 				       struct perf_tool *tool,
 				       u64 file_offset)
 {
+	struct perf_sample sample;
 	int ret;
 
-	ret = auxtrace__process_event(session, event, sample, tool);
+	ret = perf_evlist__parse_sample(session->evlist, event, &sample);
+	if (ret) {
+		pr_err("Can't parse sample, err = %d\n", ret);
+		return ret;
+	}
+
+	ret = auxtrace__process_event(session, event, &sample, tool);
 	if (ret < 0)
 		return ret;
 	if (ret > 0)
 		return 0;
 
 	return machines__deliver_event(&session->machines, session->evlist,
-				       event, sample, tool, file_offset);
+				       event, &sample, tool, file_offset);
 }
 
 static s64 perf_session__process_user_event(struct perf_session *session,
@@ -1495,7 +1493,6 @@ static s64 perf_session__process_event(struct perf_session *session,
 {
 	struct perf_evlist *evlist = session->evlist;
 	struct perf_tool *tool = session->tool;
-	struct perf_sample sample;
 	int ret;
 
 	if (session->header.needs_swap)
@@ -1509,21 +1506,19 @@ static s64 perf_session__process_event(struct perf_session *session,
 	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
 		return perf_session__process_user_event(session, event, file_offset);
 
-	/*
-	 * For all kernel events we get the sample data
-	 */
-	ret = perf_evlist__parse_sample(evlist, event, &sample);
-	if (ret)
-		return ret;
-
 	if (tool->ordered_events) {
-		ret = perf_session__queue_event(session, event, sample.time, file_offset);
+		u64 timestamp;
+
+		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
+		if (ret)
+			return ret;
+
+		ret = perf_session__queue_event(session, event, timestamp, file_offset);
 		if (ret != -ETIME)
 			return ret;
 	}
 
-	return perf_session__deliver_event(session, event, &sample, tool,
-					   file_offset);
+	return perf_session__deliver_event(session, event, tool, file_offset);
 }
 
 void perf_event_header__bswap(struct perf_event_header *hdr)
-- 
2.13.6
