Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BE34AB00;
	Thu, 13 Aug 2026 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640557; cv=fail; b=JVFkJWxwmbj+PukfGni7w4y0OWCY1sRHnigE1S7bECClbuznS6q4AP28J3ptGKaR5grVBw4ykbZhM/X+CmSj51A26LxKpM1aVuo2uXMqTT27jtLMii2rDAE5VQmqTXMBbm06N0Di5yGladjMet1DqpYb+pgMNwVOzkTURKYkpvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640557; c=relaxed/simple;
	bh=bwj/mqjl6u6MqzqV0i/vhAneK/U0bSp31ehknVQRlQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xoe5sb3AockDLLLNJZBlptXdak45JNfGtGf4XiCDydqisg/CQGgDRnggQuEvv2ud7efMhE+n2HrfJh8ScI4jNw+QNxsc8yWqBbRKWE5Y0JyWkVSTdDYZijC5qNcbSY5LCHFRFfLZ2z+3vIK6wGmWYSTb9C2hNrVfzyo3zQqQtnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sNWLpp2w; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sNWLpp2w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwDTwmkibHoKcp20cY3Hp8KIwEoeVpLJCCWpdF9QmFT+GCH2o+easNsXL3GgVCOhOOw3/R6abZ5uT8xgJI8OxBA6hvfq4jtTxVBa+CUDN3HBrd1UJiWyU55NW5ehXMBP8ofY1JvRpsXdrsQMYrLHuOuRG9mFHAZWw7IlLwlK/wazTuwzPv+ZP7QCzfs/7B33GbMhB4iGIyYeQifLMehZ261xuW8DVbhDK1YKCYf+Yz5CgQXhVw26oBewLpwGMka7wBUSxdvwVIw/cWMgHOh00pxP3heFLlZgL0h+9oSTGz/D5fIVjr8dBADbGr7ZDx7ItsLYp5xYRf1IlSSVpdovhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0OEGouVi6BybDuoLEpQOjDGHQksohogcfv1bHu5pB4=;
 b=dbWy1Pb2bsxdcKd4l/X25YoQxoK3Ln2J4AanCq9+QQWTZj3RSPLGXSBC7Jjmiu1yiXFHPgmXnoIKmdTqp1hEHgWhlS3YRQX4E1dJGs/c50putVFTL0RkEepknmRVn/msucXTT5mAtaqJDvRVykewnPUW3sWEkoToJZW81igItGU3wYRVrtL28t48nA4AdABbm6oZmhus4BREgyvRDtqGXMubY3HOUk17yYS4gQi139kJ1U/mziSPyeCv1LQFHEZMaFOebwXa2F8yiXszEEqrggBAar4LvipY/Y29EXDnhuSxrdAo5bHVdzE0uNVXxPha9Vf9MUv6fN7Gun0QvC4DkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0OEGouVi6BybDuoLEpQOjDGHQksohogcfv1bHu5pB4=;
 b=sNWLpp2wk7lozshzcLlk7aXxzDgSvoS6se26voD/I87asXqcfR2xBKcsuQfOoBPvAG7+h8mJ1b/IN1mh+fKtoeAhph+SzhI+nNl1NsAdilBeVZolWQkXmIsZjJmwGI2vgghpkqWMR4dvtYjcRKahx5XFPU3RaCtb6N/oKVDgt+8clhm0JO/FLBTbnZofN/zQAg6pTEOS1kcqr0wsimdDbYxI0CML4jhLvUg6fT7Qz++uqd+LzsCwyFPWOUhhaBQs2dw1BWTs49INKaLmmPOMBAZ8G3TPwUYVR2JtrPkp+sSFVIM/bei1wEySVHfxh5FeNMnF8/WzxMuBgSqM6C/rWw==
Received: from PH8PR21CA0015.namprd21.prod.outlook.com (2603:10b6:510:2ce::12)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 17:02:25 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::84) by PH8PR21CA0015.outlook.office365.com
 (2603:10b6:510:2ce::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Thu, 13
 Aug 2026 17:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:02:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 10:02:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 13 Aug 2026 10:02:05 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 13 Aug 2026 10:02:04 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@linaro.org>,
	<mike.leach@linaro.org>, <leo.yan@linux.dev>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tmakin@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<skelley@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <mochs@nvidia.com>, <sauravsc@amazon.com>, "Besar
 Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 1/2] perf vendor events arm64: fix swapped MetricGroup for Tegra410 L1 prefetcher metrics
Date: Thu, 13 Aug 2026 17:01:54 +0000
Message-ID: <20260813170155.1156593-2-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170155.1156593-1-bwicaksono@nvidia.com>
References: <20260813170155.1156593-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc53cd9-a6b8-4c11-b36f-08def95ca64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|7416014|10067099003|56012099006|6133799003|3023799007|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	+Qs5KPxn/PjG7Ct7qmLp3NRvGr7qxWCf/PB89wENdJFzKFSN3JzRtaBULObN729GHWV3IMBzZ/2Sr6ogEsXsY2bvQTQyurEU0dUce4MbYnPOB5lEDUxrhq3vSBTY7Tczt6h1u7laHuReMkZ1s4BizbveFNUbRFujUGPWQyD9Xjhzl2rJNDBSgpq4oKwmIXMmURAbwYXviqDGUWOe/zQF1fAUyklkPKD6oXfBXxwRvom9uE1ur63OJuF1UzZzviTpguv479ODcKTYM2KbuE0mfZ5iIRprbdMJ0sCBH+bfHwzrk2rLacyabUQ0ErEaPT4rCmQ1qdYNwi9QCKoBb4OugewwZqIKt5bywUqj7VRsQrg4hxVq+54Nxs0FdMBA/CU1cfqX1wlhl6NoyZBttbtsraZ+salzS5bn6m6a6HV+lUFiDzijezXKGCiRAnvG9Tci9qNXB7lQeKXaoZXARUVfrplUankzO4mgTfIiODkxLLzsJQQ/HMfaQPfRgfMpSnIpF+iqayCEX2xoQsJ16UqpEpUzO0L9oPGhmyFAmoAtXpSLtdooZzDr9HVh1/YuOP6c6aaIx9P5H88RleKbejzsh43v5WfiYKx/8WvJpRWC8XFdsXEW/ni8Igm39Nf7M09H5ezkRKJ70ShycyDgZcUjjBHblvaV7uAQik4w0lG83PVxg+xilakXpDn7DL/772vdlXmvRMD8iMB6cOy+ZVNX+QYBanxNS5lr2dKMhItSWMiDVEWSRWunN8kS+e/cGgA6
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(7416014)(10067099003)(56012099006)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i2mmuEsBsx8fL4G/9Ltd+kphc7H8eBRLcZQ06+QzQZjhYC1ntqDjr+rDWlBtCFB9eE4DoXK0+uzcqU+iBgdSfZuU94m5Lo8gwS7WRV+mEvlVMYmvNPTP01tU5ls83xYnoUinFhIjtOzQu2KORPTdtJGl8hZEa6Qq4ljKafTVbwWz5nbiQ4H3zSeiMoNUfR8lp1STuDI+kLp/eLPWwtSvbwtEuIj0/hfdfmfyNlTK0NQip9hE3bpAMr+se8IlvxxC8peJ1hELarKYnJY2c3Sbv68vNv6+IYh3Gdb8muP9gxSACHivLBQAvTHYmcj/R7O3jV08q7z84iz5lmp3dvWJwg9U7euKwesabvRyqcwMgTtxyAUxsfagrO+JnunVICPYx0LdiQh9K8KGtt12CbBodPNj7vY+ZzodJY1eZ4QVGi09doSnzfKKBdCWcyy+5cxq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:02:25.5463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc53cd9-a6b8-4c11-b36f-08def95ca64f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883

From: Saurav Sachidanand <sauravsc@amazon.com>

The L1D prefetcher metrics (l1d_cache_rw_miss_ratio, l1d_demand_accesses,
etc.) were incorrectly assigned to MetricGroup "L1I_Prefetcher_Effectiveness"
and vice versa. This causes 'perf stat --metric-group L1D_Prefetcher_Effectiveness'
to display L1I metrics, which is misleading.

Swap the MetricGroup assignments so L1D metrics are in the L1D group and
L1I metrics are in the L1I group.

Fixes: 86ff690f45cc ("perf vendor events arm64: Add Tegra410 Olympus PMU events")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arch/arm64/nvidia/t410/metrics.json       | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
index b825ede03f54..59474ccb7417 100644
--- a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
@@ -346,42 +346,42 @@
         "MetricExpr": "l1d_demand_misses / l1d_demand_accesses",
         "BriefDescription": "This metric measures the ratio of L1 D-cache Read accesses missed to the total number of L1 D-cache accesses. This gives an indication of the effectiveness of the L1 D-cache for demand Load or Store traffic.",
         "ScaleUnit": "1per cache access",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_demand_accesses",
         "MetricExpr": "L1D_CACHE_RW",
         "BriefDescription": "This metric measures the count of L1 D-cache accesses incurred on Load or Store by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_demand_misses",
         "MetricExpr": "L1D_CACHE_REFILL_RW",
         "BriefDescription": "This metric measures the count of L1 D-cache misses incurred on a Load or Store by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_prf_accuracy",
         "MetricExpr": "100 * (l1d_useful_prf / l1d_refilled_prf)",
         "BriefDescription": "This metric measures the fraction of prefetched memory addresses that are used by the instruction stream.",
         "ScaleUnit": "1percent of prefetch",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_prf_coverage",
         "MetricExpr": "100 * (l1d_useful_prf / (l1d_demand_misses + l1d_refilled_prf))",
         "BriefDescription": "This metric measures the baseline demand cache misses which the prefetcher brings into the cache.",
         "ScaleUnit": "1percent of cache access",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_refilled_prf",
         "MetricExpr": "L1D_CACHE_REFILL_HWPRF + L1D_CACHE_REFILL_PRFM + L1D_LFB_HIT_RW_FHWPRF + L1D_LFB_HIT_RW_FPRFM",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 data prefetcher (hardware prefetches or software preload) into L1 D-cache.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1d_tlb_miss_ratio",
@@ -402,7 +402,7 @@
         "MetricExpr": "L1D_CACHE_HIT_RW_FPRF + L1D_LFB_HIT_RW_FHWPRF + L1D_LFB_HIT_RW_FPRFM",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 data prefetcher (hardware prefetches or software preload) into L1 D-cache which are further used by Load or Store from the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_cache_miss_ratio",
@@ -423,42 +423,42 @@
         "MetricExpr": "l1i_demand_misses / l1i_demand_accesses",
         "BriefDescription": "This metric measures the ratio of L1 I-cache Read accesses missed to the total number of L1 I-cache accesses. This gives an indication of the effectiveness of the L1 I-cache for demand instruction fetch traffic. Note that cache accesses in this cache are demand instruction fetch.",
         "ScaleUnit": "1per cache access",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_demand_accesses",
         "MetricExpr": "L1I_CACHE_RD",
         "BriefDescription": "This metric measures the count of L1 I-cache accesses caused by an instruction fetch by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_demand_misses",
         "MetricExpr": "L1I_CACHE_REFILL_RD",
         "BriefDescription": "This metric measures the count of L1 I-cache misses caused by an instruction fetch by the instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_prf_accuracy",
         "MetricExpr": "100 * (l1i_useful_prf / l1i_refilled_prf)",
         "BriefDescription": "This metric measures the fraction of prefetched memory addresses that are used by the instruction stream.",
         "ScaleUnit": "1percent of prefetch",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_prf_coverage",
         "MetricExpr": "100 * (l1i_useful_prf / (l1i_demand_misses + l1i_refilled_prf))",
         "BriefDescription": "This metric measures the baseline demand cache misses which the prefetcher brings into the cache.",
         "ScaleUnit": "1percent of cache access",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_refilled_prf",
         "MetricExpr": "L1I_CACHE_REFILL_HWPRF + L1I_CACHE_REFILL_PRFM",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 instruction prefetcher (hardware prefetches or software preload) into L1 I-cache.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l1i_tlb_miss_ratio",
@@ -479,7 +479,7 @@
         "MetricExpr": "L1I_CACHE_HIT_RD_FPRF",
         "BriefDescription": "This metric measures the count of cache lines refilled by L1 instruction prefetcher (hardware prefetches or software preload) into L1 I-cache which are further used by instruction stream of the program.",
         "ScaleUnit": "1count",
-        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
     },
     {
         "MetricName": "l2_cache_miss_ratio",
-- 
2.43.0

