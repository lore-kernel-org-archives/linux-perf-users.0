Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9055C270EAF;
	Tue, 29 Apr 2025 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899251; cv=fail; b=kb1Atrc4cvADqlGKj5+6QUwcJOK/59KO5Cj0mxAkAN+K2k7MO1Uu+AhdUbuh/5SAenDEz04OAe9esGGFEKTSM1IGOto94t4KDyvj887SyJU0QNCurRs+hznADyfYKjvDkfKHI640qp1FdJ7JFnnEXQKXnKIzBrs+myn8QGDTRz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899251; c=relaxed/simple;
	bh=F6vK+qcbBQeun0lC5nxK3lTZv6uP5jfhpfJa+wgZRKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fr+M7tOhnOj9/a8CIS/GGZMfJQ24hcK43LvzjsWydtUTXdwXzQMNjek26cqeg/u4MxeJzeIIbnkDt0FO/m2BQEZgDyGcVNqGe4zJ7lOADhJIWZoGkTRC6KbEXDECJ0tzqLLAQPVQVToJWmLyWCoNnLKU8aYTdXb9AG13c7uB0nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ni9xqqKx; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ni9xqqKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOLAi+Jq4i5YH/HOc7ej++DPzRbNJbyQcuQrdqapPdcUsKjKXBIcNjH2o9q26sIPp+J65u+T0pMTuiJFP3KFtubWQ6OPv3/cC5JIDrjiwmMOYl27oJiy2XTy0fZXZx/0Q0dqhVDOFzjKQueuAF2z5G6sZ0DwHGbny1/50fQmefqfcpYmNDSJl15MTx3khKbIIF17CqzSI6KB/TIUXLQqEvtun6mNJpUNVJBCXgYCDQbKKvAesdFBzoHkU6drKWxuugDcndw/8Gms+BSdVQd4h6BWGa8iozq/PQ+9nyJ1PzmHG2+3t7tLn8qeLff9vfAdDsy+ET2XTcTDCByg8SNzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4oVkcgJIs/QHr643puiUL3vz6lXlqqMLffc8P3XfkY=;
 b=yVQ26uyniQAYnskJJPB6wxjpt6UYJqzYGHoAH5MedRk1zT9ibfiRB3bzZQD5Sy5DlTTnZhchykJs+iR/xqFt/rL1vL4Zxdvs1dmWGg7y3NWGI+XMm/ddhU5PNTK1lwh7D1py+284GCzPb83/uHAjAe6heM5hiS4j7tCNw8eRAJYR6PkG6UegesK0tynJs5qZqiWEndlTnvtH+SZGxsrWuglCB4svTpm9wMArQQbhmuX4L7uqTXJ+hEwmiTMFVuDB0tc3St/piDobCEAAO3MYK/Yd9lscwFliSfIRzD7jQy5smkf8SaEbmpLRPfnJCQzJAGNNTcHUlTg1UJvgMvpuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4oVkcgJIs/QHr643puiUL3vz6lXlqqMLffc8P3XfkY=;
 b=ni9xqqKxxykauA1HiBCswyl6BGUoq7Q59YJ1pniE0s6DJdVIjs77KDxaKMOiV6Pfd0mdHblrYqT1bHijlaQqJ5bzmpRvkZKG/Cj27Ty6Sqav8yoeactxYmJQ10y0Bfw45mbzfROQhGxl1Oyv4F9unkg6C9q1jQ4kFt7SFmkJFxA=
Received: from CH2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:610:60::22)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 04:00:42 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::77) by CH2PR14CA0012.outlook.office365.com
 (2603:10b6:610:60::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Tue,
 29 Apr 2025 04:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 04:00:42 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 23:00:36 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Joe Mario <jmario@redhat.com>, Stephane Eranian
	<eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v4 2/4] perf amd ibs: Incorporate Zen5 DTLB and PageSize information
Date: Tue, 29 Apr 2025 03:59:36 +0000
Message-ID: <20250429035938.1301-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429035938.1301-1-ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 36394a8c-4499-4e97-0598-08dd86d26919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WEsF8g33XBjnZbVJsGBjo0r2CbKFeXiL5gxNM+H4MonkUW2zEX4U6wYle/7m?=
 =?us-ascii?Q?dpvfiOJ6yUCO69Akri6BNrwjmwcB+tjeZjnxsFf1wieygMmCnf1NE5Sm6zaU?=
 =?us-ascii?Q?qORZH93+HyGquBBZwbDC3//C1GVILArxwDluHhch3aKXpRb5AoKKRkLLvjHq?=
 =?us-ascii?Q?p0X/HT0nLenKrk6rNZPXuonPRiGazQZZswe5sxjnmmy82m+s8SR0odA0Yjlr?=
 =?us-ascii?Q?enldzDfVMpquAEm1wqBL7NhJNkeA7ycK0YG4J3TInhKCuEn9oBNGCeEiStys?=
 =?us-ascii?Q?htn+1FcLfFmZEWoYZ8L9Dip8WYFcJh2uET+ks5eu1cGc0wh9Aw45x8RIRWh3?=
 =?us-ascii?Q?MEc/AYzAOjPiHIV3NsOfVMUw9zY971psciDiOCG3YR89G5qxHPAYZXFHUfGY?=
 =?us-ascii?Q?1+J5c1iIxxFjruqRMC/K9YccQj6N7uP4Azc7JW8Uu1i/BFMnR8uJmZa/SIu5?=
 =?us-ascii?Q?kMOu8yUJBU2jiJCSwk6fuoXoohk8yBud6KquhGlqY/8Ydo5OKmiBkKFTo9QE?=
 =?us-ascii?Q?277M4CLFAqcB9S8JdXvrK4f9i7l9EnGghyOBZJ0RyMxFPATTjnba6r4ggKTv?=
 =?us-ascii?Q?MK3SvxgxynY6bqxy0QkoTlgr6vAgI4YMpVk03wq/WUJPQL1WjFiW6pdBfV5F?=
 =?us-ascii?Q?1U1tFf68JL3OuGXWqSEocyuFCt/HdU07qKk7sgln15mm6GdT1OmmAwFloU8W?=
 =?us-ascii?Q?oH/Mnk79uboNKqPq6W+iIHgjChm1qllqLiI9WoyukbeX0zsQ/XYKvMH5v4GQ?=
 =?us-ascii?Q?AyP5YUdQwCIHAx82T3VdPhWh8W6fBh7zHI2CE7ErbfwN3avK7aWbm6TR0Otk?=
 =?us-ascii?Q?UZWOuo7ynGzGQj1pDpKH6B6Gn61EsCpnHZHXy8BD1oeV+Jo2pmE20BN1ZluA?=
 =?us-ascii?Q?bYw/OmI3pgEsFxTMwa3noSn4VKcQz6EdZajNaPyJs2SByX6Qg8r+rqR3ePor?=
 =?us-ascii?Q?rYNNnGBP0Lj8GcuB6bMS5WpPZqvJjvL32FqmIJAyTqB1zPzi/9sFteQJfARL?=
 =?us-ascii?Q?/7HB1fl/oZ5Ep7r5vi5zrJnkeduv9+8MboLi5yjrUcW+0Ub3v7sefffjLfUv?=
 =?us-ascii?Q?DXFeGrAtNULg7ou02rAT7dqHXo7tB5zWrp2g3Ls+nrq2506r/GEovOGohfda?=
 =?us-ascii?Q?4kmjVKXph+uzYsEsc0WHudJJhfjCgO9ql4LK3GECBzlpkGzEKKEtI43KE32j?=
 =?us-ascii?Q?lFAk25VK+K5HO/GSaqwY1iGTBp1Axd0wqd9WwYk2PixO4DFYTGUekDv5hKF+?=
 =?us-ascii?Q?Cqckq/P7XNo+O7arkar6C+Gq/lRC+bfl8yHwMnZD14dezlrGDBY1R9o1FrZ2?=
 =?us-ascii?Q?63NF6TpHpnkwDG9Giy+aRDZcLSyBXjK2NSHLUJYu+cgg8OggL26sEtbPByMx?=
 =?us-ascii?Q?ncvWvj1Yn7dj1cQMp0mK0zVVQYlHkDaMVFZiS4jmaQl5qnXuf+6UnjKH6G1S?=
 =?us-ascii?Q?uG/WpU6nzHJFDLxxRRCWSEgaZkTNkH1kAP1d1IWNVU8XPSPXwLlomErTORDk?=
 =?us-ascii?Q?0lJ4lHdAnEPkIe/+FGhmCyl9DImMjm2hn9Uj?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 04:00:42.0322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36394a8c-4499-4e97-0598-08dd86d26919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

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

