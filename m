Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96C22B646;
	Fri, 25 Oct 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854943; cv=fail; b=cqbc3MGrz6ghhuJ2gYZUT8Ci45GMbW5x8rzWrqVan8Ye15y4Jr5nSNOyn0a5gf0guUHdPKhpM5VscwN5RqtTJ8TnChbu+SppBJO3b2j65w1EHPAzR/2oXbZXGdwypObzZiuVhz/r8bT9LSnP99OjEpcYYrZPZ44Q4wWcsPVf00o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854943; c=relaxed/simple;
	bh=lUQFP9ajqYt3jdT4zrMLKGRLIm0TBwc36OzZnPBzimk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qk2I/1itQAElRC2cJSPwVKLKmbYF3G9fu8Jhydq+tWamYFWykbWRxl7XBCIm/adZdHKfP/F4Z2aTEuGCAlGmlT+FHtKumok8iYC3zWqk7pvFOyx080I/phiXX+hOulpvZUjseoPpZr7rCJ3HcObAsrsaspdFn9oVSO6MByY5yd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q2tUK2qy; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q2tUK2qy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3zNvEe5g1TN+V40sr/s5+py23+zVKUZ1G90P1wgUo4ifz6ZMGr5NbriJdmnUJijKu6/RC+/nTCkFarToKdEsh6Csa85BN5YaF+0sV2+uEKlYHzX3QUDbl1Fr6BFVkQtZiQxg34wA9xLwsKchYk1i3DWRAAplZSvk6X4VktlFT8CgzdZNAsTuf05Y2thTSwjG/khqbqVQy9GJDkdBqIAvwOs8O+vIhd1qRlGoDEcBbC3802tcTyr0eC2YMySPyFXzoIEqm9fLUGQSnRWAm5muFHWgF5218tTvp7BDB30ll6FZoFpSO4bf97ttd0pupdYjzz5T146SHTi4quNAua38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4Kxsb5RN7oeYh/h48hzuSRlwx2RkkqeDUSA/IAyzv0=;
 b=Y8kc3Qp//MTonsxJ9hYTOBMLK9bGrcCDN7kW/1y5Lk4/YaF7QJxoeBeSKcvMgl0TJTJc31AFTX7Gm/v4UIbYK28iuBvKQCr+oFWPLIeJGU+bt0/ULaovBp03rM4a0UpZxIr0Sl/pwcOS8x3F82FDYKza1060VN9/ANuWWfN05ZzKtQxK+AB6zrb4gW29AHnQzMow61DimC9yAGPs/FMpRm42qEllqiXxovPGQe31JxwTpSykstNeW4cEPOCj4rGSf3XHO+HubjlveuC7o3P6mjqSBWVE2sovqHqmE2E95pk/4yHQft+GWxMRiwPgst9TcZeiv97AZCM3gusDkOgnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4Kxsb5RN7oeYh/h48hzuSRlwx2RkkqeDUSA/IAyzv0=;
 b=q2tUK2qyDKuehdzES8asbnzTl31355TK7nkcf70ivoOEV7ln0CAOBFxrrLG8w5HSSn6HZaWKwDIpvOLJfvADNBI1GleGUKAhi8Q/0jmOPOUQIdaKpKGeymXbw+3JRNMpRyiCSVd2ybtBNuHALf8IcrtnG8jKAOcwvs7G47cjH2Y=
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 25 Oct
 2024 11:15:36 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::32) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 11:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:15:35 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:15:29 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v6 04/10] perf/x86/rapl: Rename rapl_pmu variables
Date: Fri, 25 Oct 2024 11:13:42 +0000
Message-ID: <20241025111348.3810-5-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6e3076-e836-4d02-5a1a-08dcf4e6596a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nSD7SN48t8/BtQuqUEFMMUjsHt4ULIOXcoWl7vF+wYmuP8HhdyrTJOD6CyaQ?=
 =?us-ascii?Q?S8qlJGGMfos8U7vnV8L8SezwIMw0Gu5ZsW1C4Xp7ECKuEof+i48uv+G35+fT?=
 =?us-ascii?Q?W2pXe3FjSjHp/NxE33PghoKYVe3VDbUdbG55P8bqxKLoTmCQ/WX/0gPrg71q?=
 =?us-ascii?Q?CF9o1vIOKBl15foL1JWa25cV9iqQMK4PcRgptLeb+S5B0Atx2Bq8d/VvWVOC?=
 =?us-ascii?Q?s3iScwm+Puw5yx3f9JqUj2GB+gmqjaKk64yZAZD5TEpnLXwVLbIHzbED7qrH?=
 =?us-ascii?Q?0soA1HrbxWXuznGxilu2C9SOhbIo/XLLznhsaz+koe8sZZkMbDOU8OX7cGTC?=
 =?us-ascii?Q?7Ck14W3bRUQV6X8mAUH60UzfU3XJGkr+3DizE5QR7YaNt8ptwPSvEaZ9nyIT?=
 =?us-ascii?Q?4tcCdVNxyxT+ijw5iQsUhHep0sdAjWtani92pCkOlRzMba1sRIEUKNa+j0Rp?=
 =?us-ascii?Q?SVSwOS+rAaUAMjT7APc7XexCvhX9yV115jy0AsIruj6qeMKwGLG8QBxZO4/s?=
 =?us-ascii?Q?IrKt3Q6fgaehy3K2CovnIBJHGaWbHd3B01dSEfsXuTgAUB3VdHXKT9AATIjm?=
 =?us-ascii?Q?iYmfP16mM9DRVt/W7erEPKvQiqiO9v1j7PYJhZR1Q4YDp4Vg/D772Oh7x9p1?=
 =?us-ascii?Q?MCla37TEiSr9i3NqAJ0irqSUsh/ZyHmEc4A7AMwLEDOEst7lZRFAOm1VlgQV?=
 =?us-ascii?Q?PXlMbsRRKsD3P+Wh0I5ZpavL1YdXVVw7TVEiuNSpcQZ8D3JSKR3Zz6Ip+GUM?=
 =?us-ascii?Q?mbezJwfAmjWyOdbDeizXzMZrupDotPrm7zU09BkBAEsly1NURDXedSForC6Q?=
 =?us-ascii?Q?YNt3wnlygR1de0HhRz4p1hXrxHDpVi+S1NV7qRRu3gBe0DBqSVDHjgYOJj+l?=
 =?us-ascii?Q?VOKLi9WXDaqzH7j2Jm7X2APw3CLO1AY5hWb9/JVDBC5ztjxfynJ9Ssxtq6vi?=
 =?us-ascii?Q?yT/f0r8av0YlgLY83S/xZ7YeKpDee/E1bhRYDcHsgc1rUY28nYUN1kdQNFEY?=
 =?us-ascii?Q?u6AAmTCEfiqNxPKfUGF919IbHLD/YGSMT3TiteYji2DcxIahPLkiO5A2Ykqe?=
 =?us-ascii?Q?Er5dNNw12meiddrYqleP3DzNTszveGu/nTrMGzxgGskFg8ApRjXcao8BkKls?=
 =?us-ascii?Q?CCyYW3jvqgxLsuEYrAoiSA92vdy5P//5FLMDzSowkzxDevsFo8PCjjkvuHEu?=
 =?us-ascii?Q?XHveMGfENceNVFbzcUTF1wjPY8n6uZ+l5veBTdmB7AtpTc1Y5oe/9y/xwHXP?=
 =?us-ascii?Q?dToMPVMcWYgn2xNd33qt2TLeEIAZsMlGXB/UoQmQVgGTfcGjipqczEMz63yo?=
 =?us-ascii?Q?XNmoVWYMhXxK7vZulTQPG3qEw0ts7K++CmR0qxyLAJTXM6OieXjk5R8NMNnJ?=
 =?us-ascii?Q?escbenFRx3kReNaM/MhK3QOekAurx8OkMruKat6YTlV2DG+JHXmt8NynqN1G?=
 =?us-ascii?Q?yGNlK26p5F0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:15:35.8940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6e3076-e836-4d02-5a1a-08dcf4e6596a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854

Rename struct rapl_pmu variables from "pmu" to "rapl_pmu", to
avoid any confusion between the variables of two different
structs pmu and rapl_pmu. As rapl_pmu also contains a pointer to
struct pmu, which leads to situations in code like pmu->pmu,
which is needlessly confusing. Above scenario is replaced with
much more readable rapl_pmu->pmu with this change.

Also rename "pmus" member in rapl_pmus struct, for same reason.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 91 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d20c5b1dd0ad..7387bca95018 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -129,7 +129,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
-	struct rapl_pmu		*pmus[] __counted_by(nr_rapl_pmu);
+	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
 enum rapl_unit_quirk {
@@ -223,34 +223,34 @@ static void rapl_start_hrtimer(struct rapl_pmu *pmu)
 
 static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 {
-	struct rapl_pmu *pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
+	struct rapl_pmu *rapl_pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
 	struct perf_event *event;
 	unsigned long flags;
 
-	if (!pmu->n_active)
+	if (!rapl_pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
-	list_for_each_entry(event, &pmu->active_list, active_entry)
+	list_for_each_entry(event, &rapl_pmu->active_list, active_entry)
 		rapl_event_update(event);
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 
-	hrtimer_forward_now(hrtimer, pmu->timer_interval);
+	hrtimer_forward_now(hrtimer, rapl_pmu->timer_interval);
 
 	return HRTIMER_RESTART;
 }
 
-static void rapl_hrtimer_init(struct rapl_pmu *pmu)
+static void rapl_hrtimer_init(struct rapl_pmu *rapl_pmu)
 {
-	struct hrtimer *hr = &pmu->hrtimer;
+	struct hrtimer *hr = &rapl_pmu->hrtimer;
 
 	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hr->function = rapl_hrtimer_handle;
 }
 
-static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
+static void __rapl_pmu_event_start(struct rapl_pmu *rapl_pmu,
 				   struct perf_event *event)
 {
 	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
@@ -258,39 +258,39 @@ static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
 
 	event->hw.state = 0;
 
-	list_add_tail(&event->active_entry, &pmu->active_list);
+	list_add_tail(&event->active_entry, &rapl_pmu->active_list);
 
 	local64_set(&event->hw.prev_count, rapl_read_counter(event));
 
-	pmu->n_active++;
-	if (pmu->n_active == 1)
-		rapl_start_hrtimer(pmu);
+	rapl_pmu->n_active++;
+	if (rapl_pmu->n_active == 1)
+		rapl_start_hrtimer(rapl_pmu);
 }
 
 static void rapl_pmu_event_start(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-	__rapl_pmu_event_start(pmu, event);
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
+	__rapl_pmu_event_start(rapl_pmu, event);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 }
 
 static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
 	/* mark event as deactivated and stopped */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
-		WARN_ON_ONCE(pmu->n_active <= 0);
-		pmu->n_active--;
-		if (pmu->n_active == 0)
-			hrtimer_cancel(&pmu->hrtimer);
+		WARN_ON_ONCE(rapl_pmu->n_active <= 0);
+		rapl_pmu->n_active--;
+		if (rapl_pmu->n_active == 0)
+			hrtimer_cancel(&rapl_pmu->hrtimer);
 
 		list_del(&event->active_entry);
 
@@ -308,23 +308,23 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 }
 
 static int rapl_pmu_event_add(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	if (mode & PERF_EF_START)
-		__rapl_pmu_event_start(pmu, event);
+		__rapl_pmu_event_start(rapl_pmu, event);
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 
 	return 0;
 }
@@ -338,7 +338,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, rapl_pmu_idx, ret = 0;
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 
 	/* only look at RAPL events */
 	if (event->attr.type != rapl_pmus->pmu.type)
@@ -370,10 +370,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	pmu = rapl_pmus->pmus[rapl_pmu_idx];
-	if (!pmu)
+	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
+	if (!rapl_pmu)
 		return -EINVAL;
-	event->pmu_private = pmu;
+
+	event->pmu_private = rapl_pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
@@ -600,7 +601,7 @@ static void cleanup_rapl_pmus(void)
 	int i;
 
 	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
-		kfree(rapl_pmus->pmus[i]);
+		kfree(rapl_pmus->rapl_pmu[i]);
 	kfree(rapl_pmus);
 }
 
@@ -615,27 +616,27 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static int __init init_rapl_pmu(void)
 {
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 	int idx;
 
 	for (idx = 0; idx < rapl_pmus->nr_rapl_pmu; idx++) {
-		pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
-		if (!pmu)
+		rapl_pmu = kzalloc(sizeof(*rapl_pmu), GFP_KERNEL);
+		if (!rapl_pmu)
 			goto free;
 
-		raw_spin_lock_init(&pmu->lock);
-		INIT_LIST_HEAD(&pmu->active_list);
-		pmu->pmu = &rapl_pmus->pmu;
-		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
-		rapl_hrtimer_init(pmu);
+		raw_spin_lock_init(&rapl_pmu->lock);
+		INIT_LIST_HEAD(&rapl_pmu->active_list);
+		rapl_pmu->pmu = &rapl_pmus->pmu;
+		rapl_pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(rapl_pmu);
 
-		rapl_pmus->pmus[idx] = pmu;
+		rapl_pmus->rapl_pmu[idx] = rapl_pmu;
 	}
 
 	return 0;
 free:
 	for (; idx > 0; idx--)
-		kfree(rapl_pmus->pmus[idx - 1]);
+		kfree(rapl_pmus->rapl_pmu[idx - 1]);
 	return -ENOMEM;
 }
 
@@ -649,7 +650,7 @@ static int __init init_rapl_pmus(void)
 		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
 	}
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-- 
2.34.1

