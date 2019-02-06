From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/53] perf intel-pt: Packet splitting can happen only on 32-bit
Date: Wed,  6 Feb 2019 15:49:02 -0300
Message-ID: <20190206184903.24054-53-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Data is copied when the trace is stopped, so packets are never split
between buffers except when processing if the buffer cannot fit in the
address space which can only happen on 32-bit systems. Change the logic
to reflect that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190206103947.15750-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index a54d6c9a4601..6e03db142091 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -868,7 +868,7 @@ static int intel_pt_get_next_packet(struct intel_pt_decoder *decoder)
 
 		ret = intel_pt_get_packet(decoder->buf, decoder->len,
 					  &decoder->packet);
-		if (ret == INTEL_PT_NEED_MORE_BYTES &&
+		if (ret == INTEL_PT_NEED_MORE_BYTES && BITS_PER_LONG == 32 &&
 		    decoder->len < INTEL_PT_PKT_MAX_SZ && !decoder->next_buf) {
 			ret = intel_pt_get_split_packet(decoder);
 			if (ret < 0)
-- 
2.20.1
