Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A831A704B;
	Thu, 29 May 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522125; cv=fail; b=gg8KA2f9B0KNLz4AGdzgAPLCeIriRsuX2Sa5zzXfXigpBfqSsSFwt8X1GRX6n7Bz6b1NpH7rxRLpNtHn0KvjRUJvOCN/JfJRFxILryp2C3lKgMvPNyfG+vP/aJrfmzWnXxaF4m+bjgtJj3g8t0C7LnfKOFMPYS0QGNiVl4sSkiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522125; c=relaxed/simple;
	bh=FIfbDFzf51O410nf+UQMwUllxm9rjvHGMJP4KOAUMGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QzwLvwYwhWhpoe2g5iiUhDO5YFqSz2mzxbSH2DQGZvk2JqxJUTepXUkfNFH08N6rKDSlHBD3eXlIyAqvqu+nb1ysMMXDkdybPzGJSwBjXqXY0WyRDjadCy9TP3mX/kkAwA9be2frxJrXFG+akaMhLuogRx0DJcuAul0244JO334=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TVbmAO1Z; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TVbmAO1Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJrp5OR0gzYtPrf0+z0GIn9ofdGfwj3WK6ZuqUoqLI7bQhmaAPKdMvyQKkyuxwD9PKK4uJd5jExd7g79H2mY2S6Xs1rw5BT+Nn8kKgThWm2pSB81WLbbGnAlKjXX30YI6xWyeDFu8j40YXKXN7G/IGUJIQa1B7tNkslWzmyol+AdgkcEqf86O6zwK8vfqsXoN8/TySWZ8Yo2Qf9FwAXXhvjEgG0QmvpxOB7NJY3tNfb1F5xZdXkKXAhJIilGVcOBnR3V3UJE+/7yoAYzBQq3xwyVGUQTr877BetaSMl/wGVTgPKKCPsM4YSl9UTGSbsFOc2pgwXf2/fWx1VE4mvAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4ZCO9D9XmA89Tu9y1UhlSbam0zcET0jaK+HxeFJCPs=;
 b=BSFzN4nOEuSicWAj7hLqIC4Cg1MqntlpKooLQZOL4VS00L1JU7x9stxump+X+qu9Z8Te5qcgwa//zxnD9kRw5S23G2DGqdWSG7cNq1UB3NdKfsbohDnLVljrHDi4UEBE3kVYM+6otAoh1fmNr2xESmG8qKvNgaXMWrqc+gLDpoask2fM+QMo560yar0fB83hZ30vzuFiQTSZAAdBqiCYRFCKA4VGkJ/sGoA+3o0THs9OSuDJU8o3wv1wNdXGU9X6ClJacO0TqhAMjrxpDs+iosLiC/0wvIiAxRku4PFgbdKlWx4UkTJh/x+ssPTkPzxWWc79tIoJWfZHeRHzDL/gpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4ZCO9D9XmA89Tu9y1UhlSbam0zcET0jaK+HxeFJCPs=;
 b=TVbmAO1ZRrHJiTktCVLos88OWNhgBK43GsxM6v+bcA01FgBHmypZxvM5m7EnMev3jyPnm7BGocuLyZoJtQwSNL+KcmMlIvFU7Sqh5BNYvzFKSDKomLis9pq2qWVlkvapHsW3LmRprM8ZT7fK92Ik1Yzj9AOAASDFo826wE1/1tI=
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 12:35:16 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::ac) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 12:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 12:35:16 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 07:35:11 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Joe Mario <jmario@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/4] perf/amd/ibs: Introduce load/store SW filter
Date: Thu, 29 May 2025 12:34:52 +0000
Message-ID: <20250529123456.1801-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b1dd6b-9647-4763-50d0-08dd9ead43fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rrqBE7F/9yVToxbxOjgZlwHSzZLLmete+7ZYetLnHKVWoDED3p7b+0OczwXz?=
 =?us-ascii?Q?kohjEcQvdH+6j8bgCchI0QqO9ZnTDjJnE1R2ndZQTXprMshg8q/VknF4US50?=
 =?us-ascii?Q?bGNcXL+poQPCytXPqvhONoMl/cy780Hnq+32GHqt8cf6QNvnGNWj7rFmTx3j?=
 =?us-ascii?Q?Vgw8G62msepPoCkbDL7DM7QdChfn56XIO6yP9uXGLvtDNgGRFiMwZA3NGIK5?=
 =?us-ascii?Q?AAwWdGrCpINkF3WLw6asRdFVE8mpLyryLlPJCwVKBuQscxNT+z+Oeyb+Q2y5?=
 =?us-ascii?Q?jlmFUsUl7/9IGAqqVzUtMiHIomTXbmCql1DAuNcLQcqbNq28x/1RP3tLfTk4?=
 =?us-ascii?Q?yImGjWFQor/FvhjcbmMGhMwxpjj7CAve1F13naKK15gH9vELaMbIEbdcSk8T?=
 =?us-ascii?Q?9yTT2y+OJFwyPbgoEYOjtWT+hcxUBdYFm28dfx4pF3rqn8NiHCudnVXErPF0?=
 =?us-ascii?Q?nwW7R0wEHtNkYpEcjx/WAyDgl1UX5IfYhWF1eFq18gabrit+wjyTb/x61b+2?=
 =?us-ascii?Q?LkZO03zA+YbVD9XM1AbczEHNXiamBlHBbvWtp2aJKVdLJlXCiGYdroqO44gQ?=
 =?us-ascii?Q?dYJMjFLMIwr+C0CmNA9mFYo6RBc44DFtmfiYyvcRiVHvQjTYbzXou8bGwMd/?=
 =?us-ascii?Q?JLd10vVdTHuAw6gkCSKp6pSQlEuHqhl2ENr1l5I1XeCg4/NJmHt/WAE5mahJ?=
 =?us-ascii?Q?g2w+z9OTVfrKTYkmsYGpjBZvWl3v+GOKFZ2QKer32GqRjKVTJal57QcNX8gO?=
 =?us-ascii?Q?kpDY2sXY6b0/I8REhJtQi7lvxSIo9asypnWAH6wlWLYTfaDIPF8LTdNjAYz7?=
 =?us-ascii?Q?Vtf7UZNh0sSEio0JbQZSvHSSYzMPBY5NKJPen0suKq6PH5EvLYK2UynfnqNe?=
 =?us-ascii?Q?qr5yLqVCh3/nfd4fddXB8SRZAOOYOtlc9bBt3E0jiHisV+3p5xapVuvLzdeF?=
 =?us-ascii?Q?lFisv4m5fWWErTlfUFkQEPd4zsVRpc8kaZoXCGPwbznlC32rFygAYQ982wXj?=
 =?us-ascii?Q?L5vpkkfQ8+VxtAkIESpJ8klXYnl1jmXMR76N6eKMRuDLu9rzGd6QfoHmo5CF?=
 =?us-ascii?Q?wexepPGc1woUUpzj7d8NhQPH4sOcqGvbI4SimIs5lxaJ3pcuW79seI59BILi?=
 =?us-ascii?Q?B7dIN9G/v1dnr6z79to5h6F7OGzeBqSpEjT9WnGl677t20DAwF006l/5k+bS?=
 =?us-ascii?Q?OCja6FthEve5nVy2++Qf1B+ipSA4dluxDwiOSg1uUXyHDlUSEQPeMDJRHnZ+?=
 =?us-ascii?Q?ELIWNHhsm2gPnMpB33KlQIRxx8cSSYAcLdi3Rb1oIgQKJLrHoidlgsajAUto?=
 =?us-ascii?Q?bVL/uG5w550cksKuOEuA4zjOwfryzGr4MX/Y2um8awk0c8B2EnywFobAz/wZ?=
 =?us-ascii?Q?MUzrpHuP04nFc4TMS4uSSG+QLYFWYAXMAPZ0EUTk3GwczvlMeg9cFaCePS1E?=
 =?us-ascii?Q?rPQz7lMzQMVPOSWjhZ4eASpaZEl1LmL9z3pHmYR0M9EwgeYChC+M4qwbWrsD?=
 =?us-ascii?Q?l0QeZ6MZZg0XXCQkfBEtLVzYBQZnCxz5I2+LqmssIFnf1d5OOZQtS9i1Ig?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:35:16.2420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b1dd6b-9647-4763-50d0-08dd9ead43fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

Since current IBS OP PMU does not have the capability to tag only load/
stores instructions, tools like perf mem/c2c ends up recording lots of
unwanted samples. See for example [1]. All these unwanted samples are:

1) Passed from kernel to userspace
2) Stored in the perf.data file
3) Processed every time while running perf mem/c2c report
4) Skews perf mem/c2c overhead computations

So, better to get rid of them early in the IBS NMI handler itself.
Although SW filter is not an ideal solution, it's better compared to
no filter at all.

[1]: https://lore.kernel.org/r/aBTyYv_yXCPkn2d0@x1

Patches are prepated on perf-tools-next/perf-tools-next (4d9b5146f0d9).


Ravi Bangoria (4):
  perf/amd/ibs: Add load/store SW filters to IBS OP PMU
  perf mem/c2c amd: Wire IBS OP PMU load/store SW filter
  perf test amd: Add IBS load/store swfilt tests
  perf doc amd: Update perf-amd-ibs man page

 arch/x86/events/amd/ibs.c                  | 73 ++++++++++++++++++++--
 include/linux/perf_event.h                 | 14 +++++
 tools/perf/Documentation/perf-amd-ibs.txt  | 72 +++++++++++++++------
 tools/perf/arch/x86/util/mem-events.c      | 12 ++++
 tools/perf/arch/x86/util/mem-events.h      |  2 +
 tools/perf/arch/x86/util/pmu.c             | 17 +++--
 tools/perf/tests/shell/amd-ibs-swfilt.sh   | 26 ++++++++
 tools/perf/tests/shell/test_data_symbol.sh | 26 ++++----
 tools/perf/util/mem-events.c               |  2 +-
 9 files changed, 205 insertions(+), 39 deletions(-)

-- 
2.43.0

