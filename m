From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/53] perf intel-pt: Fix overlap calculation for padding
Date: Wed,  6 Feb 2019 15:49:00 -0300
Message-ID: <20190206184903.24054-51-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Auxtrace records might have up to 7 bytes of padding appended. Adjust
the overlap accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190206103947.15750-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 4503f3ca45ab..ecd25cdc1d3e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -26,6 +26,7 @@
 
 #include "../cache.h"
 #include "../util.h"
+#include "../auxtrace.h"
 
 #include "intel-pt-insn-decoder.h"
 #include "intel-pt-pkt-decoder.h"
@@ -2575,6 +2576,34 @@ static int intel_pt_tsc_cmp(uint64_t tsc1, uint64_t tsc2)
 	}
 }
 
+#define MAX_PADDING (PERF_AUXTRACE_RECORD_ALIGNMENT - 1)
+
+/**
+ * adj_for_padding - adjust overlap to account for padding.
+ * @buf_b: second buffer
+ * @buf_a: first buffer
+ * @len_a: size of first buffer
+ *
+ * @buf_a might have up to 7 bytes of padding appended. Adjust the overlap
+ * accordingly.
+ *
+ * Return: A pointer into @buf_b from where non-overlapped data starts
+ */
+static unsigned char *adj_for_padding(unsigned char *buf_b,
+				      unsigned char *buf_a, size_t len_a)
+{
+	unsigned char *p = buf_b - MAX_PADDING;
+	unsigned char *q = buf_a + len_a - MAX_PADDING;
+	int i;
+
+	for (i = MAX_PADDING; i; i--, p++, q++) {
+		if (*p != *q)
+			break;
+	}
+
+	return p;
+}
+
 /**
  * intel_pt_find_overlap_tsc - determine start of non-overlapped trace data
  *                             using TSC.
@@ -2625,8 +2654,11 @@ static unsigned char *intel_pt_find_overlap_tsc(unsigned char *buf_a,
 
 			/* Same TSC, so buffers are consecutive */
 			if (!cmp && rem_b >= rem_a) {
+				unsigned char *start;
+
 				*consecutive = true;
-				return buf_b + len_b - (rem_b - rem_a);
+				start = buf_b + len_b - (rem_b - rem_a);
+				return adj_for_padding(start, buf_a, len_a);
 			}
 			if (cmp < 0)
 				return buf_b; /* tsc_a < tsc_b => no overlap */
@@ -2689,7 +2721,7 @@ unsigned char *intel_pt_find_overlap(unsigned char *buf_a, size_t len_a,
 		found = memmem(buf_a, len_a, buf_b, len_a);
 		if (found) {
 			*consecutive = true;
-			return buf_b + len_a;
+			return adj_for_padding(buf_b + len_a, buf_a, len_a);
 		}
 
 		/* Try again at next PSB in buffer 'a' */
-- 
2.20.1
