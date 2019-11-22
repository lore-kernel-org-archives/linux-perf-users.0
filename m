From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/26] perf auxtrace: Add support for queuing AUX area samples
Date: Fri, 22 Nov 2019 11:57:03 -0300
Message-ID: <20191122145711.3171-19-acme@kernel.org>
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

Add functions to queue AUX area samples in advance
(auxtrace_queue_data()) or individually (auxtrace_queues__add_sample())
or find out what queue a sample belongs on
(auxtrace_queues__sample_queue()).

auxtrace_queue_data() can also queue snapshot data which keeps snapshots
and samples ordered with respect to each other in case support for that
is desired.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 107 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  15 ++++++
 2 files changed, 122 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 4f5c5fe3516b..eb087e7df6f4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1004,6 +1004,113 @@ struct auxtrace_buffer *auxtrace_buffer__next(struct auxtrace_queue *queue,
 	}
 }
 
+struct auxtrace_queue *auxtrace_queues__sample_queue(struct auxtrace_queues *queues,
+						     struct perf_sample *sample,
+						     struct perf_session *session)
+{
+	struct perf_sample_id *sid;
+	unsigned int idx;
+	u64 id;
+
+	id = sample->id;
+	if (!id)
+		return NULL;
+
+	sid = perf_evlist__id2sid(session->evlist, id);
+	if (!sid)
+		return NULL;
+
+	idx = sid->idx;
+
+	if (idx >= queues->nr_queues)
+		return NULL;
+
+	return &queues->queue_array[idx];
+}
+
+int auxtrace_queues__add_sample(struct auxtrace_queues *queues,
+				struct perf_session *session,
+				struct perf_sample *sample, u64 data_offset,
+				u64 reference)
+{
+	struct auxtrace_buffer buffer = {
+		.pid = -1,
+		.data_offset = data_offset,
+		.reference = reference,
+		.size = sample->aux_sample.size,
+	};
+	struct perf_sample_id *sid;
+	u64 id = sample->id;
+	unsigned int idx;
+
+	if (!id)
+		return -EINVAL;
+
+	sid = perf_evlist__id2sid(session->evlist, id);
+	if (!sid)
+		return -ENOENT;
+
+	idx = sid->idx;
+	buffer.tid = sid->tid;
+	buffer.cpu = sid->cpu;
+
+	return auxtrace_queues__add_buffer(queues, session, idx, &buffer, NULL);
+}
+
+struct queue_data {
+	bool samples;
+	bool events;
+};
+
+static int auxtrace_queue_data_cb(struct perf_session *session,
+				  union perf_event *event, u64 offset,
+				  void *data)
+{
+	struct queue_data *qd = data;
+	struct perf_sample sample;
+	int err;
+
+	if (qd->events && event->header.type == PERF_RECORD_AUXTRACE) {
+		if (event->header.size < sizeof(struct perf_record_auxtrace))
+			return -EINVAL;
+		offset += event->header.size;
+		return session->auxtrace->queue_data(session, NULL, event,
+						     offset);
+	}
+
+	if (!qd->samples || event->header.type != PERF_RECORD_SAMPLE)
+		return 0;
+
+	err = perf_evlist__parse_sample(session->evlist, event, &sample);
+	if (err)
+		return err;
+
+	if (!sample.aux_sample.size)
+		return 0;
+
+	offset += sample.aux_sample.data - (void *)event;
+
+	return session->auxtrace->queue_data(session, &sample, NULL, offset);
+}
+
+int auxtrace_queue_data(struct perf_session *session, bool samples, bool events)
+{
+	struct queue_data qd = {
+		.samples = samples,
+		.events = events,
+	};
+
+	if (auxtrace__dont_decode(session))
+		return 0;
+
+	if (!session->auxtrace || !session->auxtrace->queue_data)
+		return -EINVAL;
+
+	return perf_session__peek_events(session, session->header.data_offset,
+					 session->header.data_size,
+					 auxtrace_queue_data_cb, &qd);
+}
+
 void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd)
 {
 	size_t adj = buffer->data_offset & (page_size - 1);
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 4a8ac7de6e22..749d72cd9c7b 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -141,6 +141,8 @@ struct auxtrace_index {
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
  * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
+ * @queue_data: queue an AUX sample or PERF_RECORD_AUXTRACE event for later
+ *              processing
  * @dump_auxtrace_sample: dump AUX area sample data
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
@@ -154,6 +156,9 @@ struct auxtrace {
 	int (*process_auxtrace_event)(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_tool *tool);
+	int (*queue_data)(struct perf_session *session,
+			  struct perf_sample *sample, union perf_event *event,
+			  u64 data_offset);
 	void (*dump_auxtrace_sample)(struct perf_session *session,
 				     struct perf_sample *sample);
 	int (*flush_events)(struct perf_session *session,
@@ -467,9 +472,19 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
 			       struct perf_session *session,
 			       union perf_event *event, off_t data_offset,
 			       struct auxtrace_buffer **buffer_ptr);
+struct auxtrace_queue *
+auxtrace_queues__sample_queue(struct auxtrace_queues *queues,
+			      struct perf_sample *sample,
+			      struct perf_session *session);
+int auxtrace_queues__add_sample(struct auxtrace_queues *queues,
+				struct perf_session *session,
+				struct perf_sample *sample, u64 data_offset,
+				u64 reference);
 void auxtrace_queues__free(struct auxtrace_queues *queues);
 int auxtrace_queues__process_index(struct auxtrace_queues *queues,
 				   struct perf_session *session);
+int auxtrace_queue_data(struct perf_session *session, bool samples,
+			bool events);
 struct auxtrace_buffer *auxtrace_buffer__next(struct auxtrace_queue *queue,
 					      struct auxtrace_buffer *buffer);
 void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd);
-- 
2.21.0
