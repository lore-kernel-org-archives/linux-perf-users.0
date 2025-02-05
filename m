Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E528399;
	Wed,  5 Feb 2025 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735589; cv=fail; b=PUlVgmvVlDqCDS0ReDysoL7QHny5AMIy1gLR/vylhZ9z286xKA7uUHpVNsPSM/WsSmZAcnQvtstMH2Tl6/W0MiSLOCTtgw30WblOAyhpR3BWbPBllMyX75qVoT/vZKwXsLMsQIFJZ90d6cLjmauap85wenVk2Nfl1Hw50PewzeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735589; c=relaxed/simple;
	bh=XOZZVAuK3YsHwWYeByfDp/8QLoT5y6Pkw6SxeqWlzT4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dme05p/lSb6rfDoORdNu+XzZNBniqlia+71zQcoTfS+Xt5jz9YvPoUfUYjY+3Ho52LmvzgM4MM3TPwOItLiODgxD8fcrmAod3zMuFwoRNyt+9GBqaiNBgq2InSeKBdaMfy339EOeKoq2T7NNgHpJYxnFX4S1Lq/iBZ0ljpr8Lzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=elgREfXL; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="elgREfXL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXyPbhqEXeXTMo6EuCr1PPf9UQRjJNIR92KSq09397XLXjnPzZwwIRQXt0z2hXvKcK9fh9ZQCXj43jvHXfl5FQjKT7EQXI4FAJwW7U81DB60MhmeX7SC2RTpOpBthGb9YhMEILqkijN6oPUVTa03D4zpy35dT4bJVgm4aL4CbI8WK2+JfiXomQOwWe24ZrZqFflqBoexFi0XSE16rGt89JwuU42o8bDYv92h9/5AGaKdDZAiM195BJfvC4uW/V2gQY7SsArCEc6AzBIYwDw4t62ctr/8bo4qAa5zdct0T4b5GmaO6fru7kgIMroHWRaFuw3SLGZD0rJjzs1IlQOZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl1e2uPyxGWX4opOyhEqpah+XkBGmH5ta00yHuupEaU=;
 b=eVjK01d3j1kEimnBS082qRUGihF5i/igE+qRrJnMFU4OP4H2OLZjJX3AcoHhui+cLbFQ0Gh5YBStkNZfM2TGh2vWEe5CgKAogdgTQ3YHye2ZNb8G5PiDmETILEc8kmmckFdgWpcGxDm+qQ641zBik72FW2WHYw2xNAzuwIbEgMWy7HM1ZfmbwfMJnP62jDf7qEHEEw6SrEkqVdREmfz25Of0KIl78xy+vszQqOuwbmUDqb3QoAJJf/c6tsR7Zp8nxWadeBSEAZanpevSN1wap+d9yR9EJakD+oF8DX8gQoCzlaXUE1zYEcyu4WSs45q8vXroWwEh7RPSMDDGXA/nWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl1e2uPyxGWX4opOyhEqpah+XkBGmH5ta00yHuupEaU=;
 b=elgREfXLN+fGg693Qjjv7hv16oFGfPYDLhznfqKrMDBscJymALiKRrQOPwuSq9hr2WHI7pxxay05X0zPNzXVdM4zvG5thLoTlBZDGEkbFZaiJHZ/jdyjjUeP+fTv1oYYzONfqE6uFfPjTQvTtjwMaQzw7Smo0xx9VzfX04rMTZw=
Received: from SJ0PR13CA0159.namprd13.prod.outlook.com (2603:10b6:a03:2c7::14)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 06:06:20 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::b4) by SJ0PR13CA0159.outlook.office365.com
 (2603:10b6:a03:2c7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 06:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 06:06:19 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 00:06:13 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <jolsa@kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [RESEND][PATCH v3 0/7] perf/amd/ibs: Add Zen5 support
Date: Wed, 5 Feb 2025 06:05:40 +0000
Message-ID: <20250205060547.1337-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: d25e914c-3f95-4028-677a-08dd45ab3557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fn9vOss56Jz8kD2XCItCRoKVr2sZ9/X2M7es9Rovqfulsg5HN4/a98V3GkQO?=
 =?us-ascii?Q?jgnv+LZ5CxsJYOKsqUzSapvmNzgvp31fPqRtvx4cOQKKgI1dEyXBgEDRSAJH?=
 =?us-ascii?Q?9cUW6/HEfYrbld5jF3KP0hV2rpgAvF5ZJCFn0sG1tb8kUBHiY3A5IeJE0xHn?=
 =?us-ascii?Q?wgXF16wL/P/wyENIz/1hszkiW/mi6Gqh4XHEG/bR9v3zXTIrB0XnRgwkXOv7?=
 =?us-ascii?Q?ps7xIpRqm6Bsl7WV1HmhTUpI9Zxq7kn4AqhFc6yg8PKRjqft5p1JNP4nLaGG?=
 =?us-ascii?Q?l3Ps5ML3lrLFrIBF/Kx3sMGt5+VWi40U6zDX5/4+ygppOJ9GJD4azewJGw/X?=
 =?us-ascii?Q?LyZfodiYKbhWGP7oRDIhvhTw4VFl3HCJWlzs61BbhGnEjYzZQ16WD+OvknZ0?=
 =?us-ascii?Q?EqaXbWlmMvzR9mX18j3DBKVq5e7ANomdRM0BPnYYysWXUaXEvPeFLPrLXZZD?=
 =?us-ascii?Q?yYTw/eH8+Iu/WJgq7FQbX7Pq/sehkX3oppK+cruzG5bs9dWbP3TCTm+LQ1+v?=
 =?us-ascii?Q?UOH9hwNB80dqp7Qi1+hRlsCv49VUDsMiyyJRGyb+5sTvKrcsTGtJSyvMuV8F?=
 =?us-ascii?Q?9WaWn2NT1dyiRGFpW/ltzjDUl9Eryf4uAWlYqgeUopW9JrICFrgsdk88KF3R?=
 =?us-ascii?Q?qXTKU3Ojsc7iDx+tDNomd0PfpjISoPRkiWwAMsxFqo0uxZAOhbBhOEBZUK+k?=
 =?us-ascii?Q?pAW2hjVkev3LPNjpZFVV24t5nsICUSdBqbvpiVjo+dzqruHnvvYcCTjZm/Va?=
 =?us-ascii?Q?DKAo+ECtwImZihbSjxo4I6YQT4R2109Ti/3tMahNVaiSL3izGLJR71Ei1mRe?=
 =?us-ascii?Q?jjxrLbZler564IEU6eTnsBbq2JueMzJIthJsVZS8QmXDe3SXmnVOWnAvddr7?=
 =?us-ascii?Q?1xI/h6rWHw+hG8msRGv5TwFhxEN5kZb1/TcBgPrRGvtwyWKonxaLLHNi2ywG?=
 =?us-ascii?Q?UXjrjIvZzvmF/c8AlVCqWgpwyy/8zjbCEeMVagkl29g3fCGv1lD5/imGOK+R?=
 =?us-ascii?Q?itZCB5UV+FtTtw6rdbx49Q4qPRAruCgIKKWtAHzgER0Gu7bzY7NMcIt/+cQe?=
 =?us-ascii?Q?EVBr+FkcYbT+E/tYuW95njGBXaabKCaszopFUuyK2gqfoYfa5pd+u5nbBsaw?=
 =?us-ascii?Q?iiTtCGuP4VkuUJ1j06UhAF+fQfeV1mrHCPHS5AdFeGWKEoNj3rIblvMVFQmS?=
 =?us-ascii?Q?/V+NtxUzkuwRjmU8ZJD3frMKhG0zsUrBpXU0BhrbIWewTz3rl3FELEPg4KkP?=
 =?us-ascii?Q?7v8d1kjfeYnmOOlyMrUdLGV8icyu1Ab8Vd8evtryqtSGmFuBoURrHlliyhvc?=
 =?us-ascii?Q?/R2anAJ+lvBCy408FcrUIB8xGMkjVV3jJKLToxmXe3DWa4oT2NTPFSLluV0W?=
 =?us-ascii?Q?0UlwO6cW7QGsNSrcExgT0uJLMssNfavUsEhL4rGpcZqa6rxa68MKTasaUobh?=
 =?us-ascii?Q?OcHb8E7XeJtwyD17HnkSsisKKaUmAsxy0FVBTPuMR0ELBC/3fciypT2b1eQo?=
 =?us-ascii?Q?1WL6YY4fzoobf+4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:06:19.1560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25e914c-3f95-4028-677a-08dd45ab3557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

IBS on Zen5:
- introduced Load Latency filtering capability.
- shows DTLB and page size information differently from prior generations.

Incorporate these changes into IBS kernel driver as well as perf tool.
Also include a perf unit-test to test IBS sample period constraints.

Patches are prepared on peterz/queue/perf/core (cffa473a06d2).

v2: https://lore.kernel.org/r/20241218121437.1717-1-ravi.bangoria@amd.com

v2->v3:
 - The patch series to fix IBS sample period computation [1] is picked up
   by Peter except the last patch which added unit test in perf tool.
   Include it in this series instead of sending it independently.
 - No changes otherwise.

[1]: https://lore.kernel.org/r/20250115054438.1021-1-ravi.bangoria@amd.com

Ravi Bangoria (7):
  perf/amd/ibs: Add support for OP Load Latency Filtering
  perf/amd/ibs: Update DTLB/PageSize decode logic
  perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h header with the
    kernel
  perf amd ibs: Add Load Latency bits in raw dump
  perf amd ibs: Incorporate Zen5 DTLB and PageSize information
  perf mem/c2c amd: Add ldlat support
  perf test amd ibs: Add sample period unit test

 arch/x86/events/amd/ibs.c                  | 116 ++-
 arch/x86/include/asm/amd-ibs.h             |   3 +-
 arch/x86/include/asm/perf_event.h          |   4 +
 tools/arch/x86/include/asm/amd-ibs.h       |   3 +-
 tools/perf/Documentation/perf-amd-ibs.txt  |   9 +
 tools/perf/Documentation/perf-c2c.txt      |  10 +-
 tools/perf/Documentation/perf-mem.txt      |  12 +-
 tools/perf/arch/x86/include/arch-tests.h   |   1 +
 tools/perf/arch/x86/tests/Build            |   1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c | 951 +++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c     |   2 +
 tools/perf/arch/x86/util/mem-events.c      |   6 +
 tools/perf/arch/x86/util/mem-events.h      |   1 +
 tools/perf/arch/x86/util/pmu.c             |  20 +-
 tools/perf/tests/shell/test_data_symbol.sh |  29 +-
 tools/perf/util/amd-sample-raw.c           |  77 +-
 tools/perf/util/pmu.c                      |  11 +
 tools/perf/util/pmu.h                      |   2 +
 18 files changed, 1224 insertions(+), 34 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c

-- 
2.43.0

