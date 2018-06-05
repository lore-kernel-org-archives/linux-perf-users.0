From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 44/46] perf intel-pt: Fix decoding to accept CBR between FUP and corresponding TIP
Date: Tue,  5 Jun 2018 14:50:28 -0300
Message-ID: <20180605175030.32549-45-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

It is possible to have a CBR packet between a FUP packet and
corresponding TIP packet. Stop treating it as an error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1527762225-26024-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index f9157aed1289..e5eb91777383 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1604,7 +1604,6 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PSB:
 		case INTEL_PT_TSC:
 		case INTEL_PT_TMA:
-		case INTEL_PT_CBR:
 		case INTEL_PT_MODE_TSX:
 		case INTEL_PT_BAD:
 		case INTEL_PT_PSBEND:
@@ -1620,6 +1619,10 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 			decoder->pkt_step = 0;
 			return -ENOENT;
 
+		case INTEL_PT_CBR:
+			intel_pt_calc_cbr(decoder);
+			break;
+
 		case INTEL_PT_OVF:
 			return intel_pt_overflow(decoder);
 
-- 
2.14.3
