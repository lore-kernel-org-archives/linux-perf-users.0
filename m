Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038A1991A8;
	Wed, 18 Dec 2024 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524274; cv=fail; b=R78nIeWbchr3E9PEK819ocEa+sAwjYcsJwCD127siFfDOeuImhfoNrHP6X5kmu0NmBZHLojOvqtboLeYAdNm/L5ktPZdWZNoV/iGBuORH+1I5zWTauSlPVepe9yW6GlRLCMRNxf/BG3eEdd/UHak/AyRv8hiGJOGRS18AyjT8AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524274; c=relaxed/simple;
	bh=/pnioMpLpqitkahhk7TaNM8LftpxuxIblfifgyu2o00=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=alt7wXTCAugOYvl6jUhCYDvrwYT2kIpUfFgI7NKZ6miRpu5mdE4kqW+tiDlqw4auACWWSwImaaWWyBBk1VJfSdgxi8Z3az58WtP810CVkzPP2HrNEpalY7gOR0ziVjfShVkJJ4/khXmcYNiuKfQatHF3TlnhysDQWYrDIqYNCqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qEUlcTdK; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qEUlcTdK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POoFwDGJkpMiYAjM6ZSF0cxK+ENyryj754Vf1/T/eVo3pkGdK/NRVlMtNaEVF6G6okKaAh15JaKdwl0YPkOhTM7kj7TbnrkgZBDtxcuMRtWsbA4igitcsKGoSyr49C7YTQy5iIkoBcWfuLjBFB6n5wh1FYm/6Pbrp9DWXbi28ez0vVWpm+w4iNsoBYhri84MNIw9nZ6VuUzoP7KSF6H5V5uYt+xc6oiMtGsyMYFM5V5a6P+SqteEbJejonRzkj74qr/ZjjdNWZK5bWLXug1AMc0llrxO0XkChYnwJCkGWfD/Yp3G4DPCvgm89DM6DiZcf4BXortqmCbzYFUa/bDQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBpQqSqELpFUH1KEd3jQYG90BGFRR/FPV4WM/zrGOzk=;
 b=mpHy+HGGERpUU1YfvIbv8nGFmWikwEuhFaBNdsZW9h+yHigLJ6RoUK/niW96lId8oT2DrgwlX2DJ55YLB97H5vlfqQG7ApbuhMCzrI8xdrOc7uJa2Qw0pXBXRH+v0yi5X2zy/ZNwLP0vdJqdNMNhAxQpMcmdSdLlTxSln/ZzTc6d60vyropNhkOTqWSp6LT7inl+b1wRqHlLeeIetRtTYJnOccjNMh+oVMYCpG006DFVoGWpzWEwh0WXbxtkio5gsJ8tfkyO1g3VNXUQbXIM8cn+ameqGUDKBbZ5awYAQuP0n2EMX6T9wqJ+iZ0au54oJp7OIwVQZxvh7/Szvzo4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBpQqSqELpFUH1KEd3jQYG90BGFRR/FPV4WM/zrGOzk=;
 b=qEUlcTdK9ghvWMTgOMTpApzTjum2vpyfQ6mlrRTYwM4Npu13So19QooglKdGFNDwtxiTZYi1TXhhwafrmy9Co7aCbtZAkDTRPa8O8ntHugBr4Bi/c44H+DtG95d3gypBlRKkBlpVd3HqffPBXrACVOoVvFvNbk6ZcwZiEp6KK2A=
Received: from DS7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::18) by
 IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Wed, 18 Dec 2024 12:17:47 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::28) by DS7P222CA0011.outlook.office365.com
 (2603:10b6:8:2e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 12:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 12:17:47 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 06:17:42 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 0/6] perf/amd/ibs: Add Zen5 support
Date: Wed, 18 Dec 2024 12:14:31 +0000
Message-ID: <20241218121437.1717-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b597be-413f-4ddc-3221-08dd1f5dfbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+nD66rcxeSFbYdxdhLhEnBC6YMrzxTspGDNxJatJNxHQmqKEt8EdXExpzVSO?=
 =?us-ascii?Q?WkRAK1Wr8wruOb1T5kmDcl47DHFVKSAJtz2QdpewsAfrLZaL52bju6R6r8Z6?=
 =?us-ascii?Q?uT6SuG8YpcWfqALYQozjHBhAjVmfZF8W6ifpjK27OkLuguuoakWfEH+X5G2U?=
 =?us-ascii?Q?ncQz/mgnhxivWpoCTSPK13J7tMhG6vGjqvJupkqi6ENDM+5+fYPWRWRUeZlg?=
 =?us-ascii?Q?ao6ccFiO4ki5xTnQX2ThBjCin6RSrWLRx0LiTe0L6E0wYbyCGqxi1mQDiis2?=
 =?us-ascii?Q?Vj5L1twZkmNayTgQd92pcBliqhRR1/oYq89dTnQMiYuGU5z01oa36aXBuMtM?=
 =?us-ascii?Q?UUlKJbdEq2LBHfPEiJPNGiEb7mUalWKrjKniD//ChpXNuuheifdOHvwIsnGu?=
 =?us-ascii?Q?8RBGWhmjaJRIE4g40gJ/pjJ8zgvkw1qh+BZ7ap8jauzDCJilViZI+FBNzoVA?=
 =?us-ascii?Q?7/EKxMty6UeUln6RxxHdP0CkjfLeCbi964Rn6yyW3hF0JuiGgh/prV8yh9L9?=
 =?us-ascii?Q?lFTLdITLWJFeBwiROfatODC5nK+zx85exhX/s4Lydw8xc08+RNXMZ8uRm/lA?=
 =?us-ascii?Q?lhvSi5/6Zh/ErUu3YInO/LRcOfJ5DElB9xfgWPfHWp/ZpJntG2OgyQWaVyEv?=
 =?us-ascii?Q?cA0Bxe1tNFNZRKr5VSY3d04ltV6Q4PK/A6mjsvtejNjd9UOCXH1+ZtuMYCtK?=
 =?us-ascii?Q?ESsVl5C1tcv6u2cZqXDNW8tnOmva8Xf5wNYlB78yETzU4BtxkS+smyK7OHdn?=
 =?us-ascii?Q?Pnx2/86jQ3CShlBihSKyXQqYDtwh2nAtTJkd7AyXVQdNmRI4yZZtCcqMkbxN?=
 =?us-ascii?Q?p7caIDTqmoY2JXjk22TU1sV7if8hBCZHmR5N6Kygh1FL4XtXDY8tAngrE/ED?=
 =?us-ascii?Q?tCr79Bupl3q7Ept2UXxBKYEbmHMJx8nLWCZmPu21J2FUOd0EpDsyzhOQy+8c?=
 =?us-ascii?Q?FbgjPseb0Tgp782NjaHc0bo2NHfPx8VgzSBv8HtRVqG6mzYCGHwmUS6HIyac?=
 =?us-ascii?Q?Rh4/I+JefjPYoxR7N6K5CNWpgX+N8wu4F0Kt89UyGKGjiZsJyXfHy9oBnTtk?=
 =?us-ascii?Q?U2RZBtxYc4KaHT++cFzjAgiy74qP6xPjvAVTeXCEKJVqHhpiZJV9pQzoy9NA?=
 =?us-ascii?Q?ryssJbfm6BpBy3JOaWVE0TAiRUSLcNLJYXh6nfpAHeeBXdjDR51a5OlPpn90?=
 =?us-ascii?Q?OBxa/HvIKYBw3qVcLWNCvgQ2S1oGHw2SQdVdpyRprXCG7F6AMqWq1QLsDFOP?=
 =?us-ascii?Q?/PvQvlfVWyotc0kw3AZDjWX3WQnuLFMVWsbzjGiTCMpcUcIpN87faQjQiL1k?=
 =?us-ascii?Q?1nQtpjH7BOksVyz9WpBRbsSXSwACKqbJ01D6VCYO026xN/smC5UVRkjxNq4c?=
 =?us-ascii?Q?l9seZsOKST5TsJhBmYMbUjpeImGBSedLjMFexhZQiDO70sSNNlogvpiQLHe7?=
 =?us-ascii?Q?sRj6IZqabcHI0pNKuzUzTnVGNnd6/mhc2EUbyEXeecahQS5U6Kpzu8tuXBnt?=
 =?us-ascii?Q?5tJadbv/3vCQUuM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:17:47.1183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b597be-413f-4ddc-3221-08dd1f5dfbc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

IBS on Zen5:
- introduced Load Latency filtering capability.
- shows DTLB and page size information differently from prior generations.

Incorporate these changes into IBS kernel driver as well as perf tool.

Patches are prepared on tip/perf/core (02c56362a7d3).

Note: IBS sample period cleanup patches are pre-req for this.
      https://lore.kernel.org/r/20241210093449.1662-1-ravi.bangoria@amd.com

v1: https://lore.kernel.org/r/20241010050815.751-1-ravi.bangoria@amd.com
v1->v2:
 - There were some conflicts with Namhyung's IBS patches[1] which are now
   in the tip tree, so rebase the series on tip/perf/core (02c56362a7d3).
 - v1 covered only Load Latency support. But there are few other IBS
   enhancements in Zen5. So cover all of them in a single series.

[1]: https://lore.kernel.org/r/20241203180441.1634709-1-namhyung@kernel.org

Ravi Bangoria (6):
  perf/amd/ibs: Add support for OP Load Latency Filtering
  perf/amd/ibs: Update DTLB/PageSize decode logic
  perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h header with the
    kernel
  perf amd ibs: Add Load Latency bits in raw dump
  perf amd ibs: Incorporate Zen5 DTLB and PageSize information
  perf mem/c2c amd: Add ldlat support

 arch/x86/events/amd/ibs.c                  | 116 +++++++++++++++++++--
 arch/x86/include/asm/amd-ibs.h             |   3 +-
 arch/x86/include/asm/perf_event.h          |   4 +
 tools/arch/x86/include/asm/amd-ibs.h       |   3 +-
 tools/perf/Documentation/perf-amd-ibs.txt  |   9 ++
 tools/perf/Documentation/perf-c2c.txt      |  10 +-
 tools/perf/Documentation/perf-mem.txt      |  12 ++-
 tools/perf/arch/x86/util/mem-events.c      |   6 ++
 tools/perf/arch/x86/util/mem-events.h      |   1 +
 tools/perf/arch/x86/util/pmu.c             |  20 +++-
 tools/perf/tests/shell/test_data_symbol.sh |  29 +++++-
 tools/perf/util/amd-sample-raw.c           |  77 +++++++++++---
 tools/perf/util/pmu.c                      |  11 ++
 tools/perf/util/pmu.h                      |   2 +
 14 files changed, 269 insertions(+), 34 deletions(-)

-- 
2.43.0

