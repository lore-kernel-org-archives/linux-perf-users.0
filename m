Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E52DBF76;
	Fri, 19 Dec 2025 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186042; cv=fail; b=nZwGSxXhqrsW8j1Z+vzyv2EHnASrEHG52NVpzv2GiynlVbJ/uKREDLYxOg10rRkRLnaRwc4INM6SsnBfB/UuFFaz8sv3YFDNawCdRTY0CN2vqnNkAa4pqE/mq6ZVAvEmy8caVHbM88h2KxBxHbp6IehNtvEUp/0edy01BNIelhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186042; c=relaxed/simple;
	bh=ZRA7HoSNzmIpeGeB1G38TM5NxYUxhgcRc5hvd6WM0ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhwghlmtwXiQEIovR+HSAnEBbMsPNhFCSpYIXMCgN9BX3t9p91AGpjU43xhJudl6RxE6TjEFj9Lrp4AHhjzVZypr0d7SoXu7elrh83U8DlS6zMncgBNPH3aUrn/Rj80lPjS73ZkGetAiIokpI3bc3CnqmxbRTHyi2peajuMg+xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gn3MAUAk; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gn3MAUAk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNJbN5Y+vQ6yhrgY73KXvENzZrbMn3Ib0h0vkeuTgH5RDJQjLHgFjMHqWWWfV1N8HWsRAsLqwmIwOC5A6ijHLda8Pb2pZkP6eKxQomdvUQhbqt+qnuf/Pw+0omfqK0YKD09mEMpBE2oyXdfIklHbNN+svid1wMFTbmEXWtA/HSF8mO9dqafN9ufv5+3m6AYRL878aOiDP7r+yZ/WZC7QOy199xJK8+Hk5CLMUVi9g4bTILApxmM+CXlijUDO76R17bj5TpOe6tzy7+fHZJjI5qUW42ODA/Unw7rh2fcCqvjN9UdbmfCZboWAnq1DPpcJZTDTl1CknnOjDU4QBHjCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iE8sTWgYvHYFzOgO26pI/qN65gsLLyon20fNXuNBtE=;
 b=jGCgX5ZgIP+bHAFLrRyp3bCotGZCUuHgbFsVPVItVu6FWTL1PQ8YhsFA3EbnWrrS6Kw1cgOj5/4vtEp9xvBqHhqc21MgsRuhf+7R6fA07j4awxD4wJn/DJMm81bhAsHmrUqwS+0eyaAB44RoE17B1a0LZOyobS/guvguNUz/BkC99xBPGLg6IGfIh5bFdgcxJrhTUzl9n2IR9HbVkbcW9vb9qndTnGmYkZZT8OBWjQRhgdDUQrP+E9yUdsJiRwxV+iJp3TUm+WgOLO3EsuNPTj/UKv1N15a+oELCpEj8QWQHoZASXK4GoPHHqzOhdt3snjZrztikILA6iXUau438Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iE8sTWgYvHYFzOgO26pI/qN65gsLLyon20fNXuNBtE=;
 b=Gn3MAUAky+R+YxuE7IJdmyvBHsRm33EO+jkzXg6i6U6fqSoYYj6KqMSGtnl4JR0wmc/JMdaExgb2Rg/SuCCHsfSVVDMgf+sIfT9j15rfOUAY9qzIbEG/Wlcd2Vu4+HHYUKg1LHpCYVVLSN1XSH7mqukR7WpX51f6Yl5qabSBlao/M9MP+4wBaraqpZoo+fbOdsuRHj7HdKLctQlQt86NRWPKVN+CRb6x1y1MM++hWE8If/5d3sr+DgOrk6t/F6PFEMSObwciSmMQNR1a/76jPsawkoHkfrH2tDZ1g+dHVpcf12a+HRQZ/j2c0G+w/5+/pFBZ5X940Yk1P1bCL1xuCg==
Received: from CH0PR03CA0287.namprd03.prod.outlook.com (2603:10b6:610:e6::22)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 23:13:57 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::98) by CH0PR03CA0287.outlook.office365.com
 (2603:10b6:610:e6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 23:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 23:13:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 15:13:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 15:13:41 -0800
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 19 Dec 2025 15:13:40 -0800
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@redhat.com>, <leo.yan@arm.com>, <james.clark@arm.com>,
	<namhyung@kernel.org>, <irogers@google.com>, <mark.rutland@arm.com>,
	<jolsa@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<ywan@nvidia.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>, "Besar
 Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 2/2] perf arm-spe: Add NVIDIA Olympus to neoverse list
Date: Fri, 19 Dec 2025 23:13:25 +0000
Message-ID: <20251219231325.2742580-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219231325.2742580-1-bwicaksono@nvidia.com>
References: <20251219231325.2742580-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 3051ae49-f986-4da9-13b0-08de3f54497a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YUMjsS5MDS6yWXBoioLxnQ6qTphTkOdP/c7IGAKWQH2YCyFtbMoaDm6qpIUM?=
 =?us-ascii?Q?yyfFWMcsqNA5VKWMGINFzlSDHxqc0kg7SpqvbUi76xyzTBwt97FZcF68XLHF?=
 =?us-ascii?Q?3ycAomVdlg/nyquvdIG/If97jdV6FazfTLpNWLhA6Wt8XHXlHjEPfvFraDzq?=
 =?us-ascii?Q?NJSSSI4pAU8rs7wPw4NSLHO+KkEpVh87QNnwflgR3HJZGP9KqVz7tKCDV7m/?=
 =?us-ascii?Q?3isYreO2QzXv6WMbCJNa1xJfDX/Crdz6R4c3u4Yys7lCgMwFgTu2f83LyN1g?=
 =?us-ascii?Q?fnRkUakbone+NHRLzNJuDbKKIqLGnw8JiKAQ7vb0eVUATlxn7DOqgFV0wYRX?=
 =?us-ascii?Q?InbY9PG4ayRzLAKe1d4sCuJzwdS+KqhT+PiHaP9gRbcPFlwazl5IKMA3yaTd?=
 =?us-ascii?Q?nkpWI6Ji0/JQWAyIIgv1zUINkvCPmPQCsvYqxyLWsdFHXej96NZ1Z3nzd17f?=
 =?us-ascii?Q?96akXsaFTV7uHfuyZu6c0fla3QwxxgCsbdo0n4+KDNfFWTGrhJSQsvx8bSCv?=
 =?us-ascii?Q?DECVaR09+9ZkSs3Q+vfJYtATtHyVG7vsBus8n6pUj9Nm3Q52vUd83LRU2u3s?=
 =?us-ascii?Q?la0sR97IsKJWHIQdr7GCNgDXX3VH6bXjM6B6xl55yxuSJgPqEk2sqh+gjymi?=
 =?us-ascii?Q?QU4NTgy9Wge3lS6t6MS46UjMLcpU/zzLXFG14IKnWYXcemdJdynJWAS73d1c?=
 =?us-ascii?Q?P4xECAI/r/pCRU0aH8fi936/NKzMPermkNAu2rmN4SWBv12jQRTPPCoJamVX?=
 =?us-ascii?Q?ZKU1C94FFzI0WBYSzXuc9d1VvKhEsr7pziAmPNGucHOTrq+vM99TQxpplP/M?=
 =?us-ascii?Q?D6lkh7tWWU0vg/SbzxRiQv/ir4GlTXoaQcQ4zwnNehDMgcCkHAFMaZFkODbl?=
 =?us-ascii?Q?AgmeWeOMAADpvIEQ8vxmmg2Qlurh5bEgm9gWh7V3gHdBqVSDm44kUOQYUtu2?=
 =?us-ascii?Q?H6cvbJMaNTAEcrcMYhih9vaO79PP95RoXy5ayF52bmO8oSqrThbTrdaED9bk?=
 =?us-ascii?Q?hhGt4oDFsjnQG+GdgJ2eqk5J0AXVYbyEewy9CnmIIx2zAWVa7IJ2QdIWy6xa?=
 =?us-ascii?Q?u+8ZLMf98PA5gmUE4vdRourCXxOH6jDGMU0UpWwh/FrEa9cERK1rgM7jhH2k?=
 =?us-ascii?Q?8NSyDypHe+fOQ9ug1tw5lfqXu0DEg5CgCFasaF/XhOCdsZ5XQix5hyA8cpar?=
 =?us-ascii?Q?Q65NwftfswVnwmIuFCLfJ9zf7Un9eqiBKwfauu08U2kT4cWeHTEzYGkrilj0?=
 =?us-ascii?Q?OFNUlHD33xgR8OgjbPY3Q5NTtdjQQyf9IeCyDKdamU/ztcNx7uQnwXeMeUMG?=
 =?us-ascii?Q?eYDOVhZL06qbKTK4UUAwr8PTyEXpa57kkqA8ezkFW3hI3Hz8a0rd18iaCg2c?=
 =?us-ascii?Q?euj8gaN19Ijdx4dgUGh0oQr8IIrB2TNyITo5xviFJSXzRjaQ2x940JOW9aCq?=
 =?us-ascii?Q?cN4tzjFOJVggv+BdP/5YOMdBylGZv4dmhVwayrOvJTgEANKmxC913YiWSguk?=
 =?us-ascii?Q?BK3Xs8/YVy7gzKaLw7IYXGl9vMVusHqzFnEkYGCa9/y08DzYvdNRC5/ILBAF?=
 =?us-ascii?Q?XGtxH1/jEjCXiZZBjbc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 23:13:57.4111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3051ae49-f986-4da9-13b0-08de3f54497a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

Add NVIDIA Olympus MIDR to neoverse_spe range list.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/perf/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 71be979f5077..75208935d2c5 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -579,6 +579,7 @@ static const struct midr_range common_ds_encoding_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
 	{},
 };
 
-- 
2.43.0

