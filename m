Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6B223339;
	Wed,  5 Feb 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735606; cv=fail; b=tfHAA1DCqLiCP2wjRIeFhc9bOO/XkqQ/LmH3oDjPM1ltbL18Di72izWYE5yASVnJKBW9C4T523zHaNMmNixZnIG1jXUAJyemoiLayqLMh1G7YPUGJi5eFHiOfO+WMeVG4XetnqZ/8StnNvjBuSMlpdXOza+JckU8VKGu1/S+vuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735606; c=relaxed/simple;
	bh=Glp+NTrVrjz69E7ID8NKNOhdRLnwqMvd7kGsouV6spA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs8DahM26EA5bUdW5OcuLXc8yQmXISyMA/l+8+dBtjLUchvYYpEHxeHnJKo4dMA6ybqs2JzykbeENKIrgv5J2Lr7quciHCWTIRriFTrqeGkSrYsOMK+ruy3BWJQpxq/79aFO4qVI3uTfHH11II70NiiPAoSSHl6Xqx/pMGU4ksQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pE+L4BLQ; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pE+L4BLQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB92HSa7GmpYsmKRexPwbydcDUPrcUKbCOA6i6CFRrWEDa9/LEbwnxPNL/8H20KO+QLmXlcP5mUIBEgsyV9XyaeKLHpozMU+FyzebTZ82N+kK6rmNbo61eHl4kCfkzTsIqDwcYKtBFjDoBJYKwe/injnxgo558ApXRVarz9O/lV5L5wiXplxld3jpOoxl2N2bkOoJYOHCkrhYokxUDb7VhQSXqVwdVeGw5YD5Dp6HYcBkn2GyJGJmX8ASOHMYShTqLhPbwN5EKm26yTk8rIervK1XvpNz0WxQavruv4woKzWMgnC7EyrPdUiFr7Cth5Xad9HhtFUQMcm05xvy/Jw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZJKQdzsXhc4h5/H42TwHke+LKvW80blz8uLEdZiC4U=;
 b=rPQXhYforDgX4jEPY2RuVust2LRcfaN9ho6VCuda7RQraAbD2uWLvFwedjOdC+4ZD6GJ2izNhOVni6oy6IxQS6tPxPXrK2+oxad6YDwN1aOfCXNLWorXRtQhuH7p+uoqMejjTwl8UeBf7gVNOjqRWzF16mPYUv6hv7L1BkZIUphEHERCIjQEMM2LSnjXT8rlMWi6FIUHXHw+Xy368/7dlOaOeKu0WybJnYCtyFwYAR+YvD+SW6g0IFim9Il8Wi9q4XXjVL3HGqg2lI6vslqNYFc4eBQtxiBct5DZ88rFJMvi9LNcyrCiNpPSvstS6w1EJpe63pnC7vRAUOdNJ+j71g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZJKQdzsXhc4h5/H42TwHke+LKvW80blz8uLEdZiC4U=;
 b=pE+L4BLQUBT9z/LhIc5UVdb8X8ulUe1Ub2oMy+ryhiVSqey+sZ4Visuh39ovMF0gthEvmCwo1uA2NaYyqFrc6i5VfhuBw0mZHDc8nQoq2GFa9nfDelrLSR4keZC+LTBlvG+kuoSI8m0JpbXKnrx2ixkkB4H673q1SI0M436Bl0s=
Received: from BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34) by
 SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 06:06:41 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::ec) by BYAPR01CA0021.outlook.office365.com
 (2603:10b6:a02:80::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 06:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 06:06:38 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 00:06:32 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <jolsa@kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 4/7] perf amd ibs: Add Load Latency bits in raw dump
Date: Wed, 5 Feb 2025 06:05:44 +0000
Message-ID: <20250205060547.1337-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205060547.1337-1-ravi.bangoria@amd.com>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: c10d880d-0f75-4082-6488-08dd45ab40c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EaaXK4OZuJ4azzLwFhaE8tJuVGqomuAikNUmnN1amxu1/TGYlHhdvKgUSMHI?=
 =?us-ascii?Q?g0c2g3wE4Ks/vNBsdhuWv0r6905vmBzeu5l5NmFvmzVO2QDHXgqLeQiZ2Ffu?=
 =?us-ascii?Q?w7Gy/Egcgwf2vZLKiRdKHrht2vVrGz76hlWdH46bf1j6yzZmoSIMJgRU3Arw?=
 =?us-ascii?Q?U0dgpz4nfVndHLx/u3ZtZn4IXFbkgiwnLL4sBJKqCX0p7XZEVBsXc2iE5TWC?=
 =?us-ascii?Q?Ct8qosOb+wxuQITz+F47g0WnK4LbDrVfl1WSQa+KfTSOYslbjh2A9MnISAVv?=
 =?us-ascii?Q?3v+I0UE6yw4ffUF5S9sdNMy/NnmOz+PaUWA/pvUTWiEUsKCELRvLHL4eob4o?=
 =?us-ascii?Q?Gr1vWEoGAlIqza7fu0WrtrbBjyR7gMjgpUHAiD/T9J6dJHIhfMxcix0D6ztV?=
 =?us-ascii?Q?Sxd/ScykIk2mojwOLOwtPMlfHK1vemB8IXDMwAo+yEksOBhfaJUiuK/ssOlq?=
 =?us-ascii?Q?tOtrkGyTwibvkE1VcU9UiXQxNRQYj7ull4bSrBrfFH44+0MuixenjJUAut96?=
 =?us-ascii?Q?RYeoBXEDRjENIKvfwy4y2FVZ6vxBNrdWekuq87sFvNP1Z7Q7OdvBy2orwNlP?=
 =?us-ascii?Q?Wli+4z6m/lNITNyOCP6kSK6HedjaBwlegBbYe36/hH8LlVYUWNKiLPdMp72z?=
 =?us-ascii?Q?6tO9B6Jg7ISik37SdafjkLtvQOr7gnqP7bL5XZs2FoQPGXyrPKj6cIL4aMM7?=
 =?us-ascii?Q?lAxx3XsZ8S26mn+gLNi+eWKYakGjTfZ94Uk/h0rGsKSJOZvI5p1ofap8mEb5?=
 =?us-ascii?Q?n0/7PYJqaQrN/ElR1cPGxBBVm/ujyMf8YPzbr4UxtPRbzLPPUmq4lR/V0KsH?=
 =?us-ascii?Q?L2hdc1pcj5txg9I+KkcTg0AHDi6BNyjKgjcIh/WSmFXepcYLPuvVEvFAd4un?=
 =?us-ascii?Q?+9B87py0fP64RDfuRWUKFYiKpH1RTarF8d9krf4yynjUy9JlfckrNRjBDOgl?=
 =?us-ascii?Q?pOagG7lLOoDlhku7xRKK641RCdnrLPWyEI5hSDkrPT95HiJ6xKbr6Vb9vZ55?=
 =?us-ascii?Q?5SXJE3FwvdVzuZnidxHGhBG42C5CFF9GwZ4rcdSAVdxvNKSyUpUsR9gS2cW/?=
 =?us-ascii?Q?q0pSoMsECB5tactA2zow3LMcS0lZ+3h+zQe5J6NQJFSIHeHbkX7TNFBAg+Pf?=
 =?us-ascii?Q?V4z95szZRp4ayZdBwLf4ACXF76+rHZ6j01ddz2S5hIIG8wPwFInEnOuRI7NS?=
 =?us-ascii?Q?/q+6UfrJe7xqo02VqwsTPT2F9vxxLyz2bL5RHAbxLNXJ4+CY4LuQRHN/6yti?=
 =?us-ascii?Q?w1YS97IIgl01bCPLSkY8Bua3tfd/QVeqcB3aVcOx/aMrtHZZtu0BqCdaFv7D?=
 =?us-ascii?Q?gX4opZLRpqHMbvkkQIuhzeS/hCZvwxFCr21pHdbMAKFEWRXmEQVP/C7woOf7?=
 =?us-ascii?Q?HFHyzqbG9v1YqXBxPXNLJ023YTSP44bPhXZJuTW8dKeV6kg91UGMDXL9UNzS?=
 =?us-ascii?Q?XWOCoAumG3c9Dfv6qQdNZmlE9JQIPQwuXfoANzDgWg8V+iAxNj9X30A/Ty/T?=
 =?us-ascii?Q?oWVc/qfkquceEK8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:06:38.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10d880d-0f75-4082-6488-08dd45ab40c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

IBS OP PMU on Zen5 supports Load Latency filtering. Decode and dump Load
Latency filtering related bits into perf script raw dump.

Also add oneliner example in the perf-amd-ibs man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-amd-ibs.txt |  9 +++++++++
 tools/perf/util/amd-sample-raw.c          | 14 ++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
index 2fd31d9d7b71..55f80beae037 100644
--- a/tools/perf/Documentation/perf-amd-ibs.txt
+++ b/tools/perf/Documentation/perf-amd-ibs.txt
@@ -85,6 +85,15 @@ System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Zen4 onwar
 
 	# perf record -e ibs_op/cnt_ctl=1,l3missonly=1/ -c 100000 -a
 
+System-wide profile, cycles event, sampling period: 100000, LdLat filtering (Zen5
+onward)
+
+	# perf record -e ibs_op/ldlat=128/ -c 100000 -a
+
+	Supported load latency threshold values are 128 to 2048 (both inclusive).
+	Latency value which is a multiple of 128 incurs a little less profiling
+	overhead compared to other values.
+
 Per process(upstream v6.2 onward), uOps event, sampling period: 100000
 
 	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 9d0ce88e90e4..ac34b18ccc0c 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -19,6 +19,7 @@
 
 static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
 static bool zen4_ibs_extensions;
+static bool ldlat_cap;
 
 static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 {
@@ -78,14 +79,20 @@ static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
 static void pr_ibs_op_ctl(union ibs_op_ctl reg)
 {
 	char l3_miss_only[sizeof(" L3MissOnly _")] = "";
+	char ldlat[sizeof(" LdLatThrsh __ LdLatEn _")] = "";
 
 	if (zen4_ibs_extensions)
 		snprintf(l3_miss_only, sizeof(l3_miss_only), " L3MissOnly %d", reg.l3_miss_only);
 
-	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d\n",
+	if (ldlat_cap) {
+		snprintf(ldlat, sizeof(ldlat), " LdLatThrsh %2d LdLatEn %d",
+			 reg.ldlat_thrsh, reg.ldlat_en);
+	}
+
+	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d%s\n",
 		reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, l3_miss_only,
 		reg.op_en, reg.op_val, reg.cnt_ctl,
-		reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
+		reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt, ldlat);
 }
 
 static void pr_ibs_op_data(union ibs_op_data reg)
@@ -331,6 +338,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 	if (perf_env__find_pmu_cap(env, "ibs_op", "zen4_ibs_extensions"))
 		zen4_ibs_extensions = 1;
 
+	if (perf_env__find_pmu_cap(env, "ibs_op", "ldlat"))
+		ldlat_cap = 1;
+
 	if (ibs_fetch_type || ibs_op_type) {
 		if (!cpu_family)
 			parse_cpuid(env);
-- 
2.43.0

