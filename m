Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756A1C68F;
	Fri, 16 Jan 2026 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534526; cv=fail; b=mxKobyxV7EJCJcXPl5J5wpYNk4ITemgFq/Jkw3nUAlJu2p3AlksydH09HTkOfNAZNL4Xqifs53wt71RqBaWDwDyZLh8o4DKHWnxpxiicGu0Su8dXdTCjXXIuj1VToTgKJC+htwIyMPaGmhJxFeXX7zWFvplgWPaOt4ZsYMdlS8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534526; c=relaxed/simple;
	bh=sdCoqbIQFCTDcQfX96U8ab92eilvI90+y8II2Q+0Ims=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pi5SsJm9NSilN09e4if8sucXoy3SPwDHVcfGlZ83SC/1chnER4h7NfvVKq0HDgkazM9lJIAAFlUPW7oU70XXl+xzELWiQuKgB9No+939AwH9vufK/4GHHCgYKN2ae0ZPZ7KrD52rM1rqGM+Bl26859q3XH5en5aFaeEdp9GV6LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RUav+sxi; arc=fail smtp.client-ip=52.101.85.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RUav+sxi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIGjiyAbNYT3ACTxuIPzqHaopVSuTFCekpLxIlWfjSySumSsgpxz3FTkxpEAQdknCZwkEnQuI1C4JlcEvWtB4dFFZkEXDEdbaplTpof3V8whR+JYs6v7JbqYBa6AXutyVDEjSLf15k201LplOCMIGPzoZCeDTEq6GZAnxBBmwdK6Z1ZCnSjJVx05iXsP3VQNW0DiwTk9TMEcBx0cJORDa8X+OFCGCpuTZUQ4WzGGY1DMnmPjpZ2anhzWPdV5yCtvSsnJdsMK71rf40UQiRSVupeuwLq2cUN0zcOz5bQBZEDwHhKAhYLNk5yMonkLKewDBwbNQXTbw0eIfu4vNJqZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh2hVig3mliOvPzGfLnb/GiPPSEkkpJZYyO4dTcplj0=;
 b=L/EpllDHB1wS2NjR+0vG57h3/0sBNKHERMk6yjuU/nFlAm1FSsv7/UjHAb1D7BwPaIL4duUSOCSf7VzPGY2R8r8cLmJtHlz9uq/EkMN8pbRs4g+1MiF3jCuV5cj/flgaN/xCXoZbYVhJK69B3Npz71EGGcPNP1yRpjzeiBvVGy6+jzgFtGWgACx0Z3owcdhJoY3rjko0FKKk1ZtfV1C7tQCDOavJ8JDaSLvvwEjROLLx5cALV23uan1QIjootRfyfwfC7/pbLgALDgbTeuRj1wZxPbF0bUptZ6fSKFdsVJo1eCc3vlzGApn22I7eZHrTiw5CMS5A8VA21tgTZh3qTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh2hVig3mliOvPzGfLnb/GiPPSEkkpJZYyO4dTcplj0=;
 b=RUav+sxiGKO1e/4ul0kOtV95x6wgqaOtQ+xttesaAFhJk0Tbm+JVIhfDj65n2W01FcZMsgsxMOGWdoKgeZZq6i0R3WQD6aS4+wx/kUsKF9agFJF9Y/CUWgSJJCawbY65yBU7kIwc8xZRvYzkyoPFPS+3rui2tyvuz9icTenNG0M=
Received: from BN9PR03CA0674.namprd03.prod.outlook.com (2603:10b6:408:10e::19)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:35:22 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::14) by BN9PR03CA0674.outlook.office365.com
 (2603:10b6:408:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 03:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:21 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:16 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 00/11] perf/amd/ibs: Fixes + future enhancements
Date: Fri, 16 Jan 2026 03:34:39 +0000
Message-ID: <20260116033450.965-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ff98ae-d96a-4f6a-8cf6-08de54b04706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJRvzMyiWwUu0vLiry3chAlNTAwEVvMxt5q17N4t3fGliwo4CxsReCqNHdjh?=
 =?us-ascii?Q?/6uDntQrBm+oR5ebpWgh6UTByIwHtEmHSJp5z4MCZv6dj3OdjLVzELDq4yXN?=
 =?us-ascii?Q?QHwgg3RRS7U9k6vhm0eCEmw7j+GhctOQxbTlKAZ0qN6u1LFQrT5hhMI0Q1UV?=
 =?us-ascii?Q?6KVjAvm5viGvZ3M/bAE2xQezIeY0/2FhYu77uKHcQCAORARStpgkJkWkv3MB?=
 =?us-ascii?Q?Y8x+nopSyYr1MfUkJCGEzi+JDqRybWOhJ1INMW1WXF5RE//XmcDiWL6Ef7T8?=
 =?us-ascii?Q?BO0OqXnW4It2Asgoq0MN2r+7NHVQRhJczdyy76UmS/zoBJHnhofipZj92Xs8?=
 =?us-ascii?Q?IiWLzYZUdb+EGjag6WFRL/7GfTO/1QZGDSi/tZrpQ7hlNN4upJpVtT60TJYk?=
 =?us-ascii?Q?NTAT+lG6ENlfFfv1jjPDRNdCF7aIIL2w7ibCfr+nTmfhwnPvHD1WgC5rEnXi?=
 =?us-ascii?Q?r57N+BnHGV0eKJaBOcFG0BQzFAwm8T+CQYzyXQVMWYoBBCtBgFcD5xnbxMro?=
 =?us-ascii?Q?1B7nEs+ZKNSEtGBtSVsmVsH4UzFsVlJwMUVhVKAZKnwMovCSdr8eKP9ecIU1?=
 =?us-ascii?Q?t4ZkUMXEwnN8NMahIPRO1MJ3rpI6WX/WT1gYyFw9Z8Hd6dKgXi86hn3YWwWh?=
 =?us-ascii?Q?15QtRUEkBvDJnqUqhB4tnEx25LgtVwKR0++NMCXxHf4DTIJri7wXCIkuyAAl?=
 =?us-ascii?Q?+980Um8RDbjpWoe1uKI3F18RU8IAiSOBpL1UbnwlWZznsfjmUd5njK5DIAU0?=
 =?us-ascii?Q?Y5Ve9NxlVAuqCHjT1TuhKtCWHYCXYcNu9YujXbBnYnjQ2pd2JX5vpBrXorjg?=
 =?us-ascii?Q?zoG2XR9YqVGXVAv0EHAKIMDTO0a0PmE5QMlfy7RMYcJjB4tc/hVLdKbW5ZLb?=
 =?us-ascii?Q?LZLVResTeSx7DtDnPXPc4nhabcWra4rbooDgRTV1gl6IIHI/3/rB7+RyTwc2?=
 =?us-ascii?Q?yhFIMt0qaRMRP+qb5aUwS+SA83ixQjAh3EjtvzSZx5RVxT9wpY+8GI6IdSxp?=
 =?us-ascii?Q?mYu5SztyfuCJcTZf2DvVI4ozWJ8I5PAQLFSHzm3Ls8htDbCoC0YYxAYNXNZQ?=
 =?us-ascii?Q?M3Et/C/bshvfrldcdm7VyyuBt3Kd9dl3qJdhWFUnSCp4SGVbhR3R0u8Vbfs7?=
 =?us-ascii?Q?dTnH9UXiPojVmGRGYk2u/LtajB0SQOKRNLOgoOYzZWGeF0goUqsRjuVdSAnS?=
 =?us-ascii?Q?alCcrjoc9ejWuKMLlxIZvQTD8JE9DkiW43aWra8hMO6on96pOsugcSvtodpv?=
 =?us-ascii?Q?uRnRAghA5ilR7B83LVAEDgIdGPv4lyUlYUv3o5EFn8yVD5Qyl5JGSUnUMXAT?=
 =?us-ascii?Q?kqQan5ZyR+UtAnqo+eShEoFutaDn3to/JWXnOYZfTg0P90ynroFXpNi8zKVZ?=
 =?us-ascii?Q?NeUn/0kGFR87QBcTu0FmW774ljeSolfpsCSsMbG/tIafIhYqshFW4M5sZy8q?=
 =?us-ascii?Q?OkTgnAFRfK3B2EGzAVgo5gbNQ9Q+UNAVe5ZkRVB9lUleDTa7beaZHQ8WJtfL?=
 =?us-ascii?Q?LFpLHP1PyKzuZhnLTqh53zxozL5jAjTnc0r/sRqIgd2tZix3LfAjpimNLiyv?=
 =?us-ascii?Q?Zku8AgEPnDrqQnudmaFkWszpa/CWPTmURmQi8d0YTx9J/tmqP04yN5xtxEvH?=
 =?us-ascii?Q?g3YWbkHDJEI4rZ6hRqYoDSV3TbqGyDOR305dYjpEmMDk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:21.5410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ff98ae-d96a-4f6a-8cf6-08de54b04706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

Patches 1-5:
  o Resolve several issues in the current IBS implementation

Patches 6-11:
  o Add support for new capabilities that will appear in future AMD
    CPUs:
    - Alternate disable bit in with control only MSRs to eliminate the
      RMW race in existing IBS_{FETCH|OP}_CTL MSRs
    - RIP bit 63 filtering, which can be used as hardware assisted
      privilege filtering, enabling IBS for unprivileged users without
      software based privilege filtering
    - Fetch latency threshold filter to capture only high-latency fetch
      events
    - Streaming-store filter to sample only instructions that perform
      streaming stores
    - Remote socket indicator for load/store instructions

Patches are prepared on tip/perf/core (eebe6446ccb7)

TODO:
  o perf tool and man page changes
  o perf test "AMD IBS software filtering" is failing on system that
    supports RIP bit63 filtering, but it's false-positive. I'll post
    a fix along with perf tools changes

Ravi Bangoria (11):
  perf/amd/ibs: Throttle interrupts with filtered ldlat samples
  perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5
  perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
  perf/amd/ibs: Avoid race between event add and NMI
  perf/amd/ibs: Define macro for ldlat mask
  perf/amd/ibs: Add new MSRs and CPUID bits definitions
  perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race
  perf/amd/ibs: Enable fetch latency filtering
  perf/amd/ibs: Enable RIP bit63 hardware filtering
  perf/amd/ibs: Enable streaming store filter
  perf/amd/ibs: Advertise remote socket capability

 arch/x86/events/amd/ibs.c         | 252 ++++++++++++++++++++++++++++--
 arch/x86/include/asm/amd/ibs.h    |   4 +-
 arch/x86/include/asm/msr-index.h  |   2 +
 arch/x86/include/asm/perf_event.h |  52 +++---
 4 files changed, 275 insertions(+), 35 deletions(-)

-- 
2.43.0

