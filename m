Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE23A8758;
	Tue, 23 Jun 2026 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192549; cv=fail; b=IAiRjPsKegXJFIy4PCAVfpQwtPbZU+FIuI5ribEzgSCmvYJTw30b7EWDwIEtSSafRPFOQZgnP9uexXplTOKCWTU0I7XGhH5GQPphleW/Mx37lnaXVdyPWMEyRoYA6Dmessv06EdVl46o06dH4wjLhK+wKyr7eDd38cFC8IDW4Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192549; c=relaxed/simple;
	bh=ZCG/9UckjStJtcVx5Wzk9QTQhk11Hx26OIJgO0VIkkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjokqSvEL+L5ZWyodPkaURNlTJ4noNKe6w2oq+izWZCCfIKjF2jZkghatNb1S3/66c3ocXF5cKmn5ZtU9THWHsBMDboFIuJGj2ssmc+5EfMHHupQVqGhxBOe9b8yvSyIaHBXRZ6Sm6Wg7DMHRjus1gIu3liNLTrf5UkufJAmLsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OwmhYOXq; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OwmhYOXq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmdPGWmiX1AJJ4pPMEJpmRAO0R5GPSljA+GjSu4pZBwRRHkOU/UpzVNtJgVkinzFOW4/B1Mz4m4Y5fTf44k1coEI+lMAYMPjSMPO86PFHV1DautzfhBI1unXRxW2qsvQXDgGn0OLz/gYg+0fqiUNl9LVQJLET8msOJ9UrYtyHfQ0Wl1viVtmVBWz3G1rNrnKbuvkNMqlHY3OUdzF0L1JQYFVwjcGNRxNjcLQgPFBoCqmIs0X4kJiuQpJLaqzonGcxNIReGqxtemKul9sAkCLqE4h60thWc7z3XyeURk0w5f09Wr/jOdCShutwHDmS+K4+w6PVbo8AdJ+iG/YHY71Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJopR9H4mjRz/qc5ohc9X7Bv3BlrHHIZCE92/iNztGo=;
 b=PUgVax7AsjS9XEnR3y7lIjPR9dUZFCTdrHoIq8pv0Sdle9yybNh4wz4T9KLJ4PueiiOsoWLcXdfQfBZZeQelwBHYxgkLPnhdRuu8p4T9Su/Fnf5lVAQ+OKPydPN9gFBlnJXkj+CIT0BIdDac4zxZek/uGecwCOczC1JBVVs2m+RGf2skQMCE+Xzx+AeGeJyiINIERNZ9GeGUJhj7sqVPZjZcz6GpacFOIoPBhYAfqWup1U6JTvRSLInolgq0S26t8ds/ktGiAn8KfNUZ+QX4pqEm69PCf2uxzDXdVmT6IlzJhZ6odHcDLbETBdQN0j28Iw+jrMQ/4jscYZ5bmgaSEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJopR9H4mjRz/qc5ohc9X7Bv3BlrHHIZCE92/iNztGo=;
 b=OwmhYOXqAQKoPicIb5IdJhl2fhy0vav+V1IUQ1ECOXDn4emMxeX1I6J42FM5TWD9ol+5V3JjAZswoVtvgN3iczL+Cd1lDgHrtGQAW0YvvZFsynhaXAQ3ToJvSn95jkeEsgCk+5LziHOOuwADvwZhYELv7LcxpAgfI5pkJp0j+70=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 05:29:03 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::46) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 05:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 05:29:03 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 00:28:57 -0500
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
Subject: [PATCH v2 2/2] perf vendor events amd: Update Zen 6 core events
Date: Tue, 23 Jun 2026 10:58:32 +0530
Message-ID: <e744e419dba6e15af33323bf01a8cbccc55e0cf2.1780383172.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
References: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2d2855-3122-4d38-b7dd-08ded0e8565e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|56012099006|6133799003|11063799006|22082099003|18002099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	fu39yPCMTqwhjxxDPhfbJpJuAoJqtmPAaFoQYkyPxEteh7nLguqDACkIWCFK+O7wX7fku/UTgaaEnBXKkhNbRsNlay4nP7fzPNquHd1AIJFtHvMvRw+SitvVsIz9rpI7F+s2tlqN/bLdNyGxDIBHp5OFsDFVmaGx3zNk7e/yD5RmVSflszuPuFRI8gUpxJTq8YJhpBIM7UDa1XL1dmeZa3ovGNb8jbm2OkHGpjq2g36lhotlf7wzt1g5DfsfUJ6ZWfAQvpOsGVW1aNBWqybLtKHBx8XDw80L9jLPxtnHhra5WsRApR01ia6smelnhv1D124KsUoMCv9HfSZhMzdWaxpJ/4+5Q8K39IGr4/GjUW5JNCxIHzmVSowTxj5ykH9BWh2TlYBTQIkwl00dQc3K1mt0qlHx1URkHcbBCczQnt5Nxy73pAORjqDJA7cH5u90/99/hnZZjkkPBXB/CYrLdVhwOO5h0patuvIC+UHFVUiiqhg6DdQh3PjqoBHM23n2lXKlfDvFVU7MIMYZ1UzQBYzhWhG1nmlBA/T0luLyNpeGqAn9e9gSRP7uPZ+MULHwuWqVWKaB1UfEvKfXa+5ZnfF9LHBfx5DLFghA6UiAB0GqpVEnrQJQBJCSkMN8+Gn4o0vcDgKEfiL5BVOdHQwSfeLBKyrp/r+cpJ8C3L9CK8XiRPHowme3YrLd3TZBcvy75KpuFXGMvuWYuHf5TXi1Sw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wPuHlmM69rxGDqwYeOpcVn4I+6AAy7ou+4AF2XiRS+6O+ftOwChlPJcchKVh/Pfje2LCuF4IBtq85QYReYs9cd+GBG3wVODN9aGJvp+6s9DFlVCWQtV/5q8OPBqLyODiI2kkmS6B8djNocJXVjaMVdCkeLjOMP4iiG31JlwuuqiVr9y8AKqG+DwIfBQqskt7+KwI70LPeC6fHvX9plbOKkVdPAVwuZGXU/WF1VhsCfqDYVWD0wKd5YNF/e77fTvFAFMnySbL4vurM7i+vexkwrj8KJ8YVCkqWXSwaZHDPT4HVJcf35MNxKZF4y87OCBGckxDRM2hLx64LR9GxNiE4O6YxUwI2tLV2Gqi3cv8MB0Mj0qZWYHBtpsV6V7W8bMVA31TAVdmHLCtaHFuqmAqoJT1k2kBkr9DWAcwQMmhw+kcnfSDNStOVMPujolzDanH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:29:03.2129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2d2855-3122-4d38-b7dd-08ded0e8565e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130

Update definitions for the following events.
  * PMCx00A - Fix descriptions
  * PMCx00C - Add missing unit masks
  * PMCx00D - Add missing unit masks and fix descriptions
  * PMCx013 - Fix incorrect unit masks

Fixes: 2f42fb0661d9 ("perf vendor events amd: Add Zen 6 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

Previous versions can be found at:
v1: https://lore.kernel.org/all/3bcbc34343711b581e0567070dc382510907bbc9.1780330378.git.sandipan.das@amd.com/

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

