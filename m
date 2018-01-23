From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/43] perf tools: Add full support for CoreSight trace decoding
Date: Tue, 23 Jan 2018 10:12:43 -0300
Message-ID: <20180123131251.28197-36-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kim Phillips <kim.phillips@arm.com>, Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch adds support for complete packet decoding, allowing traces
collected during a trace session to be decoder from the "report"
infrastructure.

Co-authored-by: Tor Jeremiassen <tor@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1516211539-5166-9-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 166 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 160 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 83eb676274b5..407095af1456 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -70,6 +70,10 @@ struct cs_etm_queue {
 	u64 offset;
 };
 
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
+static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
+					   pid_t tid, u64 time_);
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -145,9 +149,25 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 static int cs_etm__flush_events(struct perf_session *session,
 				struct perf_tool *tool)
 {
-	(void) session;
-	(void) tool;
-	return 0;
+	int ret;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+	if (dump_trace)
+		return 0;
+
+	if (!tool->ordered_events)
+		return -EINVAL;
+
+	if (!etm->timeless_decoding)
+		return -EINVAL;
+
+	ret = cs_etm__update_queues(etm);
+
+	if (ret < 0)
+		return ret;
+
+	return cs_etm__process_timeless_queues(etm, -1, MAX_TIMESTAMP - 1);
 }
 
 static void cs_etm__free_queue(void *priv)
@@ -369,6 +389,138 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
 	return 0;
 }
 
+static int
+cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
+{
+	struct auxtrace_buffer *aux_buffer = etmq->buffer;
+	struct auxtrace_buffer *old_buffer = aux_buffer;
+	struct auxtrace_queue *queue;
+
+	queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
+
+	aux_buffer = auxtrace_buffer__next(queue, aux_buffer);
+
+	/* If no more data, drop the previous auxtrace_buffer and return */
+	if (!aux_buffer) {
+		if (old_buffer)
+			auxtrace_buffer__drop_data(old_buffer);
+		buff->len = 0;
+		return 0;
+	}
+
+	etmq->buffer = aux_buffer;
+
+	/* If the aux_buffer doesn't have data associated, try to load it */
+	if (!aux_buffer->data) {
+		/* get the file desc associated with the perf data file */
+		int fd = perf_data__fd(etmq->etm->session->data);
+
+		aux_buffer->data = auxtrace_buffer__get_data(aux_buffer, fd);
+		if (!aux_buffer->data)
+			return -ENOMEM;
+	}
+
+	/* If valid, drop the previous buffer */
+	if (old_buffer)
+		auxtrace_buffer__drop_data(old_buffer);
+
+	buff->offset = aux_buffer->offset;
+	buff->len = aux_buffer->size;
+	buff->buf = aux_buffer->data;
+
+	buff->ref_timestamp = aux_buffer->reference;
+
+	return buff->len;
+}
+
+static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
+				     struct auxtrace_queue *queue)
+{
+	struct cs_etm_queue *etmq = queue->priv;
+
+	/* CPU-wide tracing isn't supported yet */
+	if (queue->tid == -1)
+		return;
+
+	if ((!etmq->thread) && (etmq->tid != -1))
+		etmq->thread = machine__find_thread(etm->machine, -1,
+						    etmq->tid);
+
+	if (etmq->thread) {
+		etmq->pid = etmq->thread->pid_;
+		if (queue->cpu == -1)
+			etmq->cpu = etmq->thread->cpu;
+	}
+}
+
+static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct cs_etm_buffer buffer;
+	size_t buffer_used, processed;
+	int err = 0;
+
+	if (!etm->kernel_start)
+		etm->kernel_start = machine__kernel_start(etm->machine);
+
+	/* Go through each buffer in the queue and decode them one by one */
+more:
+	buffer_used = 0;
+	memset(&buffer, 0, sizeof(buffer));
+	err = cs_etm__get_trace(&buffer, etmq);
+	if (err <= 0)
+		return err;
+	/*
+	 * We cannot assume consecutive blocks in the data file are contiguous,
+	 * reset the decoder to force re-sync.
+	 */
+	err = cs_etm_decoder__reset(etmq->decoder);
+	if (err != 0)
+		return err;
+
+	/* Run trace decoder until buffer consumed or end of trace */
+	do {
+		processed = 0;
+
+		err = cs_etm_decoder__process_data_block(
+						etmq->decoder,
+						etmq->offset,
+						&buffer.buf[buffer_used],
+						buffer.len - buffer_used,
+						&processed);
+
+		if (err)
+			return err;
+
+		etmq->offset += processed;
+		buffer_used += processed;
+	} while (buffer.len > buffer_used);
+
+goto more;
+
+	return err;
+}
+
+static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
+					   pid_t tid, u64 time_)
+{
+	unsigned int i;
+	struct auxtrace_queues *queues = &etm->queues;
+
+	for (i = 0; i < queues->nr_queues; i++) {
+		struct auxtrace_queue *queue = &etm->queues.queue_array[i];
+		struct cs_etm_queue *etmq = queue->priv;
+
+		if (etmq && ((tid == -1) || (etmq->tid == tid))) {
+			etmq->time = time_;
+			cs_etm__set_pid_tid_cpu(etm, queue);
+			cs_etm__run_decoder(etmq);
+		}
+	}
+
+	return 0;
+}
+
 static int cs_etm__process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -380,9 +532,6 @@ static int cs_etm__process_event(struct perf_session *session,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 
-	/* Keep compiler happy */
-	(void)event;
-
 	if (dump_trace)
 		return 0;
 
@@ -405,6 +554,11 @@ static int cs_etm__process_event(struct perf_session *session,
 			return err;
 	}
 
+	if (event->header.type == PERF_RECORD_EXIT)
+		return cs_etm__process_timeless_queues(etm,
+						       event->fork.tid,
+						       sample->time);
+
 	return 0;
 }
 
-- 
2.14.3
