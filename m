Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010058.outbound.protection.outlook.com [40.93.198.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C8376BCD;
	Fri,  8 May 2026 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220059; cv=fail; b=KY972mGf6FN2ByPo2w9Jtpl8mhb5UwdrsGBhDqswxFsfWQRQ/NmAkLNkC20iBDl2WBPu9LsFexP16VmUhr2Yx0f3gjgdVsBp+HcIDcR/OyvGOGVBB4Cxj+HKmoxOnxzvAsejR68bqiz81Oy3rvgsWiqzydAJTDARDIbbGypNyhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220059; c=relaxed/simple;
	bh=0pUV228ow/EegTmHVFecJDSMTJA857KsHRbvftAI240=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNY6pJUGDy1yO8eAySWxnGjy/ul1uTkMWYVW03PrQFBOGBiRHz3mC+i/s4SFcHqTgbC+lYt5DuIFyQnrKSH55g98FEaA5S4nuK5F9MqT7NMiMKXihUT8v9OzbNf+PvD4cCLtxJpTOcRTuC0q4HWTvYUYQEd6LA8nS1bziTKmzHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4EzTtwLi; arc=fail smtp.client-ip=40.93.198.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4EzTtwLi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIGS8P7ZjGnt1Vp1EtlKgPFTvXzDM90ZYmfeMCSL6eVXE2BBQgXrSzNTmcu842JLB+Br4J/qQ83czSkONWfRsLSDnlJF2XQz7Oqc/qkP8572ni2TAE0wbcQ3cNRpjQLgJa6DPv2eH9yX9aWOl/qpfvEx1RV0cQTlzXlWRzHdzjCq+gtBcY9Krt/hEyQ+V7Lv3/jmXawz82yDlRA8JRV7F6fCuaQ49H4j20iVpNHW3Mg45pQerGeeN7HW2Kyn1YJMjGufPQ/tU6LgCajXfqL163hcK82pysovYa/h+gMTBQ5BfTG9DpmoMRmqjN8LVtZMe7PL2JYxOhRMF5/Uucf6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeVKQSX2KcwqDIS87qdhwBM/24HFm2sWzcYKfRli23s=;
 b=NaGgOOr9Ixpp/AKHX3EP7hQZJYpv9TB9P3XFWftzHW1iQcxzAo1i4GkxyRy2in9RAVeLmyoYT2mcKLB2ODTfeuFkGvjHVWLjV7DBxMZnBTp7013unqJh0Z2GGpMZjp1zDhfx3x1EJAIVWFf22cwK9GhKWhzjF3oj3/YgqWB+d3ol596G1qRzsvEUOyuDpFfycOhJ3alScrkKZPfYNHBUTlfwfEZBH4YwHIiJhVYZK6nOCIiRwy53vmdAvz0WEuVcsQPyYm8cY0Yw1dsw76pakxIEwXYSEOl9ganhw8UOeIO+/q0wJPRvMiRC3JBkvNn7QngyDWSIGEKfkKL9s6WQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeVKQSX2KcwqDIS87qdhwBM/24HFm2sWzcYKfRli23s=;
 b=4EzTtwLiIpfKZa8oL6uE7+bKrhxotcxjYQcxxMRAQZHi605ZA264TY/aVNgZ25m78MqZR8gj9ePoWVV/p223YjwT9bzvpo1ZOL24kwLsutVBs3bZ445jT9KUMe3Efq8rng+qi1aapbVcO+cAjqu64umNEwV11x5PeImG0R4RD7g=
Received: from SJ0PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:33f::29)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:00:39 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::cb) by SJ0PR05CA0054.outlook.office365.com
 (2603:10b6:a03:33f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Fri, 8
 May 2026 06:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:39 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:34 -0500
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
Subject: [PATCH v3 4/8] perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
Date: Fri, 8 May 2026 06:00:00 +0000
Message-ID: <20260508060004.2575-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fff0b4-555e-487e-f0f6-08deacc72187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|18002099003|3023799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wp1TZwavoESwNabm0K0lnro1KfNwGEGJBcYtFbhj4NYw40oF5+aMCuLoYPvxm84FJrFJ+bPUE9+0OJY8FRSQFBrYkZ6eHmMB3DfY64pfGwWh0HKdOY6YAO5W95aISrevTjbx2lFvEpJkp8voSfKtiquAwVV9itxlXSx+uT0hEjG1bDmqpKvlMEPef0eMuo+tGNA+3EJRQop+QgP/76cM9zspUeDohDuTLHVP26/68yn0fV6aDnAJ49wVCIZyi9ND1oJLlJYWyquIfnOs3twVA9PgQzS0Z+9wsQT+WS5+cdNZKALO8PzIDZl2aihxzmKc0OblaQE79efzUwXQlLHKC6PGoYxdcyxXdj/FBHoH3XWQGNwv73cZArY3JHbBmeBoJkRTtFe2yVVggl9ZOwEcZmhYNtBVvzUW+iSnu8IBcG+yEKo6e2sbznmtxub1smw4h0UGG0MkJ5Jq5mvGCCqKBxgq2kAvmWwX3kn7ZqyUUbgSHweGfKNwrlkpKAcsWYIaPEe5xEkiFctEpNCKs75jV+yYHGuJl/gSMjNDZEt7ALfonCdWaD0k16HOGxz8G5oDTNQt7Q7k8NZFbouOoA5HVMbxuDgB4JA/31SOGFHJ0vtjEzmyOQ48ykKxkirZBh4Q2VzzIkDHCm9HeqZ0Wui2dYI8H17Ar5cFeug1YKYv/RbDnUlZwl22yXbERmapucaStmM6gWgZoR0WCGDUVX+yD6QQyYPC+vGYQqXEf0sJuCg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(18002099003)(3023799003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EPYeJjFk9wbxLfK3VjXQlwHMLZnEyiIitmc98h/WYCOHr5EuYusAsnp0m2fbUF3xUc+1tvIqFEfn+3dJqJbBAW9FaIQr1mp+DeswHcoMbGc3gOzW40PV7qlsEo6HKWkF/t83P1nvo3JFY5/eq1+4Ncc20uwZqDM0zX9N+WrNqAu4NKRoHd9Qf1L80sdN3KM1/u0qypmMfy3/KOdJCs0+0uBYZAAXaV2jEnUOavEBT20cG1p7mHylTMDpZZMgvg+6PEuygFaDnv+i1yde3DFxLB7hKq07OuC8WJbZtvv5371Ya+U+vTGNSZfraTIyHqMDzPMLoFLj+oPI8grN6yKf9XGJfCW5N0xLkpZY0cauox1UUtl0v98FD+/qtelkT0rDSogHJpQLTAYaJ2FNVg+Gew0dhI+wRcZFVdJQOx1YP17JgN2sinYR6LS+mReRvuxR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:39.3116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fff0b4-555e-487e-f0f6-08deacc72187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

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

