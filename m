From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/6] perf vendor events intel: Remove duplicated entry for westmereep-dp in mapfile.csv
Date: Mon,  7 May 2018 17:13:29 -0300
Message-ID: <20180507201333.26990-3-acme@kernel.org>
References: <20180507201333.26990-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180507201333.26990-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, William Cohen <wcohen@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: William Cohen <wcohen@redhat.com>

Signed-off-by: William Cohen <wcohen@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180503195032.28871-1-wcohen@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 93656f2fd53a..7e3cce3bcf3b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,6 @@ GenuineIntel-6-4D,v13,silvermont,core
 GenuineIntel-6-4C,v13,silvermont,core
 GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55,v1,skylakex,core
-- 
2.14.3
