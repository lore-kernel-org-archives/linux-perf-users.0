Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5F25A35E;
	Wed,  9 Apr 2025 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185524; cv=fail; b=YjuFoa6SV49iksC/ur+crNEXuPi90JPLdiD/aEdmr/FDyYYdphyMArZoXUTHeHG7duoWRRDnRAfRv4hVqlEtAKVn+tkp7jo0vsD4D9T6hfN4vyoElHk/C/iEUOb8Go9lkD4Csz7O2kTWihzhzFzqCTQ6aBGOzK9hSX9ocOGnym4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185524; c=relaxed/simple;
	bh=EQw2bcF067O36lua6IAUKIXn9+so6VYeoyvH+KuBb4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMquPxT1Dn1+5gAu6deFHxqULPqT0OfVh54wfL84MWy4fxOoavz/STxmjxdDWb1NdrASQocv5pVu4XE49x/cgezyO3wVq3JX1Xv7huQ6uRfrDpXKs+oFaXv1yoi9/ookU4535u/Cmwuh/vFpCpB/RfCcXVY0H3X2/tOVngdYx0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TXVtdMMe; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TXVtdMMe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yibAen9reA9ut5VFHrte22oKDBaIZzQVsYdSkXclsQHIFfz3GNjAEANdyNuHLrahDDreF3jNyd2p8OOhrpifS3nnS27Ac2SXQieAMXjbV58Hn9/fohcwXSjy3dx7IZWAkoINU0qp6NmIenn8Ip4bGp6hopalJ19ld/u7AVV/JWOEBjtFb42yp4cV1oDv2nTGQocLwPmrUaMIl5eFmQINHyth1xRpQzXSwomiCZ30oiTcy5juTW8uo0bYy7hhM37RGkbj2lY8WMTAlDUs5vbAIfZj15kKEsdoBQqJ6lLK3uhw6xSFA19SfdEogxJWzVumZUm5mvtH9zPW4H+zWXH9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvee5zeZ8b/e2tICwns+kHBROTnp+iw3PwNKtHaPDF8=;
 b=YCXlmnIuSnnCBVn545uqRyYTSi2bse123dk91ptnPznAJlpqoWVv8mlKU0QNnyFjCvW8zF6W/wwX9QYD5LI9Oac4GRqAGArdoOnHxqDC/WkTcxq+hrvS7mY809eGK0P5tYQUdLy7IfNRnnKZxq97vNjdpcG0wb2z9QbePi6xvVyUwdJ1deJM+7QVyoj/+EKITo2mdcp5XFTHr7jT++NkPhLBb68cEfx81tZ/aQmhViAqR3p+Ux6a4Vv+Z2D+bgDvL3SJq+9ceqsdHaQgsB9fC9x8WYOD4vbf4agiPhaQ7IRPlNN2wCEq+n1DXNc155uN7uhXG1oUd8HP+vDL2vsv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvee5zeZ8b/e2tICwns+kHBROTnp+iw3PwNKtHaPDF8=;
 b=TXVtdMMeRp0f427nYqH/9yjg+c15T+2f/J72ncJ37GAJ5PrPKViL0lSone5UF2vKMP0N0opqs6IR1ldI18aYkvncQ4535Ey8sCQ5Zhx4GxH9o/GS4tLACNfquD5zlHV8cXRF+lLcnbWD7Tix7cn1WIY8EwFsruEo2zA2SPJljD0=
Received: from BY5PR20CA0005.namprd20.prod.outlook.com (2603:10b6:a03:1f4::18)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 07:58:38 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::6b) by BY5PR20CA0005.outlook.office365.com
 (2603:10b6:a03:1f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Wed,
 9 Apr 2025 07:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 07:58:38 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 02:58:32 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <eranian@google.com>,
	<songliubraving@meta.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH 4/4] perf/x86/amd/uncore: Prevent UMC counters from saturating
Date: Wed, 9 Apr 2025 13:27:09 +0530
Message-ID: <c8e5808145985bb558d8daaefe42586b74d4085d.1744184837.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744184837.git.sandipan.das@amd.com>
References: <cover.1744184837.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: b1db04eb-dd31-426d-bf5e-08dd773c566a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Khj82S7xwAz+7/O91pcUDuDwMvVzZvt1dxmE6/HCYmOXAxX6RLQTLU+WARW?=
 =?us-ascii?Q?np4s03+GHdfXYuav+/uwo33WHDAF3RhjdQ6y8POjzzhIKWR0AUnPUnk/W9ZU?=
 =?us-ascii?Q?+XLDu0czDFESrFWWjTY9XQyTt7A40VCvAV0HX2dEXBthhv4t7lVqjmzub3j8?=
 =?us-ascii?Q?na5IH7Upr133SlmoeuGtPI/3NYh5dUkRGX4WiZW/NcWfPNMGWlq2TML9OWcC?=
 =?us-ascii?Q?5K1/rHWVA/y59CbaFeYE5QwZhlAKU6jI+04wh2L41XnBfdSuGIkeZnpuJlWT?=
 =?us-ascii?Q?jXm+L2dQgWkdl31b+BROL/aOnVQlJ871uWWeN72nQ2w94XpDdr++RvPwGVBT?=
 =?us-ascii?Q?GT94ZYas7/8XTw4GoRv8ZgD8tnKGetYR9Q9Mh0C7BgvYiEz84MtFkP3PY4bf?=
 =?us-ascii?Q?NGQoRjEK9rny8w6GUZbUtk1m7le5Ce53Np1TBquhKrpF0Y3jjCHJfd0Z2RVk?=
 =?us-ascii?Q?zmxIleuf0VC5nOLdFzQdoEMAAcpNTaMY8+BP164U9wYTzasLV1/53IfK8NFa?=
 =?us-ascii?Q?h0vtEO5SDbRLHCdf7KSl1TrPpvjQYiKypOfJ3DpwlSROfyqtgBOI8s6Mg5pb?=
 =?us-ascii?Q?WRXdCsrHBnE3IKrtJ3Itin1Orsvo6a3I5tNtadCGl4f1Xf7JfueyTGPVFwo4?=
 =?us-ascii?Q?3sovMRtVz4rISRIFdwCIZqMj3J5JVAZ0ELNUGJG1FSbUvcrknop1YMj2/VK5?=
 =?us-ascii?Q?yKgXHIXfpNbzGjrw5xtwzn6Bqbq/YRBcgXH0WwDGES+1XIi+kfsGZQDo6rOY?=
 =?us-ascii?Q?d+bXe0FSE8AxexravWH4iZebXe3vG2iCAUlsBvzU1SrOJGIXPQty3awhrim/?=
 =?us-ascii?Q?UUsrwr2+uCULWUuT4buD9ihhMUEhrlS7xKtJusFzOicUSYt+QUrg+4jnUq46?=
 =?us-ascii?Q?ca1oA4YlzaAhjyQCd9kKZW/HqX9sUnTl/WUk3oaabKIbzx/Nh/GthAHqRBG4?=
 =?us-ascii?Q?YScuayjKyxYRX8GLd4sGYKVZhcD6iickD1zajcKvuzl5WZJYWo7RUT3pkpE8?=
 =?us-ascii?Q?gxz1IckGowEhRrWfIPpddJMEBrUpCEODYcm8r48+qdQyyhYPlsw+VratDr7e?=
 =?us-ascii?Q?kypezzrT73otXChT/uxEGr8db/6xpDahqC1MlN11Lwv/HAyP9PS1QAON8/YS?=
 =?us-ascii?Q?XvTjka8ctn+UJgzKrtHNBziC1+WfcYReNq5ebebhZnvl9gwoggoj1siMC3P0?=
 =?us-ascii?Q?DciKCpakUoFEG3bMNKUXYbr9j8Y92mUF30z6vhMG8Fkie+4sVTXgp9H9LxQg?=
 =?us-ascii?Q?A6JohJ6bZcgdiTYMmNBNKb/sEbaWJIaoIdClPc0QKT8P8A7yg1lXWCfhDHLp?=
 =?us-ascii?Q?kPkkT59TDZ4cYqEY5C75zOQFFIA3l8WAKYOsT157GAVkpHJXmUgwytBM5yin?=
 =?us-ascii?Q?E6rZ4WS9+ZXiCfBK03EKLgH1nz+WeKtrv1EsXf8rTsko9UMFmKNstImFbljh?=
 =?us-ascii?Q?TXvXbsUUMGiF8VKNgcEtFJsxzFhlBn3ag9q3Dqwv1ty0ISW1AVVE+b0VfkI4?=
 =?us-ascii?Q?9EmCNiXWEsgSq4k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:58:38.6651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1db04eb-dd31-426d-bf5e-08dd773c566a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005

Unlike L3 and DF counters, UMC counters (PERF_CTRs) set the Overflow bit
(bit 48) and saturate on overflow. A subsequent pmu->read() of the event
reports an incorrect accumulated count as there is no difference between
the previous and the current values of the counter.

To avoid this, inspect the current counter value and proactively reset
the corresponding PERF_CTR register on every pmu->read(). Combined with
the periodic reads initiated by the hrtimer, the counters never get a
chance saturate but the resolution reduces to 47 bits.

Fixes: 25e56847821f ("perf/x86/amd/uncore: Add memory controller support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 8135dd60668c..fe746d803a5d 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -965,6 +965,36 @@ static void amd_uncore_umc_start(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
+static void amd_uncore_umc_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev, new, shift;
+	s64 delta;
+
+	shift = COUNTER_SHIFT + 1;
+	prev = local64_read(&hwc->prev_count);
+
+	/*
+	 * UMC counters do not have RDPMC assignments. Read counts directly
+	 * from the corresponding PERF_CTR.
+	 */
+	rdmsrl(hwc->event_base, new);
+
+	/*
+	 * Unlike the other uncore counters, UMC counters saturate and set the
+	 * Overflow bit (bit 48) on overflow. Since they do not roll over,
+	 * proactively reset the corresponding PERF_CTR when bit 47 is set so
+	 * that the counter never gets a chance to saturate.
+	 */
+	if (new & BIT_ULL(63 - COUNTER_SHIFT))
+		wrmsrl(hwc->event_base, 0);
+
+	local64_set(&hwc->prev_count, new);
+	delta = (new << shift) - (prev << shift);
+	delta >>= shift;
+	local64_add(delta, &event->count);
+}
+
 static
 void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 {
@@ -1043,7 +1073,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				.del		= amd_uncore_del,
 				.start		= amd_uncore_umc_start,
 				.stop		= amd_uncore_stop,
-				.read		= amd_uncore_read,
+				.read		= amd_uncore_umc_read,
 				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
 				.module		= THIS_MODULE,
 			};
-- 
2.43.0

