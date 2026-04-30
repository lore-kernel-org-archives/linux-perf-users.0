Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311021A92F;
	Thu, 30 Apr 2026 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529538; cv=fail; b=RiBKTIptnGfUF/Guh8AuoaccZaVqI7xgar8vhZC4U57mtI65Xl38WTDHRyE32SoCxGVQTrzeYKeSVS8fQlI0BRvM1fqsLLaSVmPsFjAIR9QjCDHtTw49AT43kFZJXTCq+Ci3o0xZrAWJOdTstKD6oR360uYKDuKFyTKe9l9h9QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529538; c=relaxed/simple;
	bh=y4HJ7XR1OOwsiFZqAdyv9c2vklp2+4rHPwrF4493t0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=il2LKDmJ4f3ByVbOpqSIBKblGgSbLjeDC3UhVZxnXKqPnH0H2ELF4xWaH6z4DYtuqzoMi2s2auFS76g8wr+xfFWUWBe45gIwmRqZn6srZTOT4ybtdKWChzTi6nVM5D2hnvqKS/y+YaSChouJbBqcFhek8lizQFcaj2Y+pbXobMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZdKZjr9z; arc=fail smtp.client-ip=40.93.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZdKZjr9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzclsXa8oyQDJ5ww8cNLKSahGEd5Nd2A8tpCaV5m38ktMWO8zMHcgKHEgARoay7lzMBHALLUsqAh6SedYaa9fzNYm2oBguygRNM3hO1TtD/0emedZ8ONzntE9wWVqIrappiYjVKAbegRPIw7Fgh4ybK3h5qYdyzPMHMvHa4Rs7f7kjoMVvLII7JD9Teo/UB1RaYyRO3jiL8DChoY/JW8UqIwVMNzR3THXlWXLlVI5nSZetR9x0q1i0XiDPHM9+mO64BTnrppQJg4MXDJzjVMCSxkzti7wmMUGSEo1nTz7t0UsQSJqb9ZBndEUoHQSmIiSOAHe2+F6MIpR8gmGWO0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9XPA7Fg8TSP5/Nu2GF6EjMIUAOG+gQ5+QBv3xUiVow=;
 b=fcKtzNkr/lbBQFFK7ZjYIulbzp0hOMmXXkxLc4ytKIMxOVA+7mTa97uJ31hLDD6q4OqvtHr/YAElX1TPX3DzFwl3/8wmTnTSveGZQqG8bNQe8zO2moUGrQnHE8iBNF+w1fnBQF4z9vmyHN9o9bome3HZzT9s/SQXmL7V42DgF3WTypg0sw9m01wGPdwLPn54/iUr73dSj0PlmOpAEEW8GOvrKdZbkGOBcn0kLczpArqhd/7EPQanra6xNg4V5rctRrIE7jASPgUsrT4xcUczK07XFKq1lf9/QtJRdBRTmWJspM1wTR23rdvQFmMUD0Ay0ANuebUAq1JcwVpE9edg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9XPA7Fg8TSP5/Nu2GF6EjMIUAOG+gQ5+QBv3xUiVow=;
 b=ZdKZjr9zsiVVuT0/nfqQf6MKn09tuD+1TUKB0W8xmj8GMCbBsSMszcYgNrRmMXoo27XFCvu/naAH5mk5qWLc6fX2OnJpveUQeeCSs9WX0lONLMptj9Yfjx5E6OkUbX5OFz9MnprdWfwx7Q43EGibkurWdY6c0e6qXTOK8pipskw=
Received: from CY5PR19CA0032.namprd19.prod.outlook.com (2603:10b6:930:1a::12)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:12:09 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::81) by CY5PR19CA0032.outlook.office365.com
 (2603:10b6:930:1a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:12:09 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:12:04 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 7/8] perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
Date: Thu, 30 Apr 2026 06:11:14 +0000
Message-ID: <20260430061115.10266-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430061115.10266-1-ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SN7PR12MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: cafe854f-f2ec-4277-2b59-08dea67f6972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	T7n0tbN7nWmMIok96F1REKNCuqzwDb/Cg0hXAjUdWrlGSU/r1MMjXrJJ++pQWgM3XoCw6jmKZkZMpN1lygeJ4OzmknjjbKBRZfOYX5FLE3mOp1f8D0372VcNGJDdjdS3qpOaGglGAZwVP/wvPparkojartagN9uFDRouzJ+L5rIWrOTeUx3AdLOJQn/VxpDwJL+02QuOELp1BN9trow+uxNrgMp5lwW3sc+DAiMrdCG1uCVVAgTQByFE1p+A661phJmy3+2fthjjRQocLOXcFgtT/mZcOGm3aKCsIIszLEr2nP+gwxpA/xwwD3cyZR1GO3rgp1XQvI8R2AdHDW1WO6OP35b4eNFQRzAh8tFiTOlgt9yAU5yqCkm9A83aHzdI3T1SYGMJi8gyy7ZqHDlxYPgF/npceyAAyi0j1c/Sp76T3BrMIzwnpgtnpkUbQ3mVhZzUi7zb8fb5XjEIiL0dlT7DPjfgkRneg/TUSa4ZGARSAcjhAfNfCwuPF/7Zff25j5QyhHWGim24oej69Bu1XomFUdJJCI/P62MuaZRwiEfVE72iUY0F8vxq/3BvQL+SVWnjYYuAsbIYe+Ee1POmRsvcWn2fOxrkJsPlmePkRyp1bC46GG4QJD5FZOwhO3BgiGwH8rANdyEJ13aMLLV6Sc5Nzd+FNgtiO4DgSVeaxBSs9xNfhF2SjZ2Xx0UwBIiGdD6dRoCwSibvu/L8FMpgtGR8twJUWWfbvlc59Ru2CDmOfgj6pPJeZ4zUqolZVF3YtGK+d/PlMFKHbPsEgxqWsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KfpYXTZ4bB7vfX5p6AucFdU9sp3EoSK6jzIQXV7nn1IAT0O4ZfDw6TMLJjwhzFbOYbL36LL6i9jMRxsJo+NELGCmARKMznJniYvcbAUnl28k0er9GMcITvDSevFctBe7uD1nbaOIwNz1KPC0u99BYfsrj8jCKsGPRfjef5fE+nadUgj8ez6E8btmKs1DWFUWvBLeIUjP4YpiocMylzLE0D4d1rLRfMyS9nA7RyTvRHTblDOsybe1J5O+3Njb88CmxUndN2y1C2HbWnMIj6c/ao++1HaWLFIEDBjfTSAVHgAXv3sAcmJElugBEU+DMP7PtqAcbb4bu4H+FiWmbF31WjbGRiVvsU9TkX93S2/yp1g4+c4FhbrIJqUztXc77xpVqdyvczQK0aa0Tdj8DnVpLg4BXQ9ouAGEBWqPx0I1YVOiVRhbKG/aw3OULXNk8z7h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:12:09.2680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafe854f-f2ec-4277-2b59-08dea67f6972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434

IBS OP on Zen6 and future platform can tag IBS samples that originate from
streaming-store instruction. When the PMU advertises this feature,
interpret IBS_OP_DATA2[8] bit as the streaming store indicator and show
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

