Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4D22F384;
	Wed, 15 Jan 2025 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919965; cv=fail; b=sR92xJalECQcvy0dQPvk7fpGtxrR5+LLU24jw1Q26ZXRlFG+AN8/zK6AATa18mjZjCY0oFH/Nojm5tl5IXbYzsaPELiyPBlwzs2RJ9CgzTBsSc49KOIYtGfg1vKnH4VS0MQgXuZ3jnh1hXS840oQG1ADSP1nflZfPBI+FALrzxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919965; c=relaxed/simple;
	bh=iCJSyrpAGG+11SM5FfdQx143oQPKaCLfkPomzceZrvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sCHXa/CTFmr+bo73ijpnHhygYAJ6yKiFtM9P7oeQiSF4g63eclvkzpt8byE3mWUW33TG9pxvJc9FAqV/VsSLhX5+rXzehIQ8RSbsQqeUhnFSqqNI3yhuov3+9RLdF0XGb0rU7+yKhVIXbaIBREWFZH+jbDcdqVCXYQSM3R2pG88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Obj+Entb; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Obj+Entb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y081ZohoAsVgW4vFtn63r6MbgWBLmmRB/wCVcllBI4jF3k7+yDhxyFY2v6dkINoFHfO70yV5f2G+gzKAP3KcpzL3CitMC5ZerhuZZ5R9gn6jAfF2aTrOxPu8S0pKXXo+xCnF5wfFAI7mTtYaynLGBGPQyAhUsFN5jsZqelagjZJMBdvrpZSb9Nn8OuAGboeqycAuMxiFHqAoYhNTrOQ3XqRIOqwvNfG8iKTK5KZELeVAWU+c4XG+jvyJW6uoELICIdZGohU+roJvsfR1ICGD8sgEtwL9LJxhuARO2ebbnHEikFyZgvyuOW38GMWG7QBusHFdp0CFg8fRkNILMUDUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a87sWqX1WwvFOt14T8pV2YJjvLjnLhmCgGPmy35YL68=;
 b=tg2m4FjCjs+hLBfQsbLxr+EPIGLBZx8awwOVk6J8Guvzr68VsuwOozwDp75EN8U2DBdtusTeMv5zxcQi5i0hjJO+1r/PgS4LgjAkjaYEMGjQ0+rkMS8sCeL3VM0ov6/bZz/CH0UTMavG+nOExqaPg65C3lZEFD57BMmrGDwxfi48dU78eVhBZPNHDB/ZgXstbtAzz+i++bCQQahQs1t2xoouc2TJWEUxs4gG/00119N9CUtj9zPiggucPRiIYaph1lU/wMUSgj9auRV3PSo/4deEtWHNBLjzQcynizny55D/ZOtcv6ddWF1aiF8uopfW1OUMSG1XH9ZRGAlvQ80ZGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a87sWqX1WwvFOt14T8pV2YJjvLjnLhmCgGPmy35YL68=;
 b=Obj+EntbnlN13iPlZTUc/3zHV/HuSPk8SVBuZTbMlL4/Rah2qlibFgU4ndo0nwgxH+DEFDoOFqLacMKi9jKdExXZhoSx+Up+kBHnCW0aEDwGOwFSwnaxbhBDJA32q2E6PLYbt+ZNXSrwfuxNTIZtFzGL7n4bLSxZmHbS4qbiwJ8=
Received: from BYAPR07CA0108.namprd07.prod.outlook.com (2603:10b6:a03:12b::49)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 05:45:58 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::65) by BYAPR07CA0108.outlook.office365.com
 (2603:10b6:a03:12b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.17 via Frontend Transport; Wed,
 15 Jan 2025 05:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:45:58 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:45:53 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 0/9] perf/amd/ibs: Fix sample period computations
Date: Wed, 15 Jan 2025 05:44:29 +0000
Message-ID: <20250115054438.1021-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b8dfdd-cd1d-477d-f273-08dd3527e2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2qWYemUAwwPePzxntCfz9i1mI4BPFI8kBNp2nu5/Mee1ukKNGg2j+fzT3SZ3?=
 =?us-ascii?Q?hJcdJKd01OzmqPHQ6grzSyS7e4xZPHKfgHY+ug13JDzhvnQ0QaBO95HqJ30T?=
 =?us-ascii?Q?cJfJqffC3iRcRImuFmYmguRYCAMKyv/56Np05L49obHd+jRm6p/hgWrhpQZh?=
 =?us-ascii?Q?EUcYKDeWqauV3lgmnTDK/3KnUtiCZu6wMaDRTNUmRP6yX28kr+exvNB18Rx/?=
 =?us-ascii?Q?0/mPBwq+cd7RhqOJHX9OwUrRcCwIAJgAVlJJv3CLHEzPUs9mC61o3vHKQwBm?=
 =?us-ascii?Q?TmMikvZZ08SrXdqgi/vKqqC1mqkXGuY2jjlq0djdtJQteX+V01Y8QdLxXhSV?=
 =?us-ascii?Q?pgoISj91+gKj4C+2B5JBYG9dkLRve3SA8bOw3iN7f+MxCPg7+bKnD5UFhxo3?=
 =?us-ascii?Q?FBVt6S2D4mkxqso4jdsURPU2bjk1l4Ae4Fk/5mEjIGFvgayvw4byIaOM9o1C?=
 =?us-ascii?Q?MvKnoq34jK/eZir2eEeG7KgMCZ9DGxS7yEEPwkVrBk037RXOAmb7awpIUfi1?=
 =?us-ascii?Q?lAbhdpeLZJzkGK1OFSWcw1AYs7xoQWrkbtxBizLBMM8bcfyTHyvVIBhzo/al?=
 =?us-ascii?Q?l4CDsGGslD5OrT6XeNt6Pxyyq++vuaXc662mkmIeigAvNmUi7U9VvMnS9FM6?=
 =?us-ascii?Q?qwI2XAyrHPndmfugt4Kdial61MPBYO3xW/Buo3+wGaywDCfHlZMsKfdqnhH3?=
 =?us-ascii?Q?xW4eCIDznGt0mBWZFr/nkORQDrfy+W/nCS3jOa8oZ5Upx744B5B6f7VUfFQo?=
 =?us-ascii?Q?crdLEO+yPUOeEUAGJ/VUxtYJnnDN4UBjGAWRg1qavB4aSnf9g86lFHC7avqF?=
 =?us-ascii?Q?+8EX1vUIdrHcVW6ruPOnpRs5shqKMXwahnZUdzfcc4TGPJtglzXzUbzsklG+?=
 =?us-ascii?Q?6HE/IKDlv6XbdAxvXdcPh2sAzFB1KwsUz9/v4rPoH4AjDKwS8b4FXsySyZhd?=
 =?us-ascii?Q?TJOR1TUyEqzVgjJAOryYnOjDzJx5thkbFSdMgzDJFA7Ewl2BG0Ke3+qyYkv6?=
 =?us-ascii?Q?biCNl4s3h5qGbCsiVUYoM+mKl6okPwhf1d0jyH1FuoJ3qfjon37BWAsBpPZA?=
 =?us-ascii?Q?E9kCKBOvzVpXggd3jX4IVxMQziyNVdQlx8Z+XHSHbuQi4uOoaDI/8A3r4Icl?=
 =?us-ascii?Q?6uf++Qx4zpPXj7v2LNcUgBtBnReIUaQsKZom08Cx7q2ymGkBddB/37sfRr78?=
 =?us-ascii?Q?e0NHWQ9fZZz1lwbnNr/24jWaD4CKLLzS7hCnWAHC4SFhdff6nmWE6eLcMaf7?=
 =?us-ascii?Q?15Uc1q7LyDAPI4B8/PKHDfwlA8zxisn7tJU0nWmB/SlM57GSur2NJcIZq5xz?=
 =?us-ascii?Q?QELBpTJ0Q8DFFclLbmnTJn3nRE6HRLQqYiz9Ust+DTC5oSCxJ2egelV5G8X9?=
 =?us-ascii?Q?BTka7vyIr0TIFXHsTwYnGe/1Ek2Jx4v1Dax6V4gcHv1zIthmPiM+hs8iocFw?=
 =?us-ascii?Q?lgR6vGK0yStfTlVRFpCdLBzZXQD6tNyHp1/PejlAiCrDwGygtgqHV1fe+sMk?=
 =?us-ascii?Q?u7NfO4iiFJQtifE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:45:58.2747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b8dfdd-cd1d-477d-f273-08dd3527e2f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

IBS Fetch and IBS Op PMUs have constraints on supported sample period
values. The IBS hw behavior could be undefined if they are not followed.
Currently, IBS driver does not honor them correctly and thus a malicious
event could cause issues to the system. Fortunately, the IBS hw is very
resilient so far and IBS PMUs are restricted to root only, so the attack
vector is minimal. In any case, these are genuine bugs and must be fixed.

Patches are prepared on tip/perf/core (b709eb872e19) with 4cd67bac9d4e
("perf test: Introduce DEFINE_SUITE_EXCLUSIVE().") cherry-picked from
perf-tools-next/perf-tools-next.

v3: https://lore.kernel.org/r/20241210093449.1662-1-ravi.bangoria@amd.com
v3->v4:
  - No need to add pmu->adjust_period() callback. Adjust sample_period
    within IBS driver itself.
  - Fix perf IBS period test when sampling freq is more than
    perf_event_max_sample_rate.
  - Add unit test with sample_period beyond IBS PMU supported max period.
  - Fix i386 perf tool build failure.
  - Patch to introduce DEFINE_SUITE_EXCLUSIVE() is already picked up by
    Arnaldo and is in the perf-tools-next/perf-tools-next. So remove it
    from the series.

Ravi Bangoria (9):
  perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
  perf/amd/ibs: Remove pointless sample period check
  perf/amd/ibs: Fix ->config to sample period calculation for OP PMU
  perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
  perf/amd/ibs: Don't allow freq mode event creation through ->config
    interface
  perf/amd/ibs: Add PMU specific minimum period
  perf/amd/ibs: Add ->check_period() callback
  perf/amd/ibs: Ceil sample_period to min_period
  perf test amd ibs: Add sample period unit test

 arch/x86/events/amd/ibs.c                  |  92 +-
 arch/x86/include/asm/perf_event.h          |   1 +
 tools/perf/arch/x86/include/arch-tests.h   |   1 +
 tools/perf/arch/x86/tests/Build            |   1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c | 951 +++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c     |   2 +
 6 files changed, 1024 insertions(+), 24 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c

-- 
2.43.0

