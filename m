From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 41/41] perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
Date: Wed, 29 May 2019 10:36:05 -0300
Message-ID: <20190529133605.21118-42-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Returning 1 from intel_pt_sync_switch() causes the current tid to be
set. That negates the need to keep next_tid anymore. Rationalize the
code to that effect.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6aaba1146fc8..7a70693c1b91 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1859,7 +1859,6 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 
 	switch (ptq->switch_state) {
 	case INTEL_PT_SS_NOT_TRACING:
-		ptq->next_tid = -1;
 		break;
 	case INTEL_PT_SS_UNKNOWN:
 	case INTEL_PT_SS_TRACING:
@@ -1879,13 +1878,14 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 		ptq->switch_state = INTEL_PT_SS_TRACING;
 		break;
 	case INTEL_PT_SS_EXPECTING_SWITCH_IP:
-		ptq->next_tid = tid;
 		intel_pt_log("ERROR: cpu %d expecting switch ip\n", cpu);
 		break;
 	default:
 		break;
 	}
 
+	ptq->next_tid = -1;
+
 	return 1;
 }
 
-- 
2.20.1
