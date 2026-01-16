Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010026.outbound.protection.outlook.com [52.101.56.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FF3128C3;
	Fri, 16 Jan 2026 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534562; cv=fail; b=u4sXoNiSjJEs9bmG8UkM//g+XtToHxcDDVJ3FEnRRVlOiEZRu8YIsN2iAevlJWV83q/Dg+QW9VvGnMzoh5ZFGgtX25+4GpnFJmHJRX+feuSRhR0g8qrEW1GurMYWohYHLExQzEMK6y6WzXPFnCTMJWZpfReG4nvStHcrUhCH9vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534562; c=relaxed/simple;
	bh=Vs08s5NdLNyJJEEOZGj9d5r87/epEjeho1b7MTdLJGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEY03/OqyTQV0GEFNF18vjD51Oq0ZBvsVqhhV0BkN+PM74DWlz2mCRM7mDfUPjgp/z/oIeQq7J+yKbv5YvZ8d8luy0XMVE7KEYKUrbwNUWQeFwMO0EkclR9oPwkMLdcdfi0NzRWLYx2kBARVsUDUqF3cdiVRxASR3R4o0hUvQhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N8eyhN9L; arc=fail smtp.client-ip=52.101.56.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N8eyhN9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2McXhs0Xq1d3uU6MDWUPa0sKcEOOq26mNP/KHf2oVp5FJiBS9VnijO/4YD1RZfIH6NPX6t0hT21k7hBe+vyC08FTwMsjQfKIoHUlLM5LGRHlWS2er/7H9cJO94nVK2APaf5FiSUnJ2yMPWx1uhMO5YPPXQ6LZ3xA7Ex3wnW13kAT2zd5YnPScBnEwhBGUnokLC+EJry8E6wzZa8IHO21f5ijReAX1z7+sLmNN+kohd/z8eag9l6u6HrsZqHxkpYqf6k/HYj0eJxoHLyzlWJmh5WV+2CgzfEK0rTtlOAqiZ/rk3io39yEPQQ5i9ceaoVnnEpWtSZQzn16+sTv88xDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN+VqDW7g2k9ae4p1WO7wIEj38vPhncDns2YoELuxSo=;
 b=Z63IoP+irGFRR1kXdXr3aWzD/MC5pdKLSuhB98aa6brG9c6d5L42enaENotwRX6TpLBAO4/kvoalhTUZG8jhyZqAd6TIwiFYoN+vUDWL5uOrzpmhV+/+Zq6JhhjSoB8o8r3CS0RDJTNCCrhi9afNj2dbGRtaDja/XUarpicUKW2zv6z6ZB5oNyCF35QcSS7VAGpO86dspVb/J2NMsWbw72KzouqKmel4DKJ68gkeu7/cR3tA+tNBan8YhaV6oMOrqkW0EFYwmOejPkELsyl9w5A+y5NdMiP+yr3Cgao9zcLTrQKEOcSS3qJ3VC8MlO0Vh7hjHwAN3NITkUBwnuLw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN+VqDW7g2k9ae4p1WO7wIEj38vPhncDns2YoELuxSo=;
 b=N8eyhN9LGN3sJt+D0FX7Eh3Xz9bMgUyXNgfnQiBzditzmdFhK+SqwtxPoTjrdnA3fCFsvRI+zBYUMSbnpW0asU8/ZHcBe7ainvfqdxiBb9LJpWcvnnK9MSjEiUSStY+fg0Y/Bq1pHyhrogDZtWMCnDdhXQizYrHDp60w9bkq4eE=
Received: from BN9P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::27)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:35:53 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::45) by BN9P222CA0022.outlook.office365.com
 (2603:10b6:408:10c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 03:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:53 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:48 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 07/11] perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race
Date: Fri, 16 Jan 2026 03:34:46 +0000
Message-ID: <20260116033450.965-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033450.965-1-ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: d135a950-6223-4abd-f76f-08de54b059f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MHxJmROwPhTxtmU/lCn5uyPmR8HuHRqSFbej6N6C6Z15nfV1Q0IJVMsAuHv4?=
 =?us-ascii?Q?vkBp8/ig7wOs1jhqXSQXnt/CNuRQ/clM7xwhakyLNOcIrFh8H1TblDrK9BO1?=
 =?us-ascii?Q?j8PgMAxVhHv//ziQGqX9Ys2cacE8olxFWdfVaQEzdAevQySbgYgeWfggN4UN?=
 =?us-ascii?Q?GhqqEEDAFvijOGYZP7zwgJdxCG0rHkKFBwzt1sVFz7tXWNQ4ath/fgCj3UoP?=
 =?us-ascii?Q?NLFYjFyyxE85fvTWijtcdgJAtkVTDCyGBX0tHe9Bs/ULfH9Xd1m5gs3JKse0?=
 =?us-ascii?Q?WnwxLfYcla049B/nqifew10oKJNMGQJ2aSTQFmy3C8HhSbPnpr5YeCkhjJl0?=
 =?us-ascii?Q?86Rh6djtcv8Pd14GFsfNIOwO8odhDjNDYUwdPwgZCygtUhoXTSAEwIETifA2?=
 =?us-ascii?Q?e0VzdNGSiA1/LuxQJUSOIY06N9NRDNU/qU2LmWkyQhyUIZLPPE0z8YUC/GwD?=
 =?us-ascii?Q?VmvmUZU7p6Kprlzo2+OS8xIwtlkkdJkWWa4uN2By1rO08Y9wP9LjR8Xe8kd8?=
 =?us-ascii?Q?V4ix8IESKqbtjSEQ2ivcDYkz72OPPeGXVuuk44KAaRNxPYhGGEnk0k+iWC9+?=
 =?us-ascii?Q?z3UMrwdOzlO819lXj+X994/NfGKEuFRMya4sNDlyWENHzDNSRz4Gtyl6Axzv?=
 =?us-ascii?Q?QwHdCOw7zLYrhzA1QTvF4/b2+dnlLnWLEDIIxV9v0rn0w1phC8Qehw9I9Lx7?=
 =?us-ascii?Q?e2TjuHtDjCEbYuFBBz/WVaoeq1WNdAr0fp9H/FtiL50zrvzNTIzRwJ8FqdeG?=
 =?us-ascii?Q?6zqoWbvk1NgRxyMhTNKECIX3jG+afX3tjulGjTbJ1P9izIGysekghG/P8hRz?=
 =?us-ascii?Q?VPHKl7e55upopc55Ls53L0OAwcme8zHAGL3oPFOincY/Th83Ty9rVVfVmiYZ?=
 =?us-ascii?Q?/wOj9jVjK5E51o6TT1ju0rvPuidPtaIy1klMEcAaHQXW3Ciw+yKr1uLk5jsC?=
 =?us-ascii?Q?iE1c6tgjFf9HWHfm3oo68JJaocoEWPjpRTUUQU1YeWMOGBEoTpqBKedb9f8+?=
 =?us-ascii?Q?L6/LF6wx/viR7AcyI0o2YXldr9VS5n8gEopTbV0f9km6q5k1vY0uEG/9YFIL?=
 =?us-ascii?Q?EooFmCE2CksiZu0gZKja6UVZHfsXLaq4whZCuH3rZffWApwVjXpbfWprikow?=
 =?us-ascii?Q?lx//AtSAlAPQmFNu82QQcuOUDEUn2VHouRT1Xq2WQ9f1URD3Tz38TnKPXYy3?=
 =?us-ascii?Q?XcQPQOqOHHN4ifWeQjQOig3I8G6GUiCD8TULBdscFhDW7m3aYPCkpaD7uFs1?=
 =?us-ascii?Q?nkbFktqJ6okvbp+uVWLrfBjfnTE/CCk6taxvCpX1yS1tMQ9qj7+lOBboBFZR?=
 =?us-ascii?Q?8v8akPze94J3cFLnrGPTnkq/buTNe715PY+7L/3Ql2YgjZyy71+46l0uoNZW?=
 =?us-ascii?Q?Bp8QwElWnoj2AUSOYGmAsO/joCyqrodVl81Op7NnnCA9eIZg6eg6uQXlOr0M?=
 =?us-ascii?Q?m1W9Q1ycpQtOfbjvGu2svRjl2MitIssFR9mSrj0F++N2zf09pvFQDye7WHnr?=
 =?us-ascii?Q?666Z/ASvTH3ffctkqyHXAH+oAqujwGbwqBu7mN9cWmTJpEIPsR6G/12Z8qZx?=
 =?us-ascii?Q?3CcjoN0/H10/LakazzCTZfWHMLNmRhqUoJkQgBl+bccGBNTweTmZQETxgXcj?=
 =?us-ascii?Q?gD1qNY8DzzuwqgRpZ1lkzxarAa9Fetyzuih9VTeaf1grf3SWf/lfzltHKXcL?=
 =?us-ascii?Q?I1pwOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:53.3031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d135a950-6223-4abd-f76f-08de54b059f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822

The existing IBS_{FETCH|OP}_CTL MSRs combine control and status bits
which leads to RMW race between HW and SW:

  HW                               SW
  ------------------------         ------------------------------
                                   config = rdmsr(IBS_OP_CTL);
                                   config &= ~EN;
  Set IBS_OP_CTL[Val] to 1
  trigger NMI
                                   wrmsr(IBS_OP_CTL, config);
                                   // Val is accidentally cleared

Future hardware adds a control-only MSR, IBS_{FETCH|OP}_CTL2, which
provides a second-level "disable" bit (Dis). IBS is now:

  Enabled:  IBS_{FETCH|OP}_CTL[En] = 1 && IBS_{FETCH|OP}_CTL2[Dis] = 0
  Disabled: IBS_{FETCH|OP}_CTL[En] = 0 || IBS_{FETCH|OP}_CTL2[Dis] = 1

The separate "Dis" bit lets software disable IBS without touching any
status fields, eliminating the hardware/software race.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 02e7bffe1208..d8216048be84 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -86,9 +86,11 @@ struct cpu_perf_ibs {
 struct perf_ibs {
 	struct pmu			pmu;
 	unsigned int			msr;
+	unsigned int			msr2;
 	u64				config_mask;
 	u64				cnt_mask;
 	u64				enable_mask;
+	u64				disable_mask;
 	u64				valid_mask;
 	u16				min_period;
 	u64				max_period;
@@ -292,6 +294,8 @@ static int perf_ibs_init(struct perf_event *event)
 		return -ENOENT;
 
 	config = event->attr.config;
+	hwc->extra_reg.config = 0;
+	hwc->extra_reg.reg = 0;
 
 	if (event->pmu != &perf_ibs->pmu)
 		return -ENOENT;
@@ -316,6 +320,11 @@ static int perf_ibs_init(struct perf_event *event)
 	if (ret)
 		return ret;
 
+	if (ibs_caps & IBS_CAPS_DIS) {
+		hwc->extra_reg.config &= ~perf_ibs->disable_mask;
+		hwc->extra_reg.reg = perf_ibs->msr2;
+	}
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -445,6 +454,9 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
 		wrmsrq(hwc->config_base, tmp & ~perf_ibs->enable_mask);
 
 	wrmsrq(hwc->config_base, tmp | perf_ibs->enable_mask);
+
+	if (hwc->extra_reg.reg)
+		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
 }
 
 /*
@@ -457,6 +469,11 @@ static inline void perf_ibs_enable_event(struct perf_ibs *perf_ibs,
 static inline void perf_ibs_disable_event(struct perf_ibs *perf_ibs,
 					  struct hw_perf_event *hwc, u64 config)
 {
+	if (ibs_caps & IBS_CAPS_DIS) {
+		wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+		return;
+	}
+
 	config &= ~perf_ibs->cnt_mask;
 	if (boot_cpu_data.x86 == 0x10)
 		wrmsrq(hwc->config_base, config);
@@ -809,6 +826,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
+	.msr2			= MSR_AMD64_IBSFETCHCTL2,
 	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
 	.cnt_mask		= IBS_FETCH_MAX_CNT,
 	.enable_mask		= IBS_FETCH_ENABLE,
@@ -834,6 +852,7 @@ static struct perf_ibs perf_ibs_op = {
 		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
+	.msr2			= MSR_AMD64_IBSOPCTL2,
 	.config_mask		= IBS_OP_MAX_CNT,
 	.cnt_mask		= IBS_OP_MAX_CNT | IBS_OP_CUR_CNT |
 				  IBS_OP_CUR_CNT_RAND,
@@ -1389,6 +1408,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 
 out:
 	if (!throttle) {
+		if (ibs_caps & IBS_CAPS_DIS)
+			wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;
@@ -1460,6 +1482,9 @@ static __init int perf_ibs_fetch_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_fetch.disable_mask = IBS_FETCH_2_DIS;
+
 	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
 	perf_ibs_fetch.pmu.attr_update = fetch_attr_update;
 
@@ -1481,6 +1506,9 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_ZEN4)
 		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		perf_ibs_op.disable_mask = IBS_OP_2_DIS;
+
 	perf_ibs_op.pmu.attr_groups = op_attr_groups;
 	perf_ibs_op.pmu.attr_update = op_attr_update;
 
@@ -1727,6 +1755,23 @@ static void clear_APIC_ibs(void)
 static int x86_pmu_amd_ibs_starting_cpu(unsigned int cpu)
 {
 	setup_APIC_ibs();
+
+	if (ibs_caps & IBS_CAPS_DIS) {
+		/*
+		 * IBS enable sequence:
+		 *   CTL[En] = 1;
+		 *   CTL2[Dis] = 0;
+		 *
+		 * IBS disable sequence:
+		 *   CTL2[Dis] = 1;
+		 *
+		 * Set CTL2[Dis] when CPU comes up. This is needed to make
+		 * enable sequence effective.
+		 */
+		wrmsrq(MSR_AMD64_IBSFETCHCTL2, 1);
+		wrmsrq(MSR_AMD64_IBSOPCTL2, 1);
+	}
+
 	return 0;
 }
 
-- 
2.43.0

