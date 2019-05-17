From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 68/73] perf intel-pt: Fix improved sample timestamp
Date: Fri, 17 May 2019 16:36:06 -0300
Message-ID: <20190517193611.4974-69-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The decoder uses its current timestamp in samples. Usually that is a
timestamp that has already passed, but in some cases it is a timestamp
for a branch that the decoder is walking towards, and consequently
hasn't reached.

The intel_pt_sample_time() function decides which is which, but was not
handling TNT packets exactly correctly.

In the case of TNT, the timestamp applies to the first branch, so the
decoder must first walk to that branch.

That means intel_pt_sample_time() should return true for TNT, and this
patch makes that change. However, if the first branch is a non-taken
branch (i.e. a 'N'), then intel_pt_sample_time() needs to return false
for subsequent taken branches in the same TNT packet.

To handle that, introduce a new state INTEL_PT_STATE_TNT_CONT to
distinguish the cases.

Note that commit 3f04d98e972b5 ("perf intel-pt: Improve sample
timestamp") was also a stable fix and appears, for example, in v4.4
stable tree as commit a4ebb58fd124 ("perf intel-pt: Improve sample
timestamp").

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org # v4.4+
Fixes: 3f04d98e972b5 ("perf intel-pt: Improve sample timestamp")
Link: http://lkml.kernel.org/r/20190510124143.27054-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 26dbf11e071a..9cbd587489bf 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -58,6 +58,7 @@ enum intel_pt_pkt_state {
 	INTEL_PT_STATE_NO_IP,
 	INTEL_PT_STATE_ERR_RESYNC,
 	INTEL_PT_STATE_IN_SYNC,
+	INTEL_PT_STATE_TNT_CONT,
 	INTEL_PT_STATE_TNT,
 	INTEL_PT_STATE_TIP,
 	INTEL_PT_STATE_TIP_PGD,
@@ -72,8 +73,9 @@ static inline bool intel_pt_sample_time(enum intel_pt_pkt_state pkt_state)
 	case INTEL_PT_STATE_NO_IP:
 	case INTEL_PT_STATE_ERR_RESYNC:
 	case INTEL_PT_STATE_IN_SYNC:
-	case INTEL_PT_STATE_TNT:
+	case INTEL_PT_STATE_TNT_CONT:
 		return true;
+	case INTEL_PT_STATE_TNT:
 	case INTEL_PT_STATE_TIP:
 	case INTEL_PT_STATE_TIP_PGD:
 	case INTEL_PT_STATE_FUP:
@@ -1261,7 +1263,9 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 				return -ENOENT;
 			}
 			decoder->tnt.count -= 1;
-			if (!decoder->tnt.count)
+			if (decoder->tnt.count)
+				decoder->pkt_state = INTEL_PT_STATE_TNT_CONT;
+			else
 				decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			decoder->tnt.payload <<= 1;
 			decoder->state.from_ip = decoder->ip;
@@ -1292,7 +1296,9 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 
 		if (intel_pt_insn.branch == INTEL_PT_BR_CONDITIONAL) {
 			decoder->tnt.count -= 1;
-			if (!decoder->tnt.count)
+			if (decoder->tnt.count)
+				decoder->pkt_state = INTEL_PT_STATE_TNT_CONT;
+			else
 				decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
 			if (decoder->tnt.payload & BIT63) {
 				decoder->tnt.payload <<= 1;
@@ -2372,6 +2378,7 @@ const struct intel_pt_state *intel_pt_decode(struct intel_pt_decoder *decoder)
 			err = intel_pt_walk_trace(decoder);
 			break;
 		case INTEL_PT_STATE_TNT:
+		case INTEL_PT_STATE_TNT_CONT:
 			err = intel_pt_walk_tnt(decoder);
 			if (err == -EAGAIN)
 				err = intel_pt_walk_trace(decoder);
-- 
2.20.1
