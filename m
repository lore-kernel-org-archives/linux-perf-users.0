Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713B25A35B;
	Wed,  9 Apr 2025 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185470; cv=fail; b=SXciG09svhMgUSU6muCdEONBjhIg3XXQtKgQj8pZa8VMK/5anE2kjZ56sp9xrdf6amPFNJkT2SDKpOYl39xZC5KrOOOt2VLGe+fYLzSJvPk2UQgRF5FcAaG/pKWEtN/urynI8qMy0I6WvNi6gNH9yyEs5E6Obt+UqEtKHBAd3UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185470; c=relaxed/simple;
	bh=lX42mYwSzIgmhuvi0CTTnxE9rjt7fDv4CUZP0eghrqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b84pPUdKbS7l1eK4R44Wp2fQBX1cHhcW+4RZLN/AwzyyFgQ63rawy83qkMquZf8V0yv5aEk8yS0l51L3Ss4AHfKb33K5EUzx06NwXyYuTNb7yuQ5i2qW9qVgFGDWshTsNPTSbLfv7WAnJtoXq6aqRxZh1PQAargGm7THVQFZhkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CQPdufbx; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQPdufbx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMs+jSA0m4KJ+SsTfnM/FVp0gJjSliCdrfQ00oPVBpzHkljIfA47PEwmBYjiW7RDQ1qc5uQGGhOVP6dDGMOuQIbx1teJ65XnHy/bn5RL6MnRhNXBKmDxGtun6HS/kRBt59opsmYLJ85C+onqGDGbAcTtW8rGOk1ejvtrL0KYam3ocVxao0rLqF+0R0XW0xJ5/sx1AR4RCPeETJ0xjSxuUR5aICgKkqNSIJI1fFYeG0EQrU1GKItasHjmcAUxKu8dn1raHGYO7MLbFUpD0Yvdsm2fq+vgf5zPBiV+J5qrbSIh3Tjym8BSrBkaaA+ntfphPyN1JdWTAf5yE/Nu33L01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Drr00yrM7KFJK28I3xFwU4757HqNUeqx4S3tEcYLPk4=;
 b=wWKbi/5XHwrBc6REN4HYJ+kvnYVmgzOe7LiQ2IlCsJ8U+WkM5efwjebwxfWJzsVbiA4elRhFABCeHFclqhxLcubR9QD4TjwfUFXgQrMsLVSafcZKomsc3vCvJYPo0P17oBUzyQbmYDUGN29Db7e2g+7bIbjDWsEy/ZiH2PKCc4hJ88ZoiYFJsUjWQLXMZjTBV3f/u2fLlXeMCHhj0T9uPk/Y/Ls0P8FsczkTJXHHaBLq2eCVG4/RRP6kmN37n8+BQQbLMslLX9sCgRLIRPH7QexWkzPD3Z96mdM8SZHSqdx628AskHit3gC8u0SnEac4wyrdq2IfjP7VlV0zsD7L6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Drr00yrM7KFJK28I3xFwU4757HqNUeqx4S3tEcYLPk4=;
 b=CQPdufbxnNLXB1mnJ/uKDNHEnILCAhXtN3AtamqQ9slf0tOZv4QzZVkdTZz74EUuZfo09+EWrJrLIRmvDCFy+o60lzNXoPK/A5SsXjUCDRrga/2i9zt92miZKsIKLazlFhAgg0q8M5mU3nPdShKzUHlHmyOVRAX7dp4+W0by/cU=
Received: from MW4PR03CA0188.namprd03.prod.outlook.com (2603:10b6:303:b8::13)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Wed, 9 Apr
 2025 07:57:43 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::41) by MW4PR03CA0188.outlook.office365.com
 (2603:10b6:303:b8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 07:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 07:57:42 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 02:57:36 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <eranian@google.com>,
	<songliubraving@meta.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH 1/4] perf/x86/amd/uncore: Remove unused member from amd_uncore_ctx
Date: Wed, 9 Apr 2025 13:27:06 +0530
Message-ID: <7be0fe62aa7e7819659c7a22e165215cf6284076.1744184837.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744184837.git.sandipan.das@amd.com>
References: <cover.1744184837.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c0e263-2643-4611-56e2-08dd773c3526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+7ylpul+4hV43mSfG0Q3O6G6pYrgAXJ5jlU0kG5RLPbxk3LdEiUZWBZc1wF?=
 =?us-ascii?Q?XXOg+YCXgdHeVKjG0lOmQAJ98hwRH0XGDXA+fvUZQ49Qqd7Xb6MhCHfAwpzM?=
 =?us-ascii?Q?KPqW2SU554FQ3SkPP9vrjSrXTfOLaGMjZR0ynpshJBCoZFlGHqGZwt6RWI0e?=
 =?us-ascii?Q?mkGkXxEAN8axNJjGJ0DgvhEJ8BGX1f/1bPwoJmtHqsjV8OBlSSxcs8UiyqFX?=
 =?us-ascii?Q?GGouZTjnFWL4nKs2KDOJVnT5X7ZKyiCJDlujGoiEoFZlS8sYK97XbCQ+RNiy?=
 =?us-ascii?Q?95oMTmX9WTy/eoF114mx4b3uOkGmjzTUfMGmPEIotOHX1USvBudiA8Xydx9N?=
 =?us-ascii?Q?Rm41KUBkqI2ItkfYWieI5sMA52h4RU83wrVHZ+Elu5DZ0KkrhwO1Wu+ssVOX?=
 =?us-ascii?Q?fr69tZHOfmSuzkgDIJDGUGQO8LE+IQVzhDr8OTSQDFzSQfJ1XEfNAQt+mdSU?=
 =?us-ascii?Q?QgdP7MbSTCGJZlbCpMK1rXTfv9KQod2zxBWL+puun15lnIQ1gD8AkJDUpSbD?=
 =?us-ascii?Q?dtqqaK1E2eBMz3zfJwU8tcnBYK5PlO3bmL2WadO9m+mxiXnVEeXsmZy1FfHi?=
 =?us-ascii?Q?9GHvte+a1Kl/oKPNHj9TBdyHehGyhbi9SFANhjoaAEEQfT8ETDdyhfI7ov2Y?=
 =?us-ascii?Q?bVlFgr0nnsty3ejDHxuE2NJQ5sqhf6cKyV9DdKsPL/Hi+LdkxkUykwZaVkp1?=
 =?us-ascii?Q?4kImX94BN1/56bmcPUiubmwwk1oQXWg4QacET1h24l/Jgb3khNL3FZKIFuba?=
 =?us-ascii?Q?pM3+B/2/TUaZTtt5+qpFNLH9rOmKFvqUI5H9QtVquoXuTWUohDHqvXxlu4jl?=
 =?us-ascii?Q?tAnCaoCjrTtzx9TIj2BVBD5gQ1inkZTMRlxDN1NpQz2M9II8JGF8r8tHHp1Q?=
 =?us-ascii?Q?45fuzoE06e+eB7+aTy44rINMHecYUxZKIFb1BRbKxiVLqRQDoPxRDTzalSAl?=
 =?us-ascii?Q?2oYnqiDu4TS1B4zX4U1TRS8wJh5bKirSuctSploC7ND6prPZSHD+lknGaZoc?=
 =?us-ascii?Q?2YPH9Bfp64E9EhTRZNJDXIJGVzs5e1oMQHgmmlos5/CcjVEqz7ACill7SMuR?=
 =?us-ascii?Q?MIF2Qneqwi8O8QvBvqaVG3XihbIkmxOLjIswxh8AbXjNzb3VW/C6/O9yOhqr?=
 =?us-ascii?Q?ncwXMGNgiwXBEASJgvin1JcVzn2wXytRQjwQ9S4575E38HS8dknXO6SHUg3v?=
 =?us-ascii?Q?d5xtcdz/dHyNy3uaUVwzF7Gf6dQR51uy/MUEgayGEGXXiXoNkhB+19xnKVK0?=
 =?us-ascii?Q?HkX3IMMlxn0SoTh/gPmoibboN5xn9AKMEbFlMgrGUhWDZQsz0Ng5PRZyE+aI?=
 =?us-ascii?Q?hsDKBTtDMOzLkBDfvOreVggaQRUUtLPyEkpWjf0y3zUyMOVonEW8IrK2nmxM?=
 =?us-ascii?Q?N+6eoAstEIL7PdAXLxYdsBVdyVWbZq9ueKD1fVqjL+ADdMDwqDeI3Pm7c8Dm?=
 =?us-ascii?Q?gyJTuoQi7miB/BzwKpYbYkglTMSiSkdfsTOE5mEW4ruXevgUb5tH5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:57:42.8520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c0e263-2643-4611-56e2-08dd773c3526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061

Remove unused member "node" from struct amd_uncore_ctx.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 49c26ce2b115..010024f09f2c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -38,7 +38,6 @@ struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
 	struct perf_event **events;
-	struct hlist_node node;
 };
 
 struct amd_uncore_pmu {
-- 
2.43.0

