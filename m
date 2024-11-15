Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D1185B48;
	Fri, 15 Nov 2024 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651016; cv=fail; b=jobzkNl/zc93IfuakJe7q0h+h5QxNHjYRqdlP3k/V5jzaQRrYzLAlrq7EhKQn6ku1GIXj6sXQO1fEUy7o9kyOtVMYLADF/8vDmiYYeanGtOjMPa7uJaZaQpalbrnv1pXuqn5rJ1T8O5ATaJ5Xs1XwL8I+OXbixWvC7WuiBf9XJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651016; c=relaxed/simple;
	bh=1Z/YkBXR4LlcrJiqaPI730LCxCFHEWtcDMmeyUsAWuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STssHAqmisoIRzf2O7q4JpEIvbMp8+hQFogO+3wC/af1iPZNIyZjLySqGHu1DJGdgSvHJgIbtF1Xfjr1kvw/5i7P+U4vi7Wz26qxljYas9/sTOG3eb70vn3YhqKgKvcWJOdd86zpxJ4B2Hds1VFkBOvyCdaEOMhuR6SYKYexH54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Lab6xvk; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Lab6xvk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJth/m7PShxeHEU6YCNx/cyzynzJMSD5kh8TUSLLpSU67zl4n5uM9linxvFfeaPE83AuYmi5PHgX9yybor5JkomfsxCfnBFAkpSyQMeodLu2U20g44TexFnTF2SVmIPA3fQqCKOKfG+JDp2zf20XS7GKcEbA1VKyMfMekkoofMCA8YvELlZ0a59A1AkXQrGABa41UUc2zbiqWMjSpSFvshsZtCKKVnh36mg6D9yIzl8lkQqmkYwpEGFKuosyIl4654CLD9f6478Tpl5hKDWv0bOaA0GFpgYbAm9RDFExdZXDwY/Qr0Rsfay5XGMeu0AUrfyo+evH5QW8xTwyS7bKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnmSwGKFRHq+wg64+KlpLpJfSA21wuNU1tS/hndGNrE=;
 b=PZiJufR2kR+702oZdY3yLSYaodo2z4pJdDwDDjvd6cx9eQrx85RTvkJkhidB8Cgi0jXfHUyTlszUHMByZn4uzu1o6WjYscMPoXc2w7nsojx4sJ+qpokcq2KgkQFv7KyIivQL+00kCjvI9ZX2LXPT/JwgUBTSlYb/9zXgL5Ia2PVGZe4XPpPF/8O2HpmQau4JKquJqdXJkr+xQ5XOZr3ERfOe1QQJMsuQW7GNk7ZHxIwlmXncxD0VyVsAAht4p5BVWC3GUzM9SdR7VP93P0xjTBPMXOAb/vBC/XydTsxgCl69QrYSasnS+0zO2/576D1tiYHXioIuLKlMRUpmvAENhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnmSwGKFRHq+wg64+KlpLpJfSA21wuNU1tS/hndGNrE=;
 b=4Lab6xvkuGwOfDZan2FWMsMDKlibz4vp6puz5S7uys7+IK/EMqN7rYybV8UqflF+K4J48bkg3IgwNNYGgyGXBBRYK5vFIAW2VnogbqAUhTw3MO5LGGpk1HaZ+1a2VmNu06IOpHRSO9aBs9MxRwBp6g9sKDuu4hlUSNkxca97HEE=
Received: from BYAPR02CA0008.namprd02.prod.outlook.com (2603:10b6:a02:ee::21)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 06:10:11 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::da) by BYAPR02CA0008.outlook.office365.com
 (2603:10b6:a02:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:10:11 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:10:03 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 05/10] perf/x86/rapl: Make rapl_model struct global
Date: Fri, 15 Nov 2024 06:08:01 +0000
Message-ID: <20241115060805.447565-6-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f030d6-d1bb-4817-f141-08dd053c29d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x9X29CGDEejvydqMwSHBctRMNYOB5AvX6O2nSRDN2a4CTY9XSdVkla5prbJL?=
 =?us-ascii?Q?4MAa3AZbM+t7cfozjsrqhumcS6kSF7vU1S8Mml14CKppgwt+4+NZzjKdVQ+m?=
 =?us-ascii?Q?UggbCxZ61MB6h8NYh7hJ2mUGkVkaVqWI9njtNLXD5DaO8nIcjzwiG+H0P5ug?=
 =?us-ascii?Q?l7l4z6CQSZYD3XvKIJrJklHoI4qLSZMiK4pozMZFDIcAiuVMh1pSBoFC+2VU?=
 =?us-ascii?Q?nET4NplWejk2a8EkhsMf+drMyhT9Nhk7ONwKWu4EPGqTQaSi4DOtSrhuD46J?=
 =?us-ascii?Q?kFKe7jyIgcDyfJ4SRt6bTT42jH7DrT5Cxr/Zq2ymWgGz5cKxN12/34yqL+rX?=
 =?us-ascii?Q?GBtVuLB+od7nlDIpq/MssfRs51Zt3sh/6zzEqyE95//uVy3kTncMaK0fHkNs?=
 =?us-ascii?Q?l5TQl0iXwk7t69MnJb3a4tDiSyTY9pjpt8ZeOAM8UOmocKIEwU95qysynsOO?=
 =?us-ascii?Q?srrxjd6+Mqua0Glpsz2VM0TZxWksZUaCd0FECrpTa7Zk1SDwNL6s2YqaBN5n?=
 =?us-ascii?Q?+X27l1CaVHo1t6Bba1xIN8zfzSqRLaNDQBRuN0N5bEvBoolaCphdGTG9wwyn?=
 =?us-ascii?Q?NcFNsU0VIGYBhZh31Q1eYL5n/Rc7gmOPfBHaafhnGkj0j8jSo3VKfD1qPhxs?=
 =?us-ascii?Q?LLeczf89DrfVkJppo+pwPx1WZ2YELF5P7kfLjg61+YVGpsxJOr0bQq9d+MAq?=
 =?us-ascii?Q?e38pW1iik+EGC9hyOTBw2WWtQ8F4jRkntPHMkuBFOAPhP00NQNUiWrm/2nzW?=
 =?us-ascii?Q?t9yZVetjhlJRVBMCOYVfyA1ieHqikZzZ71+A7Glbud7PqLa+0Na4286Zx/3V?=
 =?us-ascii?Q?I9ZazN/7ss8Z7Ytx6colFXV8+Nw5PdQ91P9p3sTkHGI9bTGdIN3h3kqrbB+i?=
 =?us-ascii?Q?RDzIpQYgFpWywEjYzwEnW9/19S7Q4qnzP8ZACuGD8qfGwpqTfbQ9c6s3MLPp?=
 =?us-ascii?Q?L+LfhrEzVOavdGUC6BmFrhMAQNMujC26lgEBcbAKUrOWULqn9XolgD2tNvrk?=
 =?us-ascii?Q?UuEPP2+1wrtUjY1Vn4i4nC3wORUdghhXQ0W4mvfnFKUgCZgaYJXpr8DZ/UPB?=
 =?us-ascii?Q?u6IP2VkxcJjKjxLmS3hy/6aKzJkxgBgIwZ+Um6d3RSKm0/F1XRH/ucrvOFe6?=
 =?us-ascii?Q?aRuIKBs0ip1G3VQdUmYpR0NQIt0ohg29Goh6jCYZXWISXf8qyEIh0a7pdzdj?=
 =?us-ascii?Q?eb7OFsfkRkhCid7/4hsE99lal72pDjJzbFNS8yv8jz3OOwZ0mP7/0doovC1r?=
 =?us-ascii?Q?43f8gYQnilZjfWcZdwxVMpIffEHkAKlGTNvzBtMPsB13QHTgibEd3nfZr7cb?=
 =?us-ascii?Q?UZRd72Qh1o6yRUw6rLN9Bfr7fWj9atRVcpYIyzo2qsTLt/M/Xpo1TSUVbd0J?=
 =?us-ascii?Q?fOE0FSaeth5afDLNYj5QgLOUBkoTJ+GWhLJrUTQZgAOnpFex+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:10:11.3044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f030d6-d1bb-4817-f141-08dd053c29d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Prepare for the addition of RAPL core energy counter support.

As there will always be just one rapl_model variable on a system, make it
global, to make it easier to access it from any function.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 arch/x86/events/rapl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index dc350292e1fc..0585e15caeab 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -151,6 +151,7 @@ static struct rapl_pmus *rapl_pmus;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
+static struct rapl_model *rapl_model;
 
 /*
  * Helper function to get the correct topology id according to the
@@ -541,18 +542,18 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_check_hw_unit(struct rapl_model *rm)
+static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
-	switch (rm->unit_quirk) {
+	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
@@ -797,21 +798,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
-	struct rapl_model *rm;
 	int ret;
 
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
 
-	rm = (struct rapl_model *) id->driver_data;
+	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rm->rapl_msrs;
+	rapl_msrs = rapl_model->rapl_msrs;
 
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
-					false, (void *) &rm->events);
+					false, (void *) &rapl_model->events);
 
-	ret = rapl_check_hw_unit(rm);
+	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
 
-- 
2.34.1

