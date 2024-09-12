Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C38189525
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123543; cv=none; b=hEFdtfdQan9t3RjIyEZ3l03poW6DeMNa0giLKBbgmKUl4b9avcBgRo16n/lzEi7P2y3K7VpsTZ6u76GqqyXHf727FtdWslLVTx3m8OIqISyzGlM3aoBPf8TezezJ2azMerUc53NSzSXeRk8nXP1CZ2RsrCP9IOIh196BtdxVofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123543; c=relaxed/simple;
	bh=EydcpxXcGQtNRmFNJ+Fr1WrTXOfX7VBGpXaVwJhrAlo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TaJqDx/M9P2fFy9HjWGrCBQ6HRTldjpy5nb8LTC1Nuf1PhbQzK+CJre17+4kJkFNm6lKSKNmwC/Mmb/UYU4tw9jhB2YXlSoEmqsN/GnWr3YLGvsT3qyE9tzSRAUkm0NUWCVQvMT9Sfn7R7Wewva/Rk1WtsbicIsKquuUjziGHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X47Gq3rHTz1j8QM;
	Thu, 12 Sep 2024 14:45:07 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id BBDC91A0170;
	Thu, 12 Sep 2024 14:45:37 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 12 Sep 2024 14:45:37 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>
CC: <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH v2] perf vender events arm64: Use "Topdown" as topdown metric group name
Date: Thu, 12 Sep 2024 14:39:03 +0800
Message-ID: <20240912063903.31460-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

HiSilicon HIP08 does support Topdown metrics but perf tool complains
when trying to count Topdown metrics:
[root@localhost tracing]# perf stat --topdown
Topdown requested but the topdown metric groups aren't present.
(See perf list the metric groups have names like TopdownL1)

It's because tool's using "Topdown" as the metric group name[1] rather
than "TopDown", so follow the convention. This is introduced by [2]
which allows to use json metrics to support --topdown function.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c?h=v6.11-rc1#n1994
[2] commit 1647cd5b8802 ("perf stat: Implement --topdown using json metrics")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Change since v1:
- Add the commit introduced this changes and Jonathan's tag
Link: https://lore.kernel.org/linux-perf-users/39921dd0-8827-31c2-6032-37a149af6b77@huawei.com/T/#m510b2d8bcd61f60e53b686d340c47d5f56d585a7

 .../arch/arm64/hisilicon/hip08/metrics.json   | 74 +++++++++----------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
index 6463531b9941..b6a0d2de8534 100644
--- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
@@ -3,235 +3,235 @@
         "MetricExpr": "FETCH_BUBBLE / (4 * CPU_CYCLES)",
         "PublicDescription": "Frontend bound L1 topdown metric",
         "BriefDescription": "Frontend bound L1 topdown metric",
-        "DefaultMetricgroupName": "TopDownL1",
-        "MetricGroup": "Default;TopDownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "frontend_bound"
     },
     {
         "MetricExpr": "(INST_SPEC - INST_RETIRED) / (4 * CPU_CYCLES)",
         "PublicDescription": "Bad Speculation L1 topdown metric",
         "BriefDescription": "Bad Speculation L1 topdown metric",
-        "DefaultMetricgroupName": "TopDownL1",
-        "MetricGroup": "Default;TopDownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "bad_speculation"
     },
     {
         "MetricExpr": "INST_RETIRED / (CPU_CYCLES * 4)",
         "PublicDescription": "Retiring L1 topdown metric",
         "BriefDescription": "Retiring L1 topdown metric",
-        "DefaultMetricgroupName": "TopDownL1",
-        "MetricGroup": "Default;TopDownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "retiring"
     },
     {
         "MetricExpr": "1 - (frontend_bound + bad_speculation + retiring)",
         "PublicDescription": "Backend Bound L1 topdown metric",
         "BriefDescription": "Backend Bound L1 topdown metric",
-        "DefaultMetricgroupName": "TopDownL1",
-        "MetricGroup": "Default;TopDownL1",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
         "MetricName": "backend_bound"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x201d@ / CPU_CYCLES",
         "PublicDescription": "Fetch latency bound L2 topdown metric",
         "BriefDescription": "Fetch latency bound L2 topdown metric",
-        "MetricGroup": "TopDownL2",
+        "MetricGroup": "TopdownL2",
         "MetricName": "fetch_latency_bound"
     },
     {
         "MetricExpr": "frontend_bound - fetch_latency_bound",
         "PublicDescription": "Fetch bandwidth bound L2 topdown metric",
         "BriefDescription": "Fetch bandwidth bound L2 topdown metric",
-        "MetricGroup": "TopDownL2",
+        "MetricGroup": "TopdownL2",
         "MetricName": "fetch_bandwidth_bound"
     },
     {
         "MetricExpr": "(bad_speculation * BR_MIS_PRED) / (BR_MIS_PRED + armv8_pmuv3_0@event\\=0x2013@)",
         "PublicDescription": "Branch mispredicts L2 topdown metric",
         "BriefDescription": "Branch mispredicts L2 topdown metric",
-        "MetricGroup": "TopDownL2",
+        "MetricGroup": "TopdownL2",
         "MetricName": "branch_mispredicts"
     },
     {
         "MetricExpr": "bad_speculation - branch_mispredicts",
         "PublicDescription": "Machine clears L2 topdown metric",
         "BriefDescription": "Machine clears L2 topdown metric",
-        "MetricGroup": "TopDownL2",
+        "MetricGroup": "TopdownL2",
         "MetricName": "machine_clears"
     },
     {
         "MetricExpr": "(EXE_STALL_CYCLE - (MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@)) / CPU_CYCLES",
         "PublicDescription": "Core bound L2 topdown metric",
         "BriefDescription": "Core bound L2 topdown metric",
-        "MetricGroup": "TopDownL2",
+        "MetricGroup": "TopdownL2",
         "MetricName": "core_bound"
     },
     {
         "MetricExpr": "(MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@) / CPU_CYCLES",
         "PublicDescription": "Memory bound L2 topdown metric",
         "BriefDescription": "Memory bound L2 topdown metric",
-        "MetricGroup": "TopDownL2",
+        "MetricGroup": "TopdownL2",
         "MetricName": "memory_bound"
     },
     {
         "MetricExpr": "(((L2I_TLB - L2I_TLB_REFILL) * 15) + (L2I_TLB_REFILL * 100)) / CPU_CYCLES",
         "PublicDescription": "Idle by itlb miss L3 topdown metric",
         "BriefDescription": "Idle by itlb miss L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "idle_by_itlb_miss"
     },
     {
         "MetricExpr": "(((L2I_CACHE - L2I_CACHE_REFILL) * 15) + (L2I_CACHE_REFILL * 100)) / CPU_CYCLES",
         "PublicDescription": "Idle by icache miss L3 topdown metric",
         "BriefDescription": "Idle by icache miss L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "idle_by_icache_miss"
     },
     {
         "MetricExpr": "(BR_MIS_PRED * 5) / CPU_CYCLES",
         "PublicDescription": "BP misp flush L3 topdown metric",
         "BriefDescription": "BP misp flush L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "bp_misp_flush"
     },
     {
         "MetricExpr": "(armv8_pmuv3_0@event\\=0x2013@ * 5) / CPU_CYCLES",
         "PublicDescription": "OOO flush L3 topdown metric",
         "BriefDescription": "OOO flush L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "ooo_flush"
     },
     {
         "MetricExpr": "(armv8_pmuv3_0@event\\=0x1001@ * 5) / CPU_CYCLES",
         "PublicDescription": "Static predictor flush L3 topdown metric",
         "BriefDescription": "Static predictor flush L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "sp_flush"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x1010@ / BR_MIS_PRED",
         "PublicDescription": "Indirect branch L3 topdown metric",
         "BriefDescription": "Indirect branch L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "indirect_branch"
     },
     {
         "MetricExpr": "(armv8_pmuv3_0@event\\=0x1013@ + armv8_pmuv3_0@event\\=0x1016@) / BR_MIS_PRED",
         "PublicDescription": "Push branch L3 topdown metric",
         "BriefDescription": "Push branch L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "push_branch"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x100d@ / BR_MIS_PRED",
         "PublicDescription": "Pop branch L3 topdown metric",
         "BriefDescription": "Pop branch L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "pop_branch"
     },
     {
         "MetricExpr": "(BR_MIS_PRED - armv8_pmuv3_0@event\\=0x1010@ - armv8_pmuv3_0@event\\=0x1013@ - armv8_pmuv3_0@event\\=0x1016@ - armv8_pmuv3_0@event\\=0x100d@) / BR_MIS_PRED",
         "PublicDescription": "Other branch L3 topdown metric",
         "BriefDescription": "Other branch L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "other_branch"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x2012@ / armv8_pmuv3_0@event\\=0x2013@",
         "PublicDescription": "Nuke flush L3 topdown metric",
         "BriefDescription": "Nuke flush L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "nuke_flush"
     },
     {
         "MetricExpr": "1 - nuke_flush",
         "PublicDescription": "Other flush L3 topdown metric",
         "BriefDescription": "Other flush L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "other_flush"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x2010@ / CPU_CYCLES",
         "PublicDescription": "Sync stall L3 topdown metric",
         "BriefDescription": "Sync stall L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "sync_stall"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x2004@ / CPU_CYCLES",
         "PublicDescription": "Rob stall L3 topdown metric",
         "BriefDescription": "Rob stall L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "rob_stall"
     },
     {
         "MetricExpr": "(armv8_pmuv3_0@event\\=0x2006@ + armv8_pmuv3_0@event\\=0x2007@ + armv8_pmuv3_0@event\\=0x2008@) / CPU_CYCLES",
         "PublicDescription": "Ptag stall L3 topdown metric",
         "BriefDescription": "Ptag stall L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "ptag_stall"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x201e@ / CPU_CYCLES",
         "PublicDescription": "SaveOpQ stall L3 topdown metric",
         "BriefDescription": "SaveOpQ stall L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "saveopq_stall"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x2005@ / CPU_CYCLES",
         "PublicDescription": "PC buffer stall L3 topdown metric",
         "BriefDescription": "PC buffer stall L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "pc_buffer_stall"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x7002@ / CPU_CYCLES",
         "PublicDescription": "Divider L3 topdown metric",
         "BriefDescription": "Divider L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "divider"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x7003@ / CPU_CYCLES",
         "PublicDescription": "FSU stall L3 topdown metric",
         "BriefDescription": "FSU stall L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "fsu_stall"
     },
     {
         "MetricExpr": "core_bound - divider - fsu_stall",
         "PublicDescription": "EXE ports util L3 topdown metric",
         "BriefDescription": "EXE ports util L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "exe_ports_util"
     },
     {
         "MetricExpr": "(MEM_STALL_ANYLOAD - MEM_STALL_L1MISS) / CPU_CYCLES",
         "PublicDescription": "L1 bound L3 topdown metric",
         "BriefDescription": "L1 bound L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "l1_bound"
     },
     {
         "MetricExpr": "(MEM_STALL_L1MISS - MEM_STALL_L2MISS) / CPU_CYCLES",
         "PublicDescription": "L2 bound L3 topdown metric",
         "BriefDescription": "L2 bound L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "l2_bound"
     },
     {
         "MetricExpr": "MEM_STALL_L2MISS / CPU_CYCLES",
         "PublicDescription": "Mem bound L3 topdown metric",
         "BriefDescription": "Mem bound L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "mem_bound"
     },
     {
         "MetricExpr": "armv8_pmuv3_0@event\\=0x7005@ / CPU_CYCLES",
         "PublicDescription": "Store bound L3 topdown metric",
         "BriefDescription": "Store bound L3 topdown metric",
-        "MetricGroup": "TopDownL3",
+        "MetricGroup": "TopdownL3",
         "MetricName": "store_bound"
     }
 ]
-- 
2.24.0

