Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7E377EA1;
	Fri,  8 May 2026 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220068; cv=fail; b=f+eUjQEhSk2KKMbrlTNNHsSlIhU94vjGPSoIjxGkjKMIXw/qZFCQun1ellG3ljB8TcWidmRkPXA5RgCS9AWLypnqGw3djIz4dHFz/BSESV9UV8wKlyS3wTvWte1pT1NhSVT/PZoKDnfrGSru3K1hncZBU1obSYZrnwcJ9VIvqC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220068; c=relaxed/simple;
	bh=gpaHX3uBGUnIlsMEtjQg7z0JRNqirlSRGAzIMIfEUmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8wRrKi0PnlN1JaI+tNpyi31SYXcSnisg3TKh1u5NtOKWDd+YtpSypkIMUWBsyXGCMNi7lp2ECqNZWFZZiKrVhzJZZbvweryNoYv7vOu7GLcpoUHw+j8MvdYs9ZsYccFiAiZsw/oe66WktuArl0YnPHEDKBBjHg0vv4VhSRDgpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XrBraI2J; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XrBraI2J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAIVuW2Aco365y+gFjT4Jnti+J7Abv2VoO3Ofc+z4+fhxO9rHm6ZGrt+h+pih82x3OQl2vugtVuVdgbf33XGiWCQU1yb2j34rmLdv/C5S1vmiwrpIkbMxqOoJvUz269Gz2G9MlZYZkRJaKE58U7KCdcxCVJdRNFsfQer+xmyQKKMimzH9C6NHuHSiZdOW+QSKCfktwiM/vVDFsQ2OV/oysKLEUCf9q0U6Kjl11FoJDJiN/fHj9xWbXkYs9FyXI4IZD6P20c69LjgJeDz58rmRl0AqqKFdjPymIUQ2dhuaGKfWFFuj8NP9B+Ll4/Ro2Lz/PonxBVe74h0Jr7YggXbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zv/TmagJhhDTV88r+UEsoTaW1MMwXerxOXc+oqRhaNc=;
 b=yJX0SCFnNdD5IkjDNEUTk0VxBra1ixkxful9PAClPNDGpd5zp/2e0lDdaPyyxCNKap3ZScHtx4VqEobxcpAGuxDPtNO2vjNK0nk57Mk1tNtPV22MnLwgXzfP+vaMfBZy7HAKi/kbwzAC+bLYExFcl3HdJ7+mLI2mDhdyhOSaddCWitTd+ksEyQkFrwZyn0hW8PXCUEPIs2GWm6Fyr9GIkc0srxSgHLUjAtyJaIfzlMi0cXqAyG29T8kov3wTg8waoU15nMbwuMNxVSOUJzp4onIsakhy66TkTdE5BeHt4w84tGBRTWBzQm5yxiyozhSEOfQFGxbI/PCpSxUgAC/YBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zv/TmagJhhDTV88r+UEsoTaW1MMwXerxOXc+oqRhaNc=;
 b=XrBraI2JNxUibkheHGGXVcL2vDMC4oHTrwqxDwAHLr1qugscaSsDbt+1GO30AXto3CxKRbAtyNblgir00jIEbyye5AFbnYaaVck54ZCJuSlsqct0gHPxmM03mT3am8+ma4inH0rugnG2lD1hvmd0881e0QmhK9zumWRag3m1pjY=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 06:00:48 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::1f) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Fri, 8
 May 2026 06:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:00:48 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 01:00:43 -0500
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
Subject: [PATCH v3 6/8] perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
Date: Fri, 8 May 2026 06:00:02 +0000
Message-ID: <20260508060004.2575-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cea94b5-b326-4bfd-81ee-08deacc7270f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	OZi94u2vepixsX8tcTGpafvTLgqHMORjsdPM/0zcBzLjvm8yRrsqdd1TEm6PYaEm7Zbh6fFMXVLqnmFDAFIam9ItWyprS5ysmZEepfqZRThUjvRR4j5CypCGPkL6UFJsYvC/ysSLKTddfaGNnR21oGrX7lQzG6+IQdngh+chb3zi+vupC3/9Bl39jwAIVyde+5hBQlZ+Ew+ubFSbmdVU1CEdzMTwhH09Y2qYfoxQLQpmOiur82561wejUMVlusbnRdUu0+AyiJ6zg399jntnU1CmZ00TwFUMkmVXR+m6fhBSRdqQ90Og2YOsdw19PYEdgPzyIb6y7r4cljorkJ29L/SmUZB486wvstJpXhjGtlKo+/ZI65CqbTMDmB+QW0TFW2YSo9UJgVEDiSPWIQ3PFujR1jwA29I/ad9LBttWzmuL/hcfk6sMk8A4yDE05xIcAH+qVYr8Pa4HXgxSfhmXZ/ISwgFn3keTseYRjGHlhCLCVX35ifaDt43tqkqQ3uOWgpJRPl6Kj/gFEA3kWYwt7IN6bJ/BDgjLPsxLXSou0EynKqhGnis+jgQxlJkdLLNmjdmFvr7TQzQlWyuYj1T88SSUjVI/VcW19/6ZTwtoDh52KTwC78K8TeKtqQ/iCEpzV5BGbTOkfuMV1/TMcfP65zoWIz5JYBUZPUReXp+FmQyhEJqhbpeaVFE1sqeDc9U1TuUvaecP5b3CwcEke1kswTgSlRq600yE1wvs0UwwnP8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	psmhLsGfGgqnxlyfFfAQsjoSB3KCzQEcaLLSIMhAWaCJChaJW5frXtlbj2iSYRttS5eOnshx3A6kECP75030MoLmQmHIz6tCgeqHjTJsjwQghgdkiJpMNPnvOCALpQDKkn5EeBm5smhkKNqVA6ufGzMJzarzvlfAgmL/MHUTs7ZE3GhDyZ/hCsykegM7evz20NZhvjqF8pW0bhiQyJEjLHvKs5pOw2QAQCmP/K3dqd5wzbJuBgH0R2IFn5VIwpxrf9rez2PwQyacx3NGmg1Y07kvdhyu6EmRPOjjMqUfOysVAyeJ+QlPa+pzuJBFZwPRe33tpZtyYWko2MyHSKs2tRTYjrj5RVpYBUCB5T5sgp2A27NUBpG1p5I2lEoPVnpRS0aX2bC4++U1mhuX9cIZAoZ5m+26LwdZ0gV8NgF224nAP6pelEHhS8C5LbzheRhe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:00:48.5577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cea94b5-b326-4bfd-81ee-08deacc7270f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096

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

