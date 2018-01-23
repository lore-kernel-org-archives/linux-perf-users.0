From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 29/43] perf tools: Add initial entry point for decoder
 CoreSight traces
Date: Tue, 23 Jan 2018 10:12:37 -0300
Message-ID: <20180123131251.28197-30-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki Poulouse <suzuki.poulose@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Mike Leach <mike.leach@arm.com>, Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch adds the entry point for CoreSight trace decoding, serving as
a jumping board for furhter expansions.

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
Link: http://lkml.kernel.org/r/1516211539-5166-3-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build      |   5 ++
 tools/perf/util/auxtrace.c |   2 +
 tools/perf/util/cs-etm.c   | 213 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.h   |  15 ++++
 4 files changed, 235 insertions(+)
 create mode 100644 tools/perf/util/cs-etm.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4eef0c243306..c054ff802efb 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -88,6 +88,11 @@ libperf-$(CONFIG_AUXTRACE) += intel-pt.o
 libperf-$(CONFIG_AUXTRACE) += intel-bts.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe.o
 libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+
+ifdef CONFIG_LIBOPENCSD
+libperf-$(CONFIG_AUXTRACE) += cs-etm.o
+endif
+
 libperf-y += parse-branch-options.o
 libperf-y += dump-insn.o
 libperf-y += parse-regs-options.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3bba9947ab7f..9faf3b5367db 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -52,6 +52,7 @@
 #include "debug.h"
 #include <subcmd/parse-options.h>
 
+#include "cs-etm.h"
 #include "intel-pt.h"
 #include "intel-bts.h"
 #include "arm-spe.h"
@@ -914,6 +915,7 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
 	case PERF_AUXTRACE_ARM_SPE:
 		return arm_spe_process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_CS_ETM:
+		return cs_etm__process_auxtrace_info(event, session);
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
new file mode 100644
index 000000000000..f47797101857
--- /dev/null
+++ b/tools/perf/util/cs-etm.c
@@ -0,0 +1,213 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright(C) 2015-2018 Linaro Limited.
+ *
+ * Author: Tor Jeremiassen <tor@ti.com>
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ */
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/types.h>
+
+#include <stdlib.h>
+
+#include "auxtrace.h"
+#include "color.h"
+#include "cs-etm.h"
+#include "debug.h"
+#include "evlist.h"
+#include "intlist.h"
+#include "machine.h"
+#include "map.h"
+#include "perf.h"
+#include "thread.h"
+#include "thread_map.h"
+#include "thread-stack.h"
+#include "util.h"
+
+#define MAX_TIMESTAMP (~0ULL)
+
+struct cs_etm_auxtrace {
+	struct auxtrace auxtrace;
+	struct auxtrace_queues queues;
+	struct auxtrace_heap heap;
+	struct itrace_synth_opts synth_opts;
+	struct perf_session *session;
+	struct machine *machine;
+	struct thread *unknown_thread;
+
+	u8 timeless_decoding;
+	u8 snapshot_mode;
+	u8 data_queued;
+	u8 sample_branches;
+
+	int num_cpu;
+	u32 auxtrace_type;
+	u64 branches_sample_type;
+	u64 branches_id;
+	u64 **metadata;
+	u64 kernel_start;
+	unsigned int pmu_type;
+};
+
+struct cs_etm_queue {
+	struct cs_etm_auxtrace *etm;
+	struct thread *thread;
+	struct cs_etm_decoder *decoder;
+	struct auxtrace_buffer *buffer;
+	const struct cs_etm_state *state;
+	union perf_event *event_buf;
+	unsigned int queue_nr;
+	pid_t pid, tid;
+	int cpu;
+	u64 time;
+	u64 timestamp;
+	u64 offset;
+};
+
+static int cs_etm__flush_events(struct perf_session *session,
+				struct perf_tool *tool)
+{
+	(void) session;
+	(void) tool;
+	return 0;
+}
+
+static void cs_etm__free_queue(void *priv)
+{
+	struct cs_etm_queue *etmq = priv;
+
+	free(etmq);
+}
+
+static void cs_etm__free_events(struct perf_session *session)
+{
+	unsigned int i;
+	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+	struct auxtrace_queues *queues = &aux->queues;
+
+	for (i = 0; i < queues->nr_queues; i++) {
+		cs_etm__free_queue(queues->queue_array[i].priv);
+		queues->queue_array[i].priv = NULL;
+	}
+
+	auxtrace_queues__free(queues);
+}
+
+static void cs_etm__free(struct perf_session *session)
+{
+	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+	cs_etm__free_events(session);
+	session->auxtrace = NULL;
+
+	zfree(&aux);
+}
+
+static int cs_etm__process_event(struct perf_session *session,
+				 union perf_event *event,
+				 struct perf_sample *sample,
+				 struct perf_tool *tool)
+{
+	(void) session;
+	(void) event;
+	(void) sample;
+	(void) tool;
+	return 0;
+}
+
+static int cs_etm__process_auxtrace_event(struct perf_session *session,
+					  union perf_event *event,
+					  struct perf_tool *tool)
+{
+	(void) session;
+	(void) event;
+	(void) tool;
+	return 0;
+}
+
+static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
+{
+	struct perf_evsel *evsel;
+	struct perf_evlist *evlist = etm->session->evlist;
+	bool timeless_decoding = true;
+
+	/*
+	 * Circle through the list of event and complain if we find one
+	 * with the time bit set.
+	 */
+	evlist__for_each_entry(evlist, evsel) {
+		if ((evsel->attr.sample_type & PERF_SAMPLE_TIME))
+			timeless_decoding = false;
+	}
+
+	return timeless_decoding;
+}
+
+int cs_etm__process_auxtrace_info(union perf_event *event,
+				  struct perf_session *session)
+{
+	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
+	struct cs_etm_auxtrace *etm = NULL;
+	int event_header_size = sizeof(struct perf_event_header);
+	int info_header_size;
+	int total_size = auxtrace_info->header.size;
+	int err = 0;
+
+	/*
+	 * sizeof(auxtrace_info_event::type) +
+	 * sizeof(auxtrace_info_event::reserved) == 8
+	 */
+	info_header_size = 8;
+
+	if (total_size < (event_header_size + info_header_size))
+		return -EINVAL;
+
+	etm = zalloc(sizeof(*etm));
+
+	if (!etm)
+		err = -ENOMEM;
+
+	err = auxtrace_queues__init(&etm->queues);
+	if (err)
+		goto err_free_etm;
+
+	etm->session = session;
+	etm->machine = &session->machines.host;
+
+	etm->auxtrace_type = auxtrace_info->type;
+	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
+
+	etm->auxtrace.process_event = cs_etm__process_event;
+	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
+	etm->auxtrace.flush_events = cs_etm__flush_events;
+	etm->auxtrace.free_events = cs_etm__free_events;
+	etm->auxtrace.free = cs_etm__free;
+	session->auxtrace = &etm->auxtrace;
+
+	if (dump_trace)
+		return 0;
+
+	err = auxtrace_queues__process_index(&etm->queues, session);
+	if (err)
+		goto err_free_queues;
+
+	etm->data_queued = etm->queues.populated;
+
+	return 0;
+
+err_free_queues:
+	auxtrace_queues__free(&etm->queues);
+	session->auxtrace = NULL;
+err_free_etm:
+	zfree(&etm);
+
+	return -EINVAL;
+}
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 3cc6bc3263fe..5ab6a8ef1b32 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -18,6 +18,9 @@
 #ifndef INCLUDE__UTIL_PERF_CS_ETM_H__
 #define INCLUDE__UTIL_PERF_CS_ETM_H__
 
+#include "util/event.h"
+#include "util/session.h"
+
 /* Versionning header in case things need tro change in the future.  That way
  * decoding of old snapshot is still possible.
  */
@@ -71,4 +74,16 @@ static const u64 __perf_cs_etmv4_magic   = 0x4040404040404040ULL;
 #define CS_ETMV3_PRIV_SIZE (CS_ETM_PRIV_MAX * sizeof(u64))
 #define CS_ETMV4_PRIV_SIZE (CS_ETMV4_PRIV_MAX * sizeof(u64))
 
+#ifdef HAVE_CSTRACE_SUPPORT
+int cs_etm__process_auxtrace_info(union perf_event *event,
+				  struct perf_session *session);
+#else
+static inline int
+cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
+			      struct perf_session *session __maybe_unused)
+{
+	return -1;
+}
+#endif
+
 #endif
-- 
2.14.3
