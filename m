From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/36] perf pmu: Add check for valid cpuid in perf_pmu__find_map()
Date: Wed,  6 Dec 2017 11:41:02 -0300
Message-ID: <20171206144115.15097-24-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752557AbdLFOnE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 09:43:04 -0500
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Ganapatrao Kulkarni <gklkml16@gmail.com>, Jayachandran C <jnair@caviumnetworks.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Robert Richter <robert.richter@cavium.com>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

On some platforms(arm/arm64) which uses cpus map to get corresponding
cpuid string, cpuid can be NULL for PMUs other than CORE PMUs.  Adding
check for NULL cpuid in function perf_pmu__find_map to avoid
segmentation fault.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc: Jayachandran C <jnair@caviumnetworks.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@cavium.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20171016183222.25750-6-ganapatrao.kulkarni@cavium.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 732ff579ec65..8b7c151579c0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -601,6 +601,12 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	char *cpuid = perf_pmu__getcpuid(pmu);
 	int i;
 
+	/* on some platforms which uses cpus map, cpuid can be NULL for
+	 * PMUs other than CORE PMUs.
+	 */
+	if (!cpuid)
+		return NULL;
+
 	i = 0;
 	for (;;) {
 		map = &pmu_events_map[i++];
-- 
2.13.6
