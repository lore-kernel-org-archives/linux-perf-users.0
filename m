Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382667;
	b=WP9SLQzZEqZIfn2a0VM7RDKbkSzC9T9e28RCQgjxPE1pfICpv2z+LppapYYnVjfBZ6Vb
	 llB6RWjsQm6DV+jNN+o7EXQa9Yeq5jH31W8dol5SxAuMHQR+zPtfHUB3SVKfotMbKcA8L
	 wypwFSLo/VmncOkyZoj9XUUa78neM8TpkEMcrTk2k1ERZ3iT3iTmjI9elrEeu2wNsgVaq
	 7oYeG/3C9WNTrlbnTG0LB+PfKqwZ5LNiLmCj4j4+WBAUyUFr/2nUeW3AOYX73iyvimHse
	 R9MLopbxCOliQjRn+RaLv/8E0V3r8VQLmkxM6nH9OlAyfsCL0aXNut+iQWkqmyzObdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382667;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mvSUPbzCTjJJThI2f3r9MxLiZ1SBhclZHyCEEOagJ2E=;
	b=BVXp0yeGi1JmVmVkqCvda0AkMyrNEIE7UEWurLMxwcYKFowNsc8jCTv4E7gBXHOkcTqU
	 JKTmQZRpYYFLrLRIkrt+EgdLh0+AVgfeVsOqGKedH9ilXOUCnno3pzg1HL7iZ9d/DWtvr
	 jRBUIHmPttOuaiyPo5CcpItbfINTtjP5P2gSfZghW1CA2lHWc1DR+lsJsujqotENNo/02
	 uN6b4CAItRvn7QumIKcCTnjjs++egy7lcPwfKidVQIkGJ2a+aoJAJt+q5Qx1VdHqw0tBX
	 G0IGUki8NLdpSENTI3nKydvcNZqgCnym/7BNrPlPNW6SLiCn05iDJp0GrCbiDtJUNtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ODAUMRCs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.29
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E0606A31C;
	Fri, 30 Oct 2026 17:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C9E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ODAUMRCs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad1AxIb3QFN6k7pmStfBz1JHh5nhWHf3EgoUKPYbTTWP19GfvGOEspd2mAqCgqGqJcPB1xmrCrhQrX12vBajSLsLK62CjzA+fO6pbfLwIHd5zrst3oGdqQWkgXMswcmkwUpWUhyuQJ0Gv9p+V7GG1ZOMgPL7buCgLeLtXF74hu8zVNlV4Kt3JdZslTsUrg4L9nsEqRKaEjeQyYVXx2Z97JmvZnVVzntf3fXyLlCYiOaTi1U5U7b04RIodGDA/e/Z48PgDxPN5B7QE6NKXtX/G3GkWF5z8uzeW5nKaaPZ4Ji0TkUAKhhyPX1S/PNw0uexMqULqTBxDjPA2J6Csi25ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvSUPbzCTjJJThI2f3r9MxLiZ1SBhclZHyCEEOagJ2E=;
 b=UuPiOuAmcX/af0JGae60sciZW+yhYPksTB4SLEFl130/IDoEZUnpoTM/eYWpBjHtMPdhfzWKCex7wfVUyD9DN9XLQuipmgsfo15ZmDEwkJeB41XxvMXvlihiudOFbg+s8QBmc9SeK36h+1HRykcyjQRYcCV2+NhieGkmgYddkVHQcgHvFVQ5yaoDNBRPRT+fkWmFJvuolvY13ST380huviTn4ialFfqk/yses4i7O7lkqIjco+hDvJ93v8NSY43kBIaU44jqQYx12zFYHOm79TMyfNytyKN4zE8bP+oMU4aggTMvPZceTT0Zmda4L0d65JSsZ6u3L7Unss/yLEZntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvSUPbzCTjJJThI2f3r9MxLiZ1SBhclZHyCEEOagJ2E=;
 b=ODAUMRCsULwzCjMJeuNH7ye5wFoWVuWeCyxR46wlRYEEUnCTvE6Z5UWhGYrP+WoJgMArPcD7sm4A7pcZVO3aEsSJWAqdtDDgekffJkGBog9YmwjUM/GhoXfSn0vxDPRjYDmJdiosHVDRtiHSAAx1/gUPt+rOoIZ44zOqptL2CmzZk4IWIZDbsW13fAhMRdHkQzsc7QYz642W7xCZ++9XZFqm9gPapSx4P94MFWZhPnaFiqdcC97QL/VO3w5zqplM8aySHS3g1DTHnTubQsFnCIbGClzOqnoZr6RUXZkllCCWbIs2s6wYPDk8cHhdM0cgm2vNFnzA0cbq5eOQzK0RFg==
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:51:01 +0000
Received: from MW3PEPF00001654.namprd21.prod.outlook.com
 (2603:10b6:a03:33a:cafe::79) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 17:51:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MW3PEPF00001654.mail.protection.outlook.com (10.167.249.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Fri, 30 Oct 2026 17:51:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:50:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:50:32 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Fri, 30 Oct 2026 10:50:32 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<ctshao@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<mochs@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <john.garry@linux.dev>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v2 4/9] perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latency PMU aliasing
Date: Fri, 30 Oct 2026 17:48:11 +0000
Message-ID: <20261030174816.1544471-5-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030174816.1544471-1-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PEPF00001654:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 179366aa-6a66-4da8-0aa7-08df36ae5c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|36860700016|82310400026|261026140227099003|10067099003|11063799006|56012099006|261009223027099003|261022105027099003|261028144727099003|261021121427099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4EvBhYBke1WJaV+MENivEYCkfscn2fuA/8A/C8lmmR7eCLj2oJ2pmwuKKTsgHs+oRw/fG0vswtuyVpTfRvypYhOHNyAcddPpQP+zjgXsmQ9sNVozsxgitMbiE/+yMnwnXHzPPnh4bCeCijqTgDQWPd0wBhQ1xrQJS56Tj87IyuQJtWsJ5cBUZYhoJBDSnKrpSEFtyDh3SCETi5GCLAL8d+QH9E8yy1wMbyf15frBzc6M3HE9VdoRnRcGLdos7uVFdtT0pZ39ozqIkGabbXagiSAbx0+EzfSJcuNv5p/63PBO7ZRZVVYqkETWNmBPBYgvZczALDKsp1FcX9R/0t07QNUxa2B6+sMyypQr6+c18LzcwrAq7TskJkQJTBfwLueJc4PUcxapW3FLSnsi5K5HqK/HwbxFpIEHfGg+jWjNgLMXSHdqobZCMlzdDsx6K0x1f4lOERmdIhn6aSCg1p2ebHh8iZH3xyv16OS/Xz+GIZh0M4PfeOa+THvxYeKLU9bMyn5OnoHnxBXED0YWB9hB0Yvvi12g3l80huepNc5QA6d/xtoCH299dX2UzNTp21wDOVeeb7iZ+YMAz89eUehBZLc30hdXNXUxRkB5iQXArOFgz8jBYloHAc6/TY5LZROJX06gufCQ36vHEgpLwkEPje5NKziSuM6uKotMToOb4Xi11z6xzI06TPI5SuHzaP2DGCiYIeFgt5meIU3kDQUuwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(36860700016)(82310400026)(261026140227099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zpLRY0wpIO+iaFvL9+zr0BB3UPZjFLNgp+UVOAn+mj/3pE3mOSiaZZHPcBfYB4WwSdunqwRqRNmx1JKlCzz5qQ1V8KA+imWTywc4Rh3fwIBI4RhGSwChTBTuc0bHiFGI8/tuWi77s0vz95XkbpXqtyu2kFcG9R/G5TWKNYlBj8RB8ZB83aReSetDqMWBihFWY5I6TUAoOzVxsL7J/tfuK/+1kNVCCxkG1oRvn+ooOFGRCfTFgetnAYkw+MKprGcI1JxtIALU0nQiyixDyZCvmziPDL/AZXOTJgkIIAKjxWdGns+NoZH/zNaX7x9BacML9K4CEd1yxid7QpEIThJHo2VtJi4e1iqS7UKTD/qrQIGJE6RfyFIwRZSWszpsLTAEqOmRCftHs7AKKt21741WdP0bDGWtGn6JJqG38BOUkvJkl/2fE+e1vWJqs4n051Hc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:51:00.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179366aa-6a66-4da8-0aa7-08df36ae5c36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW3PEPF00001654.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750

Add alias support for NVIDIA Tegra410 CPU Memory Latency PMU events.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../arm64/nvidia/t410/uncore-cpu_mem.json     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-cpu_mem.json

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-cpu_mem.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-cpu_mem.json
new file mode 100644
index 000000000000..bb7907935d6b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/uncore-cpu_mem.json
@@ -0,0 +1,43 @@
+[
+    {
+        "EventCode": "0x0",
+        "EventName": "CMEM_CYCLES",
+        "BriefDescription": "Counts elapsed MSN bridge cycles for the CMEM read-latency counters.",
+        "PublicDescription": "Counts elapsed Memory Switch Node (MSN) bridge cycles for the CMEM read-latency counters. All MSN instances share this clock, so the count is read from the first instance.",
+        "Unit": "nvidia_cmem_latency_pmu_"
+    },
+    {
+        "EventCode": "0x1",
+        "EventName": "CMEM_RD_REQ",
+        "BriefDescription": "Counts local CMEM read requests at the edge of the UCF (post SLC), in 32-byte units, from all requesters.",
+        "PublicDescription": "Counts read requests at the edge of the Unified Coherence Fabric (UCF), after the System Level Cache (SLC), to local CPU DRAM (CMEM), at 32-byte granularity. A read of up to 32 bytes adds one; a 64-byte read adds two. It counts reads from all requesters, local and remote, summed over all Memory Switch Node (MSN) instances and channels. There is no requester or security-state filtering.",
+        "Unit": "nvidia_cmem_latency_pmu_"
+    },
+    {
+        "EventCode": "0x2",
+        "EventName": "CMEM_RD_CUM_OUTS",
+        "BriefDescription": "Accumulates the in-flight read requests counted by CMEM_RD_REQ each MSN bridge cycle.",
+        "PublicDescription": "Accumulates the in-flight read requests counted by CMEM_RD_REQ each Memory Switch Node (MSN) bridge cycle. Pair the two for the average read latency.",
+        "Unit": "nvidia_cmem_latency_pmu_"
+    },
+    {
+        "MetricName": "cmem_freq",
+        "MetricGroup": "CMEM_Frequency;CMEM_Read_Latency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(CMEM_CYCLES / aggr_nr(CMEM_CYCLES)) / 1e9 / duration_time",
+        "ScaleUnit": "1GHz",
+        "BriefDescription": "MSN bridge clock frequency of the CMEM read-latency counters.",
+        "PublicDescription": "Average Memory Switch Node (MSN) bridge clock frequency over the measurement interval. This is the clock of the CMEM read-latency counters.",
+        "Unit": "nvidia_cmem_latency_pmu_"
+    },
+    {
+        "MetricName": "cmem_avg_rd_latency",
+        "MetricGroup": "CMEM_Read_Latency",
+        "MetricConstraint": "NO_GROUP_EVENTS",
+        "MetricExpr": "(CMEM_RD_CUM_OUTS / CMEM_RD_REQ) / cmem_freq",
+        "ScaleUnit": "1ns/request",
+        "BriefDescription": "Average local CMEM read latency from the edge of the UCF (post SLC) to CPU DRAM, for all requesters.",
+        "PublicDescription": "Average latency of the read requests counted by CMEM_RD_REQ, from the edge of the Unified Coherence Fabric (UCF), after the System Level Cache (SLC), to local CPU DRAM (CMEM).",
+        "Unit": "nvidia_cmem_latency_pmu_"
+    }
+]
-- 
2.43.0

