Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50123D7E3;
	Mon, 19 Jan 2026 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790653; cv=fail; b=JtX7kVyiJQJPj4Ggjw3UeKSh9omLQenhBUUvs27q9PA2ozHWz4d4ljxNpmYJL7JtGZXVMynJGG7wd1XXi4oSt/5AVeNju45qsfV5N5NXiLlIm/CwZwVIE61m7eVUPQUE3gD47dWLk7J7hwPgNPBnCWXyeAuDsC3ELQ9iedu58TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790653; c=relaxed/simple;
	bh=0pUV228ow/EegTmHVFecJDSMTJA857KsHRbvftAI240=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhvhE9ec+xwNO6teK6enViT1jexLskfC8gIJ/qim9gVgoJOoDQXdPMwcf70ml/YZcsyuRnW2o4BA+bA7NgbC23Z0WIi13Tx32ONQCBLAq9UL83+lGHqxFEamDIOVHfRHgi2/rieLkE+LIvL+AHxCY2qFuBmwvk0wwJpUFx4tlIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zDaSGWuA; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zDaSGWuA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kyhv7NlMYUO8MExx6DZ4iaBu7erU18Ggo8MJlThKplD27SWN4JjGiQkLuqur3fsAsXt2VdC42tNx9QnWjPaw+9CAPgCKDgZ1iH08u7te1WekNXV2nvmtFKaNhR1mUqURjZgy0B6R5ayOckIvbWf9sF4+3kvQNB9hRa25LwyqrurXcLn9zbjHcSVQ/NIX4mTT4x+CNdZXYjXqO3j1PiZs5bcsYE0ESGAP4b7p15++OIBgvv5VvJWcxlxlHDmjomEtnfqLTu7T6qy2UO3FEFBjbbJzJHmIe8cVShTMkNUFN9nAQaSHZUYdCnX+6ewe5me6fXBJH2nrlbZnfdr4H7kRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeVKQSX2KcwqDIS87qdhwBM/24HFm2sWzcYKfRli23s=;
 b=pPpYt10dN0bFHkj6+8fCXNG/q2c0U1dchS7K/Q/OLlLaFNBD5o4IhoYqYYittfngkzXku7e2kRCkeR9/iNNTD2Q4DDSTNEUNw2U5jAmog0M5e4U2eqb5/4NnASK8S86L0GNy/2L+cafH1dfeDtS+Rx+N5lNLvDq5N1PI86X6ymUs13zly6574WiNPjwasIuSYDxbBkioNfFNYTHX+26Fr8/UEG2OzvTLKcYZWHzbxIRnhNRU+Hd5SoUtlGiiTSH7SDDIezRxrO632oMJ2oLN+3n6gWaUxjoVU2pJT+bvLg3L33ply4wJKyoleie05gnHmWLocoKQZReX2OhGxbrbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeVKQSX2KcwqDIS87qdhwBM/24HFm2sWzcYKfRli23s=;
 b=zDaSGWuAz92a6LqS4D5SrodMNXWbquc68poXnrzU6l2O1//WTWRPaQro2F+xu5cfh54dnNJWZMYaNNZljG5i7SsbkPKOHFJQtBm8tS8DQcP7fRUVpTwtM2XfM/xpjXTKQ1KMRwUDXxgcUwjBUvzKs4A5JlKhoHdN1QQxWLiYhj4=
Received: from CY5PR15CA0183.namprd15.prod.outlook.com (2603:10b6:930:81::29)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Mon, 19 Jan 2026 02:44:05 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::f0) by CY5PR15CA0183.outlook.office365.com
 (2603:10b6:930:81::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 02:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 02:44:05 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 20:43:59 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 3/6] perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
Date: Mon, 19 Jan 2026 02:43:24 +0000
Message-ID: <20260119024328.897-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119024328.897-1-ravi.bangoria@amd.com>
References: <20260119024328.897-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ef56da-d036-4b50-e180-08de57049cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vu42jMrG0BBuFN6TtYjib5bBUzCLa1xgaExzh4jH02c5WJI9PpgetAU4k/94?=
 =?us-ascii?Q?MnSfmNl1CRe0/rpFpe7xSsgXtFnurwZ3WpLglmX71gYTVE0wQnusM5iM4Aft?=
 =?us-ascii?Q?isqTgo+InauwAw8IfN7Yy2rdetljqutkuwhDKF00i6aNAKpKnoeowjDApzLn?=
 =?us-ascii?Q?konYxspmfgjZlBQNsIbxY3fNcEXRwVEJ0QRJ50RMf677Xoxm6l6L9Up8dWfm?=
 =?us-ascii?Q?dEhSzqEOTAUsHeaX2KAh1Vd7EWPA1eOZfJYXC0k2Vn1L866B1X//VAM2ZI7z?=
 =?us-ascii?Q?XFuhJELVejvzx0J7LI+olxRlPNX6bf/WMw8C2Ae+j/+B39GB+Pg3onxUdezo?=
 =?us-ascii?Q?2VDBSaQ6BtBSH/HrdwqpetAj6TePNmp5Ir7UJjYdVzvLFmxfFjrJxfnvfSn/?=
 =?us-ascii?Q?7OLkJkzCUqCv0hYGAzKRFd4KmfkgQN7bXUzI6EAe8r6GKQECw6YEDWbc4dSc?=
 =?us-ascii?Q?JNayCw005vfr4IrVlB5zZPT+WsvvZIfzBXBKz8CdH9bAx6jsdEh09nzfQvp0?=
 =?us-ascii?Q?h6xZU+VjB1MiP8/u36ZVE4JOAACa8BJxEMyset6oWaNG2ynWrp8TsOPNF5qd?=
 =?us-ascii?Q?WO+GOcB9HN95xGhcby6zgTCCD8RIGtFHDP0vX5eLdjNOwxwGuHxgZCBItQFO?=
 =?us-ascii?Q?ERjVjggbAOUodHMSBjaK7km5/oC/k6kk6i29t1uuPbftD6yzC2kseZj503gW?=
 =?us-ascii?Q?P9Ucvws9yTSv96+dpL9I5Mqozk3w/8xX2Tgp8cNCKinvirecpzHgyUwby8pI?=
 =?us-ascii?Q?P+8jf0PhAuIQw6UjJ0rgWZ+v+ZqSHCS8I3/Qke9l78f/9CTJWVZ5yyL9L/hv?=
 =?us-ascii?Q?/F34j7MUrXCATaa6n6x0hw/Jq2Du6QyuvipLP3bJdo94qMLT6/u3gIf6Yrc5?=
 =?us-ascii?Q?pdztEkapqv4IfjmJqZSXG8c+uXVIHwBm4DtP+uPn4wTI1D4OsEPv9q2akZ/r?=
 =?us-ascii?Q?TB42x5xwpOw/dTzOwUS9c9Wwhydiq15gMu+uYBZCB1x2t3VYda0DoQFtgPgP?=
 =?us-ascii?Q?9Pw4uKIKrNwgvHP3CHIKOR4qtJCfoyuhdLhCN07CHMCOUIzRk7m1P7H9D6Uc?=
 =?us-ascii?Q?gT1Kz6IbixqwSBu65TG0LKI97Op8K9eearY6LCZ86ff2CjhAO5S1HZ0hBygP?=
 =?us-ascii?Q?fGLKFhX7gtZDWp7T7UDeF7Er5aEZ55JT8m5dQFSoy+hR8l3gx37LWk1dBLYa?=
 =?us-ascii?Q?SZAp/ZD1YilXquNVi0PQWILK4YTWvzdMHMHpEhUvRNp/PaNSfTcxDdISWLsK?=
 =?us-ascii?Q?pfAlJlxTKEEtwzvnidhIDcsx/rfberqOixuLGvT+Ue22l/g8/jjPbi0nq5v4?=
 =?us-ascii?Q?hL3hcT7lbvj5fVSbsNFDwK4CHgQ3shw/D/003SZp0qXEy+5EiFFh/28jl7ov?=
 =?us-ascii?Q?ZbfzL2+69MUbb/Vcg97txRNZvf/6otZlopcWjmUYeB61ukmOS7EV4iZ320FB?=
 =?us-ascii?Q?QGrk0pJcYjubfQ1lZy2bcrlUgeG/WF61pomXYE94foP0Jyp3Mk2T28+zXSIN?=
 =?us-ascii?Q?4NkBEAjEX1OtgtNYrVmdPAN5dIOOPomN7zUm0xpfOy7njsXkgBy4j1hO3nLG?=
 =?us-ascii?Q?EvFhIDt6NgsYMiTeN9EOgk9JoGfG2g8VlAatn5obmwO8UfTl26tVqeJbir0S?=
 =?us-ascii?Q?EYHQ/imwsvL8m7kTI/WWvNAwJuE0s4jB8TE9SYhHjKvrghrE6NLtuSwO9OfG?=
 =?us-ascii?Q?7ye7BQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 02:44:05.4284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ef56da-d036-4b50-e180-08de57049cc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023

On Zen4 (and future) CPUs, IBS_OP_DATA3[TlbRefillLat] is valid only if
IBS_OP_DATA3[DcPhyAddrValid] is set. Similarly, IBS_DC_PHYSADDR is valid
if IBS_OP_DATA3[DcLinAddrValid] is _also_ set. Add these checks while
decoding IBS MSRs.

When IBS is triggered by an unprivileged user, the kernel now zeroes
PhysAddr before storing raw IBS register values in the perf sample. The
perf tool, however, still outputs these zero physical addresses, which
serves no purpose. So avoid printing zero physical addresses.

Instead of explicit family/model checks use the !zen4_ibs_extensions as
a proxy flag to cover Zen 3 and earlier revisions.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/amd-sample-raw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index b084dee76b1a..385308c55f34 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -172,6 +172,7 @@ static void pr_ibs_op_data3(union ibs_op_data3 reg)
 	char dc_l1_l2tlb_miss_str[sizeof(" DcL1TlbMiss _ DcL2TlbMiss _")] = "";
 	char dc_l1tlb_hit_str[sizeof(" DcL1TlbHit2M _ DcL1TlbHit1G _")] = "";
 	char op_mem_width_str[sizeof(" OpMemWidth _____ bytes")] = "";
+	char tlb_refill_lat_str[sizeof(" TlbRefillLat _____")] = "";
 	char dc_l2tlb_hit_2m_str[sizeof(" DcL2TlbHit2M _")] = "";
 	char dc_l2tlb_hit_1g_str[sizeof(" DcL2TlbHit1G _")] = "";
 	char dc_page_size_str[sizeof(" DcPageSize ____")] = "";
@@ -214,17 +215,23 @@ static void pr_ibs_op_data3(union ibs_op_data3 reg)
 			 " DcL2TlbHit1G %d", reg.dc_l2_tlb_hit_1g);
 	}
 
+	/* Use !zen4_ibs_extensions as a proxy for Zen3 and earlier */
+	if (!zen4_ibs_extensions || reg.dc_phy_addr_valid) {
+		snprintf(tlb_refill_lat_str, sizeof(tlb_refill_lat_str),
+			 " TlbRefillLat %5d", reg.tlb_refill_lat);
+	}
+
 	printf("ibs_op_data3:\t%016llx LdOp %d StOp %d%s%s%s DcMiss %d DcMisAcc %d "
 		"DcWcMemAcc %d DcUcMemAcc %d DcLockedOp %d DcMissNoMabAlloc %d "
 		"DcLinAddrValid %d DcPhyAddrValid %d%s%s SwPf %d%s%s "
-		"DcMissLat %5d TlbRefillLat %5d\n",
+		"DcMissLat %5d%s\n",
 		reg.val, reg.ld_op, reg.st_op, dc_l1_l2tlb_miss_str,
 		dtlb_pgsize_cap ? dc_page_size_str : dc_l1tlb_hit_str,
 		dc_l2tlb_hit_2m_str, reg.dc_miss, reg.dc_mis_acc, reg.dc_wc_mem_acc,
 		reg.dc_uc_mem_acc, reg.dc_locked_op, reg.dc_miss_no_mab_alloc,
 		reg.dc_lin_addr_valid, reg.dc_phy_addr_valid, dc_l2tlb_hit_1g_str,
 		l2_miss_str, reg.sw_pf, op_mem_width_str, op_dc_miss_open_mem_reqs_str,
-		reg.dc_miss_lat, reg.tlb_refill_lat);
+		reg.dc_miss_lat, tlb_refill_lat_str);
 }
 
 /*
@@ -253,8 +260,12 @@ static void amd_dump_ibs_op(struct perf_sample *sample)
 	pr_ibs_op_data3(*op_data3);
 	if (op_data3->dc_lin_addr_valid)
 		printf("IbsDCLinAd:\t%016llx\n", *(rip + 4));
-	if (op_data3->dc_phy_addr_valid)
+
+	/* Use !zen4_ibs_extensions as a proxy for Zen3 and earlier */
+	if (op_data3->dc_phy_addr_valid && *(rip + 5) &&
+	    (!zen4_ibs_extensions || op_data3->dc_lin_addr_valid)) {
 		printf("IbsDCPhysAd:\t%016llx\n", *(rip + 5));
+	}
 	if (op_data->op_brn_ret && *(rip + 6))
 		printf("IbsBrTarget:\t%016llx\n", *(rip + 6));
 }
-- 
2.43.0

