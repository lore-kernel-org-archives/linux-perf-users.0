Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32BF15D5CA;
	Wed, 26 Jun 2024 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388202; cv=fail; b=W/ZxIAfnhj/9jZtxFBhG2cJ14EZ2Qf/p4/bvzBARhfPFrU0EDI9mJwX4Izqa5hNDb94oXF2WSw1LShFe6UqOtOO6RmJ8cKaOnAb4vOwlAW0qm31XLtNZiCjZ22gmldEfLx0LTAhagolx3M6HDa4cmA+pOXiQM0d56fdHyKWg6gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388202; c=relaxed/simple;
	bh=o4rPm1WxRWsQBJ3HvdPHlUrQfvp8VEmu+9nCdB44s1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3GlyFJhX0I4cMEvbsIhO/MEXloBgBsJ91gGiPXxKgqh1NcC+iPDh/BJRHq12Wpy8+g8E9adV39i3aQQFYE6dsbndgOD+Cf2/8+rhTfrSDJW6uO8xjGcuuS00QfHIZwP+uG4Xxz4oK933B56nRbCDgWYBYjofoMDsWvuaZEv7qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tnPNUu9z; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tnPNUu9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn9eSthX96rprhjg8mQvdFp98sX+UJ73XHVT8ekPWl1YE0Mjik32anj7XAj5gDd5kSsbqO1sJsJm2csQegCTK3WNgglYvsbasINMW4pqW+pjEhWlm8Elk1DF1qSh05zgPOhHoUz0idPRj9QBnsO+40ESGNLG+6v4EtiAjv0WQrodKoR+IX9iM7tU80kE86pKlsetuudcVRYjbfQsO1wAVLLOUzHwS15N1wqtzqnxS5ODyZra3+KBDY3wM/DTPh9L9f5CFLlCpKzPsghZVkdojahCMmARTn1Zkb6l49B1lSXp7lx+7frCxA+mxZtzYU4WQ2g6xy7Q2c81HwIimWDfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLtK8IHiVk17QQaFubPYdvk2aL29qqSqCfzIrBSBfME=;
 b=AUeF0ybD/rvKWnpcersuW9t8RvNj7BJj5V9tovm3IgeUNztX5+N9cWxgg2n2TU+2tdwl3pfRifI6LUSLEfWc+MKBl0pmUvKl1DntAGWxnl4VQthSoCJyHqZ5AVfSLAR24ju0E2K/ueleh3U2bk/rJ1ZpOHqGR8U2xdcQY9AyJptE6HdJ9nKP97ET4FvxN9570E+UUEOmp02PHWbFgfRtwybUNYaTPnx+mh3L4C8H944WRLS2WG8uFIWNFQUvXDJKrFaI3Z49Ysm5iJKT332BA7+/3gtenlMJS2MVqeTfPsEIaLyM69xDpBsW1E9DBv+Zsf2tMVIEBmgNA9g2v4K8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLtK8IHiVk17QQaFubPYdvk2aL29qqSqCfzIrBSBfME=;
 b=tnPNUu9zc1O9wQANhkM4LPhDddQ4mWjilrjwUFc63PWazwrGlkvzZfG0Uz0KxhdiZ6CSrztqIK4ANT7Ui6ZPV7AHB4DsWD+DzaIa6xkVjh8O4iV0lMokn7xOojeZ24dTs7EnmIAQ9UYhNq4glXW6hGc4xhVvRNr2SQW34AWZ1o8=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 07:49:56 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::be) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 07:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 07:49:56 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 02:49:50 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/uncore: Fix DF and UMC domain identification
Date: Wed, 26 Jun 2024 13:19:42 +0530
Message-ID: <20240626074942.1044818-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: ac403265-c970-4dc1-d9e9-08dc95b49287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D8yU1AQMD0bBCNoqiIQP3CICFuXQgQ31w0Vt6D35tEiT+m6iWe3ewk/dAlV5?=
 =?us-ascii?Q?2YqoBPmjrKEncpwB+ujK2fj7ntZyeZ+IR3i4wyxumciQlfNjhGcLi2WQBwzV?=
 =?us-ascii?Q?ChdV6rvvXkynmajNAnKGWFRZohVsbkN3a9/nKd72/HVGj4WJcrwtbfZHyfS/?=
 =?us-ascii?Q?rBRMsp1BAgDAV2EA4u5VDXNP3y1S/QE3MjSYFN3P6fGTiQNfWDDugSO+Bhqt?=
 =?us-ascii?Q?uEVt6XaGi5uwaLEbjHGoI0sVrGwmll1C06UsRiLm+i7SgBB81AQqQBh10u5D?=
 =?us-ascii?Q?jHmGVNHWxeFTpMwO4FrG3LmnqzbL+azV7LWKVsM9SNFLRggaoAKKI/2GmkSW?=
 =?us-ascii?Q?KCh2Vtv2CpS0ek/lPXOn/lst6qAdTfOQZEc09G2IApy0yJWRo+winhjmxmZZ?=
 =?us-ascii?Q?dwvuKTCm0Q9AKejAiOe3w+4PgmyX8WVXIf9fAmRkgeUvYUIblObiYyJF2QHm?=
 =?us-ascii?Q?bsjJAXCP77hhg9aLj4cqiFnYjZS+TUkKUSPbC6m3h8ZpODQIODBRbqu45IW7?=
 =?us-ascii?Q?CaVaL2I9g0d4nICNLCIB40EyfeKie5CSX7nrwNDSq6Pgdmd63V+DC7QiczXS?=
 =?us-ascii?Q?RvIxfYd2HPleOQ1cxq4SCSoiWJnI5shFEtctHW5Xaeu9OQuo7VsDXeZU4x8u?=
 =?us-ascii?Q?gxPpGmTcmIlmg5zVyBAWOo26c9IUwcwzTUsIuD1a/IBXoN87EitEoX6fjGnv?=
 =?us-ascii?Q?+N57ii8FHMe1giedB4X5Cu4Bv4N/6FCVIo1LRvk5fP4luMnyZi8AZJew4wu/?=
 =?us-ascii?Q?PIH5MjYOCZ9Mp+E91x1OfNsG3eqIoiUs8fP/2WXj1jw7RutJkaLYLZz/anLS?=
 =?us-ascii?Q?n8uOG+egVYTjcxYNvfcRsGQlTFDj4dZzmY6PecMp+m0U0mSidwH52TLkpEPs?=
 =?us-ascii?Q?273Jb/e3ipabAIEBGSdDMI1Z0rYc6vI4gyZgm/4GklbyiQypCDPoH75G/FSW?=
 =?us-ascii?Q?OUXGuFYJb1aEkl8+jjebrhUdMK7jIQQeT7Wou8Ua1gUCfPbyNSmcteFTM7Jq?=
 =?us-ascii?Q?Cq7YkE/So8EmKZ5L5nQfIfvs+KOSn3Gb5zbOQ2iuAKn5JGKiKb/sXZGlkcSA?=
 =?us-ascii?Q?VDTnS51VvqVtogWAQBZTYuIVLzD9L0iGZbzre7cY+45zP0X2UMmHnxUipdej?=
 =?us-ascii?Q?FKxY5IJOLpRkxCk3R7rEYLtxGtMlHXA9rZalqWXyGaY8sl6i/OfjU3woK9Pu?=
 =?us-ascii?Q?yK/nlkXcD7IUmIxgVR+9MLvWvR6Qg5Vhpdud0q1vAsPRV3CjZfoL0wKV7VKp?=
 =?us-ascii?Q?XXJTaJkK6jOJ9Cr2V6cDAkvSzCbyfRV5vwEbRuimcbQ6fgk1JyDL8U/dNCdy?=
 =?us-ascii?Q?oeLc6izGNJVv4fbBGvD4o/fI4SS6fo5wCdz0QIImPs58Foa0CrTLcgSLc/mI?=
 =?us-ascii?Q?l0iEyZ73SqZtnDilvp142NPVdo1FX/iWb32NTI6cZP3TIpKg9c6WODEs3OBB?=
 =?us-ascii?Q?EeVsy7hd+ltiwq+9D8LqzSUbHtfbt4WS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 07:49:56.3390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac403265-c970-4dc1-d9e9-08dc95b49287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256

For uncore PMUs, a single context is shared across all CPUs in a domain.
The domain can be a CCX, like in the case of the L3 PMU, or a socket,
like in the case of DF and UMC PMUs. This information is available via
the PMU's cpumask.

For contexts shared across a socket, the domain is currently determined
from topology_die_id() which is incorrect after the introduction of
commit 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD
0x80000026 leaf") as it now returns a CCX identifier on Zen 4 and later
systems which support CPUID leaf 0x80000026.

Use topology_logical_package_id() instead as it always returns a socket
identifier irrespective of the availability of CPUID leaf 0x80000026.

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4ccb8fa483e6..5219c8dbe61b 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -639,7 +639,7 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_NB;
 	info.split.gid = 0;
-	info.split.cid = topology_die_id(cpu);
+	info.split.cid = topology_logical_package_id(cpu);
 
 	if (pmu_version >= 2) {
 		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
@@ -893,8 +893,8 @@ void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 	cpuid(EXT_PERFMON_DEBUG_FEATURES, &eax, &ebx.full, &ecx, &edx);
 	info.split.aux_data = ecx;	/* stash active mask */
 	info.split.num_pmcs = ebx.split.num_umc_pmc;
-	info.split.gid = topology_die_id(cpu);
-	info.split.cid = topology_die_id(cpu);
+	info.split.gid = topology_logical_package_id(cpu);
+	info.split.cid = topology_logical_package_id(cpu);
 	*per_cpu_ptr(uncore->info, cpu) = info;
 }
 
-- 
2.43.0

