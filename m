From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/46] perf intel-pt: Fix sync_switch INTEL_PT_SS_NOT_TRACING
Date: Tue,  5 Jun 2018 14:50:27 -0300
Message-ID: <20180605175030.32549-44-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

In one case, INTEL_PT_SS_NOT_TRACING state was not correctly
transitioning to INTEL_PT_SS_TRACING state due to a missing case clause.
Add it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1527762225-26024-2-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 492986a25ef6..3db7f0ee52a8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1521,6 +1521,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
 		switch (ptq->switch_state) {
+		case INTEL_PT_SS_NOT_TRACING:
 		case INTEL_PT_SS_UNKNOWN:
 		case INTEL_PT_SS_EXPECTING_SWITCH_IP:
 			err = intel_pt_next_tid(pt, ptq);
-- 
2.14.3
