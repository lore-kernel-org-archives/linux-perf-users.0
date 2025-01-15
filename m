Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C72343BC;
	Wed, 15 Jan 2025 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920038; cv=fail; b=UUcdPJWj96aBbFe0O1sfNJMUwFAegupQQkzJDbZlZNQIkxyfGPloTo7DBdjZEexV9+8+MzKMrMxFbyylVBLaqDfVPfRupDw583t0o8Ur9Z//JR/LKQ9wik3lPxaIV6KLN16RnLa/DbaFBRTdK/ZpTnhHr2QranYh4nC0LBD2uFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920038; c=relaxed/simple;
	bh=/Xp3nELiqUqJUr3Qg+VqXNXrt8da94lh6JKO5gxxIlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3/BsyzWpJwPhkoGUK0K7Ru6MhJ2zo3hv8fopCR6AQw0Ez1I2o0ZaCa+mltXJaLVGCP/rSTPpRFmSyCNrVXyZQUgMgSbBmBm+OAR5kP7/05joU8USrFbZfRPWbok00Wh73g33wSBl22RlB57WWPUx67oUP2vuyywtwd+uVC9Ox0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vrX8QEK9; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrX8QEK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZzbpFnCrpaD9ZrLCkNyfk2L0OFg75aH6+xZP9Ovntuv+t5jA3OmWvCvRj8jsh36WdiW48iuLKm/KcKPENCva4q3Ldb1DAh+gqWb2pqPNTy5W+sgUPf+Mz2H+bjGsXNDd8e1qiTXy5tqnpVpNrCToTuqmWxCwtXWMKJIweohCN2T5dpRawT5RFciF0bFV0+Ngc9Ubs8zKUk8ojkBn5j/jLMPaVEPh/QW9ypry1K3bzjnWuU56zm/yM0H0MDbL3TQyynZQWoA+yGgOdk/qwQik83DW+XEwsYhe5U+hu6RzP6zbCM7X6GGaHlSzPUCdGK3jAOE5xCyDzH/MmuTSCOLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPOdGnNG4aECHeVZS6CseiYM5Y6mynZ1K1tjRW5qP5M=;
 b=UxtmKUX/vyurcM8Kgqh+pxenClA+m+xwu0/gJm3nGiPurDvNRIeSykDBFMfgA79m8Qz02Ey2Rq+PngwDbd33jNFOf6rB0aZfSuv+VowvmgvTuuQZEm/rHq9WZo+/wbF14WLOIFfWjMgx62owXTjNkZzpawr1R3dxDHsznSk1L8rGaCEj8WoNXGVSaNm07t5F6lVeCTGdfjD3aufFarW6DVXuMmvU6mWvn9eWnkCSprtuX0EUESlk8kMRrBAMGyf+0oigQ+Ia89HMVO4VyrZnH858B5LB0QOtlQQdnqyPZTbHG1OG1D5glGyhYLWBbhFQk1J5Ln7X6c6+FPAWcU5P4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPOdGnNG4aECHeVZS6CseiYM5Y6mynZ1K1tjRW5qP5M=;
 b=vrX8QEK9SYkZ7c8crf5MfXw9U/0vzDoXTfvgDcfYVU4lwU7Fk0FlTEZfL+C7xns0l53IRs4mbUtLUqS11O1AWcYQJBCDJgrS6M0Lk/IIJhShqm7Q+DuEEsuMxAJRhYGcYiKUuEbLPmj7wFvSuLa/0OOQXp8hfE9e5FutWqV7edw=
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 05:47:11 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::ff) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 05:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:47:10 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:47:05 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 8/9] perf/amd/ibs: Ceil sample_period to min_period
Date: Wed, 15 Jan 2025 05:44:37 +0000
Message-ID: <20250115054438.1021-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115054438.1021-1-ravi.bangoria@amd.com>
References: <20250115054438.1021-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff07d8e-ed9e-49fd-b7d2-08dd35280e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uper9x4OoVn174FJbwM0aK/ZPAanbkXDppJuXwbs+fvd6fImq89soJGkQy8L?=
 =?us-ascii?Q?ZTr8mGBzSy+QJNdKTFDbK/QrYUKBgFW7RBQjBnm7SFIPwK2xlG6ianQQc2ul?=
 =?us-ascii?Q?ZvJYuDlYYb/xxuclHlJjicwTeSwq0KzGhUVpOedmtnHWOb3zdfyco11c7acj?=
 =?us-ascii?Q?svGhsQXFYtzIh+Wb8F0sFxQ2qZhrXEcA1WxOw4yqrB7R8Zx/Oa2rjO9jrG1j?=
 =?us-ascii?Q?zdCqMsCSLZH8lDImwiUjalsUTA9mwn35ncH8v43RbtL8QLhUB+P+RYGdjjrO?=
 =?us-ascii?Q?bsa3M1Ratm2P2sTNXHsj0IU76RQywntSEHicuYqrtp5S5awPXMl3RZoWJt7u?=
 =?us-ascii?Q?S8ZKl42fczWLwZx7ZPOCQYcbd9roW2ePmRewsP+XgwE+6F9OuRNFnZP0GnCP?=
 =?us-ascii?Q?OF4BZaF/G8N7c65LHmYFA9ZoE5YogG+ueEv3+pa02QEnPKdxeKudyvZDnIFb?=
 =?us-ascii?Q?cN3oZpOCRxZaoZEitBmRgqTgr4aAGXhoyF2dICFbM7wMUmZO2rp0NnFXu++l?=
 =?us-ascii?Q?iD5XTZtQLWKOlWw93VE7MUzfFyWXvrnauozs29tMNDbk011JyojPrgPGpOFP?=
 =?us-ascii?Q?07R7xcYQjjHA8CpISvm0qiDIQGIKm+LuxUGos7loHQd48gbqP7qQWWZ0klGE?=
 =?us-ascii?Q?t9X/uNn9dA/YRN3/FEu7J5hprwDIbIMVETQ5tngzV2JxMCa0hRYOsuqZzeYG?=
 =?us-ascii?Q?ktZ/uZJX1bvA2JdXS7pNLYEmi/85Pa9Ry9RWLeyEn7SAOTwesgZbqcohZlj3?=
 =?us-ascii?Q?EWVoEurX0jnFEROxcjTtyEy5TSGDuTpruY9YVZCe9NilFoh78VAvgS50vvVZ?=
 =?us-ascii?Q?sbqnjNWuqCsujcJckdryKz23QhJrJ6/ie1/ZzTAHH9r+NBTqTabU7VpxDIYA?=
 =?us-ascii?Q?93xezMtwz1T/TlZszvDroMtcFF4jVm1E6WGBQbuIhuTGgEq0C5vhgfVpjsMc?=
 =?us-ascii?Q?efmx7EcAiwZPJ/rNz30T80NZEAv8yCwF81TxN5XDDigm0dAQ+adLQv4GMeXj?=
 =?us-ascii?Q?OXp2edafa5pqDCiXPe4Vi8FQekXG1+w/JsTWLzjREQu7V1zCinsj7kopk5Yj?=
 =?us-ascii?Q?qKXvGgXHYbRCISVV4gbFmt+a2KlHyutkNfJxMFuHKkC4ImvPhSG1aj4geKgL?=
 =?us-ascii?Q?YOoyqBIzwYOI/56wvHJ1NSWmJeq7CA74S7lvtwsvWgpsJ1HOPqmENgwy3wYb?=
 =?us-ascii?Q?pMjQ8PsPqc2Uu8cUrXFTrfbLtyEatDsirE+1T4hXj49Es67N4LGqUMI5zrcn?=
 =?us-ascii?Q?8wyMVRdH1NFsBh3rkkHvAbS7nEYuAnb0pESj3kKyfTnGcISENfK/+sbjIVy/?=
 =?us-ascii?Q?a/WutP8imPr4wU/XmMkkgkVuPp1AXnFgCLwRtB16fCwDiAo7dFwCxZVYye7J?=
 =?us-ascii?Q?PW/3JKeKYdJGvD62S42D+8TW9gjI+luWG7pSAycbKh5PmCfhZ6gVMludMV7H?=
 =?us-ascii?Q?v7xQYlKCVuS/yrXhndNFD+PPgBBM2Uon++cbrPkbF9qa+ZEc6syMUChQPTwc?=
 =?us-ascii?Q?hTl7AAPQpRA04WA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:47:10.8019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff07d8e-ed9e-49fd-b7d2-08dd35280e31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482

The sample_period needs to be recalibrated after every sample to match
the desired sampling freq for a 'freq mode event'. Since the next
sample_period is calculated by generic kernel, PMU specific constraints
are not (explicitly) reckoned.

The sample_period value is programmed in a MaxCnt field of IBS PMUs, and
the MaxCnt field has following constraints:

1) MaxCnt must be multiple of 0x10.

  Kernel keeps track of residual / over-counted period into period_left,
  which should take care of this constraint by programming MaxCnt with
  (sample_period & ~0xF) and adding remaining period into the next sample.

2) MaxCnt must be >= 0x10 for IBS Fetch PMU and >= 0x90 for IBS Op PMU.

  Currently, IBS PMU driver allows sample_period below min_period, which
  is an undefined HW behavior. Reset sample_period to min_period whenever
  it's less than that.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aea893a971b6..7978d7910adc 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -457,6 +457,9 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
+	if (event->attr.freq && hwc->sample_period < perf_ibs->min_period)
+		hwc->sample_period = perf_ibs->min_period;
+
 	perf_ibs_set_period(perf_ibs, hwc, &period);
 	if (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_OPCNTEXT)) {
 		config |= period & IBS_OP_MAX_CNT_EXT_MASK;
@@ -1191,6 +1194,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	perf_sample_save_callchain(&data, event, iregs);
 
 	throttle = perf_event_overflow(event, &data, &regs);
+
+	if (event->attr.freq && hwc->sample_period < perf_ibs->min_period)
+		hwc->sample_period = perf_ibs->min_period;
+
 out:
 	if (throttle) {
 		perf_ibs_stop(event, 0);
-- 
2.43.0

