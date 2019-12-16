From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 9/9] perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description
Date: Mon, 16 Dec 2019 17:47:38 -0300
Message-ID: <20191216204738.12107-10-acme@kernel.org>
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

In 7fcfa9a2d9 an unintended prefix "Counter:18 Name:" was removed from
the description for L1D_RO_EXCL_WRITES, but the extra name remained in
the description.  Remove it too.

Fixes: 7fcfa9a2d9a7 ("perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES")
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
Link: http://lore.kernel.org/lkml/20191212145346.5026-1-emaste@freefall.freebsd.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z14/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index 68618152ea2c..89e070727e1b 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -4,7 +4,7 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.21.0
