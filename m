From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/27] perf intel-pt: Add decoder flags for trace begin / end
Date: Mon, 24 Sep 2018 12:02:40 -0300
Message-ID: <20180924150242.14235-26-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Previously, the decoder would indicate begin / end by a branch from / to
zero. That hides useful information, in particular when a trace ends
with a call. To prepare for remedying that, add Intel PT decoder flags
for trace begin / end and map them to the existing sample flags.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h | 2 ++
 tools/perf/util/intel-pt.c                          | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 51c18d67f4ca..ed088d4726ba 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -37,6 +37,8 @@ enum intel_pt_sample_type {
 	INTEL_PT_EX_STOP	= 1 << 6,
 	INTEL_PT_PWR_EXIT	= 1 << 7,
 	INTEL_PT_CBR_CHG	= 1 << 8,
+	INTEL_PT_TRACE_BEGIN	= 1 << 9,
+	INTEL_PT_TRACE_END	= 1 << 10,
 };
 
 enum intel_pt_period_type {
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index aec68908d604..48c1d415c6b0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -908,6 +908,11 @@ static void intel_pt_sample_flags(struct intel_pt_queue *ptq)
 		ptq->insn_len = ptq->state->insn_len;
 		memcpy(ptq->insn, ptq->state->insn, INTEL_PT_INSN_BUF_SZ);
 	}
+
+	if (ptq->state->type & INTEL_PT_TRACE_BEGIN)
+		ptq->flags |= PERF_IP_FLAG_TRACE_BEGIN;
+	if (ptq->state->type & INTEL_PT_TRACE_END)
+		ptq->flags |= PERF_IP_FLAG_TRACE_END;
 }
 
 static int intel_pt_setup_queue(struct intel_pt *pt,
-- 
2.14.4
