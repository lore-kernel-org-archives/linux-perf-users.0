Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7798477E31;
	Fri, 14 Aug 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729760; cv=fail; b=jX4tTDLc+3wSO3voWQ5JrEnIqGGQ89+7hQ0HLgoCyZ+TkAtjjSvmwlz/7X82DMSl8T/FESyiJO9/Lu7IAxejVJza0xTVMxra3jah2DT4eJUZ7+PVWk/E58lBxrgy1RFP95kO8n2Px14O4/hBnMNkp4zSALaXu/t081t6re4+c4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729760; c=relaxed/simple;
	bh=b2bU6qTneVy8afZ87iMIx3Dk7MBe1QfdQrPb3+GzjCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WuRedJxqU9N303RJnz165SectguDW0YajLJlUrweqBzz/4Dqg9TMVgGfFb11B91TwluDCUELttJEKLu/ugtM6/btIi8e32RsXMaUOsYOzv7Euzkt2LTY568hL1A00VdMMRSXWJfXbtNjxfi526uMLa5DJDEW778hl9gcAw4akkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mOTGEVGd; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mOTGEVGd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkqqfFevolf8PqlOJ46qgAnmOa4yJLQKVTZ5s9T0SSX38S25guUyhPXn3VwThaebpWKT4y80lXC0kgLh0SegnsWpkUjipDxgnlraAsxXhCdyH2dl/Zw/bK6A7GbM7YOheuzoK0Ei/9mHjllxDyghTFGJtC3fpneiZyPyxu0dQN9zTyYV8wah5PI0H+QoHhRIen1sg/VHq66vh2X2XHvbYtjxMKJFn0RETdse0UeSb0LNrbmJXNsrXMjXn/0d88le/lWYlSm5glarNzbmMhaVkRnvtXDZwyWsV10XmSkxbtR2AKmvy4d+3BmcdwDnYIkbDelJvbzmMCnwnPa7fGrQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8iE4LpdtKbGEPKtnpoPzoxlaotCGqSPwcyBbalyGys=;
 b=qQqao4g/YRQMAPnjrqLl+BDoIG0g6lDcuIdq5pmD0ExpUG57i8RE97tdbA/CaexEIn9b2lkKodKLW64qSsYZKbq8Dg8jsT2bPMe0mh6YI+glw9KIEMlLuuR3FyIThxG9J9HHMsZJJu+UJxQFMBGjrrwO965yuukRy5QzAyYhiZgxldHPjhCllI1DdlvlsYf+4poyxFYl12po8SE84lBVAnSEWJV3hnIBiskS2gHTTBEyaNlQdZruKhaJvvqd6BxXEkKRfRPReNOuYmFxjZF3GA1aXMNEAnZ7gaF2+ZglhMSXOfzoSxXvpjkZTFUHbFAiUStFbNsah+nVI1z4Iu7eGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8iE4LpdtKbGEPKtnpoPzoxlaotCGqSPwcyBbalyGys=;
 b=mOTGEVGdAZR8S62N451zFNrT0FF2LqrURA8fx6KC4FBPhxOBwM/hTjZaw5qVO512WX59rnuzR/tjOCVNJDyNRQ797iG1AYQMfsMaGwcl9s2+WU6+5P31Ob7IEzHatQT8/uw9H2e1Gba+scVDvWtp3h5HjJn9RtDOO7Nt/6XnrHE=
Received: from SN7PR04CA0087.namprd04.prod.outlook.com (2603:10b6:806:121::32)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 17:49:14 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:121:cafe::66) by SN7PR04CA0087.outlook.office365.com
 (2603:10b6:806:121::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 17:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 17:49:12 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 12:49:05 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Petr Tesarik
	<ptesarik@suse.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen
	<zide.chen@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 0/3] perf/x86: Fix perf_event_print_debug() on non-Intel PMUs
Date: Fri, 14 Aug 2026 23:18:05 +0530
Message-ID: <cover.1786728929.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e775739-70ad-4866-48e6-08defa2c59ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7WTviDuKNQUKfBwRfu63oJTzomVvqMjNFtUKFrWMROcBIreDDj7zPF+wDYubh9BziBv51JIcd0Wgj2IhMBs4xbpxH0agSkDUjPDWJTtfN+Wx26WmIe1qVSmlD3lPAA5xechlP/8jRIWjCBROwoTceeCQ9Ex3CK5y+kX1Q9oy0Y5p3Ko+PnZKSa4OK3XN99nvZwSVFd2nssLZyyLKkYNFeOdKMo4moh9eZiNq7c6IOLMzqO2RekPaUoYJNy2oOysCkW+lSFQdWpY1SmL8aYMPzG0qNVXi2u9TuKhQ4RfZSOL7+d/WmtHSHPjXidDirQs4PcGpeit+oBvvwYfbxj+EmIIkKTtHq+F5pPRXEUCWCyQbrQzijEiIkmqnYRJElGF6AQ88/D3jNriSWOStcW+A5vNMqVFk2V16Ttc6q90DM/YLkhX2xPxmY3+vHKZw8aRTfhdYiIx/W7wUVjHZYZSdzNhByDzzL9G+rnr1AUHXtV5eiBHTxJ54VGLzQjbeR+E5zF9NHrjjyI/+qIV6N5Mxy0y5CImFPIYo4aR5XSuXpDWwtUiuxNZpL4wGiNTG4YC/e8XjXeSiEdDmlHAlbreSYIAfGb1FA98mJhLBQAKslF83lXc3zBj4czCwUJKxIwPI6VeAb4AJ0hD1Y3gZ0FIMX9S+x/RsUDyS+fFN4Q488Sl/GeaZQHL2Q7WkOc45ku2jDr56ciDyEvX5X2gu7y/ixw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3aiZTWku2CjsFwDkHVv2rlcRnGtzpUrDTBLfZtCeM7Za8FV9fbMh0/j37xtpyBJOCA/OrGLxRAa0jPyb4wSoJHBVAvNTzXRmsAiUyEI0m4DXFN0YjfbGt0Ti8YGeDyKZO2LeB7dstSobcVi9bYp7PDS0BD7NoG95YGYJ9mk1S5isanYlZHqsWpAnh7BC2NdxS7dcSRYnpCAU65HuzK5HRAEmBiRrHxrgcKaWURqzbgsS8yzyjGpVL/8KkwexFbrwa9LjkI7Y4D3jOTXh491BJizWsqBYjNuDdLOBqAen4Qwjnj5NXZu59ifOOsAwi/yCbFCzoz4i+vEGK/67Ur1iuSnlLI//FMpI1dZl6TFn6mw576zZgXKE2WSHuq/Kb/ljQg2txfW33i+OUqxrX59Xawf4QIuULT91oKM1PUklt8P3KQEYz4zkfBpiHpjS9Nc0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:49:12.6600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e775739-70ad-4866-48e6-08defa2c59ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787

Petr Tesarik reported that reading MSR_ARCH_PERFMON_FIXED_CTR_CTRL
raises a #GP on AMD processors that support PerfMonV2, and proposed
skipping that register when no fixed counters are implemented [1].

However, perf_event_print_debug() also dumps the global control and
status registers whenever x86_pmu.version >= 2, and reads Intel
Architectural PerfMon MSRs to do so. That condition used to be
Intel-specific, but since commit 21d59e3e2c40 ("perf/x86/amd/core:
Detect PerfMonV2 support"), x86_pmu.version is also set to 2 on AMD
processors that support PerfMonV2, where none of those registers are
available.

The same reasoning therefore applies to the other registers read here,
so rather than special-casing each one or reinstating a vendor check,
this series makes the global register dump a vendor-specific operation.

[1] https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/

Previous versions can be found at
v1: https://lore.kernel.org/all/cover.1786010408.git.sandipan.das@amd.com/

Changes in v2:
  * Address build issue reported by Sashiko.
  * Use a static_call as suggested by Dapeng.
  * Pick up Tested-by from Petr.

Sandipan Das (3):
  perf/x86: Add x86_pmu::print_debug
  perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code
  perf/x86/amd: Implement x86_pmu::print_debug

 arch/x86/events/amd/core.c     | 20 ++++++++++++
 arch/x86/events/core.c         | 60 ++++++++++++++++------------------
 arch/x86/events/intel/core.c   | 32 ++++++++++++++++++
 arch/x86/events/perf_event.h   |  4 +++
 arch/x86/events/zhaoxin/core.c | 18 ++++++++++
 5 files changed, 102 insertions(+), 32 deletions(-)

-- 
2.53.0

