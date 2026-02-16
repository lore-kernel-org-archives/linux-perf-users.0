Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A61885A5;
	Mon, 16 Feb 2026 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215764; cv=fail; b=ZVTt0hFOhJBSpojYXU2zQwbDGIKuGHQQfmgROKkXvfVB0Hm0SfcIMHAcpzB/ybsDLatFY37VQZQ8Ezptb/cyBZ5+a4JyUDRewIi1kQJrXMmTs+u/Va3mgJhIRhVVYuyHjvUFawduK4BaUKiBOz+TOkZCTd4toQU+gni7LTWUfXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215764; c=relaxed/simple;
	bh=fZATWMUNhGaY/efuh6aRkn9kNBCpKSteavnk1awf4uM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G6wSHHU/nsVfDOUA/bMxvcUS8LeMZlLOd+A9QbH6iGTEoRvfw0OaPVJkFQyxALb6ZWRr4jRsDurx5p+1DQS12NexcJGuDiIVdHzRy//5BR2ZeOFJknZoJMa3wZApexHYT2JU1Nqin6vBsh8ROhBGgBUrPLJaxuPV4No33Te9xh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lqh4j5yb; arc=fail smtp.client-ip=52.101.52.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lqh4j5yb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B89rE9G4zHmyJKapiPrsX94MmW1YjSXIJ5XZQ/p9daGfvnGWk/jkDpNMEtrkQk/60MbdZyucd0gu7vE55u0artGbapWZ4WLrciQ9lHjI4LYATzFRGx5W+HgHMtHgMrF9KvKoIGa9peRevwwkvMEc/YhnXrtkEQFnGQif+bd/rugPniCe3UkSAOq2LZPorIXkoXEnxXMK/DktsbRN04RUYztIIE3XFPLJ/CQuAvjrPWq3b1Q5Mb/S59R7IX4ZKeziSuGye+KgmZN+2s+9kp1oafmIXvJZZCErnk2nKSUodLXWhp0fxwIwbF03GeVZCA2mZavp9m081e0VgisRztPwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHAiSIkLwQZZQxHZIKTwfVQYMzGQYKCeUe5KX5WqMyc=;
 b=K2I0rqh4QKeR1O9TQZqFrAoXLzsvYkCr5l4N+VBTVAM8gmYu7qfzMUTm/r1u9MqwLZhI7AcElUsT3zrdQUoX1EbkfD1nnvv17TcoJnChcnpWaMXnlaPJTPiqbwOqz1+BSQ1chHp7eHcpSUvlJ8UuRivh4lI6x3/i0XmYOkKAvwODOHPF2mLq+XN8S9iWvxM6ODyMPXKLaFrw6IZUx2Qit7rCacvwfOLTMe5yduDZChBpY3oiVdLyL2cKiTO3TcvEXU7VOoiEcZV00vp5qUDaDGBbLtiLKrAm0ZF3OS/fmuOGgDfJyVnaGnNRznY31KeIhZLcTodCxVX/sE9v+cD18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHAiSIkLwQZZQxHZIKTwfVQYMzGQYKCeUe5KX5WqMyc=;
 b=Lqh4j5ybnJxH2iMTcrlmpcf7hW1E1UK+ypVuM+1IpbK070IL9PPcs3jfkfrixDdMVnncrRVUEg8vSfEz8K0LMN8XW/IDlN0GpEW8g4IvcbYMZDNCNQ57lu1ozObbo0x9Y9i2Jw/E9sthHRTwUyo29F6bCumvcz/1Txq1/Y7gPos=
Received: from SJ0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:a03:3a1::27)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:22:37 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::9d) by SJ0PR03CA0382.outlook.office365.com
 (2603:10b6:a03:3a1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:22:36 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:22:32 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 0/5] perf/amd/ibs: Assorted fixes
Date: Mon, 16 Feb 2026 04:22:11 +0000
Message-ID: <20260216042216.1440-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: ef144f41-0677-42ef-9958-08de6d1303ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FP8fgz8VyPkLR1uJUh1w2trbeVHJT3gCvf1WyfNIKGpxN+P9hzmGBiIYl/3B?=
 =?us-ascii?Q?HMfll9JT2KJlidSmImhewrrJ/AS7QYd9DcIZC7PgzBiny2uLTy2ePf+/0sLf?=
 =?us-ascii?Q?xj3j4xwAX4Ilb0ZnK4XOKPWMyhtmjpMlMrGLMbZqxduizrpteP1XCuXf65A7?=
 =?us-ascii?Q?MHVc0ZPVqlpi55c8WC5mr1ezMA63zFDYYo3EYaVbai6t50O+hSVTB7dY1yna?=
 =?us-ascii?Q?CapnsKp2E1GAMm5EBl2dq77z6U50bsHVJk09WfQNCijtbcropThjtL3Zh5aF?=
 =?us-ascii?Q?B8KM3R4yqsBFWSarEj+R813pnL4VrQLmKoJPRiPAHVCDYs55TwMrp+yz7XSK?=
 =?us-ascii?Q?Av9/jZHICmQRF0KpoYXXiwGl4MuFvfH9/p5Lpu+9uBPZNRbQDGo5Ai77DU3q?=
 =?us-ascii?Q?gIqLVoMtN8/0INF0fmQGiJDMKFssbp+lQuWlhiZgWeJ2apZ059ZiCHs3Qxhh?=
 =?us-ascii?Q?igAUUa4d/JTmxO96PQTdeQGOyRpV1eMH6AdnMQch+ISaE/nqE1tFjK2+dFvZ?=
 =?us-ascii?Q?465J4LnlybqwWWFd60VT+KsH98XomCDbxC8GxovPjKm2u4uv7HVIJcvAJMTO?=
 =?us-ascii?Q?yr5ONiMxJRfamdFa7Txc125wWEM6fMRfE0efgZm1nPqElgVnIeWzAApEhnDY?=
 =?us-ascii?Q?0X0anNwC2sQqOlnnKzE4FF/4BfYKyjzmyib3b6LeHibCl9FLwO+leWWhfLCP?=
 =?us-ascii?Q?Ghzp/vO7EO1P2e+JzPZyisLE5714PLOjv1Qf8ooLCOuXS8eBTzPAFLIdrhq7?=
 =?us-ascii?Q?7JSlKmNNVnqbLO78ZHfMhHzM27tJuMG2bORxzpt+dYDeNk4jzWgUQ+QYgPwX?=
 =?us-ascii?Q?PlwRyy3q6tVSPctFmXo9Qcm7rWyxgXF7QZ38IFsSQEMrJ2ShHH1l1W6Rof5e?=
 =?us-ascii?Q?EIcuoBIeiaDaDwSk8AZLo4nHXAMdqQ20wZqJTxhGCfuEGKPcqVily65N/hYk?=
 =?us-ascii?Q?VEDrnJyO3/wRvH2vcOTnELylISslyxw3ll9XAGjIqtxaBp5tL9jguMPAkxuD?=
 =?us-ascii?Q?AC1Gbdo/uSG0ONMpZn093Ejkoa1eytlWRsnYfK6apnWLjpxV6GYzrbUfcj2S?=
 =?us-ascii?Q?piLQgA0bX0cH9t52xaLhHYMThTIJ2w2TV5AIQuIbdWiwBYJcgIXoQcNRlhD/?=
 =?us-ascii?Q?gdKSbeOiFwikeX6lPwt67RpKv0FzKklqgA9SiaZD/NJ7vdw5Kmu7qMyUXs9a?=
 =?us-ascii?Q?F3iawKfCjLDs1kQn4ikHDBGJlOZbazNJb5A58N7gVXE+4TVqHSryvpnI6sQF?=
 =?us-ascii?Q?jcNKWh9Ta6L4ipliZEyOZT1y5BApkkb6PL+0qpConnEoOONu8DETZND+eYWs?=
 =?us-ascii?Q?eHjnG+k1L2rAyncZxdcoAfZcF/O1cI0VG7rXc0CubfoWCv9sl6d1ts02Dyuz?=
 =?us-ascii?Q?Pp6QmaYStHQ8sHEuQXxCS9b2OcU14my1Be++p9wK2SVLcaDo5y24GID/4aPc?=
 =?us-ascii?Q?fCvuUFOIzIm/2D7Oy/71puFXr2yWY74It14Fyz6sjHUi9vf5i2K7ad2+UdJk?=
 =?us-ascii?Q?3QNNRJNxHdwEXVyPW8cr89mFgTXGQIYr/NuTs3sG3Xbx4tBYzXQKrgmBTryT?=
 =?us-ascii?Q?SHAXSKINsS7JqppWhKi7MS+/8c2pivakBqi7dTieoGT0SKSHtrCsRVkRU2RC?=
 =?us-ascii?Q?hjavBLeA5gqEhSfoY95r4WVfQjmCeY0Mb71vCk8zMUkq068AQNnG9bdz9QaN?=
 =?us-ascii?Q?Y2gTyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qEDWuYT24jnNtxznNcgD38xW+kKdb+AxEwL9QQXhe4HFczqsMkx8uUdYOMOm0Y2V2L6LJHjUCUOQL/vu5KNyxDdwM8gn3detvm2hvoRctPQEUuRdcQSXkC7tIW51TJN5z7kMQZ43+i39a3uDZCEby2dtWVxbfu3qZEBmEkelNzG3XxYinNdM98VOR8MkXvg9rY6JE/eldq20+mNmO06RA+NyamATAW7PIa0yiaMYAa4N/twvQfXBDzhikJ8sixshuRFIMk2KGiuBDDMz1nRkRuNFEs5Q7LJwuUVOjQ6YvCAmZ+HLWyo33p/OcHkoukGIA3T7WHxTYB8Sa9+CYkk/xyrw4XBRrHF1khu6eOtC7fSuO2gekxy1uDKyW5PLiu7Wb2+hJHMSSMl0po1QQmxFp3Dzyzhzm6crdlzLoHPeBHMFOefmGO8yGiexLpRHqdbQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:22:36.9552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef144f41-0677-42ef-9958-08de6d1303ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

Address several issues in the AMD IBS perf code: interrupt accounting
for discarded samples, a Zen5-specific quirk, PhyAddrVal handling,
NMI-safety with perf_allow_kernel(), and a race between event add and
NMI.

Patches are prepared on tip/perf/core (7db06e329af3)

v1: https://lore.kernel.org/r/20260116033450.965-1-ravi.bangoria@amd.com
v1->v2:
  - Split fixes series from future enhancements
  - Add interrupt throttling for zero-rip erratum #1197
  - Avoid calling perf_allow_kernel() in NMI context (new patch)

Ravi Bangoria (5):
  perf/amd/ibs: Account interrupt for discarded samples
  perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5
  perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
  perf/amd/ibs: Avoid calling perf_allow_kernel() from the IBS NMI
    handler
  perf/amd/ibs: Avoid race between event add and NMI

 arch/x86/events/amd/ibs.c          | 28 ++++++++++++++++++++++------
 arch/x86/events/perf_event_flags.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.43.0

