Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51162B9C4;
	Mon,  7 Oct 2024 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272917; cv=fail; b=ZhlwNPjn/2oOCV0sqIY2X9ru04QP6NWvoWaZyemv6Hstw3R/+MqH+1DdHsCoWgI+ffT0u0h2vx0DustMz+WiyuirEqAwphEx+ndGXoKWkWw6PdEC/XhquUEU10FVDcNmLUzhIGmEG9g81OXfivHIXqaapv3T3UOgwqdZTMrQ9hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272917; c=relaxed/simple;
	bh=6kU0ppwmSyDb8thJiCZScHyoijYo8L3Xay1Fb63uHUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TTCAZEC+PJFg5UwNUO1laxPdFkVsKaWSzc82yZOouTVke8nbxBmd4sdso2VxVSBUb2fJiu2/yGs6yWrAiFbPgXjwJs227GLBGe+ox144xNfdUgMKJx7wF83qNAg3KNDQBXMlC5633/dXQxa67vAXiO97fR0kPb8Uao7pP7p8t4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gSrst5bm; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gSrst5bm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsFl4jvYh7VuDesK+Tg3E7BJXzLdR4xxg51s8hEVEuAYGoSAiJiShO7STep98C917+g2SOEBaAbit+2fAp/ZvjF9q82j4vJBBYM9ZAoD5/XZRuZI1XsouPKrwyIjRrV0kjqidjvcutXm+dw/eyyd03R9rrCWo0mInpM6hQQ+fiRgqyAT+obJ52bT0tn4dt4vmMwQQ9ZeQvZlhOW6Cq+Ntm/P/HiH8VLJM9Zuw9dZq3G44XtOPsShT2fXdrzm/NtBwJz2F+aB++y2gvwoosz0R5UP5xWHTNjJylyV61/J4aHZJSNU8c/6tD1X6y/9v01zLWVeyEEkP1L0IibzKUTyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtl1Q9Y+z9B4pN/fLrTmXSUba/D6EqEbaGeSi5YwxdM=;
 b=isMsIM8WAWNLNLplZkSxunX6ShLYmGnsQVSPnq6iXjmmpmMp8y0BltvNMKEW2Mk0Uuu72KxT8PPBF47a+w7fHldihX4LxemOjkCqNxhfJmKP/hUKyX/tbKiSxZx+j4e0GVhmehJgC49gTw8Kd/3RQXdKEwgS4k6MoLq8x2byCTp+1klBf0VP7OBz736ptMieFrjm7sSAgerQENUY/kIW5CORK3NTxeDurStjLzCEKdl3AVt1SFZX/ol+KIGF9A059eM0Dehtk0xPSdzjhRG6XhjLro8cfRXB+8Jf0qxtav7h2V0Hp6LTcqfgvC+KP1ClZFBEPzkAkZXuyfoxbxe8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtl1Q9Y+z9B4pN/fLrTmXSUba/D6EqEbaGeSi5YwxdM=;
 b=gSrst5bmYkJOfmTg4lcgXmVhzO1bNsBZmPQdou1Aa9N3//20D5gjxvuAd9yHy29JezWfjA+se/9NMoOtEH6dWj6qxrXprG04de2jKBE5Ja+5fkETmnpottsGm3HpadReNMkZDm84/JCxINvK/Ioa8MIyqf1Tpd+tOeFEbas/UKA=
Received: from BN9PR03CA0063.namprd03.prod.outlook.com (2603:10b6:408:fc::8)
 by PH0PR12MB7837.namprd12.prod.outlook.com (2603:10b6:510:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:48:30 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::d0) by BN9PR03CA0063.outlook.office365.com
 (2603:10b6:408:fc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 03:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:48:30 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:48:24 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 0/8] perf/amd/ibs: Fix sample period computations
Date: Mon, 7 Oct 2024 03:48:02 +0000
Message-ID: <20241007034810.754-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|PH0PR12MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c90604-929e-48b6-5eed-08dce682e889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9kS1A5EHbi5Z+TfwBUKiBu5tDG6ZqkZqW8MV9IUTxevAnQWP+k97YKiE59am?=
 =?us-ascii?Q?SKkCJr6i680+I67oGgVIwxO7y168amtmczNr/Zx9cQBV8B309Xb9/AiWIrhq?=
 =?us-ascii?Q?Ej/dWWvdRRardpKB626LfC6RQd5uP9hXMIKNNhTxq5H2wwmA2htSo1RaQGLt?=
 =?us-ascii?Q?U62YAhfgKLSB8YPGPLwlnnboWTwi7BRtIx8a0GisF3JRZYifEThObeGV8pyx?=
 =?us-ascii?Q?9e32SudLb06LJLvg3ff58UPnuu/D+4kaHnnPmiB0f4A9RDRGBGYPsZ9pFqc+?=
 =?us-ascii?Q?JZPJB4aHzZxtrt64yZEE1ecSs7oOUvvgAuJi6OGISaJAIz1U7jmLc1Jqf0lQ?=
 =?us-ascii?Q?wpFz9otKQY5LX5+8DHAsJmzi0CU03fgjlPkYrkSnjaewJpgT5VkfgjAmPa5/?=
 =?us-ascii?Q?rXNXM6qL4oVkEWY7SP29+tt494i3B8rLyBbd+9daq35D+nbmOIKSGzZevQIx?=
 =?us-ascii?Q?wMuCnrtAadeDvUCWZtDq+qpmnYg35PGoP9z3odsLV4C/AyM7Ztr0/xMB9i0P?=
 =?us-ascii?Q?rHH6nNSIdnCaHPfDG6tpvT8br/olQw8HirD2fL9R4MMF/e0j72poN9vfjh8q?=
 =?us-ascii?Q?fBzImFFRpvGRPcbX+K8ip7OAkVWdwGy1LZST1Uc5A5XU3XNj0Hd6yNfV57l/?=
 =?us-ascii?Q?nYRVKU83396mPBbnGo4vbMz7OZHyS6T3Pl0S2mSRhk6pVSelxXP6Tp4Bj2RQ?=
 =?us-ascii?Q?AlATjlTZBC1qBXbRLIVR3MLkv1zBt1fjvRQIZWyxZ9zZ/w096ZDYC+0hEWku?=
 =?us-ascii?Q?Z2I3OPrMU4dwMb/G9sYlCFvz1ueonHEl3oRqsvn83Hp7/ZSbZk+6I6F10L2N?=
 =?us-ascii?Q?GI2CvjS2rO55ZpSmCEVqgk3z8bW5Im7U1suZq7MMTb5mSlhWcbJ2cnVtnBl2?=
 =?us-ascii?Q?g+5WpAnichXX9RwSfmugO4QKXW+hJ260xGN1aqcgALhUQgWRBJQlW087wnKV?=
 =?us-ascii?Q?T8buFFsoPPkpzbzFoU2Fc036frY1BxVfwuMn7mCcBH6wsxRON4n7faDlSJbC?=
 =?us-ascii?Q?/NR/kYPt3iOBo3n94hUUmOWBUpLx3UJvkFQYNf3wPuLXqYuJz7RWm+fFKskH?=
 =?us-ascii?Q?mip/j2R5MBq6BM3EVBxHQmi7RR6fgWADuBuPd5dYsVdOwoeARc9MUdGdeYfK?=
 =?us-ascii?Q?KpIPQy4XgqZvoCOL8cof6EXM/TNjrii/EycoGp01NORstl+wW6lpfeIaDz2h?=
 =?us-ascii?Q?WSMxqmh/BmkLgU1zrHlU6Yw7nBZBvIKp/YwALRV2LA2ykbTHdlQTpI1WQj5o?=
 =?us-ascii?Q?4l/NCdYcj5aIb5ZPhQjNU7oeodBpbBOXupTGsWtU1lOIY8hHNboaUfmswDtQ?=
 =?us-ascii?Q?k6IMF7LHx3X2OQca98I1QB34+aKgw0EUhtV+PkpffhZJfdD4kRnSMOeoL766?=
 =?us-ascii?Q?ZdpEvuIG+PBps8T/qMI2U66E9Nwc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:48:30.0596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c90604-929e-48b6-5eed-08dce682e889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7837

IBS Fetch and IBS Op pmus have constraints on supported sample period
values. The IBS hw behavior could be undefined if they are not followed.
Currently, IBS driver does not honor them correctly and thus a malicious
event could cause issues to the system. Fortunately, the IBS hw is very
resilient so far and IBS pmus are restricted to root only, so the attack
vector is minimal. In any case, these are genuine bugs and must be fixed.

Patches are prepared on v6.11.

Ravi Bangoria (8):
  perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
  perf/amd/ibs: Remove pointless sample period check
  perf/amd/ibs: Fix ->config to sample period calculation for OP pmu
  perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
  perf/amd/ibs: Don't allow freq mode event creation through ->config
    interface
  perf/amd/ibs: Add pmu specific minimum period
  perf/amd/ibs: Add ->check_period() callback
  perf/core: Introduce pmu->adjust_period() callback

 arch/x86/events/amd/ibs.c         | 97 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  1 +
 include/linux/perf_event.h        |  5 ++
 kernel/events/core.c              | 12 +++-
 4 files changed, 88 insertions(+), 27 deletions(-)

-- 
2.46.2

