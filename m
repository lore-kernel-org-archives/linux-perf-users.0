From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/40] perf intel-pt: Always set no branch for dummy event
Date: Wed, 26 Jul 2017 11:16:52 -0300
Message-ID: <20170726141730.30750-3-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbdGZOSJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jul 2017 10:18:09 -0400
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kan Liang <kan.liang@intel.com>

An earlier kernel patch allowed enabling PT and LBR at the same time on
Goldmont.

commit ccbebba4c6bf ("perf/x86/intel/pt: Bypass PT vs. LBR exclusivity
if the core supports it")

However, users still cannot use Intel PT and LBRs simultaneously.  $
sudo perf record -e cycles,intel_pt//u -b  -- sleep 1 Error: PMU
Hardware doesn't support sampling/overflow-interrupts.

PT implicitly adds dummy event in perf tool. dummy event is software
event which doesn't support LBR.

Always setting no branch for dummy event in Intel PT.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170630141656.1626-2-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 4a461e8ae326..db0ba8caf5a2 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -701,6 +701,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 				perf_evsel__set_sample_bit(switch_evsel, TID);
 				perf_evsel__set_sample_bit(switch_evsel, TIME);
 				perf_evsel__set_sample_bit(switch_evsel, CPU);
+				perf_evsel__reset_sample_bit(switch_evsel, BRANCH_STACK);
 
 				opts->record_switch_events = false;
 				ptr->have_sched_switch = 3;
@@ -762,6 +763,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			/* And the CPU for switch events */
 			perf_evsel__set_sample_bit(tracking_evsel, CPU);
 		}
+		perf_evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
 	}
 
 	/*
-- 
2.9.4
