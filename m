Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129834C98C;
	Fri,  8 May 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220078; cv=fail; b=F6gzZdfWmJE1xAoH3wolChHQaIJNVTN7oqZUMhdwd5S24eGjHbQGQcBaBSLJCBE+TICRBqjIIlBfOdYI0m+TP1DuXKrfYAc+p9g0q/UuUKjnDXR6jsSe0h6rw78wWzt0UlQtVqVVtRGC1N89BHo1Xseo6IdFLAeWr6Pmt2xcTcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220078; c=relaxed/simple;
	bh=y4HJ7XR1OOwsiFZqAdyv9c2vklp2+4rHPwrF4493t0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgIbKYHGv664y3HCTWQZoFQOp3B+/LnO5kUgfGr7kTMmxpDtt09fkY8c/n1Sa+I4q53cTZHuvUmlNMFAC1HMMmcSlW0kmQ1Ib6FuIRQicXoffmAWXG0TGWcmkrrL8N6c2N4+k7NamLXJ4+gRPILpiE9RSKXi4w4H1nQTt6H8LgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DHWCID1R; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DHWCID1R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuimp6v0TAjjGJjLQGLckrGUWsDJnM3g7pgmMiivSzo9NbnxcqaDIU2HwBj5Ee8ywTuFDFrD12dXYlK4cNjyBfdVKhdtTCQdDAB7+S/TTAQ7LuMXHvWBuxGnn64rSwrAB00379dTvwi4azPCbMKnEmRuoFMpzk7tOmbF2fAA33MVAnoM/29v+95umq+HRfMX7IB4x493b+kYWR++WN60DDaA+kVnIo5aiK0h7Vbf9pxFZLvz+PL6rgvWhBI0Ud+LRJ6B47vMcnz8iTfNXv2j8J1EGFOROM1thEUP3mRxSb+HBq6DLIQUC2i49HWRXY5UdM+r8ryftFGZP3bnQj39cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9XPA7Fg8TSP5/Nu2GF6EjMIUAOG+gQ5+QBv3xUiVow=;
 b=oBJzpuxRplAR3zO+P9avcsnBeibzK3czwzZKA5BjZ1sGTyHzoyKY50iKocLxj3/z8Iim3d1ZaOgDk5AK4KSR8arsPmSM4c06iIYMytZAeGS/67IpY6DH2/IP8j4XMhHuNol2lp8ykJlbRv0KtkmA8zpWNYdKiBVlfgbDlOYQmbJoUcUJTGQMkLL7z7hCsFRL6iKx+WXi2wXJ3ELuvfdLGAH4HaAa0qQViyMmaDA8W4tVRl+Nu9ZOZCAvoUDD6bqJ8mKgeTpEaNiLhBdorbAdZZEdd0g67CRODm8FJxuq1CtwrJCplvJ5B4Jg0gZjRsFLXNza0Ap1iqDlFoTlN/GFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9XPA7Fg8TSP5/Nu2GF6EjMIUAOG+gQ5+QBv3xUiVow=;
 b=DHWCID1R8Hrj1jFN1D4PBcke+4mTS8GZT2MgjAO46USnA1FyOWz4Wn0izL9hT0AsKUfVYfNR/2MTzH+4vEKMVVlGUmYI0RFhs5IuS2VW/pFM2V23jLatM4egBhi6L7h2Dg+f9s9pXq/J8JAwY9qB+UuBBgPEijxx26CK2d6Xk3Y=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:00:53 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::9c) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.12 via Frontend Transport; Fri, 8
 May 2026 06:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:52 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:48 -0500
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
Subject: [PATCH v3 7/8] perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
Date: Fri, 8 May 2026 06:00:03 +0000
Message-ID: <20260508060004.2575-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508060004.2575-1-ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: ef572e98-289d-4654-d69d-08deacc72994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	9lIXutwXQ5sY0O+4d7U6Y/b17a9MMf59kYKuVlHOUx7xc8x7A1lkZIk8yBcnqDfOvmEsdfeSb7dvo0AO58644DgMuWFzvFyDC80aX0d6ckO3/EXvHYQ8PcmngFfH9qhhfyAzP2AVoou1kzsFVijFCIGqRbUU1GvxkJsR9ji7VxZIDQIh8jA41Nkk110LsqmdXBqTo0/3wwM/IVyVBhLAIARCCpI+STfodxbdiFXLbjlDAiM2Nev/ubw6zZNQ4zeBtfZG4ki0hD03QoYQgRG/fqPg7ZasE3C9SfF+w10Vvk+JbRXiN1t3tTkiBRf54XEYYPnK9CruaaZ9QMEET56EF/scjqGU+u93zgW5UHGv6yiCIcq+j0cffbJ0KbJL5JBEz833/POf1buMbwHzBHbGD6gmIYsLw9CgcJo2CtUj4meAW+65K20ZlhflLJGwD/QON4Msf/ZMDS6/HrswNLQV5lGIkeCQfG3gtK/xJ0kcpwBpAUDM+sBbnrVPlyi14l6j7V38GNxu9j6Jq8vUesKHTEKIAeBnKQj9+jvfUZz9SGnKChAxt+9EWeTml+3yvwa/c154JijU5MSCTWv7PsrsVRzbmdncc26aDa6DebWAOb2fBkRX/Mage9h+qAjs/kDSi78sFnAGxYL7ojC14HzRXb1JG1SkOG/kCxD618IqQzM4lpEIMgDMvQvkVuL/BkGBKSjEX2qTmsN1ZcksMMRWK9tL68y5SeciZEqyaRE7MSM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ce/UdHXor0cV1UUAXzNYaVWFe3QJ+7y8IC5c3QzfVX7vh5FvNL77pxjNmw/DgUpH3rrSyVROiG4/djTbo+9sbg4SlSS4SNpPPa/juzjmE4Ajc/ELK/naE8DsAbGPeOtzwIgZfxH8AElickPRrbZoGvMG723A2cB6XC6JTFbgZh8NcxzKM3VUZ3N09Qg9WSyqu5d301ZtJvIizE4jm2KjSvA+j/lE+85V68b8yVr+6GYxz2Yfgpy8YZP+5m4N1ETQ9mW0bf5ZqWhgXQ876vZyvnel2XTI2PYDmPEOywS2aiB7eZYy9yNmyy6BU2MnkjIL3GLwV0Mw/Ia0Nx6pOesq3PdVsKYgHkcMuzOYTvIXICQ0JWdWuS3zTy9ChxYQZiZJcA4b4SLLoXjGIWyIpjuswClvFuDnDFUXZuI3my5XRaOEc7s2WP0sMbEeXBPnw5DB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:52.7875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef572e98-289d-4654-d69d-08deacc72994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

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

