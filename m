Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666161BEF79;
	Wed, 18 Dec 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524296; cv=fail; b=MbhmOxN9AsRjlezhQ1HXFOLFYAjf4G0BEfi8QsLLA+qgvbPjCvj6b54oraeTbVmwrPRXZFO+ef1r4eik/cnT/LIK0ff0itc7rEFt2yWwyDWN7lUKjvJMYodJIdQvKtjhhSHD80qgA2/4wgVlOt9rQu1zv1Qa6XXru/GultNynDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524296; c=relaxed/simple;
	bh=1yJGiBcB1nviaox/tW3VsxAMDP6I/kH1DvRJ0GF9iZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbYIvNQvqK1IJ9LZ42aoeWRoxCY2qwGAKkk26m0f1YFShUtoLJ6oDbId/V7ZHvr8CtjTsHrNo4q4uuqKw5KMo2wykax0r+vFouOKjoV9DjBj717kWWTZM8M1vjQ094S4ml5nY1to7D07YRUbGFAvfGKTRN8ezly5oDKICbQSvk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D0sXlnU1; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D0sXlnU1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQnXot3vDAcEBO53Bk9Bkwzvdh3X8Nk4Kx/FW0Iji+DlBnq8rmEW7CgoGzX14H8+FOjfNj9w1B4irs9Zj6WzXXUqfxXP5jxcUXZ8a1lHtuG5dDWEIEJh7mmXu1ikbawlBI0iQbXbujziroUEDgjp04ZFVFmcdEjnw4p/EJz7bJtf2kPKCtPPxgEuVM8mM+eQmHeTnqma2VfL6Iff8IJnRlLVtRYfXFM+ylQ1c1etdPI4xkBx1K8trdy2bFrd5cck+86pG4L6ThJ3BirTaQnG9NDNkCJa6aoPaWuQgCNNHrSuEQP4em3imq0u2R7oho2xKBiMIlKCZn3vznPe5dfXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJU5AICm+4BggAy6mXxpROIKWsb0NrbDfYh7z1lGzT4=;
 b=mld13pF3SIOy4bQnQqbQi+nXzJ2LKdQYdYxCZkmbaToRd72IYiFc4fpN4FoiXmC+hD6rV7AdWOJVZM/0Lm5wwB2PdCySUaCWdRXoyAorMlKVi3bREkc64bQmmluXqy30D4IuCWo8bI2OtO98C3Lytrrkk0Xj4koyCR0tcBsahywS3pNBzYvkiNFsODbSdw0sA+3cx7XBg/sG0++M9GCNZlWC9/+4uP+7qLpSXT6Mtta75/7dkDlMEPTuDa7LjE7gJx0r4r1GA1hLbvIJh7ff7SCdHAbiX6StVKuA7ccvwpnEzfK6aKdUl+N7Yeuuty39oUWuwmZ5bg5TEKTfId9tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJU5AICm+4BggAy6mXxpROIKWsb0NrbDfYh7z1lGzT4=;
 b=D0sXlnU1pVOJ378ELpN1XqBjc46I9zShXd5F0umsx0DPwUCkg2S2vW9iOIH5PrLjR8G26zgusY0KiwIzxOCQNkH7TjT1ngkr6VgUdXNp/cw0z997Sf5FcSEYqdFBkG5uODIXzjsVE75Ni6SeJ1ddFLdurbGCW+LDbNsdWvUFbOg=
Received: from DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28) by
 BN5PR12MB9462.namprd12.prod.outlook.com (2603:10b6:408:2ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 12:18:11 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::8c) by DS7P222CA0029.outlook.office365.com
 (2603:10b6:8:2e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 12:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 12:18:10 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 06:18:05 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 5/6] perf amd ibs: Incorporate Zen5 DTLB and PageSize information
Date: Wed, 18 Dec 2024 12:14:36 +0000
Message-ID: <20241218121437.1717-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218121437.1717-1-ravi.bangoria@amd.com>
References: <20241218121437.1717-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|BN5PR12MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 37355d54-f2d9-4f69-18a3-08dd1f5e09bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Esbp2tKghCWCzaeeNhMhHF4ob40l6KblLOQZPMUCdpstfO8txR0DebdpPTr?=
 =?us-ascii?Q?4fdjkOqfjGY2r8ZPkC7eMLdYsc05NKzUmUem9RSNLcUeHXtJlYEizNZ9sXzq?=
 =?us-ascii?Q?cjSCHZWa+gWZ/4X7XcxFmR9mSr8dXVvxGRdWppP+1xwhPJfeXv/v9EFRGwJx?=
 =?us-ascii?Q?U20pT60lhAotN26Bfm+BbfRs0t8LXJYQd15Gpvrpz89nHAMqpvbljggnanjY?=
 =?us-ascii?Q?XOV0grkNN086Xa7eD6kaX+vT9d/HxNyL7JlbdclMpqC0LVsfIqhChZ4diVS1?=
 =?us-ascii?Q?RAnDnJDoqR90rbJVN8ZyyaazYWqX3JBKa9Ds1RAkPcahGW30aGPjEH/47Bww?=
 =?us-ascii?Q?ZoJZDNF4KLtxy4GV8fh3VQYfCiHm5V4SiUvP7+OnSIgxLU21Pdhy4tcAUFYJ?=
 =?us-ascii?Q?Uh5SDFeEKnwX4CSmOZrfEUV1fp6qVRWUHQJVdUJi0onwqW7eFvXbH/lJt8U+?=
 =?us-ascii?Q?9V7h2V+Notuyo9d5PCoUIt6dPL+xh0xHU/8cDUT0q+ZcFuJbzjQVK7uqoZyR?=
 =?us-ascii?Q?8uGTprpQMRUvYoj9UtYu90Te83IRLeP15MNehYy/1xbRQJoeZ2RXBHbDGlXY?=
 =?us-ascii?Q?qZrK9f0nhotdHokyR4VjZeFv/vmrqUoqcNreyjGvASusp8HtC+LXQ7FKf1P7?=
 =?us-ascii?Q?0prlbXgtO5zdGZKkCneTeS2Fbpx6K1p3n8VhBa0ICQdwTVd3v4KttzytW7m1?=
 =?us-ascii?Q?5mr2kK5WscMYway6nEGCx7hh0kkQWaNQMftY2QbpuMQqKvVnRybt1ZxEY77R?=
 =?us-ascii?Q?3/iCkOE1Xjx7lo4nRASLqpDdQwMBpsdWmw0kgNkP4yiEpTA5asegqb363Ilz?=
 =?us-ascii?Q?DdsTVoeYKsUuEEIS/TuZjnzkANnQAH59ju6sB8p2WBdRkVGEy8mFHwtbrNMH?=
 =?us-ascii?Q?TYWQIJbi5yJPMaoilR+aGfzfpjPo/+TNhTbrTZOTuouEE713ZFyWgRHYU9pL?=
 =?us-ascii?Q?Bg9Ak0Mop0H9R4pp37eYnxRpn/M2aTo5bHWXO16BA6BSJNvo0IRfeEq/4fxX?=
 =?us-ascii?Q?LksI96in1EUu2s+i6iy/DUVIzFVkwesro1CTcut74EWuYiagLllGHkYiWSpN?=
 =?us-ascii?Q?BORt/1lCYu384yZBrzKaccVu8EhfQX+PKDhxS57L2BubAj2GSRtwZQUQ3mqw?=
 =?us-ascii?Q?FVqMuW4fPdwANkoAW1U2meXTCQndPjgkWq6pAkx8SIutHQIXk4Q/XzmRYUd6?=
 =?us-ascii?Q?Dckrp8J4gNjnFb6GZ20Fu4yhj4migcJ0UdLSPV1ssrER5qiJJwAj0+547n6E?=
 =?us-ascii?Q?o83ZfRPWT9xneAlSZ7MRbe5IXZznuiw/wX0fdMYuEB909buyQIY7hRLYBwto?=
 =?us-ascii?Q?hvYgP71uI0hnc9pjlEJeuZWfgn0bo0Z05MLbLj8SJJnb4D0vf6Ly+EXsxk9K?=
 =?us-ascii?Q?a51TaxLkc7z+zV9LaK8RlDIIkhnhWewPsCZX2mn+Pv1xxVXAZ9RHBD8QgKYk?=
 =?us-ascii?Q?BwCb5YzwTIvXgO+l94M2O9cqg84DgCBx8V8A2tZGo1ynS97EuDD8HsYnVW4q?=
 =?us-ascii?Q?iggrRZ4IB5VVFU4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:18:10.5403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37355d54-f2d9-4f69-18a3-08dd1f5e09bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9462

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
index ac34b18ccc0c..10729f235138 100644
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

