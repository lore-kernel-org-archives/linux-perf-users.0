From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/40] perf intel-pt: Set no_aux_samples for the tracking event
Date: Wed, 26 Jul 2017 11:16:51 -0300
Message-ID: <20170726141730.30750-2-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

The reason of introducing the tracking event (a dummy software event) is
to collect side-band information. Additional sampling is wasteful.
no_aux_samples should be set for tracking event.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170630141656.1626-1-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 9535be57033f..4a461e8ae326 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -752,6 +752,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		tracking_evsel->attr.freq = 0;
 		tracking_evsel->attr.sample_period = 1;
 
+		tracking_evsel->no_aux_samples = true;
 		if (need_immediate)
 			tracking_evsel->immediate = true;
 
-- 
2.9.4
