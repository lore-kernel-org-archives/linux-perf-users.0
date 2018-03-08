From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/54] perf intel-pt: Fix timestamp following overflow
Date: Thu,  8 Mar 2018 16:50:08 -0300
Message-ID: <20180308195029.14991-34-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

timestamp_insn_cnt is used to estimate the timestamp based on the number of
instructions since the last known timestamp.

If the estimate is not accurate enough decoding might not be correctly
synchronized with side-band events causing more trace errors.

However there are always timestamps following an overflow, so the
estimate is not needed and can indeed result in more errors.

Suppress the estimate by setting timestamp_insn_cnt to zero.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5e4d0bbafc8b..f9157aed1289 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1378,6 +1378,7 @@ static int intel_pt_overflow(struct intel_pt_decoder *decoder)
 	intel_pt_clear_tx_flags(decoder);
 	decoder->have_tma = false;
 	decoder->cbr = 0;
+	decoder->timestamp_insn_cnt = 0;
 	decoder->pkt_state = INTEL_PT_STATE_ERR_RESYNC;
 	decoder->overflow = true;
 	return -EOVERFLOW;
-- 
2.14.3
