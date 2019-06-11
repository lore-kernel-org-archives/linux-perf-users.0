From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/85] perf intel-pt: Accumulate cycle count from CYC packets
Date: Tue, 11 Jun 2019 15:57:54 -0300
Message-ID: <20190611185911.11645-9-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for providing instructions-per-cycle (IPC) information,
accumulate cycle count from CYC packets.

Although CYC packets are optional (requires config term 'cyc' to enable
cycle-accurate mode when recording), the simplest way to count cycles is
with CYC packets.

The first complication is that cycles must be counted only when also
counting instructions.

That means when control flow packet generation is enabled i.e. between
TIP.PGE and TIP.PGD packets.

Also, sampling the cycle count follows the same rules as sampling the
timestamp, that is, not before the instruction to which the decoder is
walking is reached.

In addition, the cycle count is not accurate for any but the first
branch of a TNT packet.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 14 +++++++++++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 1ab4070b5633..ef3a1c1cd250 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -160,6 +160,8 @@ struct intel_pt_decoder {
 	uint64_t period_mask;
 	uint64_t period_ticks;
 	uint64_t last_masked_timestamp;
+	uint64_t tot_cyc_cnt;
+	uint64_t sample_tot_cyc_cnt;
 	bool continuous_period;
 	bool overflow;
 	bool set_fup_tx_flags;
@@ -167,6 +169,7 @@ struct intel_pt_decoder {
 	bool set_fup_mwait;
 	bool set_fup_pwre;
 	bool set_fup_exstop;
+	bool sample_cyc;
 	unsigned int fup_tx_flags;
 	unsigned int tx_flags;
 	uint64_t fup_ptw_payload;
@@ -1323,6 +1326,7 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 				decoder->ip += intel_pt_insn.length;
 				return 0;
 			}
+			decoder->sample_cyc = false;
 			decoder->ip += intel_pt_insn.length;
 			if (!decoder->tnt.count) {
 				intel_pt_update_sample_time(decoder);
@@ -1515,6 +1519,9 @@ static void intel_pt_calc_cyc_timestamp(struct intel_pt_decoder *decoder)
 	decoder->have_cyc = true;
 
 	decoder->cycle_cnt += decoder->packet.payload;
+	if (decoder->pge)
+		decoder->tot_cyc_cnt += decoder->packet.payload;
+	decoder->sample_cyc = true;
 
 	if (!decoder->cyc_ref_timestamp)
 		return;
@@ -2419,6 +2426,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 		decoder->state.err = intel_pt_ext_err(err);
 		decoder->state.from_ip = decoder->ip;
 		intel_pt_update_sample_time(decoder);
+		decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
 	} else {
 		decoder->state.err = 0;
 		if (decoder->cbr != decoder->cbr_seen && decoder->state.type) {
@@ -2426,14 +2434,18 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
 		}
-		if (intel_pt_sample_time(decoder->pkt_state))
+		if (intel_pt_sample_time(decoder->pkt_state)) {
 			intel_pt_update_sample_time(decoder);
+			if (decoder->sample_cyc)
+				decoder->sample_tot_cyc_cnt = decoder->tot_cyc_cnt;
+		}
 	}
 
 	decoder->state.timestamp = decoder->sample_timestamp;
 	decoder->state.est_timestamp = intel_pt_est_timestamp(decoder);
 	decoder->state.cr3 = decoder->cr3;
 	decoder->state.tot_insn_cnt = decoder->tot_insn_cnt;
+	decoder->state.tot_cyc_cnt = decoder->sample_tot_cyc_cnt;
 
 	return &decoder->state;
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index ed088d4726ba..6a61773dc44b 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -77,6 +77,7 @@ struct intel_pt_state {
 	uint64_t to_ip;
 	uint64_t cr3;
 	uint64_t tot_insn_cnt;
+	uint64_t tot_cyc_cnt;
 	uint64_t timestamp;
 	uint64_t est_timestamp;
 	uint64_t trace_nr;
-- 
2.20.1
