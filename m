Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC561E25E1;
	Fri, 18 Apr 2025 03:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947822; cv=fail; b=r4VQw4UzOET6qP26uniLkIofBq2ExaohSzk8MutEwpTw17gAGEJAhmrv0wvSoMsMdC6z/Spqzz+lvqZidmKSMVma5hP5bx7pGlUCFKuoH0qlbhbdcWrk2UC7c/yeHlyV0NqRmbnLuJnDIqAYA8TS9Rfxuqais7hyoBUXQ16hEUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947822; c=relaxed/simple;
	bh=+LNf7BHoKvA5JOUWhbuYLIN7Eq4GvCc+lYehMsPLC8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw50H5bhua48VLsmudRaqkPCCI5D+bhODHzRuLeeCFkSlFopqjFZMKSi0eAZYBDOT2hHbxpGgw8U5q8mfi5sLuqUOI6+YaDyTRjJCT3NDCDv6aMtniqp9KZMBFkb6eHrX5cSHh+J2OB5fZurqbPvLVf76k7fpOVEioJBZN/Sl3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mzESXZkN; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mzESXZkN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXTWieJ5LF0pvh4lOLTbLMDoKyPmWbnz01uIRgGubI5MRxckmKF3vSjJVzJpKiIUr3Qyx7sPYr1VU4eA61SYeNiK/iA2bpvU8m3aeGV6KCTbR1/wxlPldZqpGl85BFK7n5LZdmGMjGI9yeN+UVmO5FXYaEoBcCsKi4GkRg7ZY0wBPS1VELwMr6pvzTssqnTkGKWXJMIRhcJT/6q5v8VZSD86uEIADxVKxs6S5rzSdPgRtQnPqPGy9BxC/PZsNBZzvRdJjL2INv+LENrNLLLPQOofK7IfeI9OTZse7x0SEzQS3FweNf7LE7hqsKmry36853GHXGkjRAA7CJrzJZaDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9NLApPtTMVRTeXF3g9qSyxmhK8ecSI329cF0ldLrSg=;
 b=t9hozFKJQfOmx8j8Zmf1J6CDwyovhQPmGz12iGAMsz3tMTSLl6/ZBP6EFA0my3gPnkbrHctxQWyiqr3WujTON0ie9J4qMXADzVyE/LrRyT154cU2rf/Z1pZzxdp6Ui9oOBBLJdgXJDaxhxdipGcXcIIpPJs8QeEeruoLLl/9LLvFl/NxBX+MUqKRgRTKQ06891tqWWWZfS6yySyRtHc8uz1z73Hb7UuEdrOvtTzqviTLJPpDiUBeZPlW8cCvdpabMV3p7+IIY8RwhDDPnAYbz0Gk8KKVCLib6+vWVgBNHdq1P4Dq4s82roHPKRt2Xbg2fbi0SjSResmI7pTVwFHRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9NLApPtTMVRTeXF3g9qSyxmhK8ecSI329cF0ldLrSg=;
 b=mzESXZkNspDaLHW4MpVX/IS9Y+CNKvJICK7eOmG8exQ5m8abrXq8l3UgrHbijn5ALotpsPtyraWRiEqNHN0n6quWWi09d6p7W0b5V4cGpibSNW5MbTW1cteK1xpqg4sS5LsJo38cE0K7uQeqpbXcIiSq7s24XQNFH0TnAa592Xo=
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 03:43:37 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::a3) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Fri,
 18 Apr 2025 03:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 03:43:36 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 22:43:30 -0500
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
Subject: [PATCH v2 1/5] perf/x86/amd/uncore: Remove unused member from amd_uncore_ctx
Date: Fri, 18 Apr 2025 09:12:59 +0530
Message-ID: <30f9254c2de6c4318dd0809ef85a1677f68eef10.1744906694.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744906694.git.sandipan.das@amd.com>
References: <cover.1744906694.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a506d9-674f-478a-d2ff-08dd7e2b3389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dF5CknSeImSlVEaMbxBCZgf1v6YK3umgYqNc6q29ZwOjwbaTr1+uf3s/GMvf?=
 =?us-ascii?Q?f6GNaYtb5AU61IURd9xhsFxwnOn5E3pK/FvyedZBxMptOXvfO64BZ+Mlo3M2?=
 =?us-ascii?Q?jz2frNNz7dZ1Qztje2vu8hvHoXtS3Lcw8DfzytfUbsq6xQ9/cSrqNkAg8GTW?=
 =?us-ascii?Q?tgs/6Z6d34POKVftjCMG+qNwDCAXWx5Lq1aPb9U4xemfZxKyT/+OzEVcQxCX?=
 =?us-ascii?Q?X5/ah12Si5cWkhWUhh4aJDt5tu8Ys+CrTSLiYL4ijrKNJcJZrY8UZVZmJ08B?=
 =?us-ascii?Q?ovmRFRI1r3Tp0b32Uk35sOz006OKBBDnofnqLE/JWiFUhX9Dk+ABYaLZrEQl?=
 =?us-ascii?Q?KlwcCCC3XG0GAMLqmqo3gQTAPVdEyxjb2a6aWFJt1m3GazpA83fYuOK5+sxG?=
 =?us-ascii?Q?U+bpyvl1wls1nONRjW+VRSdOac7Mqmg7mKIytwgHWTS+NPRZXEVhNXWe65CZ?=
 =?us-ascii?Q?0yF0VYTikUBq+plFDjlBdYKYvrbPgYPrXAx2iynhE5ScxHp+6QRPQXZfAddJ?=
 =?us-ascii?Q?k90NWnEtHDtizPta9MQZkeyntKkuVTZ2gGe6gunOBb6nopOXxV6Ahi1zSWPl?=
 =?us-ascii?Q?FLojKUsxvwAwUFt9LR1x24MqiGvrA9E7PhF/Od0nMMW0PL8QtDCCOyVjM53H?=
 =?us-ascii?Q?azl2ARszcbAhWnAqA8pjrpwbFtUc1IjWtynI7Q7YWMKicndkEnwqhziAg5fZ?=
 =?us-ascii?Q?hY0NeUApqZ4Kn7MN2ByyrBR4+Ut1EaG9S101UOQrSPeQitLz7bM651KpGxyt?=
 =?us-ascii?Q?RkhbnGktLDo49oMQpAcupMb7eG6LOM6cbfPW9i/wMQ0LWRdLIXIkM8JfWkjL?=
 =?us-ascii?Q?rSBMolTRjy2np75qG1b3fK3JaRZrYO3to9gmPOsm0EgvZPX6/HuK0PlKx5d9?=
 =?us-ascii?Q?1n8amdLFHpXMujldXvYVhv81pnHXzAB3+hhVWj37ZRgfjkL6q8WgacSnJfCw?=
 =?us-ascii?Q?neqDRhujVJ/9gxDoawkqnsC7c5P5y7bvwNTdrRIMkqJ77B6cDRmEB977xpML?=
 =?us-ascii?Q?rgXGsqz7P1cYaGLai2ux1fNJaqdT2RRQmv93zuQrzycbbRB9iDsVc3F41p/a?=
 =?us-ascii?Q?07/OY+ax+YMiThYvf1JsmtHEX76ziw7W8LvQz81nam6P0hN5qXnibbRxFa7V?=
 =?us-ascii?Q?UFKK5Pq4fsx5YNVSvYAKgFVaT9C+K+2RaYdD3mdJOFwsW72IVne0x1JW+anp?=
 =?us-ascii?Q?rkR949e4BdhQBw8wuH8m0M6w9eA+1OlFdITZzEsVRwVmtOPa36zeAf4UDTya?=
 =?us-ascii?Q?9PAiXgwvKHU6NZ9GXAqNY0VREGm+G+m8Gq2wt1Q230otj5sGjiYU1fz5Ui8G?=
 =?us-ascii?Q?0aO2iHfXiWka7s8iebw6xm4lPGhjDC/PxV/rAXYZROZjNijC8A79sx8ZxiUB?=
 =?us-ascii?Q?mzXO8wwqYChVcwibNVF/Pi0BGa4zNgMK9agzaTjkRC250QlqPLnjDBFfh2qH?=
 =?us-ascii?Q?tkJoPWFOnXSy68GOaU3wPRsKAPvJJSRnFod7ZKDLt0fKUhEuKldeZP802EiD?=
 =?us-ascii?Q?c0PDGLhT9pyMEP/Q1JPf+yHjheCiZARlxcr0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 03:43:36.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a506d9-674f-478a-d2ff-08dd7e2b3389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280

Remove unused member "node" from struct amd_uncore_ctx.

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
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

