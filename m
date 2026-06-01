Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF593769EF;
	Mon,  1 Jun 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316023; cv=fail; b=t3tdxsPRWQALiOXYvURCaKU0gIc8PEf9+eIk0FbsnwOe0GMFfMkYNH8bAfWDLoqnjpZsSaUUf/b+BTf5PN5K2/GF8wj86s5WnEWCo7d+MGUOoTIkW8/o8Hq3wEUkbtCzGVutsGRJ3pI5AP0LCbHrkjZs0kutJ1PeOQQHbS6OnGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316023; c=relaxed/simple;
	bh=rYt1V4z2iypx5+7qIbzPDnubYvG9wq0g1NPBrmjsdr8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PBCc+iFDEC1u0qxDcSdeH57QviebFvlhMJ688QVib7v9alUWLdZDj/eX1qzko6lAbt6j56u8cQllzSM3b09jHR6cDGVfwomBNk1rQ0ZJtf84OmaJjT7uNSagETjxNqOndB3K9vt9exuW4brH814lSLAAlrHlMHZ33zfXXG7BPAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U4HDbRWo; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U4HDbRWo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uN2tM2Z3nyJBBsQgBJq+r71k2YU8VVxOKZWZnGblZ6WfwugAxMnd/JeKTZvCDGfMuWZN7e3uHfL12CFoByxblWw6vJoMCIOJrZCViMfcrCnemuVQ+zSx11PPFuOBpvZpzOIjxAUlW48NY6HjkJKn5/S/ePzhtm819ol+IKgsG1bLd/C2y1eESMBzPDorRdxYPng2HQ9ek0GAYa9xi/hP9bsQXGnAZZQeWvwstI1UoO4TaRIBkXYdjhcghU/VFkmktv42oJ4Xq4vU9IlkH/IhEf2lD7VNytzLNMBpKlZrdChQmUbKU9/cRY2J335tWlsk3gu1PHWxR9qdc7J4iVGWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8jOnzc7mo30vXTUf3wPdFgqRby147G5IHDZqXHDPYU=;
 b=s3HUg+ZF2hgFzPhZAsEsUzfQiZA1NDRL99Jh3lxrkGX7h6z0Ma6BZVqR8WIuF5HDsg/7Vsztow6dZIy+REHE/e0uMvHopg9P5XG7d3TvhWEZ+k4YV9whO4Ck7exMkomWyYRzuuedvY/p8mZ/fhyQ2mp+0gBl1rFqeiHyaLEoYt3tsQHGe9PYGVjS89AixoaMe5P64oRs60luqMWp2bm1zAOadLZIKlMuhpJDVHv9WpGjiTCSsa4veWVGqdOj3TKxU5hAx/Geqd9gyuwFyhrtynKvahq0O2RRr0Q6q2gIzxg8Grw0K31FcCO/x4oS4I2FKcKnk+pkT3SA2GW6uUudFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8jOnzc7mo30vXTUf3wPdFgqRby147G5IHDZqXHDPYU=;
 b=U4HDbRWoznD9jDDRFPK0xO5FQqsoiY+cGI45gnhKdCYqXK7bSVBtbxQbh1U+nDqoWdbbOlbSVZIP0P05Zqy4mdleUlFIzKTwA8DMCNneXme2Q+ENjY92vh4pr1wUOL0b9ut8LM6+73xMdm1CxbfHKU+dW9S1hP8eUrANqbsxMqY=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 12:13:33 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::62) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 12:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 12:13:32 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 07:13:26 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [PATCH v2] perf/x86/amd/uncore: Use Node ID to identify DF and UMC domains
Date: Mon, 1 Jun 2026 17:43:05 +0530
Message-ID: <e7a71a727c6a7b118c23d3e469929c538c4665aa.1780315832.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa4abfb-7552-4f33-06f7-08debfd732f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|82310400026|56012099006|11063799006|13003099007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KN/Rso++is7UoqEa6bwRKNNn44of79V7yGDxl9tjvXL60USMjKuq8wpQ/xAOfwNDW7TvEwKVX4GFoJf/3TN7KZ9VeaqPWWqJVunJ2CRRaoSOUUIAuLNnCfezWBdwaQvSVK6+HBlpUFhujSCR5jEIZgAPcTpvAQOBZXCHCq8An642RkGnth+a1ThsK8JLEjaBP6F3/WswkLqrbic6XYhBAefc2sgYxrQtJiDBHx4KN9wc5O/4zB77CXsLXtkMtuapHvYKOCIPzRcmlfB6Pdn1UdpEG3UDXltTUi89pBfUwBUdcHC5qg40OvXH67C1ynUSdWklYeA/Ixx3TNEoUGBEpigNs3ubop92rBoDxzLjFju8K77DtsOFVt0McDJMEZaocKKJOuzSwQ5rMrbGJFiLU1fNDHhjX/DzzmxODH6z/ebUWHVX7RUd/JqWLp2qa4eIM/RcJ2u450MTsVeaWBfMNXgTsO6ySQU6yKmvnbGYryWuMZZgJoeAV3fQSULnNqwAnfQzGEg07x/lLRKL/E5zEUGPoXJuDQW7g/Wy5oGPzgpSe623NVrmLxObuwpftxdkdnyLMPjPJ6iX5G3PZyiFNw6E4mEz2A6oY8aivr5SypRc5Xvj/VH3MveV8rgEp1TvoFMpTEyNy6yIaNEHIQIAa57UOr13B/cvVOmUnSuvCRl7WoSmlQ4JgNtv4yRNs+pCuRwPoH4i5iAL6fT0TiNB99VR/A6sz5wqDRhWBpZfdVI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(82310400026)(56012099006)(11063799006)(13003099007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WZJaWTHWGgmNFqXDsnBEJTYuuceFcVgPHQ71i3osRZLpuggx7SxxVX6RkmVcm2O5UiRGcBNc+g3QT6HXoglPQ5beKp5hXjDhdhodS0GsrWD3L2gh7Ti0PylezeOlPRr5jUb2os299DKEimA//0MiluXZ/DDBcpnPShqlRce/YflsekdLhHQT4ISeeOiDpBf+SjfLyIWulDC9g7Y14BZ5pQJ+UZr6G59lfaGx93an30rBZvtw6EEhWNjSNs0xUWcZNbZ2QnBOE1daOn+/+Svvmyd2aKpKQopliiGVfTDYEyjxXotGI3n7mraqp3mpZtprCuAzlQOB+yFN5quo7+JGmq4yzsyxZEXxJAIEEnSotjQ4KINATMTw1HOWAziY2ofWCKWAht6aaNXJ0VdXbxQCqX1vRQeMvpmVL3bMJpRIcDX6Ld8JpSabZMYcSGu801g8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:13:32.5820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa4abfb-7552-4f33-06f7-08debfd732f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

For DF and UMC PMUs, a single context is shared across all CPUs that
are connected to the same Data Fabric (DF) instance. Currently, the
Package ID, which also happens to be the Socket ID, is used to identify
DF instances. This approach works for configurations having a single IO
Die (IOD) but fails in the following cases.
  * Older Zen 1 processors, where each chiplet has its own DF instance.
  * Any configurations with multiple DF instances or multiple IODs in
    the same package.

The correct way to identify DF instances is through the Node ID (not to
be confused with NUMA Node ID). This is available in ECX[7:0] of CPUID
leaf 0x8000001e and returned via topology_amd_node_id(). Hence, replace
usage of topology_logical_package_id() with topology_amd_node_id().

Fixes: 07888daa056e ("perf/x86/amd/uncore: Move discovery and registration")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

Previous versions can be found at:
v1: https://lore.kernel.org/all/f337ed92d3e3d519ce4b5d4f23616053ca8a1726.1769063941.git.sandipan.das@amd.com/

Changes in v2:
  * Rebase on top of the latest tip.
  * Make minor changes to the commit message.

---
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 05cff39968ec..6b5a114a09ac 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -701,7 +701,7 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_NB;
 	info.split.gid = 0;
-	info.split.cid = topology_logical_package_id(cpu);
+	info.split.cid = topology_amd_node_id(cpu);
 
 	if (pmu_version >= 2) {
 		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
@@ -1000,8 +1000,8 @@ void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	cpuid(EXT_PERFMON_DEBUG_FEATURES, &eax, &ebx.full, &ecx, &edx);
 	info.split.aux_data = ecx;	/* stash active mask */
 	info.split.num_pmcs = ebx.split.num_umc_pmc;
-	info.split.gid = topology_logical_package_id(cpu);
-	info.split.cid = topology_logical_package_id(cpu);
+	info.split.gid = topology_amd_node_id(cpu);
+	info.split.cid = topology_amd_node_id(cpu);
 	*per_cpu_ptr(uncore->info, cpu) = info;
 }
 
-- 
2.53.0

