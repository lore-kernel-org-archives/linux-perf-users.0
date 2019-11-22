From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/26] perf session: Add facility to peek at all events
Date: Fri, 22 Nov 2019 11:57:02 -0300
Message-ID: <20191122145711.3171-18-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

AUX area samples are not limited in how far back in time the sample
could start. Consequently samples must be queued in advance to allow for
time-ordered processing. To achieve that, add
perf_session__peek_events() that walks and peeks at all the events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/session.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ab4dae1efea3..d0d7d25b23e3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1659,6 +1659,34 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 	return 0;
 }
 
+int perf_session__peek_events(struct perf_session *session, u64 offset,
+			      u64 size, peek_events_cb_t cb, void *data)
+{
+	u64 max_offset = offset + size;
+	char buf[PERF_SAMPLE_MAX_SIZE];
+	union perf_event *event;
+	int err;
+
+	do {
+		err = perf_session__peek_event(session, offset, buf,
+					       PERF_SAMPLE_MAX_SIZE, &event,
+					       NULL);
+		if (err)
+			return err;
+
+		err = cb(session, event, offset, data);
+		if (err)
+			return err;
+
+		offset += event->header.size;
+		if (event->header.type == PERF_RECORD_AUXTRACE)
+			offset += event->auxtrace.size;
+
+	} while (offset < max_offset);
+
+	return err;
+}
+
 static s64 perf_session__process_event(struct perf_session *session,
 				       union perf_event *event, u64 file_offset)
 {
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 8456e1d868fd..f76480166d38 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -64,6 +64,11 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 			     void *buf, size_t buf_sz,
 			     union perf_event **event_ptr,
 			     struct perf_sample *sample);
+typedef int (*peek_events_cb_t)(struct perf_session *session,
+				union perf_event *event, u64 offset,
+				void *data);
+int perf_session__peek_events(struct perf_session *session, u64 offset,
+			      u64 size, peek_events_cb_t cb, void *data);
 
 int perf_session__process_events(struct perf_session *session);
 
-- 
2.21.0
