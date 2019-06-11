From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/85] perf intel-pt: Factor out intel_pt_update_sample_time
Date: Tue, 11 Jun 2019 15:57:53 -0300
Message-ID: <20190611185911.11645-8-acme@kernel.org>
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

To eliminate some duplication and make the code more understandable,
factor out intel_pt_update_sample_time.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c   | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f4c3c84b090f..1ab4070b5633 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -479,6 +479,12 @@ static int intel_pt_bad_packet(struct intel_pt_decoder *decoder)
 	return -EBADMSG;
 }
 
+static inline void intel_pt_update_sample_time(struct intel_pt_decoder *decoder)
+{
+	decoder->sample_timestamp = decoder->timestamp;
+	decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+}
+
 static int intel_pt_get_data(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_buffer buffer = { .buf = 0, };
@@ -1319,8 +1325,7 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 			}
 			decoder->ip += intel_pt_insn.length;
 			if (!decoder->tnt.count) {
-				decoder->sample_timestamp = decoder->timestamp;
-				decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+				intel_pt_update_sample_time(decoder);
 				return -EAGAIN;
 			}
 			decoder->tnt.payload <<= 1;
@@ -2413,8 +2418,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 	if (err) {
 		decoder->state.err = intel_pt_ext_err(err);
 		decoder->state.from_ip = decoder->ip;
-		decoder->sample_timestamp = decoder->timestamp;
-		decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
+		intel_pt_update_sample_time(decoder);
 	} else {
 		decoder->state.err = 0;
 		if (decoder->cbr != decoder->cbr_seen && decoder->state.type) {
@@ -2422,10 +2426,8 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			decoder->state.type |= INTEL_PT_CBR_CHG;
 			decoder->state.cbr_payload = decoder->cbr_payload;
 		}
-		if (intel_pt_sample_time(decoder->pkt_state)) {
-			decoder->sample_timestamp = decoder->timestamp;
-			decoder->sample_insn_cnt = decoder->timestamp_insn_cnt;
-		}
+		if (intel_pt_sample_time(decoder->pkt_state))
+			intel_pt_update_sample_time(decoder);
 	}
 
 	decoder->state.timestamp = decoder->sample_timestamp;
-- 
2.20.1
