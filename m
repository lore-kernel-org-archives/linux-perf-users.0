From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 8/9] perf vendor events s390: Fix counter long description for DTLB1_GPAGE_WRITES
Date: Mon, 16 Dec 2019 17:47:37 -0300
Message-ID: <20191216204738.12107-9-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ed Maste <emaste@freebsd.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Greentime Hu <green.hu@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Nick Hu <nickhu@andestech.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Richter <tmricht@linux.ibm.com>, Vincent Chen <deanbo422@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

The cf_z13 counter DTLB1_GPAGE_WRITES included a prefix
'Counter:132\tName:'.

This is incorrect; remove the prefix as with 7fcfa9a2d9 for cf_z14.

Signed-off-by: Ed Maste <emaste@freebsd.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Link: http://lore.kernel.org/lkml/20191212143446.88582-1-emaste@freefall.freebsd.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z13/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
index 436ce33f1182..5da8296b667e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
@@ -32,7 +32,7 @@
 		"EventCode": "132",
 		"EventName": "DTLB1_GPAGE_WRITES",
 		"BriefDescription": "DTLB1 Two-Gigabyte Page Writes",
-		"PublicDescription": "Counter:132	Name:DTLB1_GPAGE_WRITES A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.21.0
