From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/75] perf cs-etm: Add support for PTMv1.1 decoding
Date: Thu,  6 Dec 2018 18:25:46 -0300
Message-ID: <20181206212602.20474-60-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

This patch is re-using the mechanic set forth by ETMv3 to add support
for PTM decoding.  Configuration for both encoding protocol is similar
but the generated stream itself is very different, hence requiring
special handling.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1543955944-10042-4-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++--
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                      | 23 +++++++++++++++++--
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 952d1f43f3fa..0b4c8629f578 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -256,8 +256,11 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
@@ -453,8 +456,11 @@ static int cs_etm_decoder__create_etm_packet_decoder(
 
 	switch (t_params->protocol) {
 	case CS_ETM_PROTO_ETMV3:
+	case CS_ETM_PROTO_PTM:
 		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
-		decoder_name = OCSD_BUILTIN_DCD_ETMV3;
+		decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
+							OCSD_BUILTIN_DCD_ETMV3 :
+							OCSD_BUILTIN_DCD_PTM;
 		trace_config = &config_etmv3;
 		break;
 	case CS_ETM_PROTO_ETMV4i:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 6b5525410a43..b295dd2b8292 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -96,6 +96,7 @@ enum {
 	CS_ETM_PROTO_ETMV3 = 1,
 	CS_ETM_PROTO_ETMV4i,
 	CS_ETM_PROTO_ETMV4d,
+	CS_ETM_PROTO_PTM,
 };
 
 enum {
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 76e509c32a28..23159c33db2a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -83,6 +83,19 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid, u64 time_);
 
+/* PTMs ETMIDR [11:8] set to b0011 */
+#define ETMIDR_PTM_VERSION 0x00000300
+
+static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
+{
+	etmidr &= ETMIDR_PTM_VERSION;
+
+	if (etmidr == ETMIDR_PTM_VERSION)
+		return CS_ETM_PROTO_PTM;
+
+	return CS_ETM_PROTO_ETMV3;
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -115,7 +128,10 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
@@ -366,7 +382,10 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV3;
+			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+
+			t_params[i].protocol =
+					cs_etm__get_v7_protocol_version(etmidr);
 			t_params[i].etmv3.reg_ctrl =
 					etm->metadata[i][CS_ETM_ETMCR];
 			t_params[i].etmv3.reg_trc_id =
-- 
2.19.2
