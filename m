Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE85227B9C;
	Wed,  5 Feb 2025 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735608; cv=fail; b=XkXLhBrf8Thh6Ang2W3diQEFccNkF6eHjZFPxMhECVs/icg2sBoRKrNHiL7Y66boXXeQSpgTKNYJNqBXiT4+M3MPgowmSnCuNiC/mydE98RCyzLluqTwBHanlThiJ6ARWEVZiOeHslW3jlG7mOFfnGebnzn1aV2GMuM84NIADk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735608; c=relaxed/simple;
	bh=F6vK+qcbBQeun0lC5nxK3lTZv6uP5jfhpfJa+wgZRKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qppqNb+YR2Ya8mNjwOk5ffdv2iSUp0boOh1un0/Dsjw4bqlYvlzbCAGk86THlYa63rmjzwbuDyGLQ+FohiadOPm1VbrvMt+NpktspxryLq/R4NKmqcjqWvv55vr3ErNOMK+6dQXa6oQtIOPXLmG+p7/6IsU+owmRE1DstciE1Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=itUltLw3; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="itUltLw3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgSYxOu7FqEnsAPNPaRACtxuUnbGHda0qIO6xgb6rm1dHr66jUTcpF40q4rOk+yebgFQ/jn3NOYe8sRLyRBWzVSCX1WUXwwj1ofytxfw7PZOLKiAI0qN8atD6NuaZGeUFdYSHcTfkCU5XO9TZDv/qXh6TweZmH7oIHo6drLf8XJnpJucdfWE8EH6N1pHWfdnEHeEYIKxIGB6milXlB1DdYqXWDiJc+ZNUwcFtaf8oG1xliqpxb2UZ2Ly4jxSDquLoEjwdhtxEptQuzw6sCcEIRP8jWEi2DdSE4Nh+3YZbkVUj4sXmmBpO5ULoHZijYkBXTVmoHRmgDLFenKMqHJ83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4oVkcgJIs/QHr643puiUL3vz6lXlqqMLffc8P3XfkY=;
 b=YO+fVU0Ewo0fXlS9bs152k6JN3W/yWFAsk1YFY/cZszsrLpa9u2dI7J6MBEQvOkYXrUIKUeoEdfXEgXlR2VwyDpWgL8OnkvgzU6B/tCzy2/cTjXPiknCgrd0Zeixrl6d1A34PlQs5EyhlWH1B79r8zSim9EcaZjNP+0Eg+y2uSezIsE+oyz6jqaLFjQnJSyQehDsqiFpe3RqLey7ubbzk1MswPV+tYw7sOmnazJpyMejpDv5d9u7+gswSmaEGFC8XyUPi5bNzZTFdyie+GYiePlT/pkVkEkCjHZDEidf+g0eNbl8DiJa4wBZ/2xPQzsAib2HgBhFdj7yJyjDoQ8UNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4oVkcgJIs/QHr643puiUL3vz6lXlqqMLffc8P3XfkY=;
 b=itUltLw3oVhHFBD6O2xbnnmVs4PpShes+bnZi8LB273YFhmv+vCbnrzEzH8UB8hOFViybe7l2yczyGmNeBx11up67tcNFEO+Hr6Zeo+ioiGznrz0Zaie16b/fWQrHRE4Ee569WZ9QURaCjGKcu7rnifp6upQum1+JGnf+YIgTUs=
Received: from SJ0PR05CA0191.namprd05.prod.outlook.com (2603:10b6:a03:330::16)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 06:06:43 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::8e) by SJ0PR05CA0191.outlook.office365.com
 (2603:10b6:a03:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 06:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 06:06:43 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 00:06:37 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <jolsa@kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 5/7] perf amd ibs: Incorporate Zen5 DTLB and PageSize information
Date: Wed, 5 Feb 2025 06:05:45 +0000
Message-ID: <20250205060547.1337-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205060547.1337-1-ravi.bangoria@amd.com>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3cc907-4b43-46e7-ea31-08dd45ab4391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sol1H2RdboUpBcUsqj619T9HyI/YpwICA9fB49YnGizA3LRVrncPth5znnq1?=
 =?us-ascii?Q?BI4Xpdi6quOYNvswFWM5+awKiPeg7ZbiiGpUQ34C1T5N/dGFZ1GrTEOsftuR?=
 =?us-ascii?Q?rgPSL1bvYNKsGsy2VkIkohaTUHNg+598Skua3gsfJAJhLePa8GOx/AKhdhiv?=
 =?us-ascii?Q?shz/1rgk4HwjlSc5BmvHmJ88cP1In+ktHeRE20D0p42nSMSeiMVGPqDgsGrD?=
 =?us-ascii?Q?TvBUvKn8D119M+FmojVE7PrRWVcrH0tHj2ikktVI22vNlW+kiMl+iE9VBTuA?=
 =?us-ascii?Q?PMr5f4BBLf4SEu4gQ0B8ElWiI4r0Zv5xY4TiT4EuVT4+ZeEdj4GW2clNwnZt?=
 =?us-ascii?Q?2n7eNhrmlgunaI99kuHaCLtiF68c8HE3WpD7018MVyAc2VZoNgIFUfi4CTYU?=
 =?us-ascii?Q?6PVczfsd1VHCPnd/hvXep3XZUY46e9kiNNPBIcxvKbxWAmuQj8VTUhpmpeVi?=
 =?us-ascii?Q?m/nYP7T2kApdV7bu8UrVweiQubhe5CCaosuKvHpzZ9hq98VDRnaTwYIfs3C0?=
 =?us-ascii?Q?kkpfgNMbit1RFZaFK1JPfpMCSdVibUEpEAZQvKyz+PaXPCetgv/bLk75VYTy?=
 =?us-ascii?Q?CXUHrhMAyCxXabTb2MgYPErEGwmOK78Z62Am5U/U8GFclJVNF/A02w4kqldA?=
 =?us-ascii?Q?DeVsURiY8EygsGVprxKG0E3r755YdWcESzvFupM1ShvvLnLUD/TKvJQcLett?=
 =?us-ascii?Q?+asz1GF7ik/v98oEKVFVhml5gQQXgMw41O9BF2PTJK//T8+JlZOPwQcDFURy?=
 =?us-ascii?Q?ntcBzLSD9o5gFD7p+Yy8hRvr6UvnfGSonU14PqZRGITZMLbFnyMlXhx0NZwb?=
 =?us-ascii?Q?V5QHyxGMRFKjFBdg6qLr4+7JUKXN/815Tr0r2QnWoLPQkd68KeNsmnCFAjsY?=
 =?us-ascii?Q?1chj6lJ8duffxpnKCefCa+dash2mrxzIk9MKqjiFNpAGs/QdHAsdkxG/cctW?=
 =?us-ascii?Q?q/PqU/P1VSS7/TwY349zihFy9Dy/1UeAmE/ycCTrxhKplqfOuMvvt0QafcbT?=
 =?us-ascii?Q?5NHKemax4ONmQpiaAxJQ/xBN1ExGjGknicHNdNddQo87kk5SIUMhARywOvh9?=
 =?us-ascii?Q?ffIj+Hl31SzYorsU2LF5NZ/8Ne+XuP8xMfCbYkWTVevtdMrUG2qCpe2V7GMD?=
 =?us-ascii?Q?RaTDs8yFluyqwWdHKwTcT2M+Q/ogsdXNRU/FpOfn3ZoKV3s/21DRxZWMLCvY?=
 =?us-ascii?Q?gQw3zN8c9j6Y2+hF0PbUHoaDraXV3hU3GIi5iTRGx59AbLUoC0rafp81hV7H?=
 =?us-ascii?Q?3Ju9yHFCpLv3bL833ei2MxEbyLlmDK9WTv2/s4T7oApHn5hlE9hSn1u7rFqK?=
 =?us-ascii?Q?UyrjrKv4cH4whizNE6dVkYP1a/ylHNujG4E3e18bF5ezsE0IfItIJ03ft/OI?=
 =?us-ascii?Q?2VOc8LDFXwK/0hpmM0/Z8w/1BtpNp4/63gdMlt3IeL5T1Fmt5JVIOLtoZ44I?=
 =?us-ascii?Q?9L0uKCqk2oJXa/Odn5EO6qZVyYy3bW5dikd5FBf/5s+kYaj0++CUdfA/Me9a?=
 =?us-ascii?Q?f/TOfOwSV/aBCpM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:06:43.0276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3cc907-4b43-46e7-ea31-08dd45ab4391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420

IBS Op PMU on Zen5 reports DTLB and page size information differently
compared to prior generation.

  IBS_OP_DATA3     Zen3/4                 Zen5
  ----------------------------------------------------------------
  19               IbsDcL2TlbHit1G        Reserved
  ----------------------------------------------------------------
   6               IbsDcL2tlbHit2M        Reserved
  ----------------------------------------------------------------
   5               IbsDcL1TlbHit1G        PageSize:
   4               IbsDcL1TlbHit2M          0 - 4K
                                            1 - 2M
                                            2 - 1G
                                            3 - Reserved
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------
   3               IbsDcL2TlbMiss         IbsDcL2TlbMiss
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------
   2               IbsDcL1tlbMiss         IbsDcL1tlbMiss
                                          Valid only if
                                            IbsDcPhyAddrValid = 1
  ----------------------------------------------------------------

Kernel expose this change as "dtlb_pgsize" capability in PMU sysfs.
Change IBS register raw-dump logic according to new bit definitions.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/amd-sample-raw.c | 63 ++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index ac34b18ccc0c..022c9eb39509 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -20,6 +20,7 @@
 static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
 static bool zen4_ibs_extensions;
 static bool ldlat_cap;
+static bool dtlb_pgsize_cap;
 
 static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 {
@@ -161,9 +162,20 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
 
 static void pr_ibs_op_data3(union ibs_op_data3 reg)
 {
-	char l2_miss_str[sizeof(" L2Miss _")] = "";
-	char op_mem_width_str[sizeof(" OpMemWidth _____ bytes")] = "";
+	static const char * const dc_page_sizes[] = {
+		"  4K",
+		"  2M",
+		"  1G",
+		"  ??",
+	};
 	char op_dc_miss_open_mem_reqs_str[sizeof(" OpDcMissOpenMemReqs __")] = "";
+	char dc_l1_l2tlb_miss_str[sizeof(" DcL1TlbMiss _ DcL2TlbMiss _")] = "";
+	char dc_l1tlb_hit_str[sizeof(" DcL1TlbHit2M _ DcL1TlbHit1G _")] = "";
+	char op_mem_width_str[sizeof(" OpMemWidth _____ bytes")] = "";
+	char dc_l2tlb_hit_2m_str[sizeof(" DcL2TlbHit2M _")] = "";
+	char dc_l2tlb_hit_1g_str[sizeof(" DcL2TlbHit1G _")] = "";
+	char dc_page_size_str[sizeof(" DcPageSize ____")] = "";
+	char l2_miss_str[sizeof(" L2Miss _")] = "";
 
 	/*
 	 * Erratum #1293
@@ -179,16 +191,40 @@ static void pr_ibs_op_data3(union ibs_op_data3 reg)
 		snprintf(op_mem_width_str, sizeof(op_mem_width_str),
 			 " OpMemWidth %2d bytes", 1 << (reg.op_mem_width - 1));
 
-	printf("ibs_op_data3:\t%016llx LdOp %d StOp %d DcL1TlbMiss %d DcL2TlbMiss %d "
-		"DcL1TlbHit2M %d DcL1TlbHit1G %d DcL2TlbHit2M %d DcMiss %d DcMisAcc %d "
-		"DcWcMemAcc %d DcUcMemAcc %d DcLockedOp %d DcMissNoMabAlloc %d DcLinAddrValid %d "
-		"DcPhyAddrValid %d DcL2TlbHit1G %d%s SwPf %d%s%s DcMissLat %5d TlbRefillLat %5d\n",
-		reg.val, reg.ld_op, reg.st_op, reg.dc_l1tlb_miss, reg.dc_l2tlb_miss,
-		reg.dc_l1tlb_hit_2m, reg.dc_l1tlb_hit_1g, reg.dc_l2tlb_hit_2m, reg.dc_miss,
-		reg.dc_mis_acc, reg.dc_wc_mem_acc, reg.dc_uc_mem_acc, reg.dc_locked_op,
-		reg.dc_miss_no_mab_alloc, reg.dc_lin_addr_valid, reg.dc_phy_addr_valid,
-		reg.dc_l2_tlb_hit_1g, l2_miss_str, reg.sw_pf, op_mem_width_str,
-		op_dc_miss_open_mem_reqs_str, reg.dc_miss_lat, reg.tlb_refill_lat);
+	if (dtlb_pgsize_cap) {
+		if (reg.dc_phy_addr_valid) {
+			int idx = (reg.dc_l1tlb_hit_1g << 1) | reg.dc_l1tlb_hit_2m;
+
+			snprintf(dc_l1_l2tlb_miss_str, sizeof(dc_l1_l2tlb_miss_str),
+				 " DcL1TlbMiss %d DcL2TlbMiss %d",
+				 reg.dc_l1tlb_miss, reg.dc_l2tlb_miss);
+			snprintf(dc_page_size_str, sizeof(dc_page_size_str),
+				 " DcPageSize %4s", dc_page_sizes[idx]);
+		}
+	} else {
+		snprintf(dc_l1_l2tlb_miss_str, sizeof(dc_l1_l2tlb_miss_str),
+			 " DcL1TlbMiss %d DcL2TlbMiss %d",
+			 reg.dc_l1tlb_miss, reg.dc_l2tlb_miss);
+		snprintf(dc_l1tlb_hit_str, sizeof(dc_l1tlb_hit_str),
+			 " DcL1TlbHit2M %d DcL1TlbHit1G %d",
+			 reg.dc_l1tlb_hit_2m, reg.dc_l1tlb_hit_1g);
+		snprintf(dc_l2tlb_hit_2m_str, sizeof(dc_l2tlb_hit_2m_str),
+			 " DcL2TlbHit2M %d", reg.dc_l2tlb_hit_2m);
+		snprintf(dc_l2tlb_hit_1g_str, sizeof(dc_l2tlb_hit_1g_str),
+			 " DcL2TlbHit1G %d", reg.dc_l2_tlb_hit_1g);
+	}
+
+	printf("ibs_op_data3:\t%016llx LdOp %d StOp %d%s%s%s DcMiss %d DcMisAcc %d "
+		"DcWcMemAcc %d DcUcMemAcc %d DcLockedOp %d DcMissNoMabAlloc %d "
+		"DcLinAddrValid %d DcPhyAddrValid %d%s%s SwPf %d%s%s "
+		"DcMissLat %5d TlbRefillLat %5d\n",
+		reg.val, reg.ld_op, reg.st_op, dc_l1_l2tlb_miss_str,
+		dtlb_pgsize_cap ? dc_page_size_str : dc_l1tlb_hit_str,
+		dc_l2tlb_hit_2m_str, reg.dc_miss, reg.dc_mis_acc, reg.dc_wc_mem_acc,
+		reg.dc_uc_mem_acc, reg.dc_locked_op, reg.dc_miss_no_mab_alloc,
+		reg.dc_lin_addr_valid, reg.dc_phy_addr_valid, dc_l2tlb_hit_1g_str,
+		l2_miss_str, reg.sw_pf, op_mem_width_str, op_dc_miss_open_mem_reqs_str,
+		reg.dc_miss_lat, reg.tlb_refill_lat);
 }
 
 /*
@@ -341,6 +377,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 	if (perf_env__find_pmu_cap(env, "ibs_op", "ldlat"))
 		ldlat_cap = 1;
 
+	if (perf_env__find_pmu_cap(env, "ibs_op", "dtlb_pgsize"))
+		dtlb_pgsize_cap = 1;
+
 	if (ibs_fetch_type || ibs_op_type) {
 		if (!cpu_family)
 			parse_cpuid(env);
-- 
2.43.0

