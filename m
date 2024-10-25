Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C61F818C;
	Fri, 25 Oct 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855014; cv=fail; b=NOYKuQN9ssmyW3bKbna7MB5ZMn80SChckAhp3sSNa1/3wfyIpPp52WcEtiXB8c4PyhmcSZkInybgoEOgzPKlHMKY0mNlit/x/N+42c4JnJlrSuTSyJboSxS3LUsAC5qUKFNg85tv/XI60bXhB/PZ0BPSKVIBiCUxIjN25RcBT4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855014; c=relaxed/simple;
	bh=rEXqWR2Nr9lhtMd4koq1VppMZu4K6tXM31FV2TErQNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prSinmvBpHy4fv2KMObWYBDESy4SiqR2iGvLGtDnKfKNxsFI1rYRdGE3VmhEHiayxCkZKiHLQRQFCvGnCJiOUCmoQB1Uwrx8S53SWnUKurPmJyXw4hBWkIzug9pRRfkwQZlIbAXVZn9xOSltf9dfVByqJDaDbWCK0j3kvhxYIIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mds0J1A1; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mds0J1A1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2yzJaQ8ekWiss4PFQtDduJah5Ii3iYd/NiZEbNcNtDb/h9aHsFP6eAqM82OtRRdTf43iNjB6nXJhZWr/FR4wPPvU69s+NOeqBd/FBPcuTkccYVRBJJzSETPCPRMf9lc6G4c16aUcSvbNbAvzQtlMMMu57GdR0Acl0TjqjkwFt+wr30CQ+J1Tvs5LBYn/wLiDJbltrJS3dn9h8MRhTMQEcYHPQmKASWqkAkYEoePwHvYWgPaDdY/rxkxdg2XziqxpM014CKDYUJaVksvtmKnI6a7fuCpTPHA2Q7MP5RqUzvL+qtjKB6PbKhgFejw9ZvxZVZfGsHcHhZm9wYz4gGymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjIIQMd+3EPajImyyu5E8TqCCv/S6l+0rsDvsPYmP/A=;
 b=FGbuy+sAmoqRm7jbuKai62w/k7n5bwTpaw2oP73LYdEc3g5zPfiCPf0mN3FubAFut7DSHr9p8HvKtlSrTApCkNhWcPYxZ5Flk/B6B7r3ijYgYAk2AjVDIpRiUQc2Bpzjv2dC6YZ8sXCM6guWsdXQTNZTGhF6IY5RJAtoxjPf8XfxnDuU4DikP71neUT+b5wLfFOyJ1QHY/ogzpGv1xPscFy3woXMM5YB4gL9ixtCm0HwxcsFBk5ramsB09ihIvBZ3BD4g0xhRzp7V0BCElhHFfoiYcsUlvVDucBulxuvu+7+zsvcL8fqZh+2KCPEAtEzaH/kbh3kkCdjFHuasycthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjIIQMd+3EPajImyyu5E8TqCCv/S6l+0rsDvsPYmP/A=;
 b=Mds0J1A18u5o12YL/NDcLT6HHj+ILZWvLRpC4rHNaAYJUmdQJRu9UkzyZj7zwYv1fkmAfmXbWlckeJ4y9t2HCd1+oIuU0m7oNK0uCXbaAduNPbXsZhKOkejLikr0wiA4Dn/IeKyq9CFioWYobMjVuJBMvP2rh+TAz7dP5PCRoao=
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 11:16:50 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::f4) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 11:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:16:49 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:16:43 -0500
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
Subject: [PATCH v6 08/10] perf/x86/rapl: Remove the global variable rapl_msrs
Date: Fri, 25 Oct 2024 11:13:46 +0000
Message-ID: <20241025111348.3810-9-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9c0d2b-0676-48fa-b66f-08dcf4e68576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8EtraLDDy5OFh/KCIfX3gbKwWqyUdn3/Yd6ANIqiuFY2Ca2J6Lzi8bH0cq0s?=
 =?us-ascii?Q?2Cx85nw2Vvpxju5Q3fdics/AA1wtOBnOPYUYB+jP2euaZQEnKwLiYmuhC0Rk?=
 =?us-ascii?Q?PQLe8NrOPo6OV3vwYwIXGc90lixKoHQ92cLiMGxnXeI7vzboFB+l29oQIOer?=
 =?us-ascii?Q?+tKSIU3RH9p/Gf5cGUUOFU6FbMAalPsL7U41aZQkl5hOkCGcbU8czDXNDPMH?=
 =?us-ascii?Q?lO1MG1Gm8hqHqnuwq8QtRjQfekMVGzIqtMs07AIo/GLvQj2SDGmPCL1xez5o?=
 =?us-ascii?Q?h/v9axFFJ8/b/z4ViYRhxxulYNUaaIQaJxWCQbaJuF5pwu9dSiZwgu4hPY2U?=
 =?us-ascii?Q?UHjFN4RCTVH41alshujimuxIA9SD3zUJAKegaX46IfIEmk9I81MCD9t6D0lI?=
 =?us-ascii?Q?8i6KBdj4dZe6LH2mCoQ7wCgMkaQlNcOou355KPKDahl3ZCsdOI9kM7fx7p05?=
 =?us-ascii?Q?fmRLM4EZELESKerqlpbwWcJ4xqLYDscUngVlj3TsuMYBM2T6bs7uZhRnsStv?=
 =?us-ascii?Q?gObEk5SoJl//ylMHeaxCfsnEU3gJ1wgYUUcNfFFaQOXfu+11dzCg7OJ3i5Wa?=
 =?us-ascii?Q?UU2Ae9R4eUxRKrkr+bjlEms7b2vAJnCIyqa+vPwX26z876hstHmCzz6gw3+7?=
 =?us-ascii?Q?am0Fo+TT/IVhYwFRroW1H0WUOyAMKrZH1ctnNvhgq1NdD6oUBTrc1Ha+EWw0?=
 =?us-ascii?Q?kXEGUUossRmNKjzAuwjKgD79vZupuzhZVJMWmKBbctWWch5L75g1iKwitQ2m?=
 =?us-ascii?Q?o0hVx0xAc+r+oNxNJRsYN5q0CTzc0OSD++AfhLREP3yMhyh6p/fDJw8fVsIp?=
 =?us-ascii?Q?38XD541/AWwwMCEezeq6Won5zB9wPc3xl9Cd1pRqFeLAM2DMWGJUmiXnSsxp?=
 =?us-ascii?Q?Whfc4U4Bf6dY4IsLAR3GSjBvorgl6V6GJZrPDEC8+k75Xle9luX5PH0OVyDe?=
 =?us-ascii?Q?8P+xwoYMKHqadQTMctkKZJY9uNJKdeD4tKhsWODLP73Qn0qcJVCtvR7AOJcc?=
 =?us-ascii?Q?sEbz1G4txguVuJiaE8SW6tml3XCR13Mv+7UWqAbup9ADsB/4PtTmNZwHjJHg?=
 =?us-ascii?Q?tX4YT4c7yNEU57TcITcXdCIoiI9E0orCg0Dc5HnaYYqIv3j4O1nr2TVv0Zb5?=
 =?us-ascii?Q?JajtkW6I20C67zv6GW92YWaSLD1Ow8aEQEgZYESphCQzID+l37kmeuxYJKgN?=
 =?us-ascii?Q?xKS3ZwbFnUYvZeTffIraUKAM1cMfVTQU5k2Hq7rTT23V0mja47eGSx7cVe0j?=
 =?us-ascii?Q?g00FAMbEZ6bwtMXHdvVkqEYFutT+t3NpHUKvlP/UC+yiWQ08zvFOOaGymMVt?=
 =?us-ascii?Q?B2pDiHaI36qzUfnrQH7AS02JA6YhiY+h4ERr2Zfpt7LMSxkEFBAzcCa1gnz2?=
 =?us-ascii?Q?+kZGkUFzb+8XJDSf4e0N+CFZJucoIcyrF6Wj3/pcTn1wnfiiJcrugzApWlWQ?=
 =?us-ascii?Q?ke4sEgEXn0E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:16:49.7791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9c0d2b-0676-48fa-b66f-08dcf4e68576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597

Prepare for the addition of RAPL core energy counter support.

After making the rapl_model struct global, the rapl_msrs global
variable isn't needed, so remove it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index ae8b450caa9b..e80b62cf9abc 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -150,7 +150,6 @@ static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
 static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
 
 /*
@@ -376,7 +375,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_msrs[bit].msr;
+	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -805,9 +804,7 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_pkg_msrs;
-
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
 					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
-- 
2.34.1

