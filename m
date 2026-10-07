Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6F1A9B46;
	Wed,  7 Oct 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396696; cv=fail; b=C6LWEL/8+AaSxhVDQ9aeCrvYJxi0cW1Wb0NZwwJKxaaraehsOAWppZQfJ16PwTSZXHd+hUjGlw2Lce34xMcfzsRREdqWBbOinkVC5FVqmw8BK+F8d96iTA0czsMTQFAzFBaorqzxzHmHrTV79Szbkg2L2p+npg/b9lFwc0wI65U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396696; c=relaxed/simple;
	bh=2T8LyhH1EsmT2mjwxf6hyhGEsQ9F6PxBhuS379sqIvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6aqoTfJJJTnEwAEeOxDhCKGtmJBqKXshImJEGfrX0LF+EGm1qbzb61sb9JuyX8T9414n+BZvddvx9CocxcK2x7o+nMtlueIzZTO2sTKgD7RMQFXgzdbnSDs4t3hve1j3I9dpKBf1eycBWXFVxLc1I1B/941Ns3DrwxWc/gEQKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5xrfRhV; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5xrfRhV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR0ECH6Y0Ap5m9QhBAw83rtfEL5UbmTrzXhnWNqhE0HxumRKHWNMHjSimt0DT9BV2cMZH2toUcgX7C6juDQeYuViifHPmpHZUHd/dn32GVlwkCRVdpPAzSOsC0l8SwKJX9t9GaOJmjQW5tOYJKaM63/Q2OhPzfSQQrSKYcRRHPid9H0mIyvCMRa8uUyr5hY0RDuWiVfK+6qR9Y3ntqE+fmbNKEayZVb8mtSTzVabcXI6EMWacqOhBby0fptDnHF80Pjk4+WwxTiWS38jWemBxvQOvc5pKAqMNv6CksH9i6Xud3sGWO8JPzb5dxhx85nIvcQo4CpFZTVDaz1lrYOoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJRZvow0OjBQOSZqq5OkdHXzsVs/pJNNeMsx1o45Fno=;
 b=EWfHB2HZ4B0eDAXwCU1VboVIWqxd1Jm5Mq4cApn1KTwoGeF48/7BQns2DWDVCvvAcj065sMHDuv6YFlj6kBo7MTz43JJGXL7imqfiAkZm3+xafw/00ZZHWwOmzCKi2Zc+xMFWlx6DzG6ScAdPFN90nWyJkxbOu2t/WEytVb3t0dLxXLmeHI7/qUY1sNQfJWUqAb2Zmjd4AQHHNsu4vlxecW7YsWuxPIcESsRPORuxB00sbUfTj1rB7C9rniFM3+EcFtJRGFMUU6+k++M8Hr8fIsF6K43NuWxa0ThZlv+/0CA98BIm/4KUroegEzPhrQSgKnjm2gMLQSdZe6YjInR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJRZvow0OjBQOSZqq5OkdHXzsVs/pJNNeMsx1o45Fno=;
 b=E5xrfRhVJFVMkAdkHyejuJF6oQpZF28yTrICzf53QM/1vIN+jkmO1fwuloX4sqkz5XnWA9S2RIR1xnx/j15lMb+EOKE1OrD07NYAYZN5q0gMj2bG8i8hXRRy0VZjCPeIeHKwzZjj5QX3n21dtV/WOVOBjBRS6tuOahJVMdFSOvc=
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by EAYPR12MB796180.namprd12.prod.outlook.com (2603:10b6:303:2fb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 18:11:32 +0000
Received: from CO1PEPF00018861.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::67) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 18:11:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018861.mail.protection.outlook.com (10.167.249.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 18:11:32 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 13:11:25 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko
	<andrii@kernel.org>, Song Liu <song@kernel.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/lbr: Limit branch snapshots to valid entries
Date: Wed, 7 Oct 2026 23:40:02 +0530
Message-ID: <20261007181002.4005262-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00018861:EE_|EAYPR12MB796180:EE_
X-MS-Office365-Filtering-Correlation-Id: 386acf52-b228-4fea-b29c-08df249e6aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tHnZRF8DiYqar9YDkF3E8dzsx2F72htHQLFwbpF19+VRrn4FBRhMpAfrv20UoUCJH/QoO/mLiO4WJYejdoYqQJO5KLIZOIwQtpIOrKEF7kDGJGOJwIGO/314ijxDd8HcLoW3M7R9hA2QZGw+YnD0za16ISy3WgYKKNF7PpRyaakyXoXrGOjIfagZrd3psS+YpDkFNQBxlCrxuJxkfdD5M7yNwwPITh2UwYd8vLyemN192UqQ5H+3Yl9h6ulGE3YVTy82wQuQ4m0lHOWljaVsqVW2upldA0c2NdBWHCffKsHTDulxPVkFDOSa2tMS42Q5mlq/fzQ8Dig1GcGpY57rxXACPnTea553yHedkXTcV/cxL3B7DfMWNacdXL7mGUooxKJFUhR3gnv3YFcYoLuYnYmv+6Rda2KnAbbzAnMyRo6RJ7oXxUfhrdr0ui8Myv21qHsSQntlIksSgrk+3QGQJqQygy3tMYgYhUzCt17twtlRXMfxsf5h5N0I2xIYse5m0Is4pNebeCRt8W9wHvFDHWX+Uym9o4h08mrdN1E5z3v/n2ld5AF/lxIkwHssCt25w8esdABub8vqbrkWQ8ubWiqJGVqa03rZsvloclKuDRBOLXwtDkuo7SAGjgSjAhkGLfUtJN3MHjf4FvKX0p8Yxym4+q50C7LLAT5xFWQ6HmWGIoCpE9UdZuwyuZpUu5VyU0ljHZUURqc1BenvKOCrag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MLMgHm1w9SdZpk+qur5JOgaTTXHnP590I5MScpg+IPYQOWF+82CmKXbo03VkxzXzuynQS5xHmyiV+5cXyeld8jB1CC05kIwt3vRm6Snec1x0QGwjJPu0/Inf/dG33r9ifqBGU2aF37fzyU0w2Yat8BOohQuqlZPaR+K6y/pnk1cEBYlJb+AXB8ZUDdALhWIv85f34B05jIi679kKcuSwt030YnYy5r9ihNnLmfSD2xwZ4+6Y2fizu9KEHqji9Q11Hf8sOtGc86rPQE0aEIhwVOy+V793bfgwBIrgkWIqnbviVsdgtuuMoJsqwr7vaXLhDxsr7YpZsOGXQhd/9Mt+E4Iz9KHiO0/a+prZb8WLlm5mhjqOaJi2GfQqwmC8taTVavYR596JvnVzj3+fB+1NZIyb7B6WdWAvkl5P6DU3p6FeTUtzKZDJpECN+DJImluC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:11:32.1878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386acf52-b228-4fea-b29c-08df249e6aaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB796180

The branch snapshot callback used by bpf_get_branch_snapshot() copies
up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
last LBR read kept fewer branches. The entries past lbr_stack.nr are
invalid, but they end up reaching BPF programs.

Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
amd_pmu_lbr_read() skips reading the registers, so that a stale count
is never reused.

Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 2 +-
 arch/x86/events/amd/lbr.c  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..bf631f60757c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 	cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	amd_pmu_lbr_read();
-	cnt = min(cnt, x86_pmu.lbr_nr);
+	cnt = min(cnt, cpuc->lbr_stack.nr);
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 
 	amd_pmu_v2_enable_all(0);
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 1e1b2f08cb51..a00d3850c4a8 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
 	struct branch_entry entry;
 	int out = 0, idx, i;
 
-	if (!cpuc->lbr_users)
+	if (!cpuc->lbr_users) {
+		cpuc->lbr_stack.nr = 0;
 		return;
+	}
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		entry.from.full	= amd_pmu_lbr_get_from(i);
-- 
2.53.0

