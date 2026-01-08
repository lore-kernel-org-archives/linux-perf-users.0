Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A83378D82;
	Thu,  8 Jan 2026 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858795; cv=fail; b=abei/YIFQQUl76wHppghKousqO5WRlDgOpcHy9VeTh//NSAz9gNHSMOf9EpL6Q70Ozl2vScutbcWC8/6mAwP69mRtdfqpYJzYdf0En0sP0Gs7L82ajpo4gqwJDWV4EIOwuZiBv20kNcTg0iC2g2u7EPboJwk1/ehBxxOI/dqaiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858795; c=relaxed/simple;
	bh=xFi3GJipmc4ALFrbwvMUGkTRjR201i984FPHpMPxJ4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRZ1xL+2Lc4qHA3zqBOCpvTAdiySLgNSEnlLttVWLNaAjAvYv+gcc7owDrFx25v0kyQjGJuTNkrTcWf16GG4vHX9ka4sk55crN6W3/4XYmf5ShaOMAKWqnOwr4j6IzTB/55vITesc7a4IhToIwuyxPNEc7SNBsaHb9PeYakFeeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=On8avOd+; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="On8avOd+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAdpKIv2zm1PcSL+Cu8L/jObokWU82Y7BFS26VwwIF0QGI7eyg5cOHc6anOK40af89xYXkQZVzk0wEXn+71nZjKuZ9e4PH1GmgVkwLH1Ww/1rvDHq1/t94Ls5PKCj/ZQxyiJHUfaiovacFlzsXNuQFvKsm7c1I/TQ9IVVGMqxEMMzlzwhuTUY8arPIIbL8bK93enzKKKGD/ZO9vcVLYi0ffSqF4MWogumrYnZreUDGmy9bkmkfEamUrjCQs+ESEgJar1CxpqUdFxDHhi4/irwwRjQV4ZKZ0HhHsSpZRJwVlbEIe8km/vtdl7ppWD1mPBr1GzMZROsc5EMQXjfmjkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6IJNEuIZtpgv588zKOWnQ5XueN/7oQJbROtC+J7fAo=;
 b=f9oc26qgBkkQ+w4N3uQoIXRRXIZHLdpKNVdPEEuZxLrAbNO4skxgJBG9BKtL0Fq0wF0cPkqRt3E6M5M5zQO264GYAKiCJ9IiG48+nqOSDWrXXGXvxBkJmmE9NXJDnJ0P6a7hczFoX1MAU2yiwPK+ya3lP6LrrNQQ4/DX/ZNDdzNJJjf3jVM805de9VWfy7En+UscPv9ATBVRYsnbVj2IlzMKYKfdsaF4lvnRKZDcWH5QxuWbtI6ylssPmBArV4LfJQgLle86Fi69iXrUzaoAolyc1Sj+UjJf6ZT/Kt8ksW00JxFoJ065BdqTmsmosZZ0VXVJxjqkTCzIqzILq7ZOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6IJNEuIZtpgv588zKOWnQ5XueN/7oQJbROtC+J7fAo=;
 b=On8avOd+8034V8fjrxSJZya3sBEP0ma5mHax51I5cCTRLEm0rxm/2MNY/qSXp7o3ZeQZzZGJRPEFsG0Xj8tdML0rIGiBv2QssIbs1aRZgwUHm8BIZqwU5mpgtV1bJmQXMpvyCgnKEHjMKR/nuraFeLtXdDoIfb+yKA40tM8Oyus=
Received: from BYAPR11CA0068.namprd11.prod.outlook.com (2603:10b6:a03:80::45)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:52:49 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::be) by BYAPR11CA0068.outlook.office365.com
 (2603:10b6:a03:80::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 07:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 07:52:48 +0000
Received: from sindhu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 01:52:42 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/4] perf vendor events amd: Add Zen 6 core events
Date: Thu, 8 Jan 2026 13:22:14 +0530
Message-ID: <ac67e19f44f6483a501bae5ce5355d961681e4bc.1767858676.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767858676.git.sandipan.das@amd.com>
References: <cover.1767858676.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 216a50b2-32a5-4be6-c0b5-08de4e8aeb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|7142099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?StanL9KMRMSBTcn/kH85dp4/Ehkc/vuHCG6XNNAhVJhUv5l+kI1sqaCRGRIi?=
 =?us-ascii?Q?gnRVu48e/JiUZjmP0uFgekC5GehB4d0kq0ve4+1jOEuX/JIeMEqpI71OWQ1N?=
 =?us-ascii?Q?XmpvheWbzL5JdVxu2sYM4k1vvWQBFBRS/gHJM6o6xXiVENtDU3K3bXzeVvr/?=
 =?us-ascii?Q?odF+22kDc3FIJz8trbtrhuIiTGYcnWB/xHrACaekKpYvXKtEv0BIPu7zGBRO?=
 =?us-ascii?Q?HHDqO+hwrlY7jtYEGbnAtvUuKKDF6UflRWobUW8CVte/PdpXxCR5+owTCvTQ?=
 =?us-ascii?Q?3+badUjdzMa8ixlyVsKjfMsnnCZdGVvRXO3gAT+1Vj7K2H1wxU3t/KhjN/3N?=
 =?us-ascii?Q?z5imGRfu3v7dKkIcC9r0A0nTf/zJIV5gH51DBfZ+E2MpifChy8Wdckigchdl?=
 =?us-ascii?Q?jpYQoEZrqcebLlmEWOLHQdeZmja4At1UxWAu5TReeIYfw9fjFGWEyMjyIIly?=
 =?us-ascii?Q?+EAUQhOI2CyiDRzDW5ymTU1W8LdwYXi+tSR+RQtm77bZaPzL2FMtqVhITEOS?=
 =?us-ascii?Q?CEBh414i6CdHmxFh+ulRDy9sAec6coj1SzWzIR9LvHgvhpQHXkb6vd9Hlhuo?=
 =?us-ascii?Q?qGr6fdQNY001temZbn5f8wHPCPGa/SNrYAf3Gk7UeTheKv9EC+Qy09auKDoT?=
 =?us-ascii?Q?/Q6C4fF5Io3DJei/omXv/svvfo6ghqTGn3gM0DlFbjle2bh/0mKtkdUoo2dQ?=
 =?us-ascii?Q?xQxWtFdzZRjUTFfLBt3Hjjd6G9IuVeJpc1COQcKmGzhyNyKSp8JUjfb1aeY7?=
 =?us-ascii?Q?IBmkSPP6Z+POXZZKC0UC7ZJebvj92gc4waNfEIZ3GS7vDUzwRiVeNAhV5uR9?=
 =?us-ascii?Q?IJ8LRCIFj8G1OeebUTHzNRHw1D+qkZ/yCP1u/KOutOVv/GZhgiOZfFBAkNOz?=
 =?us-ascii?Q?h4iBnQBmvz7boR4XhY/CwzTeRwdoRKD1XGEXesdzvcd8/iElPnslDr5lI7E4?=
 =?us-ascii?Q?X8f23sgdX71sabF6ciLroQ6g/TJ1NY/vFNZcFGCxec1iiuALmdhLU3mZiJ9j?=
 =?us-ascii?Q?JfKbccwAZioDgtOU7pY/+o38D1h3tdBnMD008YvM0mhTRgfiE5zTdVbpb6Sa?=
 =?us-ascii?Q?mYPBc91cHkgFrMDV11/tdFoCyjHsWCUyTAmHPtc5aUsXBLI41S48V6zE/dQc?=
 =?us-ascii?Q?xQrsuox4T6JjXZn/f8QoRXvTgHrP5jWOkQNUi6xzCagt5a8hvePMCuczDwWQ?=
 =?us-ascii?Q?RWHJxiI5x631BVLiw1pTU8Z12tMNBe/Bx8qlT42dokDb0WiaDih2gTlEquoI?=
 =?us-ascii?Q?s/0jX8uwNGY5SHGeU4e2jfIE+x0DxxfwYxNE+VFTqksEgxoThux8pMpeMIkK?=
 =?us-ascii?Q?hrNfgKbRF3lNusxq9AR1iMpOHbB75t0AIgviwqD4aFL4F0kgHc7MB9016mWt?=
 =?us-ascii?Q?8H1ZfG7YhfdTJKzbiVcz+6v/wEoV2RBu/zRnaNAD0zgRmgTFp5Q8rtS54V4A?=
 =?us-ascii?Q?PvxnNPAzdFsBYJ0wU4jxUfhGLngAxYLRxfEhihV7UyqtvA0f/EwObdc9jXU3?=
 =?us-ascii?Q?z2ki2cq/SbZpgR7utcj8YYWzf6JXwHU4YpTaRGkKcaTAL+wt/hxkIVnoBCUJ?=
 =?us-ascii?Q?khu8OypthlKbdmnSqXY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(7142099003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:52:48.7483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216a50b2-32a5-4be6-c0b5-08de4e8aeb08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934

Add core events taken from Section 1.5 "Core Performance Monitor
Counters" of the Performance Monitor Counters for AMD Family 1Ah Model
50h-57h Processors document available at the link below.

This constitutes events which capture information on op dispatch,
execution and retirement, branch prediction, L1 and L2 cache activity,
TLB activity, etc.

Link: https://bugzilla.kernel.org/attachment.cgi?id=309149
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen6/branch-prediction.json   |   93 ++
 .../pmu-events/arch/x86/amdzen6/decode.json   |  139 +++
 .../arch/x86/amdzen6/execution.json           |  192 +++
 .../arch/x86/amdzen6/floating-point.json      | 1106 +++++++++++++++++
 .../arch/x86/amdzen6/inst-cache.json          |  120 ++
 .../pmu-events/arch/x86/amdzen6/l2-cache.json |  326 +++++
 .../arch/x86/amdzen6/load-store.json          |  523 ++++++++
 7 files changed, 2499 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/branch-prediction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/decode.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/execution.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/inst-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l2-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/load-store.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/branch-prediction.json b/tools/perf/pmu-events/arch/x86/amdzen6/branch-prediction.json
new file mode 100644
index 000000000000..dd70069f68ed
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/branch-prediction.json
@@ -0,0 +1,93 @@
+[
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "Instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks requested) for 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks requested) for 2M pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks requested) for 1G pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.coalesced_4k",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks requested) for coalesced pages (16k pages created from four adjacent 4k pages).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.all",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks requested) for all page sizes.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "bp_pipe_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "Branch predictor pipeline flushes due to internal conditions such as a second level prediction structure."
+  },
+  {
+    "EventName": "bp_var_target_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Indirect predictions (branch used the indirect predictor to make a prediction)."
+  },
+  {
+    "EventName": "bp_early_redir",
+    "EventCode": "0x91",
+    "BriefDescription": "Early redirects sent to branch predictor. This happens when either the decoder or dispatch logic is able to detect that the branch predictor needs to be redirected."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if4k",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 4k or coalesced pages (16k pages created from four adjacent 4k pages).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if2m",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 2M pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if1g",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 1G pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.all",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for all page sizes.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "bp_fe_redir.resync",
+    "EventCode": "0x9f",
+    "BriefDescription": "Redirects of the pipeline frontend caused by resyncs. These are retire time pipeline restarts.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_fe_redir.ex_redir",
+    "EventCode": "0x9f",
+    "BriefDescription": "Redirects of the pipeline frontend caused by mispredicts. These are used for branch direction correction and handling indirect branch target mispredicts.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_fe_redir.all",
+    "EventCode": "0x9f",
+    "BriefDescription": "Redirects of the pipeline frontend caused by any reason."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/decode.json b/tools/perf/pmu-events/arch/x86/amdzen6/decode.json
new file mode 100644
index 000000000000..c5d37fbac948
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/decode.json
@@ -0,0 +1,139 @@
+[
+  {
+    "EventName": "de_op_queue_empty",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles where the op queue is empty. Such cycles indicate that the frontend is not delivering instructions fast enough."
+  },
+  {
+    "EventName": "de_src_op_disp.x86_decoder",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from x86 decoder.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_src_op_disp.op_cache",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from op cache.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_src_op_disp.all",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from any source.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "de_dis_ops_from_decoder.any_fp",
+    "EventCode": "0xab",
+    "BriefDescription": "Ops dispatched from the decoder to a floating-point unit.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_ops_from_decoder.any_int",
+    "EventCode": "0xab",
+    "BriefDescription": "Ops dispatched from the decoder to an integer unit.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_disp_stall_cycles_dynamic_tokens_part1.int_phy_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to integer physical register file resource stalls.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.load_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to load queue token stalls.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.store_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to store queue token stalls.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.taken_brnch_buffer_rsrc",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to taken branch buffer resource stalls.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.fp_sch_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to floating-point non-schedulable queue token stalls.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.int_sq0",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of integer scheduler 0 tokens.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.int_sq1",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of integer scheduler 1 tokens.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.int_sq2",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of integer scheduler 2 tokens.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.int_sq3",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of integer scheduler 3 tokens.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.int_sq4",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of integer scheduler 4 tokens.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.int_sq5",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of integer scheduler 5 tokens.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.ret_q",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of retire queue tokens.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.all",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to any token stalls.",
+    "UMask": "0xbf"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.no_ops_from_frontend",
+    "EventCode": "0x1a0",
+    "BriefDescription": "Dispatch slots in each cycle that were empty because the frontend did not supply ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.backend_stalls",
+    "EventCode": "0x1a0",
+    "BriefDescription": "Dispatch slots in each cycle that were unused because of backend stalls.",
+    "UMask": "0x1e"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.smt_contention",
+    "EventCode": "0x1a0",
+    "BriefDescription": "Dispatch slots in each cycle that were unused because the dispatch cycle was granted to the other SMT thread.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "de_additional_resource_stalls.dispatch_stalls",
+    "EventCode": "0x1a2",
+    "BriefDescription": "Counts additional cycles where dispatch is stalled due to a lack of dispatch resources.",
+    "UMask": "0x30"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/execution.json b/tools/perf/pmu-events/arch/x86/amdzen6/execution.json
new file mode 100644
index 000000000000..1b80acc89b6f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/execution.json
@@ -0,0 +1,192 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired instructions."
+  },
+  {
+    "EventName": "ex_ret_ops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired macro-ops."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired branch instructions (all types of architectural control flow changes, including exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired taken branch instructions (all types of architectural control flow changes, including exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired taken branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired far control transfers (far call, far jump, far return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts). Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired near returns (RET or RET Iw)."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired near returns that were mispredicted. Each misprediction incurs the same penalty as that of a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired indirect branch instructions that were mispredicted (only EX mispredicts). Each misprediction incurs the same penalty as that of a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind",
+    "EventCode": "0xcc",
+    "BriefDescription": "Retired indirect branch instructions."
+  },
+  {
+    "EventName": "ex_ret_brn_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired conditional branch instructions."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Cycles where the divider is busy."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Divide ops executed."
+  },
+  {
+    "EventName": "ex_no_retire.empty",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles where the thread does not retire any ops due to a lack of valid ops in the retire queue (may be caused by front-end bottlenecks or pipeline redirects).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_no_retire.not_complete",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles where the thread does not retire any ops as the oldest retire slot is waiting to be marked as completed.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_no_retire.other",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles where the thread does not retire any ops due to other reasons (retire breaks, traps, faults, etc.).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ex_no_retire.thread_not_selected",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles where the thread does not retire any ops as thread arbitration did not select the current thread.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ex_no_retire.load_not_complete",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles where the thread does not retire any ops due to missing load completion.",
+    "UMask": "0xa2"
+  },
+  {
+    "EventName": "ex_ret_ucode_instr",
+    "EventCode": "0x1c1",
+    "BriefDescription": "Retired microcoded instructions."
+  },
+  {
+    "EventName": "ex_ret_ucode_ops",
+    "EventCode": "0x1c2",
+    "BriefDescription": "Retired microcode ops."
+  },
+  {
+    "EventName": "ex_ret_brn_cond_misp",
+    "EventCode": "0x1c7",
+    "BriefDescription": "Retired conditional branch instructions that were mispredicted due to direction mismatch."
+  },
+  {
+    "EventName": "ex_ret_brn_uncond_ind_near_misp",
+    "EventCode": "0x1c8",
+    "BriefDescription": "Retired unconditional indirect near branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_uncond",
+    "EventCode": "0x1c9",
+    "BriefDescription": "Retired unconditional branch instructions."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.tagged",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Execution IBS tagged ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.tagged_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Execution IBS tagged ops that retired.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.rollovers",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Execution IBS periodic counter rollovers due to a previous tagged op not being IBS complete.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.filtered",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Execution IBS tagged ops that retired but were discarded due to IBS filtering.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.valid",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Execution IBS tagged ops that resulted in a valid sample and an IBS interrupt.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ex_ret_fused_instr",
+    "EventCode": "0x1d0",
+    "BriefDescription": "Retired fused instructions."
+  },
+  {
+    "EventName": "ex_mprof_ibs_ops.tagged",
+    "EventCode": "0x2c0",
+    "BriefDescription": "Memory Profiler IBS tagged ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_mprof_ibs_ops.tagged_ret",
+    "EventCode": "0x2c0",
+    "BriefDescription": "Memory Profiler IBS tagged ops that retired.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_mprof_ibs_ops.rollovers",
+    "EventCode": "0x2c0",
+    "BriefDescription": "Memory Profiler IBS periodic counter rollovers due to a previous tagged op not being IBS complete.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ex_mprof_ibs_ops.filtered",
+    "EventCode": "0x2c0",
+    "BriefDescription": "Memory Profiler IBS tagged ops that retired but were discarded due to IBS filtering.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ex_mprof_ibs_ops.valid",
+    "EventCode": "0x2c0",
+    "BriefDescription": "Memory Profiler IBS tagged ops that resulted in a valid sample and an IBS interrupt.",
+    "UMask": "0x10"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
new file mode 100644
index 000000000000..03cb039434de
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
@@ -0,0 +1,1106 @@
+[
+  {
+    "EventName": "fp_ret_x87_fp_ops.add_sub_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point add and subtract uops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.mul_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point multiply uops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.div_sqrt_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point divide and square root uops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.all",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point uops of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX add and subtract FLOPs.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX multiply FLOPs.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX divide and square root FLOPs.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mac_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX multiply-accumulate FLOPs (each operation is counted as 2 FLOPs, bfloat operations are not included).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.bfloat16_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX bfloat16 FLOPs.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.scalar_single_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX scalar single-precision (FP32) FLOPs.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.packed_single_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX packed single-precision (FP32) FLOPs.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.scalar_double_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX scalar double-precision (FP64) FLOPs.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.packed_double_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX packed double-precision (FP64) FLOPs.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.scalar_half_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX scalar half-precision (FP16) FLOPs.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.packed_half_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX packed half-precision (FP16) FLOPs.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX FLOPs of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_ops_ret_by_width.x87",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired x87 floating-point uops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ops_ret_by_width.mmx",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired MMX floating-point uops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ops_ret_by_width.scalar",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired scalar floating-point uops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ops_ret_by_width.pack_128",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 128-bit floating-point uops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ops_ret_by_width.pack_256",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 256-bit floating-point uops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ops_ret_by_width.pack_512",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 512-bit floating-point uops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ops_ret_by_width.all",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired floating-point uops of all widths.",
+    "UMask": "0x3f"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_add",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point add uops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_sub",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point subtract uops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_mul",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point multiply uops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_mac",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point multiply-accumulate uops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_div",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point divide uops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_sqrt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point square root uops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_cmp",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point compare uops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_cvt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point convert uops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_blend",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point blend uops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_move",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point move uops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_shuffle",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_bfloat",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point bfloat uops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_logical",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point move uops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_other",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point uops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.scalar_all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point uops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_add",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point add uops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_sub",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point subtract uops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_mul",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point multiply uops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_mac",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point multiply-accumulate uops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_div",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point divide uops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_sqrt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point square root uops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_cmp",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point compare uops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_cvt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point convert uops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_blend",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point blend uops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_move",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point move uops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_shuffle",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_bfloat",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point bfloat uops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_logical",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point logical uops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_other",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point uops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.vector_all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point uops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_ops_ret_by_type.all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired floating-point uops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_add",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer add uops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_sub",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer subtract uops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_mul",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply uops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_mac",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply-accumulate uops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_aes",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer AES uops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_sha",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer SHA uops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_cmp",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer compare uops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_cvt",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer convert or pack uops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_shift",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer shift or rotate uops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_mov",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer move uops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_shuffle",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_vnni",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer VNNI uops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_logical",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer logical uops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_other",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply uops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.mmx_all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer uops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_add",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer add uops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_sub",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer subtract uops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_mul",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer multiply uops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_mac",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer multiply-accumulate uops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_aes",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer AES uops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_sha",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer SHA uops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_cmp",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer compare uops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_cvt",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer convert or pack uops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_shift",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer shift or rotate uops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_mov",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer move uops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_shuffle",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_vnni",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer VNNI uops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_logical",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer logical uops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_other",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer uops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.sse_avx_all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer uops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_sse_avx_ops_ret.all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX, SSE and AVX integer uops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_add",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point add uops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_sub",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point subtract uops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_mul",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point multiply uops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_mac",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point multiply-accumulate uops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_div",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point divide uops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_sqrt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point square root uops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_cmp",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point compare uops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_cvt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point convert uops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_blend",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point blend uops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_mov",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point move uops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_shuffle",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_bfloat",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point bfloat uops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_logical",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point logical uops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_other",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point uops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp128_all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point uops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_add",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point add uops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_sub",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point subtract uops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_mul",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point multiply uops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_mac",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point multiply-accumulate uops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_div",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point divide uops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_sqrt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point square root uops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_cmp",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point compare uops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_cvt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point convert uops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_blend",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point blend uops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_mov",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point move uops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_shuffle",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_logical",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point logical uops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_other",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point uops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp256_all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point uops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_pack_ops_ret.fp_all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired packed floating-point uops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_add",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer add uops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_sub",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer subtract uops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_mul",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer multiply uops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_mac",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer multiply-accumulate uops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_aes",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer AES uops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_sha",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer SHA uops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_cmp",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer compare uops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_cvt",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer convert or pack uops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_shift",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer shift or rotate uops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_mov",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer move uops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_shuffle",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_vnni",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_logical",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer logical uops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_other",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer uops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int128_all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer uops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_add",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer add uops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_sub",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer subtract uops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_mul",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer multiply uops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_mac",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer multiply-accumulate uops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_cmp",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer compare uops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_shift",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer shift or rotate uops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_mov",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer move uops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_shuffle",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_vnni",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer VNNI uops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_logical",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer logical uops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_other",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer uops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int256_all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer uops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_pack_int_ops_ret.int_all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired packed integer uops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_disp_faults.x87_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for x87 fills.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_disp_faults.xmm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for XMM fills.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for YMM fills.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_spill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for YMM spills.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_disp_faults.sse_avx_all",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults of all types for SSE and AVX ops.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_disp_faults.all",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_add",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point add uops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_sub",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point subtract uops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_mul",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point multiply uops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_mac",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point multiply-accumulate uops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_div",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point divide uops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_sqrt",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point square root uops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_cmp",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point compare uops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_cvt",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point convert uops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_blend",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point blend uops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_mov",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point move uops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_shuffle",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_bfloat",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point bfloat uops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_logical",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point logical uops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_other",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point uops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.fp512_all",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed floating-point uops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_add",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer add uops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_sub",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer subtract uops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_mul",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer multiply uops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_mac",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer multiply-accumulate uops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_aes",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer AES uops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_sha",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer SHA uops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_cmp",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer compare uops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_cvt",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer convert or pack uops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_shift",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer shift or rotate uops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_mov",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer move uops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_shuffle",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer shuffle uops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_vnni",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer VNNI uops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_logical",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer logical uops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_other",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer uops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.int512_all",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed integer uops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_pack_512b_ops_ret.512b_all",
+    "EventCode": "0x0f",
+    "BriefDescription": "Retired 512-bit packed uops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_nsq_read_stalls.fp_prf",
+    "EventCode": "0x13",
+    "BriefDescription": "Cycles when reads of the NSQ and writes to the floating-point or SIMD schedulers are stalled due to insufficient free physical register file (FP-PRF) entries.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_nsq_read_stalls.k_prf",
+    "EventCode": "0x13",
+    "BriefDescription": "Cycles when reads of the NSQ and writes to the floating-point or SIMD schedulers are stalled due to insufficient free mask physical register file (K-PRF) entries.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_nsq_read_stalls.fp_sq",
+    "EventCode": "0x13",
+    "BriefDescription": "Cycles when reads of the NSQ and writes to the floating-point or SIMD schedulers are stalled due to insufficient free scheduler entries.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_nsq_read_stalls.all",
+    "EventCode": "0x13",
+    "BriefDescription": "Cycles when reads of the NSQ and writes to the floating-point or SIMD schedulers are stalled due to any reason.",
+    "UMask": "0x0e"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/inst-cache.json b/tools/perf/pmu-events/arch/x86/amdzen6/inst-cache.json
new file mode 100644
index 000000000000..5ab6766f8940
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/inst-cache.json
@@ -0,0 +1,120 @@
+[
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "Instruction cache lines (64 bytes) fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "Instruction cache lines (64 bytes) fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "ic_fetch_ibs_events.tagged",
+    "EventCode": "0x188",
+    "BriefDescription": "Fetch IBS tagged fetches. Not all tagged fetches result in a valid sample and an IBS interrupt.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ic_fetch_ibs_events.filtered",
+    "EventCode": "0x188",
+    "BriefDescription": "Fetch IBS tagged fetches that were discarded due to IBS filtering.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ic_fetch_ibs_events.valid",
+    "EventCode": "0x188",
+    "BriefDescription": "Fetch IBS tagged fetches that resulted in a valid sample and an IBS interrupt.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "op_cache_hit_miss.hit",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache fetch hits.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "op_cache_hit_miss.miss",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache fetch misses.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "op_cache_hit_miss.all",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache fetches of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ic_fills_from_sys.local_l2",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ic_fills_from_sys.local_ccx",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ic_fills_from_sys.local_all",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ic_fills_from_sys.near_cache",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ic_fills_from_sys.dram_io_near",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ic_fills_from_sys.far_cache",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ic_fills_from_sys.remote_cache",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from cache of another CCX in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "ic_fills_from_sys.dram_io_far",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from either DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ic_fills_from_sys.dram_io_all",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from either DRAM or MMIO in the same or a different NUMA node.",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ic_fills_from_sys.far_all",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from either cache of another CCX, DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "ic_fills_from_sys.alt_mem",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from extension memory (CXL).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ic_fills_from_sys.all",
+    "EventCode": "0x29c",
+    "BriefDescription": "Instruction cache fills where data is returned from all types of sources.",
+    "UMask": "0xdf"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/l2-cache.json b/tools/perf/pmu-events/arch/x86/amdzen6/l2-cache.json
new file mode 100644
index 000000000000..b0b2090fb920
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/l2-cache.json
@@ -0,0 +1,326 @@
+[
+  {
+    "EventName": "l2_request_g1.group2",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of non-cacheable type (non-cached data and instructions reads, self-modifying code checks).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hwpf",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests from hardware prefetchers to prefetch directly into L2 (hit or miss).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2_cmd",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests to prefetch directly into L2.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests for instruction cache reads.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests for data cache shared reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests for data cache stores.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests for data cache reads (includes hardware and software prefetches).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.dc_all",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of common types from data cache (includes prefetches).",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_request_g1.no_pf_all",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of common types not including prefetches.",
+    "UMask": "0xf1"
+  },
+  {
+    "EventName": "l2_request_g1.all",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of all types.",
+    "UMask": "0xf7"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "L2 cache requests for non-coherent, non-cacheable LS sized reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "L2 cache requests for coherent, non-cacheable LS sized reads.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g2.all",
+    "EventCode": "0x61",
+    "BriefDescription": "L2 cache requests of all rare types.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "Write Combining Buffer (WCB) closures.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the instruction cache that result in L2 misses.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the instruction cache that result in L2 hits on non-modifiable lines.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the instruction cache that result in L2 hits on modifiable lines.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the instruction cache that result in L2 hits.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the instruction cache that result in L2 accesses.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache that result in L2 misses.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache and the instruction cache that result in L2 misses.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) that result in data cache stores or L2 state change hits.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache that result in L2 hits on non-modifiable lines.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache that result in L2 hits on modifiable lines.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache that result in L2 read hits on shared lines.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache that result in L2 hits.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache and the instruction cache that result in L2 hits.",
+    "UMask": "0xf6"
+  },
+  {
+    "EventName": "l2_cache_req_stat.dc_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache that result in L2 accesses.",
+    "UMask": "0xf8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.all",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) from the data cache and the instruction cache that result in L2 accesses.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l2_hwpf",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache and are generated from L2 hardware prefetchers.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l1_dc_hwpf",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache and are generated from L1 data hardware prefetchers.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l1_dc_l2_hwpf",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache and are generated from L1 data and L2 hardware prefetchers.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l2_hwpf",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache but hit in the L3 cache and are generated from L2 hardware prefetchers.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l1_dc_hwpf",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache but hit in the L3 cache and are generated from L1 data hardware prefetchers.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache but hit in the L3 cache and are generated from L1 data and L2 hardware prefetchers.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l2_hwpf",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 as well as the L3 caches and are generated from L2 hardware prefetchers.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l1_dc_hwpf",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 as well as the L3 caches and are generated from L1 data hardware prefetchers.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l1_dc_l2_hwpf",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 as well as the L3 caches and are generated from L1 data and L2 hardware prefetchers.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.local_ccx",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.near_cache",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.dram_io_near",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.far_cache",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.dram_io_far",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from either DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.dram_io_all",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from either DRAM or MMIO in the same or a different NUMA node.",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.far_all",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from either cache of another CCX, DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.alt_mem",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from extension memory (CXL).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.all",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills where data is returned from all types of sources.",
+    "UMask": "0xde"
+  },
+  {
+    "EventName": "l2_sys_bw.local_dram_fill",
+    "EventCode": "0x175",
+    "BriefDescription": "System bandwidth utilization for fill events that target the same NUMA node and return from DRAM in the same NUMA node.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_sys_bw.remote_dram_fill",
+    "EventCode": "0x175",
+    "BriefDescription": "System bandwidth utilization for fill events that target a different NUMA node and return from DRAM in a different NUMA node.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_sys_bw.nt_write",
+    "EventCode": "0x175",
+    "BriefDescription": "System bandwidth utilization for non-temporal write events that target all NUMA nodes.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_sys_bw.local_scm_fill",
+    "EventCode": "0x175",
+    "BriefDescription": "System bandwidth utilization for fill events that target the same NUMA node and return from extension memory (CXL) in the same NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_sys_bw.remote_scm_fill",
+    "EventCode": "0x175",
+    "BriefDescription": "System bandwidth utilization for fill events that target a different NUMA node and return from extension memory (CXL) in a different NUMA node.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_sys_bw.victim",
+    "EventCode": "0x175",
+    "BriefDescription": "System bandwidth utilization for cache victim events that target all NUMA nodes.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_sys_bw.all",
+    "EventCode": "0x175",
+    "BriefDescription": "System bandwidth utilization for all types of events (total utilization).",
+    "UMask": "0xff"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
new file mode 100644
index 000000000000..4291eb59426f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
@@ -0,0 +1,523 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Store-to-load conflicts (loads unable to complete due to a non-forwardable conflict with an older store).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions which caused a bus lock (non-cacheable or cache-misaligned lock).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_locks.all",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions of all types.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "ls_ret_cl_flush",
+    "EventCode": "0x26",
+    "BriefDescription": "Retired CLFLUSH instructions."
+  },
+  {
+    "EventName": "ls_ret_cpuid",
+    "EventCode": "0x27",
+    "BriefDescription": "Retired CPUID instructions."
+  },
+  {
+    "EventName": "ls_dispatch.pure_ld",
+    "EventCode": "0x29",
+    "BriefDescription": "Memory load operations dispatched to the load-store unit.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dispatch.pure_st",
+    "EventCode": "0x29",
+    "BriefDescription": "Memory store operations dispatched to the load-store unit.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dispatch.ld_st",
+    "EventCode": "0x29",
+    "BriefDescription": "Memory load-store operations (load from and store to the same memory address) dispatched to the load-store unit.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_dispatch.all",
+    "EventCode": "0x29",
+    "BriefDescription": "Memory operations dispatched to the load-store unit of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ls_smi_rx",
+    "EventCode": "0x2b",
+    "BriefDescription": "System Management Interrupts (SMIs) received."
+  },
+  {
+    "EventName": "ls_int_taken",
+    "EventCode": "0x2c",
+    "BriefDescription": "Interrupts taken."
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Store-to-load-forward (STLF) hits."
+  },
+  {
+    "EventName": "ls_st_commit_cancel.older_st_vis_dep",
+    "EventCode": "0x37",
+    "BriefDescription": "Store commits cancelled due to an older store, that the thread was waiting on to become globally visible, was unable to become globally visible.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_mab_alloc.ls",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for load-store allocations.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ls_mab_alloc.hwpf",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for hardware prefetcher allocations.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_mab_alloc.all",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for all types of allocations.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_l2",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_ccx",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.near_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_near",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.far_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.remote_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from cache of another CCX in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_far",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from either DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from either DRAM or MMIO in the same or a different NUMA node.",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.far_all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from either cache of another CCX, DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.alt_mem",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from extension memory (CXL).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills where data is returned from all types of sources.",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_l2",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_ccx",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.near_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_near",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.far_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.remote_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from cache of another CCX in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_far",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from either DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from either DRAM or MMIO in the same or a different NUMA node.",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.far_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from either cache of another CCX, DRAM or MMIO when the address was in a different NUMA node.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.alt_mem",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from extension memory (CXL).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills where data is returned from all types of data sources.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for coalesced pages (16k pages created from four adjacent 4k pages).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 2M pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 1G pages.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks requested) for 4k pages.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks requested) for coalesced pages (16k pages created from four adjacent 4k pages).",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks requested) for 2M pages.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks requested) for 1G pages.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.l2_miss_all",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks requested) for all page sizes.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses for all page sizes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_misal_loads.ma64",
+    "EventCode": "0x47",
+    "BriefDescription": "64B misaligned (cacheline crossing) loads.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_misal_loads.ma4k",
+    "EventCode": "0x47",
+    "BriefDescription": "4kB misaligned (page crossing) loads.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchT0 (move data to all cache levels), T1 (move data to all cache levels except L1) and T2 (move data to all cache levels except L1 and L2).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchW (move data to L1 cache and mark it modifiable).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchNTA (move data with minimum cache pollution i.e. non-temporal access).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.all",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "wcb_close.full_line_64b",
+    "EventCode": "0x50",
+    "BriefDescription": "Events that caused a Write Combining Buffer (WCB) entry to close because all 64 bytes of the entry have been written to.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core as the PREFETCH instruction saw a data cache hit.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core as the PREFETCH instruction saw a match on an already allocated miss request (MAB).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.all",
+    "EventCode": "0x52",
+    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_l2",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_ccx",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.near_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_near",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.far_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.remote_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from cache of another CCX in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_far",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from either DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from either DRAM or MMIO in the same or a different NUMA node.",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.far_all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from either cache of another CCX, DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.alt_mem",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from extension memory (CXL).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills where data is returned from all types of data sources.",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_l2",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_ccx",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.near_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_near",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.far_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.remote_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from cache of another CCX in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_far",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from either DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from either DRAM or MMIO in the same or a different NUMA node.",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.far_all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from either cache of another CCX, DRAM or MMIO in a different NUMA node.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.alt_mem",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from extension memory (CXL).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills where data is returned from all types of data sources.",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "ls_alloc_mab_count",
+    "EventCode": "0x5f",
+    "BriefDescription": "In-flight L1 data cache misses i.e. Miss Address Buffer (MAB) allocations each cycle."
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Core cycles where the thread is not in halted state."
+  },
+  {
+    "EventName": "ls_tlb_flush.all",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB flushes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_not_halted_p0_cyc.p0_freq_cyc",
+    "EventCode": "0x120",
+    "BriefDescription": "Reference cycles (P0 frequency) where the thread is not in halted state.",
+    "UMask": "0x1"
+  }
+]
-- 
2.43.0

