From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/54] perf intel-pt: Fix error recovery from missing TIP packet
Date: Thu,  8 Mar 2018 16:50:07 -0300
Message-ID: <20180308195029.14991-33-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

When a TIP packet is expected but there is a different packet, it is an
error. However the unexpected packet might be something important like a
TSC packet, so after the error, it is necessary to continue from there,
rather than the next packet. That is achieved by setting pkt_step to
zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-4-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 00f25f4b5f48..5e4d0bbafc8b 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1616,6 +1616,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 		case INTEL_PT_PWRX:
 			intel_pt_log("ERROR: Missing TIP after FUP\n");
 			decoder->pkt_state = INTEL_PT_STATE_ERR3;
+			decoder->pkt_step = 0;
 			return -ENOENT;
 
 		case INTEL_PT_OVF:
-- 
2.14.3
