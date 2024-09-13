Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503443ADF;
	Fri, 13 Sep 2024 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240973; cv=fail; b=i1+MzcvoqjmzmDcPop0ZPaF84daGyuhJ4kdEHzFbWwfizIQHk9mCT/1GmCIUZ6fFngnNvkqeY0XmW4G4HJ7+O49FBKeN6jHE5FAfmSF3ZCgek+oj1e/Xrn/MV8OO1/Z9GEhn+Le+zkyTt6JK6tVNJjVrz3RXr7/3knSOkKf0qCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240973; c=relaxed/simple;
	bh=XHcPcs9KlH5jMe65Dai8TXwT8LnHTau0CKrTS4YH0Lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNZsa8DIpRGhHwB/19OeINZCjtAO+9Vgg4aXDZ1NC+2S2TbHGKDAkm4lG8vm2mqm3NVKm8cQVP8gAwvyXZvA/RqOqCXZt4VIdlecJhhcaHwLdaHFiGU01255hnOP7nXoLpxq027ubo05GtgNeF2nRTiXDoQBv3FdCpSDnKBJZD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Ki3Xy04; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Ki3Xy04"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKVg3VJrSdg8xxgrI87Jsd9IbSF6OfAaSupJy+Gb5fjsyX7b+GuxV87ri9GNEB6Idm8pM28ifb+MJZz8tSD8w2JClp3oOItNAkxVQ+J+TtXoTZiT9EYCFUj+wkWKlkGwCDPCWnVW98vJHUVSKbjYn7ACI1eaOfBEDlwZ6hxVEMp8fNK3rtG4VIPK4qOoRKMdJCJOyazPBdYWBSN5DPqGYoeIpYcbM8ZfDHMBEq+ujCzKrYUqrJjYjgpB4TNxPc28haoUpl1yMxP+9W9qEFivEDHFfcj5mATVj495s30VhXgQuKE7ignwB3vn1N1REp2tPar4Wz4cRF0m52f0GGCdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEq0p4TDMlyM6GQwt+F4r8XNqOYgqEVl3b2GtoWkndo=;
 b=ELR+zlwb/J3PTlh9iaGOzgqcd1qqG5aWYHqQDpN5TXBOLF+GTSeCF92g/Bpp0Ok2kMWUHLtyaW05SBK4BoCAR8SnDx0iPGHWBQCukxcG7VxOgORlL/OCAPhehJRCdCJoJl2uzGXqr+2EfmHZSoZCvuJrk/8NWhVPFhnmTpjilQaujmpRdYVVu3Ypz0TCi9DrQPdfMmzhsq7856JwbRVXr3AcI5jjFmCDPLNmdKw2+XzMykYK+FfTujwd3mocBEKz5A7lIfWn9pTHcbd4Iq4lOvj3VMiVCa+s96R72bZYrRl/676NMMegf+F+Hw3kt9otLKmcqDE12nDdLqIBKYclWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEq0p4TDMlyM6GQwt+F4r8XNqOYgqEVl3b2GtoWkndo=;
 b=5Ki3Xy04GHnuyUvOhneLzxmpOFb8iuxGkotOKh/uFFSv6YE8BvqVUfBb4CLy2Lk0Xr3CQX8EMQNsmskoIMhvuF38VgRkPWe8eLGQmiZkQOOJ//fQMmLjBHHV7gleYJdteOiUcNxId32zC2WBn5QR+QxBt4D5fP4DBsXnZmI9ncg=
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 15:22:47 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::6c) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 13 Sep 2024 15:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:22:47 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:22:40 -0500
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
Subject: [PATCH v5 2/9] perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
Date: Fri, 13 Sep 2024 15:21:42 +0000
Message-ID: <20240913152149.6317-3-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: f57d30ab-1a8d-446b-c2b7-08dcd407ec1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hu+D8R+j7/CrDybt/O+8/AgUmn4w0YPinDKMMbqe0GLJXXgGfy3aLyBAeBlG?=
 =?us-ascii?Q?YiV4cdBWYeGMMCG2R0m9ZhBr4sBnYJYCTOZJKyUWTy1ouIbsEw6Q/LGPFkT+?=
 =?us-ascii?Q?uRlR9Mlsb6WBlSgA1pOoQoeuTqQpo1Mo/aCbfc4oWLjTb7X9TvP/kRKRzCsZ?=
 =?us-ascii?Q?4tpHjdAZOIfT3kDEzh/vt8+kj9cbeKGpzabX4iBsqURA/AVgLcKPaqkVhYnW?=
 =?us-ascii?Q?4Hr0fAO1LQ6aqghUlDcTnlUaPqF0mr80elL2AyoTiDcOc6d2rvWbUVShQXlh?=
 =?us-ascii?Q?0J1ZBLMpphSu3wdVDXKkigp8HU61q+yA5nCOduXvW/9ZtaWXq65b4Pccns1l?=
 =?us-ascii?Q?liO0JHyoAsjXkGJ2A8eRMHpdUT0g6Bj+qhS0m3oBtdkgPtNg/Mvibo6ZuEjQ?=
 =?us-ascii?Q?yYhEriVfQcaBWtHy1P4eSw4mpvbBfxhXL/K1gQvfWtrwczuTYqBeaCVuhAyC?=
 =?us-ascii?Q?vNVhFvcUIuhcjwpviv1p3ijDEYckS79tMgZIE1iTfqebjkwEYcR71Hvr2fOT?=
 =?us-ascii?Q?CzzcUuyAXBEvf63lr7XtWA/snVdVFGyhjTT9SSE72qC9d//a+1MyMunDHgtZ?=
 =?us-ascii?Q?hn58Ey5cDZArcVe1O72Hv09Jovn9yM2bqlsviL6F3TBMMYfAnJwLLbRcURsN?=
 =?us-ascii?Q?8JM8ABXEm3E2WpZxW7TfvbLX0rg1o2cokBhUU/mfeS6X2iLjJhafoD2EbcDL?=
 =?us-ascii?Q?FchsCKw7T0XkHigPUfutyHavQbVsYMESfQnF5VKxFTRkbG2+JUA/gBL7RZRC?=
 =?us-ascii?Q?CHVtVOF9iJM6uqwhj8NKxcWuPSw989Kwr0m0NEZEh64ZiAZmfmqTIp5J6xLy?=
 =?us-ascii?Q?GoWDWoPzyVaqLCKL8ix90v2GElbIXJ+VWJRqauVUr5M8X7Irg0msoVHn+1Q3?=
 =?us-ascii?Q?syhXtcHP5RyjoiB2IVtMHyhTGfrp3fj1OTMkJ1aUZG0wJJCbjJtA3PYe+xK0?=
 =?us-ascii?Q?++gPrS4E0INPiArznrbLltExKOSAzeJThGLbNdxZMCmYfDLKY7McYsoV22fu?=
 =?us-ascii?Q?NPh1CT/4jeJfATyPsOq8BOKXRiFAyq2kzbMnGKkWkl0AVOk4ZLL2KL+J1dh9?=
 =?us-ascii?Q?LcuMXk/CKeQqTck6eBU1p9WhlBHGqgA4BOE3WsePXL/Kk1ebKQF90Vx7/pCy?=
 =?us-ascii?Q?NFxSMCkG+cB4X4a9YJOsYybJlNrFN2vXEj+Cc/lDejXPSl9V9R+TfRH3H6Zu?=
 =?us-ascii?Q?nVlruQ3F8l1BOSATNh0IsXFLgaDT5uoswzAO0PC7vApMtW9o2a+jxftOjEQK?=
 =?us-ascii?Q?MbkrWlxwHs9Foxm2iICasPTn2EV92qno3QM3tUtvXCOFQLW741D315GxrmmV?=
 =?us-ascii?Q?UTXp/3PZh/090WMS0Ww1P/KeuIQGTuqycA1J0sN76crxH659gwo1QLWcmKZz?=
 =?us-ascii?Q?HxzFaktyEIscxdP/qcOQBzOnqx4B9zAYGeG+LCzORTZJVc8EGxLA3BqHw2by?=
 =?us-ascii?Q?NrdGcaLkpy671kVA87Qw1lHwdfmz9tuRYpdDMrL9WgVgpUUUZ7vKmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:22:47.0219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57d30ab-1a8d-446b-c2b7-08dcd407ec1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846

Preparation for the addition of per-core RAPL energy counter support for
AMD CPUs. Post which, one cpu might be mapped to more than one rapl_pmu
(package/die one or per-core one), also makes sense to use the
get_rapl_pmu_idx macro which is anyway used to index into the
rapl_pmus->pmus[] array.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index ce04dc5844c4..b997899233c3 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -162,17 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
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
@@ -348,7 +337,7 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, ret = 0;
+	int bit, rapl_pmu_idx, ret = 0;
 	struct rapl_pmu *pmu;
 
 	/* only look at RAPL events */
@@ -376,8 +365,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
@@ -623,12 +616,16 @@ static const struct attribute_group *rapl_attr_update[] = {
 static void __init init_rapl_pmu(void)
 {
 	struct rapl_pmu *pmu;
-	int cpu;
+	int cpu, rapl_pmu_idx;
 
 	cpus_read_lock();
 
 	for_each_cpu(cpu, cpu_online_mask) {
-		pmu = cpu_to_rapl_pmu(cpu);
+		rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+		if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
+			continue;
+
+		pmu = rapl_pmus->pmus[rapl_pmu_idx];
 		if (pmu)
 			continue;
 		pmu = kzalloc_node(sizeof(*pmu), GFP_KERNEL, cpu_to_node(cpu));
@@ -640,7 +637,7 @@ static void __init init_rapl_pmu(void)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[get_rapl_pmu_idx(cpu)] = pmu;
+		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
 	}
 
 	cpus_read_unlock();
-- 
2.34.1

