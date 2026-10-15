Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED51486430;
	Thu, 15 Oct 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064885; cv=fail; b=ZZyTnOR34Rymb/dHWnaOvgcjKPF4Cl/GlHlYvOVi6Cc7SrLnakwurm0D1M/xBniTJqhkJ3N7V1MV4fMJRkTWEhIeDm4xmmnNAOE2K3egiBQ5ubSOvLDb/xlk7H/dFEU066Ft3Se8oJkCAgTxG+mElVZhUe/wkHAEL8PbSNxYC8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064885; c=relaxed/simple;
	bh=2T8LyhH1EsmT2mjwxf6hyhGEsQ9F6PxBhuS379sqIvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ux4fIeSOb6jCBsteeu476dqTpLMkGbcgGn2vO+BILl2Ky0EKSP9n2YEOxOBNfLmDx1/dJjYWZQF4Hd67595dmS8wiz1DUe9AXdp2LJaa9YoSWFgWo84dRh1xPLJVTzJRZl0SynrcFquVCKTJrcWDfQ0Udvzz/EVneK2pPLnfCbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kiXPcLxs; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kiXPcLxs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iB7Q9FxCetM0CFOJAAbkhU2FShOnIiU6w4hQjcAqSSwB4gTGcxCIVBLH23ySizXS6kdclQEc8kHrQtNO/gdqWOSbtFxY5tQJQbmwGCTqpQxPZXOVbnr/uFTV6GYrTiu9+t5cDaT07Ht7c1JpeLo86l0bo2NLSlHObdfuuFHi0AsVYw7HAn3EtS8helHlvvpAXdSrHkhkNkiTmyCOJ3ETf8sMVyM1QxyNghOTiJyHWJ9w3d+BQ8n8KmyJmMLVVvU6ywKAfhtwOqlF+gfyNNw8Wx+N7DrcspIOaH6cE6XW64nKVDWN3xw/04RLFBYvDlkKmYUFsL2Z2ssJYbG4jWKTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJRZvow0OjBQOSZqq5OkdHXzsVs/pJNNeMsx1o45Fno=;
 b=wpYmx+r4lVbaFzz+VTR5EKHCjYyX7wkH41cDeVNRVV7bHeBqzBkzbSc5lakvKhZLkoveJGoA/QaZblDWDTuED1a39J/tlAZDb2/+6xRQb6st5gR5AH6V50Ea4aK50K4lqYrlI7D3Y2lmIRC2C5ptWzCPyrIv53Ejz/KBdu0yMAdZwq/J/INyOFO2olOmO/TEs+JCP9wKleM/dAiG22+N2IyuNNVACBrEBt6fvis743NHNjlf3ka6NkphdikEEbe+Edi+6gIibYv80r61trgICx0gAYWng5H8mFmPFBdTjaialFM7zysWXmNhciXIwzB33XM/9kdjo7FI1GzlyMbS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJRZvow0OjBQOSZqq5OkdHXzsVs/pJNNeMsx1o45Fno=;
 b=kiXPcLxsoB7tiGFqSXXs0Ds04Au06N/h7qrhl5gpestqSUh3dE6gWepTvHdMhoeOyj0XHZG5fWRYlhCxBJ8UWPT6za0pkRVcsOwRDSJ5o16892+z5rjsCuA5yFOCnWGKUKvy5cajPL5zG1Rm7i4OECBXB09eybiSi7OWBfiqWNQ=
Received: from DS7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::26) by
 FT1PR12MB553912.namprd12.prod.outlook.com (2603:10b6:170:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:48:01 +0000
Received: from CH01EPF000BE949.namprd02.prod.outlook.com
 (2603:10b6:8:2e:cafe::91) by DS7P222CA0017.outlook.office365.com
 (2603:10b6:8:2e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 11:48:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE949.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 11:48:01 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:47:48 -0500
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
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Andrii Nakryiko <andrii@kernel.org>, Song Liu
	<song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 1/2] perf/x86/amd/lbr: Limit branch snapshots to valid entries
Date: Thu, 15 Oct 2026 17:16:11 +0530
Message-ID: <21b52422864cea9f768ddee6be48102954cef984.1792064123.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792064123.git.sandipan.das@amd.com>
References: <cover.1792064123.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE949:EE_|FT1PR12MB553912:EE_
X-MS-Office365-Filtering-Correlation-Id: d34290e2-0f93-46d4-e897-08df2ab22a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Li/WI7QJ+Okh7OLqdwUBw5eupWNd+G1Le5Td49v4sanGfFHE8d8R1SV8su4AfzSycqH259snqKWyZ8Rq/em21I3rEnnSAPuAmOIOH7UJ48r49yVLNicmv1rU2x7aE0XiEajsFpGPEjzoIbTlr7peSx7zL0TtICPjMSwKw2QfaXTsAPD6iMK1h/xF0O0TlDML63vFT9s2EjWBX201lD3GnoI9QRF/JQ80Rs7yYRfqlUJakRDWeMq42GMpKMHf+M7Z5zW3i41e3ZCuKkY7BzMc1/KZ0ocWVyPi7PpJdp6Hq9KxccTMNs4cvW67IrA+hLi458hrGnO0UnAEfA0CWBGKWKghqI4+Zf4YYloQH/R1JdCAg0gCicHn0DA9mPWpKJFe+GGPTzdChQ7yycB17qLB3UXu2+ZcEWdMFn7RziMA/fZMGCWsosPBYLnKiAEUI8/wkxSI6iSBhzbSGioZjWWprGN+aRTGPZOo4tt0RWzpJJfJ8zis8bM+f5cPu83urLCKfNligqDej9vdjIBFEIoSMDthEjLtla1Vsg8JvDoa8fVSv8zN8QU2IsIRLISfHE7KYv8CQGm7m7ckNWvAJ1LxapMTaNMXyZKRTO0a8nMl7LJC2fsQ8rfn89uFP4zsJB7B1lCp/aqA0wlqzYy4kDZHX4cM8qavXvfR+tFGx/EKA5I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b0PymN0E6nF7ZRji1JScBX+apDpTpsO3o7rcwN4oKaFL73Ea6GwuZm5dCYwbpBoift6XAy9UYfmJZy/1zszfXSYBshFQFjjWIHrZla9jsN2KxVMlxE/j/ePCBaQOQm5Os7DOefO968jGtdBdmoz0nxhdYv/kU3G+WMGMA0iMuytYeNNDNKQZFImVysZSMj1O8Z45w2odWk+ypj9a5KjD26fDzRsIRZr7ZB7UKe/DD+FwelQeGhPKmE1xk6SpP8/swKqrj6hiw1XAMi1CmiLh3a/8Do6RiL5H311nByhol7HRGP9PmZh+y1Vd+W5bybgSyBmyC0986+hwzS4Lg6VUFMRs0BZEZoX+sa0exOKFWEQhYKZ5BiBQcl/4AMSh2er3+uCBgIUxTVgZG9VM5CxIcWYR4AuO5uo/5qBmft5Su8jhypSx9YbRP4Z+1I+Z3TjS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:48:01.1163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34290e2-0f93-46d4-e897-08df2ab22a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE949.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB553912

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

