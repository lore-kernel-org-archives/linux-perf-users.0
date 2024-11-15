Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D59175D5D;
	Fri, 15 Nov 2024 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650985; cv=fail; b=NFeAryff+3kQWAJCiIPq/QCs1w+JLy64Nnd6OL/1wAr1hLxjIge+uEIvC+kbezd9GDNReQnhkEn3YYDM1ol6DRn8qjdIQs7afT92MF6S4QTvY/z3yPCZn/IL67dhESjwKNDvRTSRzEcM2Taa28id/fXMIyyeIn0GzcG5yiUjC5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650985; c=relaxed/simple;
	bh=tsAW1ZXU39JnxVvBmLk/nLX25bu1uk6m8LF9RvuD364=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrbACoccGKiMx67QftFhOQYNa8eqdeGzVe0bjgAdhjzN3HC1sZz6aWaMG8Fz6DykUw2tTT/422S8OULyejw+bxaM6a8j09sqmqgT7FaYTCuRnvrTmniPOIOU2XBQhJLztHHy3SUeVxSFtcpbaSmvBxNx9wXS3lY8CehzOru9Sec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bp8TYOLe; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bp8TYOLe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+Vnt5zub2RwbBNpABRD0SW90c6j1Paqq4vmzhP3UzCcISicNDcnrta4BwF+OuGhpF8DUa8eyIRIS6/Gi70zxaTZv1l8IIGGrmNUCL0NZ9HTzgkirvqlw8E6Go9/tTGMgp70yeBlzHegtbrPxLAx8fIAg1lIMm4dqWVDV+94yCGUcwyEzGpICPsV8TG3CA6jC64S0JgQcYikXAlQIh+4tQY2xwfxNEdFiFW1Nk3Zvn0qCTTRcK+ruP+hK8WV584GUEux55ckbdUjSm2HyweEe+slpUJ12XttZTYwVOy5zyK6ewnoAV0S0OGZYZFwBweMGYEBoTcA0OmyV4gDOeFpAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/p5mnlmRDXlitQL1ql0qMaunOgM34+p7TXkLvkBaJ4=;
 b=iSWAhfy2XzEY7cPXaBhcFZJW2HLm5FQEstuzTCXJwXUiJbmBVUjA2G8nEk5pvW09WDkWA5cYELoAwO9w/qzsdZ+Nq4mTHSZ8R+nbL2hFET9QzLUvrE/R+QKaQRGjrGjsuuopTAJVyML9jq0azXIn8zQsQi+tPgrdujopnI5Qh7DN0U18AFNummUrrajWFvBhYRP5jRZt9dDhZsN3TnGeZBO4kIFjuTKhPiWp88xkTTnF4nZ3HdbrTSCWWdgNWFvzr+iTxA7ZsfIn5Ny4V6ihET8P5FJZn9mivuC5T0a//hU3uN0Txo/LdvMKCMl9jQdvv9Q7CAeh3xqIhrfa7PXJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/p5mnlmRDXlitQL1ql0qMaunOgM34+p7TXkLvkBaJ4=;
 b=Bp8TYOLetnIEgiiTZ0R+HGXQI6u0iBLmhMnfKwm/eiPVxWoxfvFw4OPWIVCP08LQ6ih1o26PMrDEFCb9jzshewu+2sG4Gxd0VUZOVXGXeCXj+Rsw2Vvk9erC7K3plX0SBCLh+ZF/GrgHfDl5L4Ya9mfasZM7jvZpVE+KfPKtXYg=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 06:09:37 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::72) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:34 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:29 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
Date: Fri, 15 Nov 2024 06:07:59 +0000
Message-ID: <20241115060805.447565-4-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 53031988-080b-4b7b-d639-08dd053c1433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OlS7lck+HEPsbUgOm3KfUK0mUhYrqpspAtjoMTx4deV58UyyJuS/oq4W/GxJ?=
 =?us-ascii?Q?vggXMzG6pxQ8QRg6E1/z9Tc2IWyqWcz0769CN2F87gbZf6c1yUSILQN6n8I3?=
 =?us-ascii?Q?rTk7+LjODZqCm5OoYGFfSIi2Iz4NzcTDMsPOAa66ex09lvPXHz8JTR2Ac03c?=
 =?us-ascii?Q?bNH65eyoI/77H7uGcqGXVTbmpKnTv88YsFZTVCAdHgTDbUsdllxqquLl7J6q?=
 =?us-ascii?Q?5aXfrFkzgzmTMRZhJd8bopV5TjaPR07BX6SVJjZrCyNt1iPjdF4AXlPltwkm?=
 =?us-ascii?Q?4wKv6HlGJ60kQOZR4NU5awuiLQ3bN/jbCHpSr+Y7wv9jnhakGjuvZuEO/g0X?=
 =?us-ascii?Q?f5qyPnMMiAoZQwO+0iaQqCn/e1rheaiB1etGk6ZZQaa1oCsQWAoQidB+etFi?=
 =?us-ascii?Q?QlGfzJE2G2LbNLzaLcRKt/lBdOmmhqRP68oeMY+L9FBFNGbLqdlXBZH6pUXr?=
 =?us-ascii?Q?zyCd8yeD5r1/OGpnQ+NnivalSfXMILldlTcsLo28t223HxzsVDdvOCeKNDFz?=
 =?us-ascii?Q?q0nlLZcCMEdx3hp6oAL+CON831VqWbPDig5X04appqMeHRmp7tT7784APkMM?=
 =?us-ascii?Q?jGGabOWT91a79np8CaYg4OC+lEBS+Qr6radSdsFYigS79gjRg0LK3rSKW2zc?=
 =?us-ascii?Q?7+EJW5YIhmS0uuxVi6YLBMJuQY9thcG05qFNXwGG9EW7zjztaR00J5L/M25D?=
 =?us-ascii?Q?sbYKm0D+fWyFS1Aqti0wcS8TJorMNO0s5Mc857hN0mMtgy1uysD9hlcsXpHc?=
 =?us-ascii?Q?MBd+w1QXpbPoAKS2Ckv83XtY88Mmpm+2l6NeR3JNsTkCxdNUK3aESqmYEPce?=
 =?us-ascii?Q?H9EaF/3SFxQNnagUW3zrrLpQhFd8GrejwB0zwjKxZmYydjvbKV1uTdFPt3DD?=
 =?us-ascii?Q?N0Q6Sz5EX0yd1GYeY3FdE+KYNH/MJBcnOlMyccmfwT/Fw3c7l1eZfIJrjBmD?=
 =?us-ascii?Q?pcdTUA5dGPGHCKQIzJYSaHkcYfpxWAALNPNPlr0wM2pVC3zDrEeD1WMiO+m7?=
 =?us-ascii?Q?r2j9YfsIeNtBmADj/qc0cMiJRnUwmzDTAK+lf1mRF06j174/mSlK3IBOBOvo?=
 =?us-ascii?Q?kcFQ2ShqYyZQEc2SmGBKurFwwh0znFSQd5rSv1hNynRHZMhYhiGCtuDaovGd?=
 =?us-ascii?Q?S5y6RoQYd9uSCqQ1ZajEvNpFP6rxqIcHaei5XxXiOdifOSYb8yeHhkJ6/UxI?=
 =?us-ascii?Q?IiJj53jSjHOdeb2iz6mvoAYQvUf/8hNG0oP3tzkIuXlKKbvKzDtf8nlk016G?=
 =?us-ascii?Q?Oc6nk0+tbsMpyG7hyGoDYuWg0NNmhaUkMVKsove2kk9HBCcKHAKxmCDUkhMh?=
 =?us-ascii?Q?Sjdqh9N4qWfzs7lMyruhJBKhoOW5ymxK7zTgvzIba2JWIt1dd6QOxDV0z12U?=
 =?us-ascii?Q?hGWrJ7C3fXPpIok3Hrm5idgZ7nUYwNOTLll4P3MW7C5MMc0bjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:34.9096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53031988-080b-4b7b-d639-08dd053c1433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

Prepare for the addition of RAPL core energy counter support.
Post which, one CPU might be mapped to more than one rapl_pmu
(package/die one and a core one). So, remove the cpu_to_rapl_pmu()
function.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
v7 changes:
* Add comment to get_rapl_pmu_idx()
* Change the rapl_pmu_idx variable in rapl_pmu_event_init() to 
  unsigned int
---
 arch/x86/events/rapl.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f70c49ca0ef3..a3c063176513 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -157,22 +157,15 @@ static struct perf_msr *rapl_msrs;
  * RAPL PMU scope.
  */
 static inline unsigned int get_rapl_pmu_idx(int cpu)
-{
+{	/*
+	 * Returns unsigned int, which converts the '-1' return value
+	 * (for non-existent mappings in topology map) to UINT_MAX, so
+	 * the error check in the caller is simplified.
+	 */
 	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
 					 topology_logical_die_id(cpu);
 }
 
-static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
-{
-	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-
-	/*
-	 * The unsigned check also catches the '-1' return value for non
-	 * existent mappings in the topology map.
-	 */
-	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
-}
-
 static inline u64 rapl_read_counter(struct perf_event *event)
 {
 	u64 raw;
@@ -350,6 +343,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
 	struct rapl_pmu *pmu;
+	unsigned int rapl_pmu_idx;
 
 	/* only look at RAPL events */
 	if (event->attr.type != rapl_pmus->pmu.type)
@@ -376,8 +370,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
+	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
+		return -EINVAL;
+
 	/* must be done before validate_group */
-	pmu = cpu_to_rapl_pmu(event->cpu);
+	pmu = rapl_pmus->pmus[rapl_pmu_idx];
 	if (!pmu)
 		return -EINVAL;
 	event->pmu_private = pmu;
-- 
2.34.1

