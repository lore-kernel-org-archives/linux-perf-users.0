From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/43] perf tools: Add support for decoding CoreSight trace
 data
Date: Tue, 23 Jan 2018 10:12:40 -0300
Message-ID: <20180123131251.28197-33-acme@kernel.org>
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

Adding functionality to create a CoreSight trace decoder capable
of decoding trace data pushed by a client application.

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
Link: http://lkml.kernel.org/r/1516211539-5166-6-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 119 ++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 6a4c86b1431f..57b020b0b36f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -200,6 +200,121 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 	}
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
+			      const ocsd_generic_trace_elem *elem,
+			      const u8 trace_chan_id,
+			      enum cs_etm_sample_type sample_type)
+{
+	u32 et = 0;
+	struct int_node *inode = NULL;
+
+	if (decoder->packet_count >= MAX_BUFFER - 1)
+		return OCSD_RESP_FATAL_SYS_ERR;
+
+	/* Search the RB tree for the cpu associated with this traceID */
+	inode = intlist__find(traceid_list, trace_chan_id);
+	if (!inode)
+		return OCSD_RESP_FATAL_SYS_ERR;
+
+	et = decoder->tail;
+	decoder->packet_buffer[et].sample_type = sample_type;
+	decoder->packet_buffer[et].start_addr = elem->st_addr;
+	decoder->packet_buffer[et].end_addr = elem->en_addr;
+	decoder->packet_buffer[et].exc = false;
+	decoder->packet_buffer[et].exc_ret = false;
+	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
+
+	/* Wrap around if need be */
+	et = (et + 1) & (MAX_BUFFER - 1);
+
+	decoder->tail = et;
+	decoder->packet_count++;
+
+	if (decoder->packet_count == MAX_BUFFER - 1)
+		return OCSD_RESP_WAIT;
+
+	return OCSD_RESP_CONT;
+}
+
+static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
+				const void *context,
+				const ocsd_trc_index_t indx __maybe_unused,
+				const u8 trace_chan_id __maybe_unused,
+				const ocsd_generic_trace_elem *elem)
+{
+	ocsd_datapath_resp_t resp = OCSD_RESP_CONT;
+	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
+
+	switch (elem->elem_type) {
+	case OCSD_GEN_TRC_ELEM_UNKNOWN:
+		break;
+	case OCSD_GEN_TRC_ELEM_NO_SYNC:
+		decoder->trace_on = false;
+		break;
+	case OCSD_GEN_TRC_ELEM_TRACE_ON:
+		decoder->trace_on = true;
+		break;
+	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
+		resp = cs_etm_decoder__buffer_packet(decoder, elem,
+						     trace_chan_id,
+						     CS_ETM_RANGE);
+		break;
+	case OCSD_GEN_TRC_ELEM_EXCEPTION:
+		decoder->packet_buffer[decoder->tail].exc = true;
+		break;
+	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
+		decoder->packet_buffer[decoder->tail].exc_ret = true;
+		break;
+	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
+	case OCSD_GEN_TRC_ELEM_EO_TRACE:
+	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
+	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
+	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
+	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
+	case OCSD_GEN_TRC_ELEM_EVENT:
+	case OCSD_GEN_TRC_ELEM_SWTRACE:
+	case OCSD_GEN_TRC_ELEM_CUSTOM:
+	default:
+		break;
+	}
+
+	return resp;
+}
+
+static int cs_etm_decoder__create_etm_packet_decoder(
+					struct cs_etm_trace_params *t_params,
+					struct cs_etm_decoder *decoder)
+{
+	const char *decoder_name;
+	ocsd_etmv4_cfg trace_config_etmv4;
+	void *trace_config;
+	u8 csid;
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
+	if (ocsd_dt_create_decoder(decoder->dcd_tree,
+				     decoder_name,
+				     OCSD_CREATE_FLG_FULL_DECODER,
+				     trace_config, &csid))
+		return -1;
+
+	if (ocsd_dt_set_gen_elem_outfn(decoder->dcd_tree,
+				       cs_etm_decoder__gen_trace_elem_printer,
+				       decoder))
+		return -1;
+
+	return 0;
+}
+
 static int
 cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 				   struct cs_etm_trace_params *t_params,
@@ -208,6 +323,10 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 	if (d_params->operation == CS_ETM_OPERATION_PRINT)
 		return cs_etm_decoder__create_etm_packet_printer(t_params,
 								 decoder);
+	else if (d_params->operation == CS_ETM_OPERATION_DECODE)
+		return cs_etm_decoder__create_etm_packet_decoder(t_params,
+								 decoder);
+
 	return -1;
 }
 
-- 
2.14.3
