From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/85] perf intel-pt: Record when decoding PSB+ packets
Date: Tue, 11 Jun 2019 15:57:58 -0300
Message-ID: <20190611185911.11645-13-acme@kernel.org>
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

In preparation for using MTC packets to count cycles, record whether
decoding is between a PSB and PSBEND packets.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index ef3a1c1cd250..a2384a314990 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -116,6 +116,7 @@ struct intel_pt_decoder {
 	bool have_cyc;
 	bool fixup_last_mtc;
 	bool have_last_ip;
+	bool in_psb;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -1549,14 +1550,17 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_TIP_PGD:
 		case INTEL_PT_TIP_PGE:
@@ -1574,10 +1578,12 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRX:
 			decoder->have_tma = false;
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -EAGAIN;
+			err = -EAGAIN;
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_TSC:
 			intel_pt_calc_tsc_timestamp(decoder);
@@ -1623,6 +1629,10 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
@@ -1996,10 +2006,12 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 {
 	int err;
 
+	decoder->in_psb = true;
+
 	while (1) {
 		err = intel_pt_get_next_packet(decoder);
 		if (err)
-			return err;
+			goto out;
 
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
@@ -2015,7 +2027,8 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRE:
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Unexpected packet\n");
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_FUP:
 			decoder->pge = true;
@@ -2074,16 +2087,20 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 				decoder->pkt_state = INTEL_PT_STATE_ERR4;
 			else
 				decoder->pkt_state = INTEL_PT_STATE_ERR3;
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 
 		case INTEL_PT_BAD: /* Does not happen */
-			return intel_pt_bug(decoder);
+			err = intel_pt_bug(decoder);
+			goto out;
 
 		case INTEL_PT_OVF:
-			return intel_pt_overflow(decoder);
+			err = intel_pt_overflow(decoder);
+			goto out;
 
 		case INTEL_PT_PSBEND:
-			return 0;
+			err = 0;
+			goto out;
 
 		case INTEL_PT_PSB:
 		case INTEL_PT_VMCS:
@@ -2093,6 +2110,10 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 			break;
 		}
 	}
+out:
+	decoder->in_psb = false;
+
+	return err;
 }
 
 static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
-- 
2.20.1
