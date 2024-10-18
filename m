Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00111F7081;
	Fri, 18 Oct 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243948; cv=fail; b=b66HOgJq9PcvgSSnZtNFKHuNwGh3zne6zbr4EHOBo3Ui1FzhNawSfo+EyFSPvg97MYhGYf5q8EhfIJkU+x0EyiFjuGpNqRaMCtO5xEndj5mPKgniYehdfm8bpKQPUafqj7BWUGXnqeVscEflWpCYINTCCM62i/u0KnFcUmMdwos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243948; c=relaxed/simple;
	bh=QotxZ+mdEiWMUQmUMg2zPaQkgz5bAB/xJDvMq2WmFIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDo6DJ1DurQ3k8Tpe4i+8yu6BKgWW2Vy/DAACP6iiwnXe6IO11dUdBatUqgU4FhceHvYK8bbhZvUA4pPRxdKOSMeXrERdU3HGSm1nN2jLGgp5rIXHF6rJS4G9pa1cgb5DMwX6b3Sc8B0wynXUEBmEPzJsR6Zwj+O8QxaIQompWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uVoDh0nO; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uVoDh0nO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie3nSsowxiVyL5voP/4NZa3upab6sCHxU2n242GXxq6eaeG6vGaDXyDHtfl0O9+G18gATrwX5Jj6/NIXGp6ld4JshLn4YjgI2xcEFuf6yePu/cEh/o3rJEX5xvPohrSk9MkagpC3H7VAg1sgEyHsR/Qrf2Zpwo02zvIwvqHjdqVtrM7yqItASQvzZm8X+qsRuNVZSkSUw8VI2rPSb4pIuKkSBTBbfDrE6eq+FNEdL6PQOM9aEbJilnS/ddMqM+AySJEE0mEUYiaSw3nP7/jcS7CXCI8SPNYPcsA1n1g8x+VJ9ElXaIz5rqMN06BK2fBdZ0qCHYGyWhPdCxlDux2duA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoY1v0ur4zv+N6fgpk/8sd2cCZyaAiuOwiNQXuXVdT0=;
 b=APfrDMTsGNcDik079fd+Leb2WQEMaDKi9hNhTtnA+/O1WC9RoJ1dB6scx43OpLKfPpuhbrpnfL3L+//q2hVro3T4YGWz+PhK/B7Z4I+cX/BB9hM4f8nDGoBw0udMPLKAXLIqUIpSjbVzAngx2qK1E571iwPQC7CyoeRH2MUn3vrNxpvaSCM1T42ZXomixuxEccgVcL5cGDDQuAJ3esOHmULlKGdMWEsQNHH72U/tMS32iwBrJideZON0LLiHP1L+sr8t3OKE4wQQw2JR16LolxOaxfgJTd8RX/kX36WU2Jt4GBDryz2Hg6vLAVVC+8uzyrgLQY95mayoLNcwuggoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoY1v0ur4zv+N6fgpk/8sd2cCZyaAiuOwiNQXuXVdT0=;
 b=uVoDh0nO+u7yaG0Oul8mrJ3eOpUAfQA7Q5jBVeCXQIRJVOfNIhD9Xvl+5fzxgcfTdx8FcNNUKC32UCKE/mjx5ub2IZ6wMM2rpfqrokn7G7W2Dk7tEmEaN3YVDr7PEhw6ub+mpgg9GmfA+kNUVf6yiW9pgQImGGOg/GIlvN0XnxM=
Received: from CY5PR13CA0030.namprd13.prod.outlook.com (2603:10b6:930::18) by
 MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Fri, 18 Oct 2024 09:32:22 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::a1) by CY5PR13CA0030.outlook.office365.com
 (2603:10b6:930::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.9 via Frontend
 Transport; Fri, 18 Oct 2024 09:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 09:32:22 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 04:32:16 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 3/3] perf vendor events amd: Update Zen 5 data cache fill events
Date: Fri, 18 Oct 2024 15:01:05 +0530
Message-ID: <e036e3c9fb962c939fa06c855b68e532ee609e01.1729242778.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729242778.git.sandipan.das@amd.com>
References: <cover.1729242778.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 574e2917-0cbb-410a-7d51-08dcef57c4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WjNDkFNXcqZdccsn3v9mA6aI2XoUvOLYlW5dy7imHVtpI6KQfpCR4rxiXTEa?=
 =?us-ascii?Q?FAI1RE2q2I8jeQgB/QMyGdjfnygQ0GsbClyqyzJmmwWjbefO86+43jbtiP5z?=
 =?us-ascii?Q?Lpyh0fTIzDZIRs6i2exLf2BScZGN+8gc71APXWr3S+UZr6ijWEt89Sc0xyjH?=
 =?us-ascii?Q?Ry3+moj82iPR3bSa0wK9L8KiFspc4ip+gbjje1e7JOxnraB4RGKWN9/MFSXZ?=
 =?us-ascii?Q?yFsrwYOS7PyuiRp6uwr+bH3yQDk6NauIvBxQW90BKHkRgqC7+Qc1i8d5s7cc?=
 =?us-ascii?Q?52T3aN7QCaKgA1Z5BPHUmEA8JT5yfEA/SMLLsIZ9DIqbL5nm3ANZWT2SM7k6?=
 =?us-ascii?Q?B7zh/OseDNMe6MS+uY9nFE/XVP5aaRWUsjnApulSDkmxXSwHsU6eStt7KDZr?=
 =?us-ascii?Q?5z4P8LReoQ7MbJ8A0gwR9UgJcWdg+pH2AnIVA93p0HFyP/Ig0D62SmCmRGXK?=
 =?us-ascii?Q?Vs+uf0uZ12tlJWfTDZ7fECcQvCdQ8IQi1yz2UppjFfpq6GaVby4l0oocg+kl?=
 =?us-ascii?Q?/fJ4qN7lihjpBLHEcY3u8e76VYooh3+Rfc/Qy5dO6TIZLgCsbBVkb6YjOH+e?=
 =?us-ascii?Q?mvPd5tbACOJ1PRgrLhmoHSf9NaSOq5xEkas7U9kTKakuYrtsClTApgzBXba0?=
 =?us-ascii?Q?BjOeQhsomcRkcUDl5WCCos1UiSKjLWV/Ca8z7YMLlpT4dBOg+RmOnS7dcAei?=
 =?us-ascii?Q?NAv+qFnGkdoMjXbtERTUJjqalOTHUM+rJktf+ypgWz5kPMsTd7VkKUin6f/m?=
 =?us-ascii?Q?zu9K6TKUFd7IVf0xnEf/LEatn3kVqBRmla/Yh4sXCb5o0m1zQJ4yztX3UIIF?=
 =?us-ascii?Q?mjPRFIEvvz9Wu0F3kyI8jfFn67VHuSsHQVYAQbzoR0YbbBIA+xVwYicfozTy?=
 =?us-ascii?Q?0AFgtHb69d3IDya7VJXoW4QqTaPY5jhagWWSfSAhEnVZBQPPkHvFVPGYxMvB?=
 =?us-ascii?Q?MXZ3xkEiAXiiTohKyJezsGN1DnahrJRdzqg3acwwnuJvTEGuu89Txx8eku3q?=
 =?us-ascii?Q?nlqmxGmEc0MSpCN5EyMZ7zoK9lZrxG2TechKxMCiKhSPyIaGWBvCrw8PoHWs?=
 =?us-ascii?Q?LiTHtIH7Ja0ISUcxW8NIJD8nTRqCKwo2B57WyAiepmld7MnNJ12Y+jpICI40?=
 =?us-ascii?Q?qOw7du1Omouziz/P8yfIp2Ax7qAdlgWWV511D3svxbjnO0JhUYbhbdjmrrJe?=
 =?us-ascii?Q?QItduA22sOwLs1oqQBEFkflN6M0ttcTWNg1EZr/6GIC53W+Iz3LPLKcFbTOL?=
 =?us-ascii?Q?zB6AkbNTdhe1a6L5wV5m3Ce93JBHPtRQIBtbiPVP5cczjTAB31vYPiGCv86s?=
 =?us-ascii?Q?utVh0k9pXqH7ycYHrwIOnjEJ+kAASxac9wKJBJVUkrXV/CsFo9D0camFk98H?=
 =?us-ascii?Q?XVT0CfUi7arTTtnW6Jr60jI3HqA0v12/Dc7v8xLFdmTIVB6DTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:32:22.3902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574e2917-0cbb-410a-7d51-08dcef57c4fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625

For events that count data cache fills, some combinations of the unit
mask bits are useful for counting fills from local caches, DRAM or any
far sources. However, named events currently exist for PMCx044 (Any Data
Cache Fills) only. Add similar events for the following base events.
  * PMCx043 (Demand Data Cache Fills)
  * PMCx059 (Software Prefetch Data Cache Fills)
  * PMCx05A (Hardware Prefetch Data Cache Fills)

While at it, remove "ls_any_fills_from_sys.all_dram_io" since it is a
duplicate of "ls_any_fills_from_sys.dram_io_all".

Event descriptions can be found in Section 2.1.16.5.2 "Load/Store (LS)
Events" of the Processor Programming Reference (PPR) for AMD Family 1Ah
Model 02h Revision C1 Processors document available at the link below.

Link: https://bugzilla.kernel.org/attachment.cgi?id=307010
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen5/load-store.json          | 78 +++++++++++++++++--
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index af2fdf1f55d6..ff6627a77805 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -96,6 +96,12 @@
     "BriefDescription": "Demand data cache fills from L3 cache or different L2 cache in the same CCX.",
     "UMask": "0x02"
   },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
   {
     "EventName": "ls_dmnd_fills_from_sys.near_cache",
     "EventCode": "0x43",
@@ -114,12 +120,30 @@
     "BriefDescription": "Demand data cache fills from cache of another CCX when the address was in a different NUMA node.",
     "UMask": "0x10"
   },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.remote_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from cache of another CCX when the address was in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
   {
     "EventName": "ls_dmnd_fills_from_sys.dram_io_far",
     "EventCode": "0x43",
     "BriefDescription": "Demand data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
     "UMask": "0x40"
   },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from either DRAM or MMIO in the same or a different NUMA node (same or different socket).",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.far_all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from either cache of another CCX, DRAM or MMIO when the address was in a different NUMA node (same or different socket).",
+    "UMask": "0x50"
+  },
   {
     "EventName": "ls_dmnd_fills_from_sys.alternate_memories",
     "EventCode": "0x43",
@@ -192,12 +216,6 @@
     "BriefDescription": "Any data cache fills from either cache of another CCX, DRAM or MMIO when the address was in a different NUMA node (same or different socket).",
     "UMask": "0x50"
   },
-  {
-    "EventName": "ls_any_fills_from_sys.all_dram_io",
-    "EventCode": "0x44",
-    "BriefDescription": "Any data cache fills from either DRAM or MMIO in any NUMA node (same or different socket).",
-    "UMask": "0x48"
-  },
   {
     "EventName": "ls_any_fills_from_sys.alternate_memories",
     "EventCode": "0x44",
@@ -342,6 +360,12 @@
     "BriefDescription": "Software prefetch data cache fills from L3 cache or different L2 cache in the same CCX.",
     "UMask": "0x02"
   },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
   {
     "EventName": "ls_sw_pf_dc_fills.near_cache",
     "EventCode": "0x59",
@@ -360,12 +384,30 @@
     "BriefDescription": "Software prefetch data cache fills from cache of another CCX in a different NUMA node.",
     "UMask": "0x10"
   },
+  {
+    "EventName": "ls_sw_pf_dc_fills.remote_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from cache of another CCX when the address was in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
   {
     "EventName": "ls_sw_pf_dc_fills.dram_io_far",
     "EventCode": "0x59",
     "BriefDescription": "Software prefetch data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
     "UMask": "0x40"
   },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from either DRAM or MMIO in the same or a different NUMA node (same or different socket).",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.far_all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from either cache of another CCX, DRAM or MMIO when the address was in a different NUMA node (same or different socket).",
+    "UMask": "0x50"
+  },
   {
     "EventName": "ls_sw_pf_dc_fills.alternate_memories",
     "EventCode": "0x59",
@@ -390,6 +432,12 @@
     "BriefDescription": "Hardware prefetch data cache fills from L3 cache or different L2 cache in the same CCX.",
     "UMask": "0x02"
   },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from local L2 cache, L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
   {
     "EventName": "ls_hw_pf_dc_fills.near_cache",
     "EventCode": "0x5a",
@@ -408,12 +456,30 @@
     "BriefDescription": "Hardware prefetch data cache fills from cache of another CCX when the address was in a different NUMA node.",
     "UMask": "0x10"
   },
+  {
+    "EventName": "ls_hw_pf_dc_fills.remote_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from cache of another CCX when the address was in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
   {
     "EventName": "ls_hw_pf_dc_fills.dram_io_far",
     "EventCode": "0x5a",
     "BriefDescription": "Hardware prefetch data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
     "UMask": "0x40"
   },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from either DRAM or MMIO in the same or a different NUMA node (same or different socket).",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.far_all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from either cache of another CCX, DRAM or MMIO when the address was in a different NUMA node (same or different socket).",
+    "UMask": "0x50"
+  },
   {
     "EventName": "ls_hw_pf_dc_fills.alternate_memories",
     "EventCode": "0x5a",
-- 
2.43.0

