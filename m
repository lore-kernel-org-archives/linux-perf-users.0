Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784E39AF4;
	Mon,  7 Oct 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272955; cv=fail; b=NVAevRvHYCYM7NlPBQfU53D5Vkg6fZ/6aok9vrUCIRV4cIKX4p5e3eQV1sBDfJWbXMaE43R7hjyBcaeDrybhD4zAG/ooZnL78qxbqVALkopbJisXz7/oDweC06T7KiHk9wR29NZx0lrkNo9EAQh3+hgxgNHndRvEDZWJiljidzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272955; c=relaxed/simple;
	bh=5KOe9RQz6i10fytxi7IHpaIpVaIW1In4sKJ7Gp8O/0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FjXdhid96eZAM6JJxa66geTBBL9ztkq4VFxKajitj/iua/1bRHr1HAUDQfkzKwV1QeMiHKnxNowLX/GfQc1aGK3OzHq2zvvyX/K5ex7dN2e5wz18ZxPt31DMWIQNQD6/tA8sPd4/u3xtbMU6sflO6MUNudo/yjwLOCKd5ZYC9kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yqPa52j+; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yqPa52j+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeslcNLgK7DlyA6rFVLgWR172gMW+zVqPXo8ljgORjgGNPriXp1aMkCaGsZm+ELZUSlyV+8sDzpxxAOgNkmUqW51a0IfjTRE4MZqPGwxBArDsL2TuxtQo4rtl+kpFwhKV6iaFxxbeIQmby7FZqPuiRho5kA/1oQU0lE2KV0L2WzqGcCKS44x/Mf0pdM9onltcyxtL076xjnZoKEUaT3PFmJTYBMUW/O7/CSAHucnkiLbm/nFD5VLvdw/foZDAM6Mma0t8sEYMpXw1G49Oafj9JqYpYyLTvQ7TIUKqSR9oxnREpV+BkISm3e8rf7Ycdws5oeARizaEzeiniA0xIA9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTopsBlRSTqqz3Jwlb7C09zECXz9Imn1XqMoZKBQsV4=;
 b=tJ/Z4XITufVcn8uQfrEWqsFr+3UzWE6HFZnGrhxilVL5vB4PSpDQECuIi8shfrVjLPIb37NkbVgSJrv5Hh5fTwrks3fS97yv71Ovd7N8iuXpPO/fmPiFDjx/czsQoN+2zLCEmIOe33Ea2JyyCL7Pre7a436OTJ4smdKMeQhVmnX0VeblXWxM21ZUvx4fb+YSdvMKWRY/5S3rhnJCbDNTzWrCeBg50YmJc1vF9KuT4jtuJUyPtMGh6CiPKr03oqEH4s8wkYpJRwBOQt6ZZ9/tQmewXWED6aOfdReSFbai5oxc3DR8qPlsu4zP2HOgz+2/VMPREc2zreuOB1kgBmhZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTopsBlRSTqqz3Jwlb7C09zECXz9Imn1XqMoZKBQsV4=;
 b=yqPa52j+7GmpdlEV++4IB35jVsXyiK072xumLv7n99kTRCBrmcW8JBOSVlAuwXAN3MSEQUnNBKj5b/DxJArfSL42QlwJLPU4mcvLHYTJbfQsUzkC5hzGFqM63KYfBPzkqr4osGf8lhmhSXePl+8YSzn6LBzdP9bsdqOFtUX6HZc=
Received: from PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::6)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:49:09 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::c5) by PH7P220CA0144.outlook.office365.com
 (2603:10b6:510:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 03:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:49:08 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:48:47 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 4/8] perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
Date: Mon, 7 Oct 2024 03:48:06 +0000
Message-ID: <20241007034810.754-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007034810.754-1-ravi.bangoria@amd.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: e8697058-0633-486b-fff4-08dce682ff47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TeFWfQ6cFXdZCKtPTpNwBo/ggMCvEMFzOPb1qBB6+J9UtSxawgihzP4Xtkgk?=
 =?us-ascii?Q?qBCLc8nxxnzO/fcKSLojNr2KoVOGhh3KBDACFNL0IPWyvmbJeMRg6rIMcYzt?=
 =?us-ascii?Q?+GG/h346VaG8GTWjKnsAVQycWOH67wGNcBrGxGtJEwanoHHsXhNyG3nh+XNm?=
 =?us-ascii?Q?5HTursmRp9o1/GInoLl6yp+rmCSn91M2V2aOcwTld/gXHgK4VVYjRWjdtGNr?=
 =?us-ascii?Q?q7bq45ebStoQoViO7UthWk+QqkvwtMAXnuF9NxWzcvnC9x4AJojQQ1DGAK4q?=
 =?us-ascii?Q?kY33V/eqcTGSHn+WiGrfOPGStfDSQgsRiJ+RlFVo/PrqnZId24KFD+dQUg+f?=
 =?us-ascii?Q?YHa1h0IgpImrj2ijDt+IAfT28WSGCxXNFpwWO78guTet2/CrhIohC+ywVFPl?=
 =?us-ascii?Q?2NPzJkYR5RKYKdxSS1znUoC4NrKgkvCU8g7BnWnrCKaYuLSfszGzRI85P2ev?=
 =?us-ascii?Q?6gKSmyUn7kvPxli/zH4yx1hA2GHNxsjzb2XATz2HNIn7VSn8DtsTyP7+EzR7?=
 =?us-ascii?Q?NWSYVj+z4/5pTXLA8SyhtMrA1SjjqtPIg77qlHkU3SOx3w5D+WzExx6ObBmQ?=
 =?us-ascii?Q?NUAM2evpJ3eLzdOa9DWuL377Z9w5pE5SnHrUbEPAkSMO2JlwD3KaP4EmsJxA?=
 =?us-ascii?Q?8VWf1oa32VTjaGoXC4VBS7e5oKF7manSljPfX33WCRwgRzpuLKBaPi40WAto?=
 =?us-ascii?Q?NyZkCIvSVboJvJOSm3t58QvZmwi20VGYw05qgAagM0QIpydl+fWaEv+rDirF?=
 =?us-ascii?Q?Y7IqN8stQLy41PZBOnmRnlirGAY0KTfXzhLi67LT7DM8c/rknSftEZXrzMJp?=
 =?us-ascii?Q?7gkH8HwfQItM5Aji4+VZ725KhdC2k0IUZDhH0Or7FOKzQQnnM0MqmJmmqN+o?=
 =?us-ascii?Q?mEGLYF+LCnSQY9/dm+4jlyHg3y5pFkc8s+F/3BuPnfG3qpmjzVgAgudYUOOC?=
 =?us-ascii?Q?ny0BhQUhWREEyPkbAoS16MzQKkyYHmZY5Glu9V4t7V/TSZmgE3bLaUAgln/K?=
 =?us-ascii?Q?ttN+GIlfZCaZsY5pPalonbtAt7aiNXDC1ZZ49CkwsX64hhCLX6e4mAFQ5QOh?=
 =?us-ascii?Q?i9dKiFfk0fKiYPq6NYe7pQ3uaXTq4DbxlY4GofG2mW3VMTfzEngYdAWi9Q/v?=
 =?us-ascii?Q?BBzxz+S79P7RypIlkOakN3vYlb777GXMuO9xm9Ph/UCFTcZhA4qGIYfiu2Dj?=
 =?us-ascii?Q?c7iF86vqGzKcESanE1UYowaOxf1/ySZL2fjhhvDDTG5KKXdFpJpgrBSVybH0?=
 =?us-ascii?Q?hlu6qxQ74REFAn56uQGarotEe1R1e6sNfOK3qOY1iG0PWndenLnBM5VYTILt?=
 =?us-ascii?Q?GFAbsazrrif6sG670n5sCosusTOGWPplhlWbySNrbp8SS/GJv7ajcBfD19z5?=
 =?us-ascii?Q?cBnd1IyWRTxKwkLVReDKIHbZJKJG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:49:08.2032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8697058-0633-486b-fff4-08dce682ff47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577

IBS Op uses two counters: MaxCnt and CurCnt. MaxCnt is programmed with
the desired sample period. IBS hw generates sample when CurCnt reaches
to MaxCnt. The size of these counter used to be 20 bits but later they
were extended to 27 bits. The 7 bit extension is indicated by CPUID
Fn8000_001B_EAX[6 / OpCntExt].

perf_ibs->cnt_mask variable contains bit masks for MaxCnt and CurCnt.
But IBS driver does not set upper 7 bits of CurCnt in cnt_mask even
when OpCntExt CPUID bit is set. Fix this.

IBS driver uses cnt_mask[CurCnt] bits only while disabling an event.
Fortunately, CurCnt bits are not read from MSR while re-enabling the
event, instead MaxCnt is programmed with desired period and CurCnt is
set to 0. Hence, we did not see any issues so far.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 3 ++-
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 79422d2e301b..152f9116af1e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1222,7 +1222,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 91b73571412f..72f1bcb0fa31 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -498,6 +498,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
-- 
2.46.2

