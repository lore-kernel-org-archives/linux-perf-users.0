Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAE61FFC;
	Fri, 13 Sep 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240993; cv=fail; b=KUE+LaVJL6uqQUTHGvfIAodXfIflvbaocYyubm/AdeRCuea0j95pUxDwuol49Uknt0dGUpxbcut1zRW0vYSd6ahM0n5hSvUuvzcc1ZyTku3w16oggtT6SJURAo/zMPPYL5gT5G9pJHbuT7sGSgqKxCcb/90ZiCjR7YoiBcXwcok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240993; c=relaxed/simple;
	bh=fv7/KUPsO0/ptlJcPyQA1MSd0s73Yqktsf9839+Fhfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfu2Yz683lXTdOjAmdlfUbl9+5s6c+oSTEp3VHEHANNUeEdhSq8WbciKGRV4vg0OYz+A38OMO8Nao8QMyRbFnHawDJFv7oZbP/yemU5DGZvRXiBRxMqQtHastpz5SPQjJ9Qqj0pQ24DKPYVvNUa5k2+pNHMS9ZI7sZfCo+q0x4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WRhJ+Sp6; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WRhJ+Sp6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSMmF6Btl5Tnb1JacMB7eJoVthFGGO62ZbK6dvdiw/DD8SKf9zGMAHjESDmJbpiFpyORtemSH/1DoJQlOpBM7LtEuAEBpE4CGHL9096I9PcR/xNf9AH1czoGJlYAN1Jm+Ybl5Mp+TCsaatmgvBcma7E1RG+HSGnaXSVAHKdWaUNd0xh/WpE+sL7dTHUTh1FiZ5/ASJuLmzLL5Yo23kNRnPpsEMEUfjZTgtlD4uY9M0PnItymRHvgGKGyIksanJ0ad3wFyPLShXg3CvkMWImHPNiEmm22HBiOvaPomX2Zyx76k9Q9tALSmjBvEAxJ12FK2lXS9swangZq7iHGHA2n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUc6L1DUGzvYd67MabZEbKXJ5kZ1er7xnnUe8YJ0Nwc=;
 b=YtxewQ0k0njEZUYfHWiwAj/gMuGGm0kHiPQiMpE1zIHh9sR33Tb70lVZjIpdg8ZqxBOUp1ffnCRQIDTMa8T0nj80QnBeE0H63jDiBJoMydoLN+1WkrLgN53QktE/fq0ec4ZUfxjYzzNI97BWth8YFPv4srSOXPd3qgLasS9hLVszA4nA9SFS9nPva+8Lnc2a4eNbPf9Qy1LxupDcHLIE13YEraai2p9hsENFUHV2GztJFVRXF0FaHdrHgXwNUngNFyMSS4cs6cPibDdZxK5z8SpWfJYYY/NlWAq/QGAczYVXDfo20xQheaSBhGcY06+Dl69+4V2iw6gzGTvR8kwSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUc6L1DUGzvYd67MabZEbKXJ5kZ1er7xnnUe8YJ0Nwc=;
 b=WRhJ+Sp63Wv98Dcto6a46mR7hbxMTC/EQEZ/2PaDKXMpO0fI9g5SH3iDwQIU304eI489v/9w+B1X/3KDJfod4M3PoX1VgwZO9HmaxBFuwYxv1Abw3yOv3HSHDKqQ/zIXUMtgFqShWK91gOWFI2DINidl/oAFh2KHBKN90TQ26dA=
Received: from CH0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:610:b3::28)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:23:07 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::45) by CH0PR03CA0053.outlook.office365.com
 (2603:10b6:610:b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.28 via Frontend
 Transport; Fri, 13 Sep 2024 15:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:23:07 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:22:59 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <rui.zhang@intel.com>,
	<oleksandr@natalenko.name>
CC: <eranian@google.com>, <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v5 3/9] perf/x86/rapl: Rename rapl_pmu variables
Date: Fri, 13 Sep 2024 15:21:43 +0000
Message-ID: <20240913152149.6317-4-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cbabef-7cd1-4ae8-3931-08dcd407f877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bL1mtF9548w4ZyekQVyVFs13ZuY7TawPEvlM97IRuOT8FQrmbq10VH8jQ35m?=
 =?us-ascii?Q?U9jpIqZ2QkW2EuAXtg6R56HiguwA7xtAgm2DB/ZMUYp1aEOaQdVZOKOhfV0Z?=
 =?us-ascii?Q?DOKMlZhTe3fifJ9AFJqatiecGfVVrrOXnf7VnVSB11SZiqlWsSgdiQV4Vty6?=
 =?us-ascii?Q?Suep5SDI5hjio4U7vkIY41GTvI66oDHLGfbwVCYS6WscRvu2uQH1RKWSqoJ5?=
 =?us-ascii?Q?TKaT2/bs5KiYcC3MzrA9uzzVkEGP4efI/YVHWykS7XEbF8cy/qpfEnAFSeOU?=
 =?us-ascii?Q?JoJMGp5Oy1FFnqbvY4eMG51+hzy84OXJuAyzPkm8+sYbt4uV6ICfb5ZiA3FD?=
 =?us-ascii?Q?mwsRpqzuSOeBZgJ2274eSwYeVWDR11Zj+rE8u7SWku4JFlQO5VB1LnPdoycX?=
 =?us-ascii?Q?L0++1sLwrp4m+grEQFkBJyvx8oQNV+1yPFCEWx3yAGiXR0DiyP9jb5AONUSa?=
 =?us-ascii?Q?zyoH57fpogbrGi8Y1CNzjqsAzC3D6rTMHcWRfeY3DK2mmmV4fsd29USqfQtY?=
 =?us-ascii?Q?4xXzQPWn1hXCUHEZV5IkV/d1vLkrTLw2xbaDRUhm8KUVDtnNtPuV48HA7aMM?=
 =?us-ascii?Q?o6nivh+evodJ1JaRsfiOuzYs5xADhXFO4irrAarKopeZHR5z2MlSCXdnDZ+3?=
 =?us-ascii?Q?9cCt9+Ddr3nTj77MYaMs/UBSWOuwxfmw2XsmxQ3RCuwbm8/ltaTGn3Ra0Otr?=
 =?us-ascii?Q?Gqh9FQ05Izge9nPKr4ve8PswV4UQnPQwqARpvuWchIXhzf17PmYUHhPDnVJK?=
 =?us-ascii?Q?xqAPofkxUUu3r5uMMSagj9BKnlaTOA1Vx5f4qOwBMNJzzmAixY5/6tyvuEnH?=
 =?us-ascii?Q?qMI9aqLKXGSQtj42d6rOLNjw/TMcOqP4veuVA7D7ARHJyq1dDIq2ksWasBVf?=
 =?us-ascii?Q?YfEIM8jU6Y3ULjtqQRT1kF9Kww5U+bQA4cCqjx1q7cAIuV5Np58/TeCWXmeu?=
 =?us-ascii?Q?RrNfReC+aK7PKUZkdhx2PX6FRvzFBxeZlsasuc+moIaHuCvOV1E2VPYgRtyI?=
 =?us-ascii?Q?jh2uvS6evLkW/+nQgx1nSROpJJY2fp+PFNu4FFgVIR+Iv2ukrnMiIrunM0H+?=
 =?us-ascii?Q?2RkFK6tvCxTnZHzOSU8Xm/Rhc6ezAzOT9tq1ZWcTL8wnYZhdepbPg8/Kcnjy?=
 =?us-ascii?Q?mrlr7mkAkXpU2j0o2V3n7+9PY7N4I2/wV98xiUCoyXZ7l2nUvQcY3nLZeWSd?=
 =?us-ascii?Q?Pkt+KP1+IebLvAUG8vcBDQm+ZdTfbEsUuBBVnC+FPZwoHFSWKGRgg9Ve66rt?=
 =?us-ascii?Q?nyeGzC7p31BTEAaeCtAxQgscdc6QY6Gj6wmd3Ss/a5KJx2MkVLfmbxd6WpEj?=
 =?us-ascii?Q?hr6WMV4ZlarM+30DzA4LNj8REulzM0ItJht4OkwPGHKuXcp8cP2wo4StL9vj?=
 =?us-ascii?Q?WSMwDSr/PKyQWbveK0VB5/m40z7EivyGQ1QcU+E8d5zLlNLuaCvvB0Tc7EbT?=
 =?us-ascii?Q?hbPJ7eU5WYKQ5BcVi2C+BtuxqwOaeoDN75hgMUQGomtXkKWE5OxdJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:23:07.7252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cbabef-7cd1-4ae8-3931-08dcd407f877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

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
 arch/x86/events/rapl.c | 93 +++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b997899233c3..a2f8c77fe629 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -116,7 +116,7 @@ struct rapl_pmu {
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
 
@@ -615,7 +616,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static void __init init_rapl_pmu(void)
 {
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 	int cpu, rapl_pmu_idx;
 
 	cpus_read_lock();
@@ -625,19 +626,19 @@ static void __init init_rapl_pmu(void)
 		if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
 			continue;
 
-		pmu = rapl_pmus->pmus[rapl_pmu_idx];
-		if (pmu)
+		rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
+		if (rapl_pmu)
 			continue;
-		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
-		if (!pmu)
+		rapl_pmu = kzalloc_node(sizeof(*rapl_pmu), GFP_KERNEL, cpu_to_node(cpu));
+		if (!rapl_pmu)
 			continue;
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
 
-		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
+		rapl_pmus->rapl_pmu[rapl_pmu_idx] = rapl_pmu;
 	}
 
 	cpus_read_unlock();
@@ -653,7 +654,7 @@ static int __init init_rapl_pmus(void)
 		rapl_pmu_scope		= PERF_PMU_SCOPE_PKG;
 	}
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-- 
2.34.1

