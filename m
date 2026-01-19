Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7DF25C704;
	Mon, 19 Jan 2026 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790671; cv=fail; b=CqvzynaE7bsFEvbgUW6LSA7nZ83IfrT954l6N51IqbidQyr6OS4KdTnA9abJ4INwy1Z0DdeOMYIJ06ntQP+0ABmOITcsfK6sne2XnzAACAvN1opo4d3efgKicI9T/2t/a1m1v3hXf6LcIKoB8sOduT+VwqNtbiNWKyb6YLCkBNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790671; c=relaxed/simple;
	bh=5EP3fAS4IRjNcDUUoie8ScwdDoIxtrjfviDDWJXmDyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvTafvsffdaN0isr/pnEtpmsPZ6zjDSSL7utqClOpmkXuoWz5lnjIf+UnB90WqThIetbSR2MLUCF7qjXI7WM+5757xLsZfdkyGce8Qu6uLRbvOb4gMM5hk01v5u2DP7f9k0SQ3O3JjdJnvCUBYLMACMQLbJ4VzQCc+xLtJOCVd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oSxAA1/1; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oSxAA1/1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGFnXl25iOTn6bWePAHV+CD9fLKAae+UQ9VfaxP5wXN9EIcwIUl3Ch1KbPc9OjUeQHitn6flyK+yicDgbpTSuylBpayEpZEkFzVrXuuMoZFG11HDb9jUehjsuH5WCmU9kSu8FCc+ez2+PThwQbl+96TLrxgL6if35H2xWuqTueuFhQj+w83xtFGbyG6VApeuq7mwcrNyrdl8ALejcH+9m21DzuU4m3iaybOV8tNPBz6EG/E8eZqEMzAr1LKkI27xJaQUaDov7yVGW7KLMkdkjykS3mdRBhT8oV8TGvGXy4XRng2dvoBHd942iMPwtZEAEKHRnBHmO6Gq7baw1wfWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B9zwgY9+ciniOusLIUjmwl8zXrblrcbHU3FweWLm3s=;
 b=pTBDzyN1fYTstToxoXRsFv0yONiaJmL0JrVEy3EskBJNNQMjOjqRHZr6hWGUf1mxygRYUlwoF9ZwRkC13GZrR3sCpn6ayXmJTaFg1GsZUdTKZwFVgXXDpi+N/Wy+dZCj1b4KShtuzpdV4rjcI7KJwB/sRn63Ou5JnBGT8iUq1S+Tzvxz9aFLrMWBVBhP5nF4xfemTM6daHFppp3Zd90DKn9msO2hZf9c/cpob3xdByT0Agooh/Eqhx4slhJyXYAd6/r1J0PIpHPbfg4DqRE9AeG5F03jlHypQWMXxuGg9nyPYuMQNCrvim4/5qwWWErkLwHOIqH6fR84l0+pIjga2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B9zwgY9+ciniOusLIUjmwl8zXrblrcbHU3FweWLm3s=;
 b=oSxAA1/15MomRdSVjV51VPMubBE0eFCY4x16rgAML5xOV+qBuYV9Xndtn5mmpZ1Jmll0Ky21xILzqGPmwEeLKzzjaqtAF8HeLfFHR8c8mJv8P5+TETG+1kymau/OBfazaWTuHqZyq2tEvt3u3Gkh66pR5lVFBUMtB/VqBWWhK6s=
Received: from PH7PR10CA0008.namprd10.prod.outlook.com (2603:10b6:510:23d::14)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 02:44:20 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::bb) by PH7PR10CA0008.outlook.office365.com
 (2603:10b6:510:23d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 02:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 02:44:20 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 20:44:15 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 6/6] perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
Date: Mon, 19 Jan 2026 02:43:27 +0000
Message-ID: <20260119024328.897-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 56402fc0-af03-4bdd-1447-08de5704a5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e1Pz+JClwQ5S8jt4QwhwGE/1NUKFdgP9w5anGoIjcKVN9TzkDwBtTWe0eRx5?=
 =?us-ascii?Q?MFkty7gA/6KqYkCek4JiRLhow/lZpf1CevyKcg80oozi4wBPkpDKqxDrHZcE?=
 =?us-ascii?Q?SEhxw6Kjzp+IzIzRkiuCy7CEKzjbo1J9D76FpWVgjM7wjkOu1rO12/5qqY4i?=
 =?us-ascii?Q?P6zkbrf6lx+mL/QlpW7yzi02Sd7tps4EbP+maNTBhQK3UTcliltzm8ioa3WD?=
 =?us-ascii?Q?4w0jGQd3DZs0NelkqG9zP5rraPP+qJxHRVAPGgYDSXQSlwVFjD9RI3gqPHWP?=
 =?us-ascii?Q?0lfyoSJmau5se7EjRNQ81FZ/s9v1czTffNtjF4StCX+4dTHHaOpmqflfGjHo?=
 =?us-ascii?Q?S2AmGXk09PfmIZpblBFrdhTPokRF+6LyQdRz1xk3VYFcD99RlHchqxbahLcW?=
 =?us-ascii?Q?23SYuhLRSE8AAUq+AMr+58FLNuSU8jCiAmDCb0G6Tr0ZxQqq2mAuKIjH9kEr?=
 =?us-ascii?Q?S8JxRc1xtm9CUtVLx7ReFw2v3YPUS/O1C+huC+SZ88psM55vAIvd069W6Mze?=
 =?us-ascii?Q?iPSnOUcYEmamLh0aYx9XDwxWDd5cGIiEzPoGtkJ8oeITqEFV+7RH8j7z7Au3?=
 =?us-ascii?Q?6U0XLsDlcz0gyJgfVG9DcV4UeVIWHBFBUaVXc0kDRCGyZmEKFXZwuHZ27j5w?=
 =?us-ascii?Q?xYZGf+yrrl+SeTl6Qeng0+t7UO9KVLbgF9g1S73vEsT/uTQ+Hkil1CP27i5X?=
 =?us-ascii?Q?AN2VxX2NDFzCUvEFUkokE9AP0h+lFFoklKGEM9j872Kx+dmi7QnAsxNmIcqs?=
 =?us-ascii?Q?Zppw7NIcRqQz6JC0SrqgSgDHeKwTQ/6n4p0pK4vOo/eT7zSR18LBiLqdQ65J?=
 =?us-ascii?Q?j+DSGIaiAUbGm/6JT4gzzjZWHKL+TTq+wMqZYpbG6z7KAeSizMWiBvOyKDQA?=
 =?us-ascii?Q?ilqrp/9hFmsjpPqVtWyVFbC72kIb9Y25uVyIEZAjBAl/VwobyT7QECep0nEP?=
 =?us-ascii?Q?z/XvBBYkiXrv+8J0Icu1ox/xWTiSy8TxgKcgAo9LFxXlG/5Ad7pJSByb606v?=
 =?us-ascii?Q?2VyxkiGex3CI8YCk/X3yb0Iz0pIr95OmyY8c49/AcUP+TY4LBVj0RmlSaNUP?=
 =?us-ascii?Q?46c0os1fVDQC3/U+S1QZQyybpeWiGNfINkdehNr90Zcwo9+WAmLcdKbEvn4u?=
 =?us-ascii?Q?QTtUMJpXcV8Dp9O2c7x04M+OUA4O23WBivJQpXPrnVNLV5HFHCEOrG6chvR7?=
 =?us-ascii?Q?C1OEnL+EJ72l9D6WpAcXvoiemtb9pmtRmIvBPW7npvGldPJC6T0FBuRY7LfR?=
 =?us-ascii?Q?Vku/dLaz4aI0Ok/YFV26oxmCmODBcvX/llsMD90qADxy+tCaO1ZsJ6mD6ca0?=
 =?us-ascii?Q?VzZpAqzrHrmFY4fkXOP2ygpbpfyrovmpu1pi3frlIdGKLWovZq0EPlCWCIkG?=
 =?us-ascii?Q?LajQnjWUYof7YoKxb53S4XztNRHvwPG2cN8v2tGiwlZ0I5tUHAeAA/lqIDMO?=
 =?us-ascii?Q?BW0xI6FgJXPULB6bnqPwsQMjPB0c8WmygPqCy9MQvWH6B8VDYcMRplSLiGJW?=
 =?us-ascii?Q?px45NVmicXOq6BFXQyeK6Qr7tC2drPkykXIjd2+iiXtnO42vZmPUmgtAi6kZ?=
 =?us-ascii?Q?/nb13QROR/HQlp8QaER6rQjL2XM+wVE25FBrDein956eHEmpR6Z6ZmeOHEen?=
 =?us-ascii?Q?jLcCuw+GTxG+JQUh0aqpzOfvt+7OFbJbeg3DfMuWx1pwMxCPKmjZBaEAClG2?=
 =?us-ascii?Q?NuS+1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 02:44:20.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56402fc0-af03-4bdd-1447-08de5704a5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

Newer AMD CPUs can tag IBS samples that originate from streaming-
store instruction. When the PMU advertises this feature, interpret
IBS_OP_DATA2[8] bit as the streaming store indicator and show
it in the raw dump output.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/amd-sample-raw.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 3e5530008b14..394c061fbeb3 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -22,6 +22,7 @@ static bool zen4_ibs_extensions;
 static bool ldlat_cap;
 static bool dtlb_pgsize_cap;
 static bool rmtsocket_cap;
+static bool strmst_cap;
 
 /*
  * Status fields of IBS_FETCH_CTL and IBS_FETCH_CTL_EXT are valid only if
@@ -166,12 +167,15 @@ static void pr_ibs_op_data2_extended(union ibs_op_data2 reg)
 	};
 	int data_src = (reg.data_src_hi << 3) | reg.data_src_lo;
 	char rmtsocket[sizeof("RmtSocket _ ")] = "";
+	char strmst[sizeof("StrmSt _ ")] = "";
 
 	if (rmtsocket_cap)
 		snprintf(rmtsocket, sizeof(rmtsocket), "RmtSocket %d ", reg.rmt_socket);
+	if (strmst_cap)
+		snprintf(strmst, sizeof(strmst), "StrmSt %d ", reg.strm_st);
 
-	printf("ibs_op_data2:\t%016llx %s%sRmtNode %d%s\n", reg.val,
-		rmtsocket,
+	printf("ibs_op_data2:\t%016llx %s%s%sRmtNode %d%s\n", reg.val,
+		rmtsocket, strmst,
 		(data_src == 1 || data_src == 2 || data_src == 5) ?
 			(reg.cache_hit_st ? "CacheHitSt 1=O-State " : "CacheHitSt 0=M-state ") : "",
 		reg.rmt_node,
@@ -191,12 +195,15 @@ static void pr_ibs_op_data2_default(union ibs_op_data2 reg)
 		" DataSrc 7=Other"
 	};
 	char rmtsocket[sizeof("RmtSocket _ ")] = "";
+	char strmst[sizeof("StrmSt _ ")] = "";
 
 	if (rmtsocket_cap)
 		snprintf(rmtsocket, sizeof(rmtsocket), "RmtSocket %d ", reg.rmt_socket);
+	if (strmst_cap)
+		snprintf(strmst, sizeof(strmst), "StrmSt %d ", reg.strm_st);
 
-	printf("ibs_op_data2:\t%016llx %s%sRmtNode %d%s\n", reg.val,
-	       rmtsocket,
+	printf("ibs_op_data2:\t%016llx %s%s%sRmtNode %d%s\n", reg.val,
+	       rmtsocket, strmst,
 	       reg.data_src_lo == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
 						     : "CacheHitSt 0=M-state ") : "",
 	       reg.rmt_node, data_src_str[reg.data_src_lo]);
@@ -443,6 +450,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 	if (perf_env__find_pmu_cap(env, "ibs_op", "rmtsocket"))
 		rmtsocket_cap = 1;
 
+	if (perf_env__find_pmu_cap(env, "ibs_op", "strmst"))
+		strmst_cap = 1;
+
 	if (ibs_fetch_type || ibs_op_type) {
 		if (!cpu_family)
 			parse_cpuid(env);
-- 
2.43.0

