Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A928CF6F;
	Mon,  1 Jun 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330589; cv=fail; b=O+SsU9a7/m9ZmRNnNmHcsasubWw7UBofSGsr/NKY8IVgKL5I8l07jZCo7CEem7VVSaAxmOHUKMWlI9jUcdRxkl0ajvT/7rPzfMysBP7NaBuMrm29DfwEDDMH4IwgLKWvq5hNY0we0ftUYnXqzMjBPrKOmtilkxvGmtMxKazgOt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330589; c=relaxed/simple;
	bh=1D4FaRJTrcbmKbmEA66G+Y3Qc2OD6lOk3cDMdoNM104=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8Lkq1v9EoF0GOXqGHFe+rCxOidAXYOYgcV6F44rEVW4/bb4eElnokLnC6bCQ7HTQJIr+JQxc6ik7MNidh3GGpc+9GZ69UfLSQvu+X802qw+hlSXfkM42N5mMYebtYAJaSmJzAayxZSpPliBUW3uajY9QRNSem9FOJJ4dVRgqMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPI1iOGl; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPI1iOGl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMJTgBNivTrQnocSn0OGSgWpZyUOwNHME6epX4kO+L5YzBMdofUqq1cFdO65zm1xAeqZIHyYlDigW7BfRR2iRRMKM9A2u1A359+Bx60OqQsK1do3zIXLjXWaQ8Q8ViodhZvppWsefeI6PzHTtsj8Rq9WgJmRxDcHMFqlKrDP6j4y39oshqUHjYHUhaBWTXf+6WwdPpLRkx8bkW6Kqay1UFiHzS5qU8ZMxdITElOHeW75sAWsw9mU2adohyiyfhDj9rHjLlgBXRNpx40ckbTC4AVNmj3bstOAuXdm7i5wHKGMDXMA1q70n0AvJXmwZwrbLwq22mB2psbQHMLf6RNaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgcoAwYrhq+rDgy2LY1jaQt0ubujAAxP4CT5EugSRS0=;
 b=nQ4G0ZLUBN3SW3t+/26V9hYo2jSJMZzmQi9lDg1nTSUxYrKEZu4+B2fbmvZbWIRsSddHn03E+siG+DHmgmHz37zKG/+oD/V7Q0aDR2/AmMxZU6lJ4Vj8e/aGiud5Wg74o/Rg1HhxJ5f+M9AnSlFHlJ4NAZR+tBis9WaJaGACf4sNqtx/smoAD8O2jHlKuHSXFIi05qlTI8ZoLV/wngIjbkL6tObSxNrKB2ICRS3DGlJvZeHQUOUQ2mPFEYPNi7EK1axbXXW16f2wABRRx9tUdNplSAQIpQ4ZscuD8V8Lr3dW0KQ7/JHWH8xoDehR2e8bEME7+rdaXMAS6KZHI/mehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgcoAwYrhq+rDgy2LY1jaQt0ubujAAxP4CT5EugSRS0=;
 b=VPI1iOGl4AjnTvju4R6cPH6w8Nbh9U3GX0QrV4bGJcevTfrnLNX9EfakG51Ie0dd/vigFy2HQiop+SSV822+kwBsYbCuuaNMtRkoHLIYrfaeeEzDKB5iJZ+X9fZEOdt4nAiH4ZVhIMElYCBZP97Gr8iAPBmjaE4wkxeyZheZHOw=
Received: from SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 16:16:19 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::43) by SJ0PR05CA0204.outlook.office365.com
 (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Mon, 1
 Jun 2026 16:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 16:16:18 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 11:16:11 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 2/2] perf vendor events amd: Update Zen 6 core events
Date: Mon, 1 Jun 2026 21:45:46 +0530
Message-ID: <3bcbc34343711b581e0567070dc382510907bbc9.1780330378.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com>
References: <f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: ee69e5fc-d06e-4be8-c045-08debff91d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kbbt4uXSviivjXSBN2wzCBzAKb+KPudbAGLfcMagx5sPU9rJdba/JJ2zRUu7ememjXFRLNzkPBRjwaBK/PdSc9hX+2ES59I5DJxW6OSZF4DX+1Jy5s8xAf+rLMFMblFR0qM7kiqGgg1y7iSyF4wtU8RzXQtkFhQ211AaD3zaQSsDD+d+ZgwHFquFPRhpBu0cipam0nZ5ruFy1kqlLxQ/LAP+DYuyEYJZru3F7fEVHlO7Uu5x1QyAMM1ateYK4vTVOUT7o3+o4IouvvMAYbwhW7OOhlGhwkqzeLewUHv992fxskw0xQ/NlbQkJ8V7RhsSSGmfF189hV6cI0Lj7TxiotmkD/zwc1IeCsl3So9vZSQXotaH0zmACjTkVPpT3MWgRl1q5qVN8mumsOKQQvl53i0ySh4fbm+skuosn4yusk8ddS1gDdXRqVKeBg9FJqi2xFxn5qyZDz0ovWiyPcXrVePFuNsBGgCwa8RMjRqN02XpUDuVkbQ4V4hOGUfwAr5oDDlQ8OACJ66RJ58PUxX/ZCXD3HoTLwoSaqqlZMpjVsMclejCpGmIaReLZdfBvXI/VL52W9Rpu3IPHvfBB4yZHQIF6UBSkLYV4UU90Fh9S3+WgMy6WePozG0H9WA7CIGLeRv/z83++yxacg9YuzHH3CxVlxfPCjlYrhjPdp+YyuCgt7tAf1Hg6E8jzPrDz0tdf601hXQInDihi9runtcir2ltDqhhskNRGiTiNKOfDDM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Ku7BIDzOf52v/Uq8/4KHzwFdhyvR9yVOZ1L4EMKuSvDTVJXeXogOWo19Zk1PvglXRYRELP0brY0rxaxABM0bHlfu6MuZZGyM4tG55lzjOj6j0AxAwhsXFQsihI4cjrtSBiHs+4xv3HdoIh4lCs3/ZvUVWKk6iMP4RcBU9HfHP76ASNy1m+0e3KlUg+Hev3TIJhH1T4nOZLKHk5tq4v0ZglpIsmr6JaT/uMVrRt+ksDnhESxAdfXLezMgRixA/pe2++NqL4Z8+uGClh22r7qLMrwNinxckykCc7dh7RysT8jcNMOdcWnA0+Uc7HfO46+t2LQfQQAZjPxh1F92VoasRKKpThl6EJ8Wf3jBuHKpRClgxeT4dMlNVlvzIwzjoxlaZiJ81sAQATS7oRHJmgvM9dIhqgfTM1AIsmengi+3Frqip2biXxViTtVQ1iidSUx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:16:18.7692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee69e5fc-d06e-4be8-c045-08debff91d12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136

Update definitions for the following events.
  * PMCx00A - Fix descriptions
  * PMCx00C - Add missing unit masks
  * PMCx00D - Add missing unit masks and fix descriptions
  * PMCx013 - Fix incorrect unit masks

Fixes: 2f42fb0661d9 ("perf vendor events amd: Add Zen 6 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen6/floating-point.json      | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
index 03cb039434de..71b883776f37 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
@@ -212,7 +212,7 @@
   {
     "EventName": "fp_ops_ret_by_type.scalar_logical",
     "EventCode": "0x0a",
-    "BriefDescription": "Retired scalar floating-point move uops.",
+    "BriefDescription": "Retired scalar floating-point logical uops.",
     "UMask": "0x0d"
   },
   {
@@ -665,6 +665,12 @@
     "BriefDescription": "Retired 256-bit packed floating-point shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
     "UMask": "0xb0"
   },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_bfloat",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point bfloat uops.",
+    "UMask": "0xc0"
+  },
   {
     "EventName": "fp_pack_ops_ret.fp256_logical",
     "EventCode": "0x0c",
@@ -758,7 +764,7 @@
   {
     "EventName": "fp_pack_int_ops_ret.int128_vnni",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
+    "BriefDescription": "Retired 128-bit packed integer VNNI uops.",
     "UMask": "0x0c"
   },
   {
@@ -803,12 +809,30 @@
     "BriefDescription": "Retired 256-bit packed integer multiply-accumulate uops.",
     "UMask": "0x40"
   },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_aes",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer AES uops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_sha",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer SHA uops.",
+    "UMask": "0x60"
+  },
   {
     "EventName": "fp_pack_int_ops_ret.int256_cmp",
     "EventCode": "0x0d",
     "BriefDescription": "Retired 256-bit packed integer compare uops.",
     "UMask": "0x70"
   },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_cvt",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer convert or pack uops.",
+    "UMask": "0x80"
+  },
   {
     "EventName": "fp_pack_int_ops_ret.int256_shift",
     "EventCode": "0x0d",
@@ -1083,19 +1107,19 @@
     "EventName": "fp_nsq_read_stalls.fp_prf",
     "EventCode": "0x13",
     "BriefDescription": "Cycles when reads of the NSQ and writes to the floating-point or SIMD schedulers are stalled due to insufficient free physical register file (FP-PRF) entries.",
-    "UMask": "0x0e"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_nsq_read_stalls.k_prf",
     "EventCode": "0x13",
     "BriefDescription": "Cycles when reads of the NSQ and writes to the floating-point or SIMD schedulers are stalled due to insufficient free mask physical register file (K-PRF) entries.",
-    "UMask": "0x0e"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_nsq_read_stalls.fp_sq",
     "EventCode": "0x13",
     "BriefDescription": "Cycles when reads of the NSQ and writes to the floating-point or SIMD schedulers are stalled due to insufficient free scheduler entries.",
-    "UMask": "0x0e"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_nsq_read_stalls.all",
-- 
2.53.0

