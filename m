Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DB3A3E67;
	Tue, 23 Jun 2026 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192532; cv=fail; b=HuKbQUuLq4eNUe/AaBKfhIl1SAiOaWafah0wgjDklLVF7kCt8ihSkyq4NTUWNQ6U3hyW/Av/Ax+EUIJu/IqYjjX4TNPzW1rPNrr2b0yXPPsnxeiW2HcXPb8O2bfRemmL9iFHboBl5vwwakBkBoqTGB3r7rozqXqIuXsLPf70sfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192532; c=relaxed/simple;
	bh=hqjMuoRHlsLFPfBs+5hs+/gvz/IOE6+Rs2qHR3SPryU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iqchprYrfU4EtNOE5slqWHZjWpQaSxzdaPnpwfVZK5tHHuUW8Fp0X7pUaUerus+VMkgY4oVInk6jF+L3A8+dBxSqnQWxwFzZ/XDLlaPvpQHepx6zSyIdN/0l57trLByxvmr6YkZdro3zhSb0qwaOoSLtkfYjAJwZTUMjy14phUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MWl6OIft; arc=fail smtp.client-ip=52.101.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MWl6OIft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MU9Hgq7oRi2jOcpwuQ+7JE4XTq90GtHnkqSfuHjiuKGS955oPt+qL1WA2XU+awCXkvjOBGMxrYOgGTQ2ETmniXUM+zcycKCZfeYb6nqDUomeNbgxfTriuIUiHUpd/ecL/UC45FqK0FN8UOfzrSP2KI83bhApGxhe0mLtBPLrV9mOAGjNWb+O+i9cYN86Ia25GiODflrqHZIjL3ShUvJQV719isMQYYKtzgglYftKpMicJWcCLSlzftTL8FfHvzmP1ibMn0VI3+bO0c3st9tWsKtA1HldGWD69cXueQg3G1CLOyGbPfmFhXyiRMctBkTi9WtPaXhN4CLEd7BcDgKDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC3lNQUQeIEPfDHY725Tm6i01hGhImtIV1pbmqmOuJU=;
 b=zIK8O0EV9BI/X7Krdm68QZeEMDYic3PYHmQmUM0Pl9/LgoF0mst8+Nbpmp+0qOi92l45WDtiepG7KqR0+a9izxGQcDV7m49lgTXIqbMmNMZjlDbBRe38Edh5yTgIqzoq8UHe6Z/V8ltTGcE5OWwn3hbhe7Tk84rfTIsR35o9IzcAdHpRhuOepftpKGPZYpOAL7Hugce4tM2PNskkZ6UmHLpx7i3X3TzTFIA/rXOYVeMcWOHsa9z92+O4IGYn8D1kW/wyeGrz52NfJbGzhDFhr7fU6OR0PzJKAFkJRptNUIoFPaQawDAzIDUe1hOXm9xPb6RYL9UfVSelig4u1tURyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC3lNQUQeIEPfDHY725Tm6i01hGhImtIV1pbmqmOuJU=;
 b=MWl6OIftKS/1hF1/u6wtJ3Z+c6Jr8tLJwX9V+CAQ8/3RR0qJrGugqo+jKpFWwJlgacSQblzuirYXEFDIv3x7VLkVRrH3xYj5u+Kpqdj+70ZMErOLtkhiKxKFVPo021TWDSCu+Lh6w7gDFuOG3q644j8ObF0nezAFz8GygHG1Dzc=
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 05:28:46 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::7d) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 05:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 05:28:45 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 00:28:40 -0500
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
Subject: [PATCH v2 1/2] perf vendor events amd: Update Zen 5 core events
Date: Tue, 23 Jun 2026 10:58:31 +0530
Message-ID: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f7a021-e776-4fed-852e-08ded0e84c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|13003099007|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	QPTP1RSYYBVVmYk2ZMLqDFkAd2SOe+qjcJxfzY7ZlJTCyjL433QYgZ88mjYj4TbW3Jcz0cK+F76JEqASUUr6nwOB9OGi8057Ggtx5c3g3ECtqwyjtEu475ST3gilEE13P47Bks5wyA2Lws5PUYVJ6ZIss8ODpflhB10DsaxUwM2ZnLFhdaPbnJGNBdTUikl0yzH/hkuNx0bi2bldrCs+QlX6iO8zFu//obglKtGW7ByuA3qExn7LQfAsu8cLrqw3kkF5jIw33ycUUAEmXjmIOBiCrn0uEFN/oika56eSzE1ktTFE7ZYMNktsgy0kLudonOpWjoCjOF7+i2MiCl+dpaTID3gcrJX1opqIYIi29Q8eIJh8awTeBIREtgZD39IUomw7kVOQ8YNm3fUTF6wHFa5mVL3pchmIAV2kJMwtSHRgYOeIvj+Zo5orHVMWVTER0APVa36H5CwRJ8bVjOoctMHKokHJUuzdmLLxsfPXh6geetlR6o2rrYhZrR66/Ryi5WsS2b1jeWeJTCY3BjN+vPtowKk1nQ2mpzZWrY6bDYnoNc8/NWSHyNdEZAxOlBb4BYiCYvGkzKFId25S2oOJnC+ZlSkiSJUDIoDib4WwW3B2Dqt1L7pMzhftQK2kPjquG8q4De/RAp986xybZ/aBMGB30xKIBliRtAtv8Z7twNcmVaj5yfQl9TZGwjngr30eZBHuPdcI7cZvayPKYlucMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(13003099007)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CHZKESIN9XeLHewQdFmKxeQKk8xCqdoE137ZO099Imv4mw4S9QdZofPZhLN3DfxwzzEtw8tURocOLGeAxXmCtiwxMu8GOA3ZacXTv1RSMSZvC7M7KeNOXw+RgCIlCnnH5uQhM16gYS5HArVjYWnnJRgZ8rWzmhV9Nm4yZq15DBBmdxo6/04kWVRbY3JTVkI50S4wIUESRHxezvweFIJGeH3rUWzF9hJctqcBepazIvXsGFwbp8GpwfjyRDbwFNq3Klzbxh7w8u9Nc5Z5TKZCsjP19XkV3NERgxfPYn2jeEtF9np3+zMtGf/FifWjR83S06zoigz7gyM+lYMtCRKnH/cciizOOMuMrS/qBeobvdBdIZkHoPEFV0VUtbeKgyq8Ku3Qf8OqQeL9KrHtzS9L7hckQbGRnIPMUFmTSWwcfhhZIPkwcn1gsOCzIn2xgAiF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:28:45.9300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f7a021-e776-4fed-852e-08ded0e84c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224

Update definitions for the following events.
  * PMCx00A - Add missing unit masks
  * PMCx00B - Add missing unit masks and fix descriptions
  * PMCx00C - Add missing unit masks
  * PMCx00D - Add missing unit masks
  * PMCx025 - Add missing unit masks and fix descriptions

Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

Previous versions can be found at:
v1: https://lore.kernel.org/all/f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com/

Changes in v2:
  * Fix event description pointed out by sashiko.

---
 .../arch/x86/amdzen5/floating-point.json      | 130 +++++++++++++++---
 .../arch/x86/amdzen5/load-store.json          |   8 +-
 2 files changed, 120 insertions(+), 18 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
index 9204bfb1d69e..569975b53cc3 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
@@ -179,6 +179,30 @@
     "BriefDescription": "Retired scalar floating-point blend ops.",
     "UMask": "0x09"
   },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_mov",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point MOV ops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_shuffle",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_bfloat",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point bfloat ops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_logical",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point logical ops.",
+    "UMask": "0x0d"
+  },
   {
     "EventName": "fp_ops_retired_by_type.scalar_other",
     "EventCode": "0x0a",
@@ -245,12 +269,24 @@
     "BriefDescription": "Retired vector floating-point blend ops.",
     "UMask": "0x90"
   },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_mov",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point MOV ops.",
+    "UMask": "0xa0"
+  },
   {
     "EventName": "fp_ops_retired_by_type.vector_shuffle",
     "EventCode": "0x0a",
     "BriefDescription": "Retired vector floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
     "UMask": "0xb0"
   },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_bfloat",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point bfloat ops.",
+    "UMask": "0xc0"
+  },
   {
     "EventName": "fp_ops_retired_by_type.vector_logical",
     "EventCode": "0x0a",
@@ -278,7 +314,7 @@
   {
     "EventName": "sse_avx_ops_retired.mmx_add",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired MMX integer add.",
+    "BriefDescription": "Retired MMX integer add ops.",
     "UMask": "0x01"
   },
   {
@@ -299,16 +335,34 @@
     "BriefDescription": "Retired MMX integer multiply-accumulate ops.",
     "UMask": "0x04"
   },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_aes",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer AES ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_sha",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer SHA ops.",
+    "UMask": "0x06"
+  },
   {
     "EventName": "sse_avx_ops_retired.mmx_cmp",
     "EventCode": "0x0b",
     "BriefDescription": "Retired MMX integer compare ops.",
     "UMask": "0x07"
   },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_cvt",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer convert or pack ops.",
+    "UMask": "0x08"
+  },
   {
     "EventName": "sse_avx_ops_retired.mmx_shift",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired MMX integer shift ops.",
+    "BriefDescription": "Retired MMX integer shift or rotate ops.",
     "UMask": "0x09"
   },
   {
@@ -324,9 +378,9 @@
     "UMask": "0x0b"
   },
   {
-    "EventName": "sse_avx_ops_retired.mmx_pack",
+    "EventName": "sse_avx_ops_retired.mmx_vnni",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired MMX integer pack ops.",
+    "BriefDescription": "Retired MMX integer VNNI ops.",
     "UMask": "0x0c"
   },
   {
@@ -390,15 +444,15 @@
     "UMask": "0x70"
   },
   {
-    "EventName": "sse_avx_ops_retired.sse_avx_clm",
+    "EventName": "sse_avx_ops_retired.sse_avx_cvt",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired SSE and AVX integer CLM ops.",
+    "BriefDescription": "Retired SSE and AVX integer convert or pack ops.",
     "UMask": "0x80"
   },
   {
     "EventName": "sse_avx_ops_retired.sse_avx_shift",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired SSE and AVX integer shift ops.",
+    "BriefDescription": "Retired SSE and AVX integer shift or rotate ops.",
     "UMask": "0x90"
   },
   {
@@ -414,9 +468,9 @@
     "UMask": "0xb0"
   },
   {
-    "EventName": "sse_avx_ops_retired.sse_avx_pack",
+    "EventName": "sse_avx_ops_retired.sse_avx_vnni",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired SSE and AVX integer pack ops.",
+    "BriefDescription": "Retired SSE and AVX integer VNNI ops.",
     "UMask": "0xc0"
   },
   {
@@ -497,12 +551,24 @@
     "BriefDescription": "Retired 128-bit packed floating-point blend ops.",
     "UMask": "0x09"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_mov",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point MOV ops.",
+    "UMask": "0x0a"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp128_shuffle",
     "EventCode": "0x0c",
     "BriefDescription": "Retired 128-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
     "UMask": "0x0b"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_bfloat",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point bfloat ops.",
+    "UMask": "0x0c"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp128_logical",
     "EventCode": "0x0c",
@@ -575,12 +641,24 @@
     "BriefDescription": "Retired 256-bit packed floating-point blend ops.",
     "UMask": "0x90"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_mov",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point MOV ops.",
+    "UMask": "0xa0"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp256_shuffle",
     "EventCode": "0x0c",
     "BriefDescription": "Retired 256-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
     "UMask": "0xb0"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_bfloat",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point bfloat ops.",
+    "UMask": "0xc0"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp256_logical",
     "EventCode": "0x0c",
@@ -648,15 +726,15 @@
     "UMask": "0x07"
   },
   {
-    "EventName": "packed_int_op_type.int128_clm",
+    "EventName": "packed_int_op_type.int128_cvt",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 128-bit packed integer CLM ops.",
+    "BriefDescription": "Retired 128-bit packed integer convert or pack ops.",
     "UMask": "0x08"
   },
   {
     "EventName": "packed_int_op_type.int128_shift",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 128-bit packed integer shift ops.",
+    "BriefDescription": "Retired 128-bit packed integer shift or rotate ops.",
     "UMask": "0x09"
   },
   {
@@ -672,9 +750,9 @@
     "UMask": "0x0b"
   },
   {
-    "EventName": "packed_int_op_type.int128_pack",
+    "EventName": "packed_int_op_type.int128_vnni",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 128-bit packed integer pack ops.",
+    "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
     "UMask": "0x0c"
   },
   {
@@ -719,16 +797,34 @@
     "BriefDescription": "Retired 256-bit packed integer multiply-accumulate ops.",
     "UMask": "0x40"
   },
+  {
+    "EventName": "packed_int_op_type.int256_aes",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer AES ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_sha",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer SHA ops.",
+    "UMask": "0x60"
+  },
   {
     "EventName": "packed_int_op_type.int256_cmp",
     "EventCode": "0x0d",
     "BriefDescription": "Retired 256-bit packed integer compare ops.",
     "UMask": "0x70"
   },
+  {
+    "EventName": "packed_int_op_type.int256_cvt",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer convert or pack ops.",
+    "UMask": "0x80"
+  },
   {
     "EventName": "packed_int_op_type.int256_shift",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 256-bit packed integer shift ops.",
+    "BriefDescription": "Retired 256-bit packed integer shift or rotate ops.",
     "UMask": "0x90"
   },
   {
@@ -744,9 +840,9 @@
     "UMask": "0xb0"
   },
   {
-    "EventName": "packed_int_op_type.int256_pack",
+    "EventName": "packed_int_op_type.int256_vnni",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 256-bit packed integer pack ops.",
+    "BriefDescription": "Retired 256-bit packed integer VNNI ops.",
     "UMask": "0xc0"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index 06bbaea15925..b1994539ece8 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -8,9 +8,15 @@
   {
     "EventName": "ls_locks.bus_lock",
     "EventCode": "0x25",
-    "BriefDescription": "Retired Lock instructions which caused a bus lock.",
+    "BriefDescription": "Retired lock instructions which caused a bus lock.",
     "UMask": "0x01"
   },
+  {
+    "EventName": "ls_locks.all",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions of all types.",
+    "UMask": "0x1f"
+  },
   {
     "EventName": "ls_ret_cl_flush",
     "EventCode": "0x26",
-- 
2.53.0

