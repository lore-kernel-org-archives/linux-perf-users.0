Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF7487B0;
	Mon,  7 Oct 2024 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272936; cv=fail; b=WRvujLM4So57FATb2cnJO1JHwV4W/j75SLuk93eSCgXiZTvOzjOhchqQIZy60fWSQ6jpOkWiKVBP7MGH2ck7/pY/VNn5dFco+BtT47xPodvhzFW2KCvfunsIqhk+QTYB7sWHpqHQSaHWkwjQR+BstGDjHIpfktSkw0SdCYBztHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272936; c=relaxed/simple;
	bh=wu059bQzMxVpPGC0O7fN9Fao3fXFUoPaVlz9vRInlYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iq0Gx6me28nlmEmI96wb2vAVlJZ7mTDxBpdWyeJ9FE1Lg5w0PcFTpqtg2TE25zxracvQQ7FMjj0jH+Ev5LcpgELmprFG/q3kOw6OFioVGyK3bsoH/yFfOb3mf3ARJvil7aV7/bYut1ianfLQiwfoSTCPX6ZGeZgR8MVDdU/mZJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YRxQVgHI; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YRxQVgHI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6uUpsF2KYLUQAad4E10yNTlUSNSJeyeT7OzEj/qqK312fH22KKgx09KkBS51XBoaEBKR+pMvVP+lHIjiTaVHi4qHc9l4cOFl6jsDb7NHUCjxDD+WeK20mBl8GBqXbKsR8H7i0XyGVFt05XIb5nv6p+/YeTVCXWJGLKfla04VmU62zW3LfN/gqskylvpbTiV7TyX42pHzauEF3FFDoeNsKEV8pbZkrDrGyPguh+dgOkJHLaClkY+HQVZVS1q5Lmj2+tBzCzlGGt9VKYI5pnNeJQaARQzascfouYwC+U/olafDDkyUdM+8iLtNKJataI42kCHRFYfUL+7VqtP0lYauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vWRlNNeen9rkZyT5NDJ1vYRJlJcvRm8igj5OOGeWtE=;
 b=u9powu+H6qkvu0oxxyJ8E3CwxH3tkqAbsiUzfD2o5FTbdpovB0AofjrS6tQZV588NkAFG5TUax9LE0JUSNPYaGJAiJsc1DJBn6d6IvZavsrawQB3ydYdLmB0xM60E9K1S/ixY2nKjUbgba/1zujoRdaLeqRP8dcJOAIbxhdlZEfFUnt0ssDyuNXnaHquAIiZcoKIj0nnfjpUE8Vox6WTw3iAFEIkgytWULwwhxU4mqTEgUPpCn429BGG5pqHqHfvOIu2OdeYHW74p8htokaWM6szKMsrvZOMol8xZdfdfccOpM3QnmWbpxKVS2MrJ9J6S3+nOsdW7Y3ih1iv62Tf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vWRlNNeen9rkZyT5NDJ1vYRJlJcvRm8igj5OOGeWtE=;
 b=YRxQVgHIhQAaF5XGRxhIXnqsCyPFDEK+sFlHfTemduswnFqycWuCieYNDpP1hK01rhTZVBucdsEM9T2Ih0+Z/t25TTJovKmjpKx/7w4mL843pBrYAmJCVyE11qlslyvHjdInVUxVCJpQckco5T6WbOs1p4Nw3eNFH/8uel/I1jM=
Received: from PH7P220CA0121.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::10)
 by CH3PR12MB8188.namprd12.prod.outlook.com (2603:10b6:610:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:48:49 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::1) by PH7P220CA0121.outlook.office365.com
 (2603:10b6:510:327::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 03:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:48:47 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:48:41 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 3/8] perf/amd/ibs: Fix ->config to sample period calculation for OP pmu
Date: Mon, 7 Oct 2024 03:48:05 +0000
Message-ID: <20241007034810.754-4-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CH3PR12MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cafebc-100c-4805-2c94-08dce682f30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lkJ9QFKPEXuav4Q/RnFNt9l8rXGe0/4JlgTS+EvnbXRwESGjiIBYiAHsRDpc?=
 =?us-ascii?Q?qr/CvXn3Kv3fvmX1f4cIJdPU7sXSwurAy2Hynze2DprtpZPd7njHEy2W5hUA?=
 =?us-ascii?Q?O08yVO5bn1ICsvNCm41ggHQRqiVt1XTJJTAkAz+sZ5XEEbmI1UsWUxAir0nN?=
 =?us-ascii?Q?oABAxzOg1QzZmRyuJhSzMz1ySdyPlkXR5DWYc9r7fhAShV87DzXF+8Qg0bLI?=
 =?us-ascii?Q?oU8jJyqV2VwPZqjY0e/lcHo3x1JQQ8jdreNgq7cQXJ8A3A1M6dkDjMtIhZ2B?=
 =?us-ascii?Q?YlyKSRVotKFBp9nzoVSgki5vj/BI+lXFPWlijiqsGy7y7r3tbRE8ep2C/B6x?=
 =?us-ascii?Q?v5xjfyYH0JIRW5GkbG9KupXxaiSbq8hzq81OHAeA/r96Nk5txOfe3/qneNfC?=
 =?us-ascii?Q?DsHr2A6QA8RtRSigVILIr9jiNNGLjRiBVvoI1QyW8SA7USLo5E6PMiXblKkx?=
 =?us-ascii?Q?9vkbECgzHX62ScU9ckshCMTsEaGUrNWYV0gx4yX609YZQIK2XZLr1jQJ6vji?=
 =?us-ascii?Q?Z8NuPvWeAHAcskPHwpBYcqQGrdzAl0lgk/8asmlKinwOKessrqCE+S/cxKY2?=
 =?us-ascii?Q?vlmQ4cwiM7UsIBiMRW3aN5JboqxECqO2qipMVPnDxdmfjBKS80Axu9a4HC9Z?=
 =?us-ascii?Q?o6Ppo9mJPCY1EMN4DMMLgNfAO5UXHFEPZ/VspV9+PZsG1+tp4SrEiEj/GiS9?=
 =?us-ascii?Q?ayiITP7yczVlrxogXyywDb6G//Kva9CFFFwCil8m8RL+wKxc4rZwJUG42AOH?=
 =?us-ascii?Q?nLbTyTrTJxD0QwEiJABj/+l5yl1petd77h7AOLj+QuLACrjVfN8ZA28g2Onw?=
 =?us-ascii?Q?VUD+6CZ81mRf5Of5cLPrNYg+jKTo8Q01P1Us9uIF3rhFjFGSuyKJwJV99gEA?=
 =?us-ascii?Q?wfCj6zj8U3rq2uOvw/LPwX/i9h2ih5K0Y3k2b1OOReCPZgG52ELgUveQKeU+?=
 =?us-ascii?Q?3dUAQAqGBsg28WuKbPh1Ar0ULHEvTJ/c71ENs+kLfMSiVvN/xz+DBcBfT2ax?=
 =?us-ascii?Q?6wafspIYREuE3NofndfXrdXof6Q6n+QtbTTl7Adv0QXWk4XeguKcSxjnPRB8?=
 =?us-ascii?Q?b0f9dc02ilmeuZxo7709AQZab4sn3o5Wcin6zJXi/eBeT2McA+rjjtPMWCur?=
 =?us-ascii?Q?yN57litvUDdchIDOZUOVSVgE9OOXAWqun7WlT2dfkTaGKSShQvY6oulJQkc/?=
 =?us-ascii?Q?R/4fxa+VMpHtDIHBjhG5+EQsZGGzvSMBwMgmO4WXYW6iA7CZ0d9C8EIHhB8e?=
 =?us-ascii?Q?S8KnugOKMuJKIDGmxhITMaBKclok0TN/jCP2w3xcwO8FaOE2zNibGVpF/DwO?=
 =?us-ascii?Q?Z1+i0pwcXXR8gtNUxuU1d8p3cWz4uPEPCBsHqiCaMlRP8BjbDIXuHaCRvOnR?=
 =?us-ascii?Q?75PlTGDKMR/wsY5ArWj5ZavfsTB6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:48:47.6719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cafebc-100c-4805-2c94-08dce682f30b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8188

Instead of using standard perf_event_attr->freq=0 and ->sample_period
fields, IBS event in 'sample period mode' can also be opened by setting
period value directly in perf_event_attr->config in a MaxCnt bit-field
format.

IBS OP MaxCnt bits are defined as:

  (high bits) IbsOpCtl[26:20] = IbsOpMaxCnt[26:20]
  (low bits)  IbsOpCtl[15:0]  = IbsOpMaxCnt[19:4]

Perf event sample period can be derived from MaxCnt bits as:

  sample_period = (high bits) | ((low_bits) << 4);

However, current code just masks MaxCnt bits and shifts all of them,
including high bits, which is incorrect. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 6b55a8520166..79422d2e301b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -268,7 +268,7 @@ static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
-	u64 max_cnt, config;
+	u64 config;
 	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
@@ -300,10 +300,19 @@ static int perf_ibs_init(struct perf_event *event)
 		if (!hwc->sample_period)
 			hwc->sample_period = 0x10;
 	} else {
-		max_cnt = config & perf_ibs->cnt_mask;
+		u64 period = 0;
+
+		if (perf_ibs == &perf_ibs_op) {
+			period = (config & IBS_OP_MAX_CNT) << 4;
+			if (ibs_caps & IBS_CAPS_OPCNTEXT)
+				period |= config & IBS_OP_MAX_CNT_EXT_MASK;
+		} else {
+			period = (config & IBS_FETCH_MAX_CNT) << 4;
+		}
+
 		config &= ~perf_ibs->cnt_mask;
-		event->attr.sample_period = max_cnt << 4;
-		hwc->sample_period = event->attr.sample_period;
+		event->attr.sample_period = period;
+		hwc->sample_period = period;
 	}
 
 	if (!hwc->sample_period)
-- 
2.46.2

