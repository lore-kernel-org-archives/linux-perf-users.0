From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/91] perf pmu: Fix function name in comment, its get_cpuid_str(), not get_cpustr()
Date: Wed,  6 May 2020 12:21:20 -0300
Message-ID: <20200506152234.21977-18-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Shaokun Zhang <zhangshaokun@hisilicon.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

get_cpuid_str() is used in tools/perf/arch/xxx/util/header.c,
fix the name in comment.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lore.kernel.org/lkml/1588141992-48382-1-git-send-email-zhangshaokun@hisilicon.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/pmu-events.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 53e76d5d5b37..c8f306b572f4 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -26,7 +26,7 @@ struct pmu_event {
  * Map a CPU to its table of PMU events. The CPU is identified by the
  * cpuid field, which is an arch-specific identifier for the CPU.
  * The identifier specified in tools/perf/pmu-events/arch/xxx/mapfile
- * must match the get_cpustr() in tools/perf/arch/xxx/util/header.c)
+ * must match the get_cpuid_str() in tools/perf/arch/xxx/util/header.c)
  *
  * The  cpuid can contain any character other than the comma.
  */
-- 
2.21.1
