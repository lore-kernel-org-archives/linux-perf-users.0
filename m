Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E66375AD0;
	Thu, 30 Apr 2026 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529531; cv=fail; b=k0j4SUUN7Mp79FWB1Kiqj74nzz33MuvGK7Ko6E//5/EOzOU/+4TQPK9qaYxyoe8P15iGeODHJwYq2GO7DBelfSppXqAXF49X8wTSKtJUtzFZ2xfPLZXt50mXhiVzFQtq/YEEF3eTrZ+zVH39zv8CqQC4kfEEuEvuPDlO2iCIAwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529531; c=relaxed/simple;
	bh=gpaHX3uBGUnIlsMEtjQg7z0JRNqirlSRGAzIMIfEUmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCGXa/J48872jQm8BjS8fOo/MTPHFeYzxFySpY8w1Y+FpFqQIrOSu9Bayg1/TvefdyhN1VDgLq9MzoWgr3fieHn1gkxGFhtbmVlCdw13WYZ8+C7fQoKLp267skpmJzGIRwkXfkq6HpWjMupdKrzdt8eH2OzW0kgnckTNttulHTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zwTTVDW+; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zwTTVDW+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyAMjMNwOQZG8UWtzqxLR0nBeCja1F4QOSPQ9ectOQLAgSM2fH8GGOV/RiayO1tffJJ3EJ6ebErNdI3FCkD9OME7PkxQfqIHZlJjItiYhmNJ4USBVjwKOYpVM6by01pRUW+roRbFHox7xHNfQW1SnoQxwXWscvyyxtNSbRkfv7P0a7BsXyqlDzucUL7KJenYktb/Wb70zUB7hkrApAMvayEaTvLdaClN8Cc0O5UPaV3YRbdGXBN1GK++10V3nfZNo8kHzF34klkqMW0gcK/G8jk8r3FPZc3yAqWnOQR3qG7sr9JEJ9wmQ6U8SPR6VvmbmqV+DT3QPo/Mzw7Ls/KsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zv/TmagJhhDTV88r+UEsoTaW1MMwXerxOXc+oqRhaNc=;
 b=QsQSMNrJQ+r7fsrklIC+2dWjKYdLU9uHHfl+X5zGBsfXVAEvSTaMqcpWFbDTMbxiR+gLZ2YUOwSLWmLn9FXRL90yJ3TdqVw5L/49ig7Oub0F3DjLzh6j8qVsm6NpbATMd1fUMFfvtTGXTMb4NhXNWLidTeagvzvc240aT9pUolmu4DISQOZXTSBFwZ5TNbowjg1v7NlF1JBpCyON+zaOh/XOG+vGKf1RfEh7DXKlGQ5Xmc2S5o2u5U9MDPu4HjNAD3XZRwwfB52rpgbXQm3Uf3vxseyuxbQbkOYpNensFGt/ekYnMLvPWJrSvkOwjZfimwaUrxsoSQp7up3FdbASvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv/TmagJhhDTV88r+UEsoTaW1MMwXerxOXc+oqRhaNc=;
 b=zwTTVDW+EAgydoIkRTZaAnUG54/SnuPyJ8ZBwRgLpruK7wFxNZ3Tpb6uu5MVkkECicfszf5JiE02EvgbKzSVhGqBh5oKQkt45t+rDgpiUOlIblFj2px6MxhOyWb8V2L8wHpL5pP2oFGHx6JGTpQuLX1kAJ9Q9i/BG4l8MzkMVuQ=
Received: from PH8PR20CA0012.namprd20.prod.outlook.com (2603:10b6:510:23c::10)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:12:05 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::dc) by PH8PR20CA0012.outlook.office365.com
 (2603:10b6:510:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:12:04 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:11:59 -0500
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
Subject: [PATCH v2 6/8] perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
Date: Thu, 30 Apr 2026 06:11:13 +0000
Message-ID: <20260430061115.10266-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a38a9c-8dc8-4db0-5e49-08dea67f66e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I4RnFc3vUo/XpiS+0NpUlgOWcouBuJKlBZpd8eXjRk0k5rXGfIkvGrOuoX7XAc17fOtxb0nrMkyrisYA7EKflCJh4OuoUB9Lh39BTQAWqD1875owGm1Eg99W4IGIJghcCcCqmf1Um6XvnK69mWjw6B/0Xo0Ec/AFOnYHVXMfIkjZpN5oYSWqs6fy4H3AGMo+jMp4+pte9AQcvSSLnteAohO0ACoVwjaKY9bPLh7R1Zf8TRJd/VyGLaUZrjRGz25xSUmLDmuGrjsD8U0WfoaL+L/jVtSWf/3q/IAwBYIGheWLJObYiS1u19ONvYKY31kqs8Xum9wtxz4lqYt4kjG6WisbUnttOHCDaUGrVmNwrksFYZ/zP9pAvuQUJMUKgRyKqNLHpaAzSEuYfoCXZ2pCOwiy4J/mRlDEL2xm/DWPRYY9b//yyEyAdT5uqGI56OBhzietyiK6XjM1Ih6qR84Wacpv8JCzaGw6rdZwpQeKEY9TTAQ9eysngLWNd5OKR5eeQUOEEzczJWmOLlY4G2BPiALrcQZS2/gMDeaHh6dh9SHPrBAIH6HGxskwQmOSyV6d9tcyAtkxB/SEE+FLLdOwWFZMQMVorXoq2u9HSvhPfYCOyS32e+1vW5+yb96t6a4weD0LE5Q57eicPIvBzVX5b36YgoaAbKB05gxsH1LAG6ytFVq3M4pLhFQYeNKiZ/NjluXrARiNt3ZUeA+/mEErftyOhIccz0s2lLb1u8gexqLt71Hq7vmI9a0tXnyw7wWN5ImnY63yEwj3lsOP+B9Urg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TVPaaMl1JgA4gWICjpRY+elqjZCvDmcLTOp4EU+YMcWjbxe9z6huGf17tNf0m44qyRM0xlw3EbmWRZbtGR2H2fcqS8pNMGqya6jkVKFx4Ysg0YzNEBUcHUrBQNADENkcT9zOerO128wV0vxVAL7XL46wjBtfgumqYixw7vWZbAzHfHWLv4AnWSPiqFx1jzsQrTGgLpLKpE7xLKrVFhMhD8iOJl39rYecL6Ai8z2mRh2w2y4pSzkdfkkOFIK0wunALtvsP8Tux2ReVxQYH6E3t703g5Xfv6biOMvPoG+IYW+OZCtvrBlJ35m6cNnuLd65DdosGi3F56ARIa3qHQDO5Uk3y/WCLwTjmZYwUVUP6ycn6pIWbWv95ajTPtv1T4+f7sF3moGEBPswUb/dqNnuojJD7T/YWUrgGj/bmOGjqh+olpoN1ZQaOCQOWt6f7A7p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:12:04.9984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a38a9c-8dc8-4db0-5e49-08dea67f66e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

IBS OP on Zen6 and future platform can mark a data source as coming from
a remote socket. When the PMU advertises this feature, interpret
IBS_OP_DATA2[9] bit as the Remote-Socket indicator and show it in the
raw dump output.

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

