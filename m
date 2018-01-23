From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/43] perf tools: Add decoder mechanic to support dumping
 trace data
Date: Tue, 23 Jan 2018 10:12:39 -0300
Message-ID: <20180123131251.28197-32-acme@kernel.org>
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

This patch adds the required interface to the openCSD library to support
dumping CoreSight trace packet using the "report --dump" command.  The
information conveyed is related to the type of packets gathered by a
trace session rather than full decoding.

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
Link: http://lkml.kernel.org/r/1516211539-5166-5-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build                           |   1 +
 tools/perf/util/cs-etm-decoder/Build            |   1 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 334 ++++++++++++++++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  96 +++++++
 tools/perf/util/cs-etm.c                        | 108 +++++++-
 5 files changed, 536 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-decoder/Build
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
 create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c054ff802efb..ea0a452550b0 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -91,6 +91,7 @@ libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
 
 ifdef CONFIG_LIBOPENCSD
 libperf-$(CONFIG_AUXTRACE) += cs-etm.o
+libperf-$(CONFIG_AUXTRACE) += cs-etm-decoder/
 endif
 
 libperf-y += parse-branch-options.o
diff --git a/tools/perf/util/cs-etm-decoder/Build b/tools/perf/util/cs-etm-decoder/Build
new file mode 100644
index 000000000000..bc22c39c727f
--- /dev/null
+++ b/tools/perf/util/cs-etm-decoder/Build
@@ -0,0 +1 @@
+libperf-$(CONFIG_AUXTRACE) += cs-etm-decoder.o
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
new file mode 100644
index 000000000000..6a4c86b1431f
--- /dev/null
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -0,0 +1,334 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright(C) 2015-2018 Linaro Limited.
+ *
+ * Author: Tor Jeremiassen <tor@ti.com>
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <linux/list.h>
+#include <stdlib.h>
+#include <opencsd/c_api/opencsd_c_api.h>
+#include <opencsd/etmv4/trc_pkt_types_etmv4.h>
+#include <opencsd/ocsd_if_types.h>
+
+#include "cs-etm.h"
+#include "cs-etm-decoder.h"
+#include "intlist.h"
+#include "util.h"
+
+#define MAX_BUFFER 1024
+
+/* use raw logging */
+#ifdef CS_DEBUG_RAW
+#define CS_LOG_RAW_FRAMES
+#ifdef CS_RAW_PACKED
+#define CS_RAW_DEBUG_FLAGS (OCSD_DFRMTR_UNPACKED_RAW_OUT | \
+			    OCSD_DFRMTR_PACKED_RAW_OUT)
+#else
+#define CS_RAW_DEBUG_FLAGS (OCSD_DFRMTR_UNPACKED_RAW_OUT)
+#endif
+#endif
+
+struct cs_etm_decoder {
+	void *data;
+	void (*packet_printer)(const char *msg);
+	bool trace_on;
+	dcd_tree_handle_t dcd_tree;
+	cs_etm_mem_cb_type mem_access;
+	ocsd_datapath_resp_t prev_return;
+	u32 packet_count;
+	u32 head;
+	u32 tail;
+	struct cs_etm_packet packet_buffer[MAX_BUFFER];
+};
+
+static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
+					     ocsd_etmv4_cfg *config)
+{
+	config->reg_configr = params->etmv4.reg_configr;
+	config->reg_traceidr = params->etmv4.reg_traceidr;
+	config->reg_idr0 = params->etmv4.reg_idr0;
+	config->reg_idr1 = params->etmv4.reg_idr1;
+	config->reg_idr2 = params->etmv4.reg_idr2;
+	config->reg_idr8 = params->etmv4.reg_idr8;
+	config->reg_idr9 = 0;
+	config->reg_idr10 = 0;
+	config->reg_idr11 = 0;
+	config->reg_idr12 = 0;
+	config->reg_idr13 = 0;
+	config->arch_ver = ARCH_V8;
+	config->core_prof = profile_CortexA;
+}
+
+static void cs_etm_decoder__print_str_cb(const void *p_context,
+					 const char *msg,
+					 const int str_len)
+{
+	if (p_context && str_len)
+		((struct cs_etm_decoder *)p_context)->packet_printer(msg);
+}
+
+static int
+cs_etm_decoder__init_def_logger_printing(struct cs_etm_decoder_params *d_params,
+					 struct cs_etm_decoder *decoder)
+{
+	int ret = 0;
+
+	if (d_params->packet_printer == NULL)
+		return -1;
+
+	decoder->packet_printer = d_params->packet_printer;
+
+	/*
+	 * Set up a library default logger to process any printers
+	 * (packet/raw frame) we add later.
+	 */
+	ret = ocsd_def_errlog_init(OCSD_ERR_SEV_ERROR, 1);
+	if (ret != 0)
+		return -1;
+
+	/* no stdout / err / file output */
+	ret = ocsd_def_errlog_config_output(C_API_MSGLOGOUT_FLG_NONE, NULL);
+	if (ret != 0)
+		return -1;
+
+	/*
+	 * Set the string CB for the default logger, passes strings to
+	 * perf print logger.
+	 */
+	ret = ocsd_def_errlog_set_strprint_cb(decoder->dcd_tree,
+					      (void *)decoder,
+					      cs_etm_decoder__print_str_cb);
+	if (ret != 0)
+		ret = -1;
+
+	return 0;
+}
+
+#ifdef CS_LOG_RAW_FRAMES
+static void
+cs_etm_decoder__init_raw_frame_logging(struct cs_etm_decoder_params *d_params,
+				       struct cs_etm_decoder *decoder)
+{
+	/* Only log these during a --dump operation */
+	if (d_params->operation == CS_ETM_OPERATION_PRINT) {
+		/* set up a library default logger to process the
+		 *  raw frame printer we add later
+		 */
+		ocsd_def_errlog_init(OCSD_ERR_SEV_ERROR, 1);
+
+		/* no stdout / err / file output */
+		ocsd_def_errlog_config_output(C_API_MSGLOGOUT_FLG_NONE, NULL);
+
+		/* set the string CB for the default logger,
+		 * passes strings to perf print logger.
+		 */
+		ocsd_def_errlog_set_strprint_cb(decoder->dcd_tree,
+						(void *)decoder,
+						cs_etm_decoder__print_str_cb);
+
+		/* use the built in library printer for the raw frames */
+		ocsd_dt_set_raw_frame_printer(decoder->dcd_tree,
+					      CS_RAW_DEBUG_FLAGS);
+	}
+}
+#else
+static void
+cs_etm_decoder__init_raw_frame_logging(
+		struct cs_etm_decoder_params *d_params __maybe_unused,
+		struct cs_etm_decoder *decoder __maybe_unused)
+{
+}
+#endif
+
+static int cs_etm_decoder__create_packet_printer(struct cs_etm_decoder *decoder,
+						 const char *decoder_name,
+						 void *trace_config)
+{
+	u8 csid;
+
+	if (ocsd_dt_create_decoder(decoder->dcd_tree, decoder_name,
+				   OCSD_CREATE_FLG_PACKET_PROC,
+				   trace_config, &csid))
+		return -1;
+
+	if (ocsd_dt_set_pkt_protocol_printer(decoder->dcd_tree, csid, 0))
+		return -1;
+
+	return 0;
+}
+
+static int
+cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_decoder *decoder)
+{
+	const char *decoder_name;
+	ocsd_etmv4_cfg trace_config_etmv4;
+	void *trace_config;
+
+	switch (t_params->protocol) {
+	case CS_ETM_PROTO_ETMV4i:
+		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
+		decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
+		trace_config = &trace_config_etmv4;
+		break;
+	default:
+		return -1;
+	}
+
+	return cs_etm_decoder__create_packet_printer(decoder,
+						     decoder_name,
+						     trace_config);
+}
+
+static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
+{
+	int i;
+
+	decoder->head = 0;
+	decoder->tail = 0;
+	decoder->packet_count = 0;
+	for (i = 0; i < MAX_BUFFER; i++) {
+		decoder->packet_buffer[i].start_addr = 0xdeadbeefdeadbeefUL;
+		decoder->packet_buffer[i].end_addr   = 0xdeadbeefdeadbeefUL;
+		decoder->packet_buffer[i].exc	     = false;
+		decoder->packet_buffer[i].exc_ret    = false;
+		decoder->packet_buffer[i].cpu	     = INT_MIN;
+	}
+}
+
+static int
+cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
+				   struct cs_etm_trace_params *t_params,
+				   struct cs_etm_decoder *decoder)
+{
+	if (d_params->operation == CS_ETM_OPERATION_PRINT)
+		return cs_etm_decoder__create_etm_packet_printer(t_params,
+								 decoder);
+	return -1;
+}
+
+struct cs_etm_decoder *
+cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
+		    struct cs_etm_trace_params t_params[])
+{
+	struct cs_etm_decoder *decoder;
+	ocsd_dcd_tree_src_t format;
+	u32 flags;
+	int i, ret;
+
+	if ((!t_params) || (!d_params))
+		return NULL;
+
+	decoder = zalloc(sizeof(*decoder));
+
+	if (!decoder)
+		return NULL;
+
+	decoder->data = d_params->data;
+	decoder->prev_return = OCSD_RESP_CONT;
+	cs_etm_decoder__clear_buffer(decoder);
+	format = (d_params->formatted ? OCSD_TRC_SRC_FRAME_FORMATTED :
+					 OCSD_TRC_SRC_SINGLE);
+	flags = 0;
+	flags |= (d_params->fsyncs ? OCSD_DFRMTR_HAS_FSYNCS : 0);
+	flags |= (d_params->hsyncs ? OCSD_DFRMTR_HAS_HSYNCS : 0);
+	flags |= (d_params->frame_aligned ? OCSD_DFRMTR_FRAME_MEM_ALIGN : 0);
+
+	/*
+	 * Drivers may add barrier frames when used with perf, set up to
+	 * handle this. Barriers const of FSYNC packet repeated 4 times.
+	 */
+	flags |= OCSD_DFRMTR_RESET_ON_4X_FSYNC;
+
+	/* Create decode tree for the data source */
+	decoder->dcd_tree = ocsd_create_dcd_tree(format, flags);
+
+	if (decoder->dcd_tree == 0)
+		goto err_free_decoder;
+
+	/* init library print logging support */
+	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
+	if (ret != 0)
+		goto err_free_decoder_tree;
+
+	/* init raw frame logging if required */
+	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
+
+	for (i = 0; i < num_cpu; i++) {
+		ret = cs_etm_decoder__create_etm_decoder(d_params,
+							 &t_params[i],
+							 decoder);
+		if (ret != 0)
+			goto err_free_decoder_tree;
+	}
+
+	return decoder;
+
+err_free_decoder_tree:
+	ocsd_destroy_dcd_tree(decoder->dcd_tree);
+err_free_decoder:
+	free(decoder);
+	return NULL;
+}
+
+int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
+				       u64 indx, const u8 *buf,
+				       size_t len, size_t *consumed)
+{
+	int ret = 0;
+	ocsd_datapath_resp_t cur = OCSD_RESP_CONT;
+	ocsd_datapath_resp_t prev_return = decoder->prev_return;
+	size_t processed = 0;
+	u32 count;
+
+	while (processed < len) {
+		if (OCSD_DATA_RESP_IS_WAIT(prev_return)) {
+			cur = ocsd_dt_process_data(decoder->dcd_tree,
+						   OCSD_OP_FLUSH,
+						   0,
+						   0,
+						   NULL,
+						   NULL);
+		} else if (OCSD_DATA_RESP_IS_CONT(prev_return)) {
+			cur = ocsd_dt_process_data(decoder->dcd_tree,
+						   OCSD_OP_DATA,
+						   indx + processed,
+						   len - processed,
+						   &buf[processed],
+						   &count);
+			processed += count;
+		} else {
+			ret = -EINVAL;
+			break;
+		}
+
+		/*
+		 * Return to the input code if the packet buffer is full.
+		 * Flushing will get done once the packet buffer has been
+		 * processed.
+		 */
+		if (OCSD_DATA_RESP_IS_WAIT(cur))
+			break;
+
+		prev_return = cur;
+	}
+
+	decoder->prev_return = cur;
+	*consumed = processed;
+
+	return ret;
+}
+
+void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
+{
+	if (!decoder)
+		return;
+
+	ocsd_destroy_dcd_tree(decoder->dcd_tree);
+	decoder->dcd_tree = NULL;
+	free(decoder);
+}
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
new file mode 100644
index 000000000000..a1e9b0ac5965
--- /dev/null
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -0,0 +1,96 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright(C) 2015-2018 Linaro Limited.
+ *
+ * Author: Tor Jeremiassen <tor@ti.com>
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ */
+
+#ifndef INCLUDE__CS_ETM_DECODER_H__
+#define INCLUDE__CS_ETM_DECODER_H__
+
+#include <linux/types.h>
+#include <stdio.h>
+
+struct cs_etm_decoder;
+
+struct cs_etm_buffer {
+	const unsigned char *buf;
+	size_t len;
+	u64 offset;
+	u64 ref_timestamp;
+};
+
+enum cs_etm_sample_type {
+	CS_ETM_RANGE = 1 << 0,
+};
+
+struct cs_etm_packet {
+	enum cs_etm_sample_type sample_type;
+	u64 start_addr;
+	u64 end_addr;
+	u8 exc;
+	u8 exc_ret;
+	int cpu;
+};
+
+struct cs_etm_queue;
+
+typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u64,
+				  size_t, u8 *);
+
+struct cs_etmv4_trace_params {
+	u32 reg_idr0;
+	u32 reg_idr1;
+	u32 reg_idr2;
+	u32 reg_idr8;
+	u32 reg_configr;
+	u32 reg_traceidr;
+};
+
+struct cs_etm_trace_params {
+	int protocol;
+	union {
+		struct cs_etmv4_trace_params etmv4;
+	};
+};
+
+struct cs_etm_decoder_params {
+	int operation;
+	void (*packet_printer)(const char *msg);
+	cs_etm_mem_cb_type mem_acc_cb;
+	u8 formatted;
+	u8 fsyncs;
+	u8 hsyncs;
+	u8 frame_aligned;
+	void *data;
+};
+
+/*
+ * The following enums are indexed starting with 1 to align with the
+ * open source coresight trace decoder library.
+ */
+enum {
+	CS_ETM_PROTO_ETMV3 = 1,
+	CS_ETM_PROTO_ETMV4i,
+	CS_ETM_PROTO_ETMV4d,
+};
+
+enum {
+	CS_ETM_OPERATION_PRINT = 1,
+	CS_ETM_OPERATION_DECODE,
+};
+
+int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
+				       u64 indx, const u8 *buf,
+				       size_t len, size_t *consumed);
+
+struct cs_etm_decoder *
+cs_etm_decoder__new(int num_cpu,
+		    struct cs_etm_decoder_params *d_params,
+		    struct cs_etm_trace_params t_params[]);
+
+void cs_etm_decoder__free(struct cs_etm_decoder *decoder);
+
+#endif /* INCLUDE__CS_ETM_DECODER_H__ */
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 18894ee7aa0b..cad429ce3c00 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -18,6 +18,7 @@
 #include "auxtrace.h"
 #include "color.h"
 #include "cs-etm.h"
+#include "cs-etm-decoder/cs-etm-decoder.h"
 #include "debug.h"
 #include "evlist.h"
 #include "intlist.h"
@@ -69,6 +70,78 @@ struct cs_etm_queue {
 	u64 offset;
 };
 
+static void cs_etm__packet_dump(const char *pkt_string)
+{
+	const char *color = PERF_COLOR_BLUE;
+	int len = strlen(pkt_string);
+
+	if (len && (pkt_string[len-1] == '\n'))
+		color_fprintf(stdout, color, "	%s", pkt_string);
+	else
+		color_fprintf(stdout, color, "	%s\n", pkt_string);
+
+	fflush(stdout);
+}
+
+static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
+			       struct auxtrace_buffer *buffer)
+{
+	int i, ret;
+	const char *color = PERF_COLOR_BLUE;
+	struct cs_etm_decoder_params d_params;
+	struct cs_etm_trace_params *t_params;
+	struct cs_etm_decoder *decoder;
+	size_t buffer_used = 0;
+
+	fprintf(stdout, "\n");
+	color_fprintf(stdout, color,
+		     ". ... CoreSight ETM Trace data: size %zu bytes\n",
+		     buffer->size);
+
+	/* Use metadata to fill in trace parameters for trace decoder */
+	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
+	for (i = 0; i < etm->num_cpu; i++) {
+		t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
+		t_params[i].etmv4.reg_idr0 = etm->metadata[i][CS_ETMV4_TRCIDR0];
+		t_params[i].etmv4.reg_idr1 = etm->metadata[i][CS_ETMV4_TRCIDR1];
+		t_params[i].etmv4.reg_idr2 = etm->metadata[i][CS_ETMV4_TRCIDR2];
+		t_params[i].etmv4.reg_idr8 = etm->metadata[i][CS_ETMV4_TRCIDR8];
+		t_params[i].etmv4.reg_configr =
+					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
+		t_params[i].etmv4.reg_traceidr =
+					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
+	}
+
+	/* Set decoder parameters to simply print the trace packets */
+	d_params.packet_printer = cs_etm__packet_dump;
+	d_params.operation = CS_ETM_OPERATION_PRINT;
+	d_params.formatted = true;
+	d_params.fsyncs = false;
+	d_params.hsyncs = false;
+	d_params.frame_aligned = true;
+
+	decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
+
+	zfree(&t_params);
+
+	if (!decoder)
+		return;
+	do {
+		size_t consumed;
+
+		ret = cs_etm_decoder__process_data_block(
+				decoder, buffer->offset,
+				&((u8 *)buffer->data)[buffer_used],
+				buffer->size - buffer_used, &consumed);
+		if (ret)
+			break;
+
+		buffer_used += consumed;
+	} while (buffer_used < buffer->size);
+
+	cs_etm_decoder__free(decoder);
+}
+
 static int cs_etm__flush_events(struct perf_session *session,
 				struct perf_tool *tool)
 {
@@ -137,11 +210,38 @@ static int cs_etm__process_event(struct perf_session *session,
 
 static int cs_etm__process_auxtrace_event(struct perf_session *session,
 					  union perf_event *event,
-					  struct perf_tool *tool)
+					  struct perf_tool *tool __maybe_unused)
 {
-	(void) session;
-	(void) event;
-	(void) tool;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+	if (!etm->data_queued) {
+		struct auxtrace_buffer *buffer;
+		off_t  data_offset;
+		int fd = perf_data__fd(session->data);
+		bool is_pipe = perf_data__is_pipe(session->data);
+		int err;
+
+		if (is_pipe)
+			data_offset = 0;
+		else {
+			data_offset = lseek(fd, 0, SEEK_CUR);
+			if (data_offset == -1)
+				return -errno;
+		}
+
+		err = auxtrace_queues__add_event(&etm->queues, session,
+						 event, data_offset, &buffer);
+		if (err)
+			return err;
+
+		if (dump_trace)
+			if (auxtrace_buffer__get_data(buffer, fd)) {
+				cs_etm__dump_event(etm, buffer);
+				auxtrace_buffer__put_data(buffer);
+			}
+	}
+
 	return 0;
 }
 
-- 
2.14.3
