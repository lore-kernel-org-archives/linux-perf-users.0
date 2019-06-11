From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 72/85] perf intel-pt: Add support for lookahead
Date: Tue, 11 Jun 2019 15:58:58 -0300
Message-ID: <20190611185911.11645-73-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Implement the lookahead callback to let the decoder access subsequent
buffers. intel_pt_lookahead() manages the buffer lifetime and calls the
decoder for each buffer until the decoder returns a non-zero value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 59 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4a61c73c9711..3e3a01318b76 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -278,7 +278,63 @@ static int intel_pt_get_buffer(struct intel_pt_queue *ptq,
 	return 0;
 }
 
-/* This function assumes data is processed sequentially only */
+/* Do not drop buffers with references - refer intel_pt_get_trace() */
+static void intel_pt_lookahead_drop_buffer(struct intel_pt_queue *ptq,
+					   struct auxtrace_buffer *buffer)
+{
+	if (!buffer || buffer == ptq->buffer || buffer == ptq->old_buffer)
+		return;
+
+	auxtrace_buffer__drop_data(buffer);
+}
+
+/* Must be serialized with respect to intel_pt_get_trace() */
+static int intel_pt_lookahead(void *data, intel_pt_lookahead_cb_t cb,
+			      void *cb_data)
+{
+	struct intel_pt_queue *ptq = data;
+	struct auxtrace_buffer *buffer = ptq->buffer;
+	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
+	struct auxtrace_queue *queue;
+	int err = 0;
+
+	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
+
+	while (1) {
+		struct intel_pt_buffer b = { .len = 0 };
+
+		buffer = auxtrace_buffer__next(queue, buffer);
+		if (!buffer)
+			break;
+
+		err = intel_pt_get_buffer(ptq, buffer, old_buffer, &b);
+		if (err)
+			break;
+
+		if (b.len) {
+			intel_pt_lookahead_drop_buffer(ptq, old_buffer);
+			old_buffer = buffer;
+		} else {
+			intel_pt_lookahead_drop_buffer(ptq, buffer);
+			continue;
+		}
+
+		err = cb(&b, cb_data);
+		if (err)
+			break;
+	}
+
+	if (buffer != old_buffer)
+		intel_pt_lookahead_drop_buffer(ptq, buffer);
+	intel_pt_lookahead_drop_buffer(ptq, old_buffer);
+
+	return err;
+}
+
+/*
+ * This function assumes data is processed sequentially only.
+ * Must be serialized with respect to intel_pt_lookahead()
+ */
 static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 {
 	struct intel_pt_queue *ptq = data;
@@ -827,6 +883,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 
 	params.get_trace = intel_pt_get_trace;
 	params.walk_insn = intel_pt_walk_next_insn;
+	params.lookahead = intel_pt_lookahead;
 	params.data = ptq;
 	params.return_compression = intel_pt_return_compression(pt);
 	params.branch_enable = intel_pt_branch_enable(pt);
-- 
2.20.1
