From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 71/85] perf intel-pt: Factor out intel_pt_get_buffer()
Date: Tue, 11 Jun 2019 15:58:57 -0300
Message-ID: <20190611185911.11645-72-acme@kernel.org>
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

Factor out intel_pt_get_buffer() so it can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 60 +++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 3cff8fe2eaa0..4a61c73c9711 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -239,32 +239,13 @@ static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *
 	return 0;
 }
 
-/* This function assumes data is processed sequentially only */
-static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
+static int intel_pt_get_buffer(struct intel_pt_queue *ptq,
+			       struct auxtrace_buffer *buffer,
+			       struct auxtrace_buffer *old_buffer,
+			       struct intel_pt_buffer *b)
 {
-	struct intel_pt_queue *ptq = data;
-	struct auxtrace_buffer *buffer = ptq->buffer;
-	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
-	struct auxtrace_queue *queue;
 	bool might_overlap;
 
-	if (ptq->stop) {
-		b->len = 0;
-		return 0;
-	}
-
-	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
-
-	buffer = auxtrace_buffer__next(queue, buffer);
-	if (!buffer) {
-		if (old_buffer)
-			auxtrace_buffer__drop_data(old_buffer);
-		b->len = 0;
-		return 0;
-	}
-
-	ptq->buffer = buffer;
-
 	if (!buffer->data) {
 		int fd = perf_data__fd(ptq->pt->session->data);
 
@@ -294,6 +275,39 @@ static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
 		b->consecutive = true;
 	}
 
+	return 0;
+}
+
+/* This function assumes data is processed sequentially only */
+static int intel_pt_get_trace(struct intel_pt_buffer *b, void *data)
+{
+	struct intel_pt_queue *ptq = data;
+	struct auxtrace_buffer *buffer = ptq->buffer;
+	struct auxtrace_buffer *old_buffer = ptq->old_buffer;
+	struct auxtrace_queue *queue;
+	int err;
+
+	if (ptq->stop) {
+		b->len = 0;
+		return 0;
+	}
+
+	queue = &ptq->pt->queues.queue_array[ptq->queue_nr];
+
+	buffer = auxtrace_buffer__next(queue, buffer);
+	if (!buffer) {
+		if (old_buffer)
+			auxtrace_buffer__drop_data(old_buffer);
+		b->len = 0;
+		return 0;
+	}
+
+	ptq->buffer = buffer;
+
+	err = intel_pt_get_buffer(ptq, buffer, old_buffer, b);
+	if (err)
+		return err;
+
 	if (ptq->step_through_buffers)
 		ptq->stop = true;
 
-- 
2.20.1
