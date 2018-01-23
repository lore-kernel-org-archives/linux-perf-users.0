From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/43] perf vendor events intel: Update Silvermont events to V14
Date: Tue, 23 Jan 2018 10:12:30 -0300
Message-ID: <20180123131251.28197-23-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Link: https://lkml.kernel.org/r/20180118234518.GA27753@tassilo.jf.intel.com
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/silvermont/cache.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/silvermont/cache.json b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
index 0bd1bc5302de..82be7d1b8b81 100644
--- a/tools/perf/pmu-events/arch/x86/silvermont/cache.json
+++ b/tools/perf/pmu-events/arch/x86/silvermont/cache.json
@@ -36,12 +36,13 @@
         "BriefDescription": "L2 cache request misses"
     },
     {
+        "PublicDescription": "Counts cycles that fetch is stalled due to an outstanding ICache miss. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes due to an ICache miss.  Note: this event is not the same as the total number of cycles spent retrieving instruction cache lines from the memory hierarchy.\r\nCounts cycles that fetch is stalled due to any reason. That is, the decoder queue is able to accept bytes, but the fetch unit is unable to provide bytes.  This will include cycles due to an ITLB miss, ICache miss and other events. \r\n",
         "EventCode": "0x86",
         "Counter": "0,1",
         "UMask": "0x4",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of cycles the NIP stalls because of an icache miss. This is a cumulative count of cycles the NIP stalled for all icache misses."
+        "BriefDescription": "Cycles code-fetch stalled due to an outstanding ICache miss."
     },
     {
         "PEBS": "1",
-- 
2.14.3
