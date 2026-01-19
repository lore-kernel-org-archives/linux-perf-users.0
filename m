Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A9246774;
	Mon, 19 Jan 2026 02:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790634; cv=fail; b=IRnEnYPCK6Gs3Oq3a+FtVpFiCO4F19VXUfnkRnL/JpVAoVG0jEPUCqQqjB4O2ocvyUHYatVSt2mYi4meYhO5z4U1x1xxziOpk4ESJ3eX3exHz6cRwsVpz5sFeNcg4LFfgqSMO/Gg/ZoKlkgTED6lFWVALc4mAC2jKzwQL1R7sWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790634; c=relaxed/simple;
	bh=Bxa1tGgv5XMRI7piNG2cm2rzmVKDVxIdgK1zR8HmZY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GULZ3/D/e0YdPQWGTaf650d10qLZTM5sUZE5sKJF51GSplUk5HDIryvYVaZmRb2jim4gP3a773PJf71rnh2+pPmQjmZ6373UtS5rMDIP9T/RHFDuaa9UDIxkBrT6yFLtaeZFQllGZGHGh/JFT10LEU3vSLRHW6xGZL8sPflvi4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kOCEg9pM; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kOCEg9pM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCwnxH0ldJfyUk1TdCSXWEVaww8S1lgxnPgM2LSKJ03KDwyq+rWrcMcBJQWvZhZLGMs1nlNRV5jr2vYy6YdXW5qYl2ZJv5wDLJv5ffRIrvFbhajVe9LHsYE0+3/VexyLcIV3QuuPTXSDc4YSTH57dsJJ4arqD2jbhbPaePCSwDBjOgpfrtXJS9G9uuaHBI1sILnphpXyJI6iSB/0erLKogS47uGrLOzJ1Aw0FEhgzONYN48EnRwqTyBgYnTVFyAqVtVSAxQ23rk1mHgP+vTQdq6NAmWmSTAIyl7E6pkx4j834up5OTTG2fYgtlbaZ/1budpyewj6OS7udS2wb1X+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3Ul7yMocKzaK0pWhqFXOZXoAIRYfJ8Tgg5hN7NqtbA=;
 b=k4nJZfLseu7iTDy8wyR6YKEt7VBTWmfIqRbQ99gvCemmZMWJp7EAl/X+d1qIAnAYbEoDxhtVRCI51JHoJjsYIRpe7GX0zTywV+TXcbMBGW5JIXH/Jrcsj1c15aMh6HtbYCTIHfJJ5hsf4cXZug2humYcLHfoTU8aSZdQDV69Xag3g1FuyeYdjBxpyWis6OXnImVnGo9zmFVsHnrBiFakCs/UlqQONZQX2duwFS0oayi6aoDKV56O3geP8iqah2yoEqx5KtOpgrIfJFa9OMJptfyn0DekB1QDhCtl7OFJ4uOdlwS9PNTm6m9MK1NdieXxnLvaTdWBtPwJzs8JVN72VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3Ul7yMocKzaK0pWhqFXOZXoAIRYfJ8Tgg5hN7NqtbA=;
 b=kOCEg9pMjOR0N1r7ohLoupkjPeDDCN77bO+xLGGdqSakMv69mg1s4E/yTxKHOzNxaJn6FgIKd+Ly6AwOvbLk+yJ4BfPNe+6ujWQkn76vUKBb0uoN3As2QGvN8kCxMgv3tL1fFUndsBESawusMmDAHNaq1VlP5LbVacRRMlUapGA=
Received: from PH7PR10CA0020.namprd10.prod.outlook.com (2603:10b6:510:23d::18)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 02:43:49 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::c8) by PH7PR10CA0020.outlook.office365.com
 (2603:10b6:510:23d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 02:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 02:43:49 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 20:43:43 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/6] perf tools amd ibs: Fixes + future enhancements
Date: Mon, 19 Jan 2026 02:43:21 +0000
Message-ID: <20260119024328.897-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 01148c6b-9a5b-4019-eb24-08de57049325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvIYa9K1vWxXOAAjta8+gfycyBvU+CtI4Ec4S6rIY2RZPldn1AZYJCbmFMbN?=
 =?us-ascii?Q?C/+CT7G8YE2BRdDY6Ipewk8jZBhmsd7mvGQZ0OiAraoxDiQIO7BhbhNSMF4n?=
 =?us-ascii?Q?lPTl/EbGDyShLumok/25nYTmOPIgs4GiTxUPz4tBHqaSi175TG7VdNURYHdI?=
 =?us-ascii?Q?3N8FPjGPNpIhdXHV8DV0he1z9Ilv9SVtdoYqs0lLsp89upgs0W7tEIxShEuY?=
 =?us-ascii?Q?gJFfwspeXKn/9FDCOMamWKJ+E6iiK+gMVrdnkPHqgMFKR0R/lGVfhAeBA/4u?=
 =?us-ascii?Q?btMA53n3aX5Ne5d+aoMefjn1qASKa7kXfZ6zk7/pyf/V40V8gxR0H6PXwoUs?=
 =?us-ascii?Q?7zbHz5Qs2qFU3speN6VZk/qvToHiuynHljkp7KrdatKo/n49WJY0ZuCV8PKY?=
 =?us-ascii?Q?893qLu3LJlep0fq4SUCcU5YRc52Ozh7cPBolVOBmxoT7+HCeM+Tn+HHycRme?=
 =?us-ascii?Q?GvJWUr0yKUTGI/850C07R7dDy4cGRo5mnoUbYydY39zTvCgAd9qsvAHKMkEB?=
 =?us-ascii?Q?jefWI/Sc6ALvuTQJAqQTPpuX/2gByMP5IB/a5UezcUI3rCXcxhEbQtKiH4c2?=
 =?us-ascii?Q?Gkus59qtGkUmmz74R2joLYSjIN5t2z4a9byouwlzV1C8tX97Axd457qrmQB1?=
 =?us-ascii?Q?TXTOlOPxCWTDI++RDmzBFPFunw+yT60Ipr7xuaSaaHvyyI3IpU6dm03mwHrK?=
 =?us-ascii?Q?9sHS6YWbVrMIhm6I4tuS3ZUtQ2lb6D2SnhoGTvJPpibXE75t9fkHnMd6Negb?=
 =?us-ascii?Q?frkrAvTBiOVfVlxliY8GGfJoyImNK6YiGsRrzykkZzv0qnyHVw0SZdubBLY4?=
 =?us-ascii?Q?mWvYAMrcCF1l/ji+0rO1dyAzZ91NtcYfmkCKgst+k6nKktyh0mt2XfibsQ15?=
 =?us-ascii?Q?Bk925Gpife74gCLb/mD8FdO6qsuTAoQo4cCLaWHPryak6FqCnmiQFHn8W8Ya?=
 =?us-ascii?Q?NIaWRLeJf/gSMQezTNN3T5DDoEkB7Ow0dxVxVEG8kqrpNTaozarTSgYuUp0f?=
 =?us-ascii?Q?8RVq7hnlWTHbk5X157Z38+fwD7mo8wd+R0Z5gzbxUXJmA5n4Wd6uTAuC/tpK?=
 =?us-ascii?Q?/TrrCeK1YoH6tgzqyjpHSonujdO9N8o04rMzWQq14nuc1+k1AmhL7jRiIW71?=
 =?us-ascii?Q?1+Qp/nGlZSlxQu1NtQgJ9K/FfA6SqeqCiczVPhsguLfdxudf7H+VNOZ/mPhZ?=
 =?us-ascii?Q?/Y/WHy/Pgcb/fJAH4XXkyk27T5/1s2reFH3sdxz5C2ee9Df6PSucXZC8lsY+?=
 =?us-ascii?Q?HZUCyOCJp5K8S9Vasuj3iBcBOpCYFefN2X3PIrm3KLFUcS/tAvmQk44rkMVA?=
 =?us-ascii?Q?85vCXsSdRuCnQS+H1jmfRxViY6hQAHUjAU/ENcMnaqe3Eff6cyKUxJdmc0H2?=
 =?us-ascii?Q?KxfNNqgT01PtprF8oAk/piwjHzuzMT+MaJlxrVJ54yfo4c38Pwusm9iD1OoC?=
 =?us-ascii?Q?TOL1HFQqhZ1sJEEtlsjWq0vgxu8Ui0Sbnr9jmVWm9UoCaFZ+/OL/AWfn0YmD?=
 =?us-ascii?Q?6UwmeDC66fn4DjqYwv6ASSFlrGDSeFHvVBHifImRO71h6hQ6MgCUEqKt1Pst?=
 =?us-ascii?Q?SdMhTzCG3cwK0JgRe1+Xu/SCTDJzytVMz2OOPb21QOOsbB0Nbj8og+Wp3ZUf?=
 =?us-ascii?Q?m2hZrPgDnAcf8bwYG43eXjRI9mygsJJ+eiCUOLGi/bn7zzePJ6lduP3HK5pK?=
 =?us-ascii?Q?QE2Kow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 02:43:49.2546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01148c6b-9a5b-4019-eb24-08de57049325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186

o Drop perf unit test that assumes IBS don't have hardware-assisted
  privilege filter. This is now supported.
o Starting with Zen4, the validity of several IBS fields changes. Add
  the required dependency checks when decoding IBS MSRs.
o Future CPUs extend IBS OP with Streaming-Store and Remote-Socket
  indicators for load/store instructions. Add decoding support for
  these new bits.

Patches are prepared on perf-tools-next/perf-tools-next (571d29baa07e).

Kernel patches:
  https://lore.kernel.org/r/20260116033450.965-1-ravi.bangoria@amd.com

Ravi Bangoria (6):
  perf tool ibs: Sync AMD IBS header file
  perf test ibs: Remove obsolete privilege test
  perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
  perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for
    newer platforms
  perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
  perf amd ibs: Decode Streaming-store flag in IBS OP raw dump

 tools/arch/x86/include/asm/amd/ibs.h     |  4 +-
 tools/perf/tests/shell/amd-ibs-swfilt.sh |  7 --
 tools/perf/util/amd-sample-raw.c         | 87 ++++++++++++++++++++++--
 3 files changed, 83 insertions(+), 15 deletions(-)

-- 
2.43.0

