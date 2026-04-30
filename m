Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8BD375AAD;
	Thu, 30 Apr 2026 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529521; cv=fail; b=rA7H7x1z96trkk1UOfooM2eAMWWuuF/quYqf9GvS8vBVITdIgzL4DBkYU3BzYWdFaKjuYwx62tMDeZ+T5SyH4qTj8dA5ZhotLUbdMk3cirCK7COZbzQK7MuGcy56eR+O9a090aZwwhwvEScK5bFB6QH6rI2oF3by4dX/6t/sq64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529521; c=relaxed/simple;
	bh=0pUV228ow/EegTmHVFecJDSMTJA857KsHRbvftAI240=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2D5oXSDTdEPuaWObXswhw5IuXNb5fuuZ6X5++lmPtYOw2CbYIB9/91P7SLOrxWt4XWfV6Y0i8SSKKgifymuDNiaPJoLjLYpDzzdIYlyFr3rkQMCa/sv8HOJiBXmpRc5ZLHjZY3GTrn/6QMM6BtFkA0J82Y2/86VUcQRgN8SWvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tPgYFN4U; arc=fail smtp.client-ip=52.101.52.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tPgYFN4U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9lOVKj6+2lo3N6rHJSb006I5JTtIsfS4loRtVoW71Q6eLEQmstKTNoMOqS8xsp+TtYCf3M0mk9UjVA2U6NjOm6P5bafa4vR3giwH8ba56b9HbgVIGKsL3Dw68sZca7+dO9uKtKeJSWzxHwLyb0yoQX02qtW3a1ObnTDbvh5TekaiTC9kLx06CFdZUTwHtq7dL+oCZIMKIBSSIudSNQrI5fHLvIYnCjv1lubbHTfcCUsQUyR8aNqysA5ZwfNZ70ZAZoRRLseVZZm7jYBfzfyvczcNanY8pEMcfysAlvGySB/3/TuCGnHxVYEp87hfxQtS78jYlXdsTbky5DLouQteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeVKQSX2KcwqDIS87qdhwBM/24HFm2sWzcYKfRli23s=;
 b=Dm1lKuPM5OUTLCJQcNJ8qGttbUy3qxV7U6M5ftLq1h0wIg0LYfxbQZ+LdwHEMUvH/0I9R6TzV8KUsEJhHFlRbPdM3A04bOM/mQpXicFnZ+dRH1zSE0zhdqm8bOhfdH2dneaY0m/jgPSJQmTq93o16PXJGiho90Y2Pd4oO6HfZYG3eqTpxt6XITbXCNjpo6OMAwv3fXk/X75Xt+EZ4naU/Qgu9gQfMCjWkiamaqN9cYw/TyV5aPQZ9Cr5pvWi7pKiAOIMzDTtQjQbDQQOYAlgj4R1iu4TyxRtgzsQ3StTsvgzrval/DtBb9h6x3TicvnMMZ+KqpKEuu59GB9IlMohuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeVKQSX2KcwqDIS87qdhwBM/24HFm2sWzcYKfRli23s=;
 b=tPgYFN4UUfp/P1CPO98uLFeQxYYGo5RYgZ+11JOCCsYmVXSZ8HlVVq0S+5kW+ahnvQbr2HQ2hxOFWZfPCJnnUzjE21/1RgoyJTZDk1MLU6t9PijRFLI6e3f8BhDEVp3rKGMUA9htGMYX1bGExEVpa9CRrq5FCGnNi0jI4T/bM6M=
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:11:55 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::ad) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:11:54 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:11:49 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 4/8] perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
Date: Thu, 30 Apr 2026 06:11:11 +0000
Message-ID: <20260430061115.10266-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430061115.10266-1-ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: e8741478-1dc4-4c31-d07b-08dea67f60eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3CgrBwjYbQcUzXqid2EsLuqqIZWx7n6b0fblE4ticEjgja1c3/10lbQpbtZ0vdO8wHjTzmUCnfGVF4h5rH7c/LcbAO4Zcl5SQCJkhgNgdnNC6A/lXVD3ykwfRHo1+1kY/V6WUQN/waTrywzua7cP7XdrFYjwB5MGcxFFFitgrKYHKTB4+65G3bSHs6lxD6LQL0Nc0fXlMdB0toRc0ca1PkT8v0aG7x5xP7cAUyMxEWe97NEOafj2sxmx5/iMm9Mr1G+gDB/NCxsNhSfG8WjlMfG7w5q8eEnJRCg9/kU1J4kLYhBoaRiIsX1QkJMY1omWKi92hBtpN/i/ekvPU6rfCM9CeVs2j1jtvDqmJKlggf2//IKMDpQLOqaJCJMrQARIQLvBWlGwLVZnzl7wy9jfHgbi+IzBIRbUdJPRlHLn3Isf5I+ZcUcPyRKaQlFiDHI0tBFQmZ1EzerajKrqenFW7R1rM6/b6lQobLwTqWk0KnI3Q6l+JKJINcK/Qg8BAz5d0ilEaAmVadm1A6pDE+a4qr6rNd7GI6mPTPLG1ZXJ0DCz7TjSkjS3BEcj8RX2e53GzYLsU715y9UpUr7dq1f3cL8N98bW/g1VOJmXn5WuZv/oFq5UhmNsGxnjU/E/qSM9Gh3YHQjBCCNaM1jlBKCWql0JKUizKEsvC+kEvv6xyNVEsyb49oJcZGP8vpiIFqEIwmUKpfqPZTuuH27y+OafMbcYtu0SCdwOJN/5UUhmM12ZQW6JcJ/GEfeX+IEWA9CRquyfW2So7doeAcR1JUahnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	73bUraK2Afp7uR1hghJ32OnzKYDAewf8rVcN/WR/15IJx5+nc//zhbqrKdXjl9wAtmdcmFx4kE5to6R9FS4wWkIVPLa0j2EYslOGiG/RC7JOMsPHWGDzlkaGhp1gkN+xVzT98OSXnGTIzQXCGkbYzkaCW5gMnuVbndLHw9qM7H+zURALwTLRVuqQXbyLq/4SBxMIu2LO2xfuEGm+M1Xz8XoRBuf/sg165LHAzgyA+60EjPvyagtmI3l1y6GdG5VJERDK/ZNEWt63OZPXfjRYhS2HOcRnRD3rQqLvpxkGU6Clt84DVZNadg2cCfvlZ4Gx7IJqG13wu+F5AjjEPYsnheCueVXBXZf9Gd3NWEvYfTlh1JiOmnv9ZSW4G/e+xe1XFmUg2E47L/TmqQcI8I7qWDkZKdYX7c5yEtdZTFwvEX+gGIJdNZ82XdTwGk+jFz1I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:11:54.9438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8741478-1dc4-4c31-d07b-08dea67f60eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139

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

