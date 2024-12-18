Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747E1B4255;
	Wed, 18 Dec 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524291; cv=fail; b=kX/sXMJF8r19+K6K3Kn3Dyuho828Q1Bx9JkTjKuq+0UB+CdpvNVqCNJ7uEDppD6JUJWhEwH4WnayErYrFXk+/Pvee7gmxZxyli2Qqqht3QUGe6k32MepF90og6Ia5jvyrR8saE5ac3dRrJP733PQfszJ7J1Z2G/YZvRQNgjhr9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524291; c=relaxed/simple;
	bh=Glp+NTrVrjz69E7ID8NKNOhdRLnwqMvd7kGsouV6spA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipfC3tj0wgjy0AicWZCYv9hoE5desuRq0QHWAVDSF0/FhEIBT5WekaVw3u+dyqLhO5sVTHKZM1BIkQ/0Z5KMZrIR/sic0iQMQV9BLMcCICkPV3d0sR3A42GIlD3Lx8nP2ZTDMYVHyftUxmThlvsSt3nOLxb+qCc1IqIojEHnsc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dfR9Wun+; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dfR9Wun+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVoqy+7SSGJxQqQwKbTikziHa+GuaZYv6r0LUww3KXex0i9bA3Uf5hfp3Vbjp8wD1oLDtqdfz9XjKYgpm0WNCVL5ZTMcLAlahxARfCcW2Og7y9n3c4Uw+/gIBRqOrUsSbJxWQS93CyULm6LNKHyqvvDxMmy/4qj+WWwIswjv832QdPdPoLft4q+qCrgvxWKU/fb4jlcc/5TBk2o+gncL0rprXXVja0ztw1xX0d1TDtiux0cEHurtQMQSFIh/bZDd4vy908MeOvj6bk1AFhrL0hAispg/XgOWAJxltd3kcIOifwnpKYiv9WssVjNUmIy5IEqxyTjnAkyj0aBARCntkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZJKQdzsXhc4h5/H42TwHke+LKvW80blz8uLEdZiC4U=;
 b=J3GpUOMv6vv6lxJC7a28tVhNIXcIWaG399uKKF7tJcpdgR9AbnGxSIpjL+qPUN6MA/dEP5DZ+g+qdFVCeOkAkBr098QDDjtEyeoEjpfqPnixZHnv6AEkDL4A87vs7KE/N9esAZEpte/sItr+Gwm17z8mC0Fkqf8YZxt2tvPguvV4vrjBtGKwO5yajkyZKP+4gYgbN94qQ/0K4hLSIwsz5hsaQ0AAdsbRiVsITWMWSv1NNJ5nDNuqhFQJPMVVhaAKtKP3pByt9J/KVgCzrH8RcgV5M8K5kdtJUWiAz+WODrVfBmnKu6EIRGiB6ESjEajLaVycetSedRoC2Xqc2g7EAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZJKQdzsXhc4h5/H42TwHke+LKvW80blz8uLEdZiC4U=;
 b=dfR9Wun+tuSp/ru7JRsGy/SKCtAcHJQZXJ8Y8FTD5neimFH68q5ERjgnAc1StQjyH2dFLscPnDZTzPEt/lj+d/tO/eaRNVH8K7zhom56DT2YT5QBsKppj5rR8QYwrt7qas4Z64DamRmOjvbSsQ2OV3C8EAAvhxk5wTUJOTAAZgI=
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 12:18:05 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::ad) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 12:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 12:18:05 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 06:18:00 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 4/6] perf amd ibs: Add Load Latency bits in raw dump
Date: Wed, 18 Dec 2024 12:14:35 +0000
Message-ID: <20241218121437.1717-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218121437.1717-1-ravi.bangoria@amd.com>
References: <20241218121437.1717-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e33cd93-055c-43d4-ed11-08dd1f5e06c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EYXft+/CERuwILrrtEYQ42b7PV18QgkhzIuoxXZs96CK6coT0t0NOEzCngX1?=
 =?us-ascii?Q?iFwA5kLXl6wPuJbn1DAOtsolUeIVQ9tryQfqt2D1XbXJJxhGhAAlzn3/0XBp?=
 =?us-ascii?Q?Y4w68hi7m0bfVIZiqXlEpqnAg1PP7J0r+aBpw0Ay73vQh9qpJiVcEzytxBMA?=
 =?us-ascii?Q?Ek4Tqv0mOIN6bEFkfBwBfmG+BlOp4+7a5pgkTyedoJrZXCtQg7K+LHzunH1M?=
 =?us-ascii?Q?Dciep2WBZ7nM+12KJTa6jtA0w3keZVAUhd7CeMxSD1STrInfVLtYSCg8+bOY?=
 =?us-ascii?Q?48WANl0rzTcfZDJf76hr21oIMxNySSUYjwLGpDMKxXG0TXSUUmY9kUsRxVId?=
 =?us-ascii?Q?kNJk7sSPJZtXvlFxgRucgwYo5RYbXDZtGaFeYtwF0C7dL39ZyzOCEixCtp3U?=
 =?us-ascii?Q?BPowj85Ez2+Ncz0nbcHVZ3Wc1kkf4IlJ5JTR4TQkTsBQs0R2yRWgY/yVxlNH?=
 =?us-ascii?Q?JAAlM3mg6tq1iwa31xSymt+Ie3vB2qaHQyR1+7KSEczYKR2ZrR+/wGKMY0+Y?=
 =?us-ascii?Q?+Be+UzWt2wuWLt3661ztvkpSuhPPGahqpF5RWl5PAh3S7mVv6qFLZLP/rBmS?=
 =?us-ascii?Q?6eepSB5pXoKo3El4y5236VN2VeHpyApoPq4RcCIQfw9geRcZ7rERrVo1Y2Go?=
 =?us-ascii?Q?IXnAenU5J0MLgv2iY1nYkO9LwPAhBLkTxBZWDiBM/zjB1uW1ZhOmjgwchiG4?=
 =?us-ascii?Q?26cmQlUwilv48SxtAKPeJ919ec/Mey0MTJb0zAyLd5qTsbau7zurXj065l+e?=
 =?us-ascii?Q?i5AxTP4lIY8OU0qyxU5XGwOfASgx98jRVX6BIZoHcElfA/tlV6R7LMQ3MkGI?=
 =?us-ascii?Q?7BPrQtJehfynWIbgx8AYZWS4w6NosmYox8sNZQAeDcEI4ID5KC0O0iSbxQvD?=
 =?us-ascii?Q?TNnssNbrD2hIkssyyA4GqVQip+voq2C5zgu6HhgcIxfVrjg5kM+jOZllWvxN?=
 =?us-ascii?Q?gbnfI1F3TE6No5w0JjvbM9XR8HbG6Cti3lVjX53t7B1+gNKQUs49zZcYwhU+?=
 =?us-ascii?Q?XFdSw4Zub67Es6CjTDXv3+iIoEiepUxs27fAFt2c8KAm5/7DFRFips2+d1FC?=
 =?us-ascii?Q?uVY3LThu1xq7j3jxMnth2AOwqfRtoWmRt4RxsGgpBbZhQgiiMoX8Go3uXeRh?=
 =?us-ascii?Q?z9u3BAhSU5a1pzUnvnUOypygKl+5zQBtJdit7T6cK6PrODgai4oPmXYiVHzI?=
 =?us-ascii?Q?jvpbXO/rLA1E+Ii8kKFVyv/bjJ8eGPJCqnMGACiiglnRWHYQuajhjOrJb8JZ?=
 =?us-ascii?Q?tNqxmpcVCIb1K++21lzsxvyc+Hoy4xmwNEw6skxta/YmfpPxqV93WOoLsrpK?=
 =?us-ascii?Q?ywDvP3Mu8hrMuCBc56waGV1SJbq6Q3f+dE21qeFcldGxcZHQ3m6ZVH+NV59V?=
 =?us-ascii?Q?wibAdO+0kF3oS/xHWtrrkr1SY6A1OfLzNDdDT2lG3rJwmBkKRLP/WHpVrUT6?=
 =?us-ascii?Q?O749ffqzElExV3qTHdt6rTJQT+K4J+yO18AwBtq7g5Eiktz0qORtlHDkPE7w?=
 =?us-ascii?Q?GtzNWq9jmDyHXdc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:18:05.5715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e33cd93-055c-43d4-ed11-08dd1f5e06c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220

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

