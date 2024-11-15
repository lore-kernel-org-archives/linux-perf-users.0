Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCDF185B77;
	Fri, 15 Nov 2024 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650998; cv=fail; b=iHo0X3sAYlTbVY4ZIqxz8exkcgax7awIkdNDWZ33VQtdDClrjjg7pkLWK0Qt7QjELocrMMN/KuxzM/zF0FkOf7j2A3SpvVbjDDuubBD+rgsMls36t3dK/v9dbvJEyBtpNhwNZZ/BfVEuaesGjMLLNMKh2Zz0JIQwxU3PEInxO/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650998; c=relaxed/simple;
	bh=s+GTVMKAKz7IPYR79PcNnu8eczX2xrfvuYPClxKMlbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWwowbWIKKwraFfFWJxlPJq9M25ksp2QHYmQcNPG6udvAcNNlHzAppnPiBpEKmuTnhitslqZaXagGxW/3zzHQVhSxPc9LwdvuUn4TRskuGu0/JVwOfX3HFRBlwNvbsJ/0tKbl1nC5ruoUazQj0vtnIiaCPNbzCpDVtcMc64gemw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GZcZpZSs; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GZcZpZSs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBSJ6q3Tpjiud61awbP4BjzFJoScpHKI5nhmnNnyKUbkkPky2lgfoihGAsbxjHRTcMLzIw3wJDneWiq7x4CiCizAkmMvq1+K36XwXMSpIVJ3+0DDR5RvfeOXN8ystflLLveF19ihpcYU8fCuX4RaKHMs+nq1fKtmPAoDmNF00WwcSkk0McaC1DEVjQz70JoSJ5YtNi3wDg2hDeuw2nmJpdn1UdReu9X4XvqQyh12HzHa7qC2SnHPx6veJgjd7BlyuLyTWlyErsttTjT45fvG8uZcTR2g/cNMbB5j7DVIAPzagZ+nBLb35v1Rkz9/LWr3kJQ0cKbe+V9s5586xF9yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOfxX9Sj+7LshFYV7yeAKV6GB8AFND85pkDzl6oMLKU=;
 b=dHLPJve2VbET+KsTnafXnDXpMGiw135rb9uz8lBxGcqK1OrTbxE9a/+SItRUhK58urDRQnlRSX1/ysHv+1snn5HRMZzwAr+d61kIQ5TuhzGbfYL7zav3Y6q78uijX0gfww+siaOqLECk6sjJQ+iJBzusbLYyG0xmTC/dfdBGeUFHu4dRoE19l2tKSu66gxeJnzlvDrBSHqqTqYC2E9QbG2NATFlLqgOAujeTkYpddLkvRPZZu4WH2/cOHnXzHVi+rlPFFImtsRi6brWGfGjG4vj4RotsVNAviQdFrzMF4wZKgSiYT/0NX+n/p1ZV10W7SlwOpQIeCcYOfQSqNLEpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOfxX9Sj+7LshFYV7yeAKV6GB8AFND85pkDzl6oMLKU=;
 b=GZcZpZSs+7yIy7Frh2SkWHqerdBKM8Ga8jxiQzSs7xp7bs9IOpSZyuS1yRiqwG1pxWQhgO63StZpotEIA2Nh4SH1u4e63Srd52wLK6h3qG34oTpku7tl28nEdefqbpJv9HH+YNA2Y63IdObcYuEeETAit+70QKOgJ9t6KJqlI8o=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 06:09:52 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::8e) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:51 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:46 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 04/10] perf/x86/rapl: Rename rapl_pmu variables
Date: Fri, 15 Nov 2024 06:08:00 +0000
Message-ID: <20241115060805.447565-5-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b563b9-b2b3-4cd8-5eca-08dd053c1e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j8TBJMoawKiXl3ckRdtYmtSAs4e5pRe98FnJ4pdxxM84zrlrTgh66UMO+yUD?=
 =?us-ascii?Q?XKeEqjSUj2MmartxOfnKobQWpCN5DjOMyYt+X9qIuZetkNza9k6PIyv3QolU?=
 =?us-ascii?Q?K9JS/xqoWZLY652B3vhzxMkfTFCqLjB00dSF5TonJR1s8o3dxajAD98I3BfN?=
 =?us-ascii?Q?Pq1uaRNr+Yz1U+9Dpq0TFw5e7s8A/rTxeZjOTcFy3u8hTkHFgr5fUa8fXL5i?=
 =?us-ascii?Q?zKgaf2dW2iA6h627p97mhM/M4/dbKClANq74e6Fs7wK9nMJ5UhnyXeSvJaAW?=
 =?us-ascii?Q?SFqmAHK/KkQaWsVWZHrjixMt6qJlZr/8v+S0Q7YutuMH0aHV85XbXCSWi/nI?=
 =?us-ascii?Q?8ZF+McFCHyeyNCGTACnD9ps5amcZWj/mQbEsn6Fi8WpR6wUqTjarKpg8n5n/?=
 =?us-ascii?Q?6c1o+O0TretyLGGRMtCWJzge+rACcSg7t3Thn6KK6REceQVht6TXIkgJ/AFi?=
 =?us-ascii?Q?XpudTTevWoqig2IPjCHFLK7DZUpZCWie1+dD3drg4bEXUlzXYeQ2zDDFnWQr?=
 =?us-ascii?Q?BFWOMwIJITbJgCzy5cexYrZvMie6EVkK5i41Iag8E87j40ZjOK0DGAoFbJQo?=
 =?us-ascii?Q?0VFSzT7FJ70NFRSS1IQGpgVOQPq7pS7dUj/3J1iHOUFsi/OUMBO7ibTF2OPO?=
 =?us-ascii?Q?0kiOO6O/m+ni/IvsphJELaWxO05wuBSjnAvIolrIaaRpcFlX7SczTwOEaxNF?=
 =?us-ascii?Q?gYKH58DrLS6QngI1/kNEYAwbFHvhm03pSitYwB/6+LfBY/x3CbWGHSKfuZD7?=
 =?us-ascii?Q?hbAYLsj1y1G1LdMKjuUQOF3Yo0Un0c51APzSSCz5nZA3CaTdzEyvvZiHwhBh?=
 =?us-ascii?Q?wUDAkQi0YBOv9j86kQSq/nEjPHMRTOz4/OqSC9vkIsjAf+5W2x1UI3VMintN?=
 =?us-ascii?Q?wUg6Ky54gMWAcXOGoraZo/TeUSURxuDd9ZfiGoRqMt8oH3klvm6TTvMEWdMe?=
 =?us-ascii?Q?ibeouQOfSy0JpntHM2fl/dkdqqY4XD9fsPHJJf5rngjhpi97NLqaNPk+kTP8?=
 =?us-ascii?Q?rb8FoiAaz4oGQgTjBOwb4pq6nSU0z+MPN83N0YhHVssw7zGxq8kh0kIKzxzj?=
 =?us-ascii?Q?iR9f162t353CRiyblwPKOKL0gffZpnmM32GcemFMmtAtl/iIPXJFnkBPfmCC?=
 =?us-ascii?Q?lhv3oihFiUUfY+fbNaIKjpzbcAcsnFKH6qmoo1UNGXI0IfC07N6C8ziKG3Ln?=
 =?us-ascii?Q?J0aITk7zoanGPIub/vN7qC5pH79VbloZkpxeRr4VH2pYOtBpJVd+g9EXZ+Nu?=
 =?us-ascii?Q?CmBxCqU83L/+BIr4cpUF/E+LgEpFtaJzWAEUERJO5to7aTxHZjGpFXxoNyN2?=
 =?us-ascii?Q?+jzJwUNoq6uA2ehsysTPLw5uGNnvXZe5HOpu4hhY7tyBdNT2zIdQH4h9Yd6/?=
 =?us-ascii?Q?qVzNzZXz0yr+rPoS+hzLfCFsAfaIgbNl2GaPGfkzbUah9PFkBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:51.6661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b563b9-b2b3-4cd8-5eca-08dd053c1e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154

Rename struct rapl_pmu variables from "pmu" to "rapl_pmu", to
avoid any confusion between the variables of two different
structs pmu and rapl_pmu. As rapl_pmu also contains a pointer to
struct pmu, which leads to situations in code like pmu->pmu,
which is needlessly confusing. Above scenario is replaced with
much more readable rapl_pmu->pmu with this change.

Also rename "pmus" member in rapl_pmus struct, for same reason.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 91 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a3c063176513..dc350292e1fc 100644
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
@@ -227,34 +227,34 @@ static void rapl_start_hrtimer(struct rapl_pmu *pmu)
 
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
@@ -262,39 +262,39 @@ static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
 
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
 
@@ -312,23 +312,23 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
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
@@ -342,7 +342,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 	unsigned int rapl_pmu_idx;
 
 	/* only look at RAPL events */
@@ -375,10 +375,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
@@ -605,7 +606,7 @@ static void cleanup_rapl_pmus(void)
 	int i;
 
 	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
-		kfree(rapl_pmus->pmus[i]);
+		kfree(rapl_pmus->rapl_pmu[i]);
 	kfree(rapl_pmus);
 }
 
@@ -620,27 +621,27 @@ static const struct attribute_group *rapl_attr_update[] = {
 
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
 
@@ -654,7 +655,7 @@ static int __init init_rapl_pmus(void)
 		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
 	}
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-- 
2.34.1

