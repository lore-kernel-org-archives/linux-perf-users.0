Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDC1E25E1;
	Fri, 18 Apr 2025 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947843; cv=fail; b=nm10sZscKdYaFeQoEQ+WMLMh7xdw4X6/tQCUKHi+YvRbhwrBCl0biFHVtJse6EhK3bKx0rA/4Mjary91khB6ZzMMAVpKmMItBCkBjCGXgrsL49BMoMCoEPOtjv0aVZvrtENIf510YalHRMHb13tL+m2LgeloC48cYBrGDGb5bZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947843; c=relaxed/simple;
	bh=y5wNSmq8QUO0flqdkg6lLFl/hpBDZrrqL387EL7uCqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Drb41M4RXp/cJi7jVvt1XXhl86o/+1E6nw7qO2gu36YxQ9PURUMpcRZSZJXX8XV83Yp1efoq+J5Sgyn0ceXjDamu1oEbYMJt9E8icm46hdgFMFHLy0W6oOI3yY4iL08C0VCrZAtdZpUDUS93wtMPxjxEgvVO8amS6BtgSg0edvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ik9VHbPj; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ik9VHbPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1aZ/Ib+11oRM5UIa65wWoFvUB5IIP3CAyOzlxGdnja2toCT7bleZigfnM7JGInwv9Gd/dOrkSLRiD/Z/+ZAu7JpH7OPoIBzBTyqFmoApf1PxOwFJjdLHTX3DJHQfQDUk5LqBENEPHSbe6X9J/l9jQRaIpLTylLzXUUYs+1UclkluynQKhI998NwA67L8VPeBI3Xl4eKeWFHdSj3wG9fA0HztSHhrHXqx0iHoqRQE5gmJ5y34UJrk4kIYt4uIOmjW8VkII0DXsOeAQWdIv7amDvCfcnccQWQJ7d02j0oNGfRJdHb+W/WNiwZZvsQ2aPsE7nCOjMPo+f8woh8k1gIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EspE+wP1mZ1DX10FJTH9EyvIIUqN3yS4qs+W9oSS/BY=;
 b=Gwzkhc2UelT2OpTj1oC3kQIJMhB6lrR+h1k3H9Dm3X3UQoW3tLzYZewnHtQ0RjySc0VkLafKM0MEe233jOstAZuJco7l2J9uKq2M/3gxtT98O2drF3LXEsJ2QJaRAS3rpTlE99hroaHdjlcdpvb4NpsPtcP1NksEoKvEdDSLTmEO4N+Dykmn6v3jH6oXtTbKnNgWd/Ah3nucRyodWnqPCOeeXaxiYRQRyzi4/Q3aswX35QxvYcUzaXIdVSe2QUhmjF/7VdKhhcmj9xMMn0JJr5pr95OCQfDZHcG/RctZJQMkBmN0J9iKTmzhb4r4MFwAZFrPaWtegIwUuhYg7TGL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EspE+wP1mZ1DX10FJTH9EyvIIUqN3yS4qs+W9oSS/BY=;
 b=ik9VHbPjl0cWMyQ283Vw+sw0e7g1wl/LiHaE1E73m1pvNt5+MCR/p6YhtxX3DkypuJ58ltSW9TfYFuoIPv5gAXyh+qSOlgKzWENFQ+TmXXsXT+CCVblTR2JLH9m1XRDHDDQBki8rscU8yPM98xK73j9DcmG5WfHe3+oT11VKIAI=
Received: from PH8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:510:2cd::23)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Fri, 18 Apr
 2025 03:43:58 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::72) by PH8PR07CA0007.outlook.office365.com
 (2603:10b6:510:2cd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Fri,
 18 Apr 2025 03:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 03:43:57 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 22:43:48 -0500
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
Subject: [PATCH v2 2/5] perf/x86/intel/uncore: Use HRTIMER_MODE_HARD for detecting overflows
Date: Fri, 18 Apr 2025 09:13:00 +0530
Message-ID: <0ad4698465077225769e8edd5b2c7e8f48f636d5.1744906694.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744906694.git.sandipan.das@amd.com>
References: <cover.1744906694.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: aab0a600-a45e-4c31-362a-08dd7e2b3fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2D/J+Y8DjVgll8m014X1a8yylN2dzTfC4cImNlJQF7UqyNWBtCBaHyxbS6s?=
 =?us-ascii?Q?9ti+VwHTRF4iRMyJREdimf3dsqSiIk4/Zz7RipsAjd96MTM601paD0LmeBet?=
 =?us-ascii?Q?i5YeFrxD28pHPSN9ov76RPGpJ+727HC91xVU/kTEdf66tVGksAH9J6n1+/sL?=
 =?us-ascii?Q?nERF44fGL1n2Utw1xJvX0HBytt/kmeWMqKvwq1J7nsWjXbVbdMK8lJfcA8EQ?=
 =?us-ascii?Q?KHN9LnRaVVBbjc/SemRAtYAvP55XspWL7Gni9Upa2Ec3QzkLsDu1Utb8W6qd?=
 =?us-ascii?Q?N3495husyvVnCQeBX0KoiATRL4B4/VYXMwzQXIyz2VFlMyi6SzQh/qG3j/Jt?=
 =?us-ascii?Q?l35gDl/aFoLUMdfW4DpDOsGZeFuXOgwAKEMhi8MCwjq5xhY6dNBgptFV1uUB?=
 =?us-ascii?Q?f11efQxjRovSuUGHGJgC+YNacGqE/6m+tjVDblJpHsQ2q+oXDoQYRHKs7O2o?=
 =?us-ascii?Q?80vAs8rwXKH15QWT3N/jXxgkZuz5kvfhsPgpyffVIJ0+cx2JfkbslLfhxfaS?=
 =?us-ascii?Q?ZC0TckVPaSYqePNsWgtqtw7BetZAxN2aJp2AgH2UxOYZZraMJ9BtaUFj+/NW?=
 =?us-ascii?Q?VC1GWO41/vdBHy86juVdjxLBGDx75FJN9G1rOCSzIb9307qzhGWXcLFqVHLa?=
 =?us-ascii?Q?/S8N5lDj5Mx8jdn8g5aaHeKYqo6OqzSWv5+7zbauDIbxmkPRAbGR9N8TwMki?=
 =?us-ascii?Q?p09Ihi631c0rGqLotz9vAr0U84qRmSq/NMWupJc8qsVNiNt+jomLO5eoStBZ?=
 =?us-ascii?Q?mLyAFdsVRv5aV1PB0iKq3Ymyk7d7EPWUdU3ZzwYnnUcc1ZIPl1DoWNEEce1y?=
 =?us-ascii?Q?HEIiFyekX+S9T5ZlGWG3dDVWIHrXTBaz8NP3/hzCqXbC3Ftx/rTl92U1lyr/?=
 =?us-ascii?Q?DBhmySMx3Qqw5gFbm9CWXvcSmcnLgXy/vHdQe+cgPQjFsaGiP6TFi+Zw08Cr?=
 =?us-ascii?Q?oOEbktoHlSCGKAuDteYZzXxpZHGznxGjlDdZV40TPZpmaBJaB6SQjJWtlIC3?=
 =?us-ascii?Q?PMbmASBH57LRYe3WIAzx2mQJAelYW6kmOL5m2WxVUsWPCRvPJUyYUeECxrbc?=
 =?us-ascii?Q?YFEsjEOhm+SlzqSjjwFWX2qpj1So8rkKONd7ZYO+Jt35JHEC5eEmMVh+nCSV?=
 =?us-ascii?Q?wMUM6f7rhH7PspS4gkEECYFHROLyKPW97dHi+HyZvyXqF7FuBCT6df9y2qdF?=
 =?us-ascii?Q?bg9zhAW5Kl2DchNdOM9n6mp2IGNNSNYXJ/kopYIj5A1+qaLnFz6NKk4RPx21?=
 =?us-ascii?Q?r5njdfB51Bez9j5zefQ4cJEuahx0SL+weQbDUGQqMEi7ZAkzq8sPlaZxy56V?=
 =?us-ascii?Q?+QYqqeHLduyw4rssXaH2tgy9V12bCf5QmD/IW8R2+bTR/C0uc9tRPH+cj3lV?=
 =?us-ascii?Q?A6sxixW3HWKYlIIxXLl7uAmKNXm6GXMuGyHUcHC5Vjs+Bo13e5gBjalN2EMA?=
 =?us-ascii?Q?tv45QXGwSHNrm3liJMCo++7OOn91f8VxWhzLI0aBlsTQzUyVQpwDHeRELcog?=
 =?us-ascii?Q?nvIjLvD+3Sg3ZcUw9lnKvt7M5gHDD22R7CV+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 03:43:57.2656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab0a600-a45e-4c31-362a-08dd7e2b3fb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

Hrtimer handlers can be deferred to softirq context and affect timely
detection of counter overflows. Hence switch to HRTIMER_MODE_HARD.

Disabling and re-enabling IRQs in the hrtimer handler is not required
as pmu->start() and pmu->stop() can no longer intervene while updating
event->hw.prev_count.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/intel/uncore.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a34e50fc4a8f..5811e172f721 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -305,17 +305,11 @@ static enum hrtimer_restart uncore_pmu_hrtimer(struct hrtimer *hrtimer)
 {
 	struct intel_uncore_box *box;
 	struct perf_event *event;
-	unsigned long flags;
 	int bit;
 
 	box = container_of(hrtimer, struct intel_uncore_box, hrtimer);
 	if (!box->n_active || box->cpu != smp_processor_id())
 		return HRTIMER_NORESTART;
-	/*
-	 * disable local interrupt to prevent uncore_pmu_event_start/stop
-	 * to interrupt the update process
-	 */
-	local_irq_save(flags);
 
 	/*
 	 * handle boxes with an active event list as opposed to active
@@ -328,8 +322,6 @@ static enum hrtimer_restart uncore_pmu_hrtimer(struct hrtimer *hrtimer)
 	for_each_set_bit(bit, box->active_mask, UNCORE_PMC_IDX_MAX)
 		uncore_perf_event_update(box, box->events[bit]);
 
-	local_irq_restore(flags);
-
 	hrtimer_forward_now(hrtimer, ns_to_ktime(box->hrtimer_duration));
 	return HRTIMER_RESTART;
 }
@@ -337,7 +329,7 @@ static enum hrtimer_restart uncore_pmu_hrtimer(struct hrtimer *hrtimer)
 void uncore_pmu_start_hrtimer(struct intel_uncore_box *box)
 {
 	hrtimer_start(&box->hrtimer, ns_to_ktime(box->hrtimer_duration),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 
 void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box)
@@ -347,7 +339,7 @@ void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box)
 
 static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 {
-	hrtimer_setup(&box->hrtimer, uncore_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&box->hrtimer, uncore_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
 
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
-- 
2.43.0

