Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F698258CE7;
	Mon, 19 Jan 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790663; cv=fail; b=cWELoJPTqbaUe/rMj/UxWq26QSg3YNrC6GBtA54WJgRfeEm+0ck8IPBqo40bq0ibHG4eb7ha1DhoSeOGAnXNKL863UPKsu1dX4uHPP0sgtygD4m2cTSztMizUbY8XS6bdmbTkGclJpnA5tmB76Pse3ZkgfaNDj6qufmGai9RBRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790663; c=relaxed/simple;
	bh=u/Hb7VHOogFbgR2O2KAPYSaS5XMLXgeyO1npv21wy9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSykdXXc2Tefv8k69NVosZmFKO7E3RbBT8s5d4ssDJYWIWHrNZ7zv0ZkLYHD0qgQ5YOpEAQcMXNQUX4/KI+lknriOE6cYf/vzZJX5ZZPYWXmLxw8B8J5jpc2TF8Zm0cLHPyypJDIENItJKVFkaL4jdtnGj+2MEqErpQ19zCEXO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mwfVwTB3; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mwfVwTB3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZqqAIIrmJYdr0WsXTUvEhEZWVvcYOV7+2voOjV0HnUHopcNrxeSQRMYX/flTAp1YbQDIv9+Bq3vZA+s4s6dmx4xkY0hWiouyq/RgF2w3lDaV8V7Bm5cflS/5XgQn8N8s2/TxqCTAJh7JGKcUak5rDYNxoQsrpIDbJ/2fJdpUHc1ignTvf0bJmWrld5dfPbP07Mp5Hi7sP3ijIroEHWYLCU6yl+6voKjfxsCUcjQDaZBJpo1sa+stGB2/XFhmJlcJHpc4mLqzKMQoUqhRYlYPrBbs13PrcyaKqqqxVJS2uIoq9p0V4S6Y4V1iwiLp16SrULzNKZ0SepTKUXtsSbh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/mC/oSGtswWu7E4SRmWNVm8GoFdxsqPHzskbxB/fyE=;
 b=OHXcawKN85nrkNOVq0MAPInJC3qcH+W2HSqxDlyPwsCUtJ5fCRZviUAOdBMttuBeYwwwh7vW9dXzcOtWlYRdXlFYByCOgP8molbolGISTRJ8UMGhdBVVzlF8QXwG/ogycv4aKq3C7TFvKRjCfrfxz7DXSGDt3CR7xSURKSrkKyr+Vm5OZSaq8r5N2cPegJpyk5+HRSjYYSElOPMsMWMlNIt+EweQ+Nh4JJ2lOab4rmRAnOktPY7vxzViLOwEJJXT9NzPxP3ZAJNKSU26eOCivD/OwcLPMJGCvS1eQPXsXIsUPhVwev3PmOnVsjybqqo8ehRcKSQ/UdUv0/sVlJQXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/mC/oSGtswWu7E4SRmWNVm8GoFdxsqPHzskbxB/fyE=;
 b=mwfVwTB3T1ewrqOlYtsMrM5ekkM/ZMw9cwyWbuIDvyYdoC0QmSteqaEz0WwptHY8Mg8leJs7ykXojkaMhQynoX77snO3Gf2mLvk2eKaYZyJA8cARwK19BY0F+HIyWBr02D7CxgkOhwXY29wmL49iT3dJcDC5FrSIK9tBaEkrkOI=
Received: from PH7P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::6)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 02:44:18 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::f7) by PH7P223CA0008.outlook.office365.com
 (2603:10b6:510:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 02:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 02:44:17 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 20:44:10 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 5/6] perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
Date: Mon, 19 Jan 2026 02:43:26 +0000
Message-ID: <20260119024328.897-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119024328.897-1-ravi.bangoria@amd.com>
References: <20260119024328.897-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: dee76ddc-8849-4b2b-ee4e-08de5704a434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J4xVNeMw3OaE731H0mMk4dosS168AuvKSN/R0X0av1nEvOINVQ5W6vG6RAYS?=
 =?us-ascii?Q?U9bTT4UTbJxx54lt14lzAHF2xEtCjPeEGdMMRvUjAdqQPJ3EgbD9G8siPmjK?=
 =?us-ascii?Q?nNCCyx/W8/8lzpvUm/xYw2Pys4l2kTyKl2R4/PeHPTyDtlhlZM0Y0quPwi/H?=
 =?us-ascii?Q?fwvvJ3pB+K9hJIAf4CIkFTEiz+K/lzKHck75hIWlKOFKYDDNO0dZ7rLuyVVr?=
 =?us-ascii?Q?uzEw8yNiCb5sPPdyL/sG/5QkP9tDfL/xFOwZL9bhcwXx3VoEL3IIUsobMUha?=
 =?us-ascii?Q?tswJR892GmBAicUtMY2vNiEw68RCxlnnuTApif7mCCKVNXbjGFAVzu/Mp/G7?=
 =?us-ascii?Q?g5+E1uiquvzUIgrt19Y1zTQ3OMeL91HkT8R7HVpAR58LixmrdTRbECf+znL+?=
 =?us-ascii?Q?YEiBE8hhFmtrf1jp5heY2wnjpo/1kZeBWxV5TzE+EuiZbFMcaggmU7CmMddd?=
 =?us-ascii?Q?tAZUt1Mqo173FvdurGcUpa4N/GEIqQHFXqbl59urJ9U7LqyjmfL8WYDd1vIr?=
 =?us-ascii?Q?iH0mjBJJcP+PP7KyD+uoODnwsIBcXY/rETHNxMmxz9TalsCOUzuWzMSuAQs7?=
 =?us-ascii?Q?WV0lzl8yDiiKMg2iM3mGN7NKIScdfaRQV2KiyQyrbczjw7IOSIiAxoFpgoMO?=
 =?us-ascii?Q?BdwFbIPzyTA1LtkUhrvsllXTsCP4A8ED9y7mcX1kdYyupWaN1zhWj8rJfl40?=
 =?us-ascii?Q?hASBKl+HmjqMvYgtmXMOZ+BRlJyua+489SlVTftS3mXQwJzb1uCdy2Z8ne++?=
 =?us-ascii?Q?AC8AiiJUKh1BU269m0ATItPS5h2xaTRXmpPnZvyi49PGxr4Gv0vhH5ygO2nk?=
 =?us-ascii?Q?XrWays/2zpvjm3YWYBof0AMCJ68FHIQrVZnE61x/bFLQIYVDgM/5A8lSEpVG?=
 =?us-ascii?Q?JZxdxFV8UBzP7ONdXq9eW4RwGW6SrnB6kvcqczhIDJ8FP2F099gFs8iUje/d?=
 =?us-ascii?Q?xfO0ltDKxqhXnQKllZLSg2mM3k0j8jyEqgKM/elIwvqYt04ZV+0bO10NLlI1?=
 =?us-ascii?Q?ks8Dsd6jT4wPLgH/LRbOfiFGykchZNobNU/OWhT3QSVwVtUmr+4U/dTROkUp?=
 =?us-ascii?Q?k0s798lPLHmSlQ++711/Bf7hQbvl8Hp8ZGUfMlV3mInMFUCnkW4RW181sJw6?=
 =?us-ascii?Q?nJVXtggIdMHv5VDK/XJjJICu6l8jae10dbVSXrqEOcpnbqbofuTsXIqg6b2g?=
 =?us-ascii?Q?0gN5eXMqwYGnjcSevcarYzq3AcetqzHfgSanLeuwz3AQ5ICPu05YdaoFTN3k?=
 =?us-ascii?Q?hZYkpzm/KHfQYVlE0mXPp6zL06UvbgmgZEj2LXEunkvdGNOm1F7N4R4A3jlI?=
 =?us-ascii?Q?6Ff7Aia/AbbW7yG839ySybkBTUNNYd+XGCInEjGQfY6CAYYde+NUMBpGOMYs?=
 =?us-ascii?Q?vxOIva0j8CvcvGFnnqSOVcPZSLPq8CBXINMQb0gDDXY5GaVPyT7Z/qbw8mM3?=
 =?us-ascii?Q?LkLHKUoyjUbgxuIf39r9nfFdtMm2eEzIXeyFeoWNm15tsb7PVEMNDr2nuxXo?=
 =?us-ascii?Q?M69OKA0rC2EbV60wzHUYaTF3H//qxrq6tlw2usRxY56Gga09RMpRsEeJnDbu?=
 =?us-ascii?Q?58eJ2uC3rbnOgO2u1Kd2CtHe9OjrYdcY3gHlxO+/SFFCRiG2ZwbZCll2x8aa?=
 =?us-ascii?Q?tL2386HPwySpQ2kfc+IA16kxZsccy+0rzfLZy6v0AbTg2M6DFIyhkFuSffFm?=
 =?us-ascii?Q?j4/81g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 02:44:17.8729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dee76ddc-8849-4b2b-ee4e-08de5704a434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

Newer AMD CPUs can mark a data source as coming from a remote socket.
When the PMU advertises this feature, interpret IBS_OP_DATA2[9] bit
as the Remote-Socket indicator and show it in the raw dump output.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/amd-sample-raw.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index ae005eb0363d..3e5530008b14 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -21,6 +21,7 @@ static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
 static bool zen4_ibs_extensions;
 static bool ldlat_cap;
 static bool dtlb_pgsize_cap;
+static bool rmtsocket_cap;
 
 /*
  * Status fields of IBS_FETCH_CTL and IBS_FETCH_CTL_EXT are valid only if
@@ -164,8 +165,13 @@ static void pr_ibs_op_data2_extended(union ibs_op_data2 reg)
 		/* 13 to 31 are reserved. Avoid printing them. */
 	};
 	int data_src = (reg.data_src_hi << 3) | reg.data_src_lo;
+	char rmtsocket[sizeof("RmtSocket _ ")] = "";
 
-	printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
+	if (rmtsocket_cap)
+		snprintf(rmtsocket, sizeof(rmtsocket), "RmtSocket %d ", reg.rmt_socket);
+
+	printf("ibs_op_data2:\t%016llx %s%sRmtNode %d%s\n", reg.val,
+		rmtsocket,
 		(data_src == 1 || data_src == 2 || data_src == 5) ?
 			(reg.cache_hit_st ? "CacheHitSt 1=O-State " : "CacheHitSt 0=M-state ") : "",
 		reg.rmt_node,
@@ -184,8 +190,13 @@ static void pr_ibs_op_data2_default(union ibs_op_data2 reg)
 		" DataSrc 6=(reserved)",
 		" DataSrc 7=Other"
 	};
+	char rmtsocket[sizeof("RmtSocket _ ")] = "";
+
+	if (rmtsocket_cap)
+		snprintf(rmtsocket, sizeof(rmtsocket), "RmtSocket %d ", reg.rmt_socket);
 
-	printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
+	printf("ibs_op_data2:\t%016llx %s%sRmtNode %d%s\n", reg.val,
+	       rmtsocket,
 	       reg.data_src_lo == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
 						     : "CacheHitSt 0=M-state ") : "",
 	       reg.rmt_node, data_src_str[reg.data_src_lo]);
@@ -429,6 +440,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 	if (perf_env__find_pmu_cap(env, "ibs_op", "dtlb_pgsize"))
 		dtlb_pgsize_cap = 1;
 
+	if (perf_env__find_pmu_cap(env, "ibs_op", "rmtsocket"))
+		rmtsocket_cap = 1;
+
 	if (ibs_fetch_type || ibs_op_type) {
 		if (!cpu_family)
 			parse_cpuid(env);
-- 
2.43.0

