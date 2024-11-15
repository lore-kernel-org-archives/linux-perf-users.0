Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30DC17C22A;
	Fri, 15 Nov 2024 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650948; cv=fail; b=qkfVW+hADQs2FWxH8epfe+swQBy0IoBIsGHYYokFyEsT6B5Rc2hVaPOque0Ow2nLAyhzeABFVdH8HBqnOe8hmYE7aGGP1nkJuQyWNBnpBYuKBZSlkZ46y74UJhtZa52Kd0jHhJVRxP8SuZXUb3QiQt4u7cIFb5fc7g23rSpePdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650948; c=relaxed/simple;
	bh=opwavjozzgnwtL4o/pL/gbEqwqG1lBmudZcpYTIqiCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS0ebAx36vXdliKPg+OTT7l93psxiaWBpxiEMTg++STUDX0E4qntQj+MUvLVJK4mrCWpWEIGTk3TtS9AUXEUEJeiCdsP3USy4iDyIAjzgjoafm0wReY2vFJxDIVpOdBMJdnftD9G3vqwawf97QqCIm87Gm/086DcihG8jFtpOw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OBFPuVfs; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OBFPuVfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm3DLJJABo1bpVZSyflYH42zz7frFGTkqMMSbVDYNdeUmLAvErcNMLqjxu6mQYGp9cznlyCcCYdIrCvmtXlIT11Y+Ds/CCZvdH05cm7+wD1WNB4ZcoCHj+JArl2Eut6zAuxBiJ0HZo+sIRVV03YBRD7JZQpYfWzbq5l1RuEbaEijUNnXOdSefg4ttRV1uRsh4axEbWDBsxoCvcsJYYFgmcrrfDB9G3uiz/lk4Jfr+CNUIhYHJAhJOqVy9x2qwlhOEeukXnkH6Sx4bIxfwY5M64rjVp7nGUGhlfFb6a7uE9kbjwqG5LLv9gq2vHSGqP1ylCDBzOtu8k9a7xkjGDqyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbVQI7kQK5zRhVbMUD5+QkS00L4lh5QU+qGcoJkz7jU=;
 b=tTaEpIh8OS3aZ2CzzDVyQkP7kw+vkcOnef+e1mKaclg3dXy7RglN3/oPoxqwT6pwRZdZ/vnrp2ixjyncZ9lMp0m8HoZmuTUeOoQ0hxyHZEYbwHx31TmoTNgE8rIT8uZdv5xBaLDZX5B6YpsiRJaontrFtmFgsi8Bz3so3XKKMyboffuIePyiYpRy1Cg1j0cQkNb554778p8hskoGV3aWfh0VS8N/qbNmbru+aOVWSEoSXxK265NSCTQsK/l7HRHWg0uaEkWhwO7LSo/ia2GH4D5ZK0SmTbb249GZ1SCGVt7cn/f4FHo7j7dCxE/QdNYnzKoN0RX1+1So92E9mHrH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbVQI7kQK5zRhVbMUD5+QkS00L4lh5QU+qGcoJkz7jU=;
 b=OBFPuVfsnQ5qb9KywyDZSXuus2R5n3Y0+6EtQQU0eab2XqXgnQFHBmIgvhNMAkH10jq4rHWnhzj5uCd+C3Z05FmIUATBg18QWmaPBEUx/FHwTKlka61YxRmZ7Tu4s3VOM1cprqUPU9Mjp5jiNxQv0x7tRXHJLgVRkarfClaN7QU=
Received: from SJ0PR13CA0108.namprd13.prod.outlook.com (2603:10b6:a03:2c5::23)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 06:09:01 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8f) by SJ0PR13CA0108.outlook.office365.com
 (2603:10b6:a03:2c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:00 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:08:55 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 01/10] perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function
Date: Fri, 15 Nov 2024 06:07:57 +0000
Message-ID: <20241115060805.447565-2-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c802ee3-38b5-4af3-0ee2-08dd053bffd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6lDaRKGMfqO1s2ndpGLAi8Yam2YMuShBl8GoVvioii96Kndq2eUy7+A4Z6P?=
 =?us-ascii?Q?GlH9ahe7XcA1GFGDUB/0GTyAiMPBK+cq1RsWg/rC7aDlYkw5kgWuu/TvPfYe?=
 =?us-ascii?Q?kdyuMsdsQGL1oFvn2PqD7VhDI50ECMI8MpfMfgc0IkfXBwT+KAnWblh2DmpG?=
 =?us-ascii?Q?bFaws2GGiyeH4e9U5qpE/yJzw00VOs8Wws74Dvac3evJI4cnHfBDfm8cvvee?=
 =?us-ascii?Q?5RrmxDZljSAOX/clXDC1+u4BI1Obr8qx4alFqYQXHCNupjSFK/EfyEjZEfPj?=
 =?us-ascii?Q?okUF6qvgbRvSZ8bYR5KVnpLDGz4zwZ7yl+RvnyIugXNiwIyKFsCpxYEu8KrF?=
 =?us-ascii?Q?zJH4nTEtEWQueeMQjJNqBjqLSy78S2metABcXJCNr0fNerXZRGY9R5bssetb?=
 =?us-ascii?Q?7bhF8Bg5Kf9Wgo3YlVqVgUkoJsHXV1Tm7UnoP/u0q2HbNIilpUq4UYiggh0r?=
 =?us-ascii?Q?NaFe4GtoGcQJdplMK/E8pEykbRcYDd5k44hoxcquh+gJgNrgvIDCx7GuHOH1?=
 =?us-ascii?Q?conkrvDUVWNHj+WiO7SuvUeV7gIcHUSSUUTTzf96IRX2cUkp1hXyaNuw5ck3?=
 =?us-ascii?Q?Vi+7k8jbqPlYJYDWwEdUlThmMyJJSWn651V1N5P8dTsddWC+eGaidCGwvgNK?=
 =?us-ascii?Q?cpj/YK0HtiA9DQk7sMCEHKEkSmUD6V1wuWsrHcJagEHAkpabKIwtJJq17/6O?=
 =?us-ascii?Q?fEfDsC0926HLLJ6hQGS6hZiuGWMV2CHolAxeRDt+D7GTjOR5QRvYRXXMhAi7?=
 =?us-ascii?Q?dQRBj63urtBe69B9AIN/R0dHIawXteDG32APTVeWszWhowTap1g/s1rcc59Y?=
 =?us-ascii?Q?C82rrkl/mV5YeJq9GOKFk3oR5biDe7+Y/o64e1Lr5LFgS6JjS4KTafO0P9r9?=
 =?us-ascii?Q?OE56Rx1ybQZMl//p1QQ+8y4Z+GUNnZ5H1A6R8AUaB2lKkkcHA+C6MvALPTBF?=
 =?us-ascii?Q?OE2w4nYGswkDtjBURH9eEzSq7o7QLU3hBh4HX2211/nVP+2krzsOnDSkNWIW?=
 =?us-ascii?Q?3dLzw67Mqwf/rqYfAz35tOuqnMrUosFWDMGs2fY2AP10l6WW+zmVsoqe/6T1?=
 =?us-ascii?Q?Xc12ZEaXO+iNm/zMjC+GHGS/YP6WZkOS7QKoPLKXZARUf1W/r3yYjgJVnEYS?=
 =?us-ascii?Q?k3As9rgJk4Zo0O+oKdiYyV/J84WzbWA2NJA7J+fTfK3lSWifAzbCtxpEXY/i?=
 =?us-ascii?Q?DZMdIRs2wHgjHu8f5rAagdO9dBkJJpjzhk1CCZgCmHUtjHNQqLdu/CeSO0ul?=
 =?us-ascii?Q?iVgtYa5Ss/EDkfoH38lUpaLqL7hQcdH+CpgyANUYVtMt5+25BKtwhNkgsG6S?=
 =?us-ascii?Q?7qaFpPKScWZlY6vrYQVKL/qbPKioYTnX8nid+bbtHmbeQY0UMuTF6ls9FFaB?=
 =?us-ascii?Q?6vx2vOSO78t3/aceYJMJazmgZBBpNCvwUH1XqLM/5H3CFp9IWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:00.7225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c802ee3-38b5-4af3-0ee2-08dd053bffd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

commit 9e9af8bbb5f9 ("perf/x86/rapl: Clean up cpumask and hotplug")
removes the cpumask handling from rapl. Post that, we no longer need the
get_rapl_pmu_cpumask() function. So remove it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a8defc813c36..f70c49ca0ef3 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -153,7 +153,7 @@ static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
 /*
- * Helper functions to get the correct topology macros according to the
+ * Helper function to get the correct topology id according to the
  * RAPL PMU scope.
  */
 static inline unsigned int get_rapl_pmu_idx(int cpu)
@@ -162,12 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
 					 topology_logical_die_id(cpu);
 }
 
-static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
-{
-	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
-					 topology_die_cpumask(cpu);
-}
-
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
 	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-- 
2.34.1

