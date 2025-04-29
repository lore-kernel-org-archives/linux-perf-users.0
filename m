Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655827470;
	Tue, 29 Apr 2025 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899236; cv=fail; b=BbUUJm+J26cxy0tf59UxWZ8JUHpv3Q7BkPDjnfD3pk7BNXYPu5P7cAT5aB9C62J94y1pNNYxYhJD2EPk/WqjRBb+naOhJAboWOZ+fOHFOgj8aqCWpV+t6xaoNYd16EMd+Zk7AE4o03Yo8ry8HWK019Ua5sYcRVqHobyczr/rVjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899236; c=relaxed/simple;
	bh=Hz2XrD1/7P9zTq2FrW3+68n7012/ifWvJW400Ts8UDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RtAxevUtjZMA6AADMYwYTj+Aa+Zo4XFpb43PdZYMyIa6Q3LvYeJoWgN0NLSYKMuplbggpmqpDOVqrbHSlEiPyPfqBtRibZSsg9jTzx0C+MPbFtqJ0MNmHewyAshRJ5PLe57Dc7cYaNCc1ArNv+U5M9Z+JirXlyP91P1Xtx6SkIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HcdmgVuC; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HcdmgVuC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0KUo6qEXScUuc+M8XAzeRudBB7oYKuFay4gVlNP4CsJPV1w8DJ2bTLSwbvlwsN+mxseRhhFTMXTWKnqwkHIl4pXNN2rfHXZwMw4ZY4z84gvsx85e5DUPXuRaXZIytizifVGToSghslmr7kJ7tDIB9Kq2xSNpajU9O7Db96k4pIxjIuEfioNYukB4IybZQ/YqUGAbtDvGOw085A6Zzo3aDkEVrTObLhMiZyLDX4C3xN+Fnc28RbbN0R+C+mzo/Yi8xdlPQV5Z6isYSEFS2HuZERCmmDKmtaO4pbnvC4EJGxEw8F7YBaQ+X4+4BJ8TqtD9xft/tdtD6cX3xrzprGi5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuQjwNJBM1KjdJzncjl1RFGAUEN0cpjH2dpbf/ZnchM=;
 b=ymxiXGm+owqinN1rFIJ823a5eBaLkP+trCW0NsxKi6u1t7zBnsk8VzZAly46yCQ6JRxSCxKtw6pNzMf1tXaUxQjBuaz5p6f9CBRSkeBu3ONY0vVGy/yvITy2oDCY9zwdD41bic/ZXGoZoV4RDhXX6bUNCy/89pr7/LAGQUt5/xbI6WYYAFuvVQ8v6BoVeGIiMqXOCpVJ7ttiE0jkY30yeCRG51NMYhwaZN4zugbSYCKFcD/WQkmeG1dBqX8InGEBnpsOJ2d6DwdbfLQPNx9ZZkLd+FnKPexFYqvTjL6inMeOZCLTJjXEqJcDp7DKyiNedQTiSj7YrxwYlhXuMuMK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuQjwNJBM1KjdJzncjl1RFGAUEN0cpjH2dpbf/ZnchM=;
 b=HcdmgVuCz3tizbs1hORI4mxJ7pzouwtNq2v+CXXQ5SIOwjYsqf64JzrxMU1n4JEagk9C3q7NriCLnybyGWtx65if8W/S9IvFcp+FDAuzdMpRip872QovHPFhneMpWqBGhBGOxEfIjQfZF/3GWZWBLxlT73RkEIYUyXybiu4wjAg=
Received: from CH2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:610:60::30)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 04:00:32 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::e3) by CH2PR14CA0020.outlook.office365.com
 (2603:10b6:610:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Tue,
 29 Apr 2025 04:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 04:00:32 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 23:00:05 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Joe Mario <jmario@redhat.com>, Stephane Eranian
	<eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v4 0/4] perf/amd/ibs: Add Zen5 support (tools changes)
Date: Tue, 29 Apr 2025 03:59:34 +0000
Message-ID: <20250429035938.1301-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 03886972-7a0c-40b9-f110-08dd86d26365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jx3WskEo/9yYdkBW6IqPm5r2OOf0Nsn9R4YLO0CowrxbbsUSIYjTUoUmO1hl?=
 =?us-ascii?Q?nrpJNP8AwUHkngq1VCoAo/drw9xaSYSiLNc0OPdsZH78HSNly9y4n+Iqvnss?=
 =?us-ascii?Q?qxP8yCDlZViO6iJO9HmCVWEFI0fwQfrAHtb5fGPCK1nkpcxoIz8wBo+N8owW?=
 =?us-ascii?Q?xDwAPVm+IktNzR+f/yqviLLJ0HKkt2LTa2txmy1rgH0irgvo/qNcjQvwRqET?=
 =?us-ascii?Q?BrGl3KwSh61DMlUD7yEN14CgM1n6MBbwRqVazw92eeU9S6Th/+JY3nMQ+Bpi?=
 =?us-ascii?Q?oTtTYnWyR643iTuwcviYbJuXCOcLKlNVXB6T0NJ0IOTL3fdwKX4rDMZCukj9?=
 =?us-ascii?Q?0MGdnrxKYagfgHhWrn34Td83DNN+xW41gQnWFu9VescQkfwkj10ZdnqaAJbg?=
 =?us-ascii?Q?y1ozzA7Wfbo7IcRHT5XVcJEbR3NM898sOPBn69Qjh4FICto5Rn6MHEBQt+Z/?=
 =?us-ascii?Q?UY5MzCH2kcIhZcbbqmqYapOv10rrWCYkIzulCRBdanQ+P5U66DJwQGvROeL0?=
 =?us-ascii?Q?dK9HztXzI/8Xnr4HwCEln8684wCKRUVloYrfMhO+59eRkyVfXqf8ZCCXYAcj?=
 =?us-ascii?Q?mRFMmBsJYIX+7tEj9cwgfwq2YalmcBN6YjXMZFzNsXZrQjkpDjISzULj2gvT?=
 =?us-ascii?Q?HYWmunnHjn6XT2ii2j/627WrHpcTSuT/6AQzJgQkd8x0tSiZsvIzgD6+Gtor?=
 =?us-ascii?Q?KqC4ETnEaM7F+XeOohBw+rC14wHGw8bM01pVChQoSv3aAQWrA+LUQK3mh+u+?=
 =?us-ascii?Q?JstmuLVUW4N5fpruYD7sHlJ78xaTCoA8gCCJBiIn8zEUcX90oRdhLqIgepb0?=
 =?us-ascii?Q?oKmbqQeidkAW+CmRJvH8/BcqORQuD7/xsh40WbhrSJg1FMDs7vetCNxEbEeR?=
 =?us-ascii?Q?ewtlwgA+nFU2gD/bol1/skGHjISbf1fyWxRz+BKgk8omSAU6UWv+VYrJah8q?=
 =?us-ascii?Q?XKce1JaMOhjNxTY6aSpRNzUmtxMzmAsRHB5Z0La6AMsn+F09AswXAE8xvCkl?=
 =?us-ascii?Q?kJ0WY9/Q+dSa9silNa0UmKeJvxtRbaA1168BnUBdbKjJAM1no95py2OjgDyz?=
 =?us-ascii?Q?1dXLt8rnNey4opOvFF8/bYA3+4ei1noCn7jLGxIRYK/vC2Dwuy1RLDwQhven?=
 =?us-ascii?Q?eybTnVQCgqYFxtIuSEwsAJv5oAKKjWJ8uU0p+vbkqoGpIS+akWjSFBaN1ykm?=
 =?us-ascii?Q?EkNeX1lx7ouQ5SRdbZwPWaJqWasnDngpBZxY4sibReZvcdRP67HCXAXcMrQo?=
 =?us-ascii?Q?aYO2As8eNAcaFjdLjLcP2gxLMrHWwkafP19B3vvzn1l8Qy56PYnGx7U7L3Zj?=
 =?us-ascii?Q?lYOpBph4w3J5R6wFIZGHWj025m1JZcx+vp7KBqFGF5U0Zp7xH+wSSzTtR6OG?=
 =?us-ascii?Q?IoncVyMyuIE1Jk8MC0WDi5emSRJCwtCTKvjUQSJEDjD3wh/QUVkoOZceKXBx?=
 =?us-ascii?Q?WxhRw5ye0OmgrgSna+sRejSSOgU0zZ+r8CBOXeuLxJd+Y4lnI+om/olMFW9f?=
 =?us-ascii?Q?5rmkfOBIspKLQgQQP+Q3aqdzZNIRzTqg88UtmIUaoS9YEgTxbc8gyc+dqQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 04:00:32.4716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03886972-7a0c-40b9-f110-08dd86d26365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

IBS on Zen5:
- Introduced Load Latency filtering capability.
- Shows DTLB and page size information differently from prior generations.

Kernel changes for these enhancements are already upstream. So, resending
tools changes separately.

Patches are prepared on perf-tools-next/perf-tools-next (85447f68a1e3).

v3: https://lore.kernel.org/r/20250205060547.1337-1-ravi.bangoria@amd.com
v3->v4:
- Remove kernel changes.
- Improve IBS sample period unit test


Ravi Bangoria (4):
  perf amd ibs: Add Load Latency bits in raw dump
  perf amd ibs: Incorporate Zen5 DTLB and PageSize information
  perf mem/c2c amd: Add ldlat support
  perf test amd ibs: Add sample period unit test

 tools/perf/Documentation/perf-amd-ibs.txt  |    9 +
 tools/perf/Documentation/perf-c2c.txt      |   11 +-
 tools/perf/Documentation/perf-mem.txt      |   13 +-
 tools/perf/arch/x86/include/arch-tests.h   |    1 +
 tools/perf/arch/x86/tests/Build            |    1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c | 1001 ++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c     |    2 +
 tools/perf/arch/x86/util/mem-events.c      |    6 +
 tools/perf/arch/x86/util/mem-events.h      |    1 +
 tools/perf/arch/x86/util/pmu.c             |   20 +-
 tools/perf/tests/shell/test_data_symbol.sh |   29 +-
 tools/perf/util/amd-sample-raw.c           |   77 +-
 tools/perf/util/pmu.c                      |   11 +
 tools/perf/util/pmu.h                      |    2 +
 14 files changed, 1160 insertions(+), 24 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c

-- 
2.43.0

