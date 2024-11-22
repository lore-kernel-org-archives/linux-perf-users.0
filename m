Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD7176231;
	Fri, 22 Nov 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265302; cv=fail; b=uiU+pIvlc8/nu+lSWG94fUKjBLIeoJAw0KzJvNr3de9Jj9lZmT1XZ234t1OjggJOylve7DvrDMzX77qKFK5mWJqaBWELjpoVmAoj6e4wohLL8brXfXelP4i1Hz6j4d4ilo3z14FDhNfUuHyyePyNIG5NvdnZbb5Dwg5UBH3BrSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265302; c=relaxed/simple;
	bh=VxEypGemKOEczqxt6cJg8viNuyfBrZnj1ZAPmuTMYsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQy4ORXkxoBc4KPzRutqAER9nZFV01VfdEwM+Yel1gO/eanzy5GbgGVexa3GNQg/q4MxJUkjUqXmKe4MH2SKiN/wPS7P0K0mjodg7lF7QseLGuFajjm+M5DW2lhcJz+cCuqq1kGxyfdRgG843ON3JHI85deZOgv2A91jxClDEYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ctTE/qp2; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ctTE/qp2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpM1Nws5ijWhPKF+q44cC7al5r598M7DumJAjswqmkVJGoCuNLMCblZTNpJzf12EkO1yPQMGYaHji0kcNVehnTZOKUVZBb/ibp4g2YwxNB2/qCpMlBhAfHEftANYo0Ai48tWv2/MEe8448HIcttx8fK9izLH43x7tHdHh+hsjgtV4L+L/yd/PBqDRWOg0C2SWrPG0wQiNMYYHIuMrIQA5Zf2tFmGHqzM0zMJXpApgM3oJ144n+14aY19WJEbSLnPmRVEePoHniuyfperDScQq5sswAAIPfCCQ3nVV/aXt0eUY3MVwS3JgRK5ptGZhWfBpB0B+QIelIXP3icyy7mbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsW8H/2p54qynLbu0UIh1gh0M+if7ZRs2yqKMdiHrH4=;
 b=cDSCoa/Q8yWUB8ZfFxH2LY/8u7N/uSqWFPPfid5MZljptzNLZfikibr13G4bcAkMeF28Bl8EB2wqgqc1EOP+Y4r4ADPv/Wng2denFe6noMaSOTPRJd5aMcUJJWVLDmtuFIvsUVr7VhR5m3sTp7hXGuCfZlJdu6WsCef4KgtWuTLa8HNNvEfcKuU1K6LcFQJc02r2ZxhDSFgJi7bKiMT3uOHO2Be5pOugurMzq52bqywgIYU6TsJBriE2kkeCUtG0w+xdqCbM6Rn5uqej88CKkdBFiD4E7Cba48TzKtBb0DiJPLSXMwvriV9tASedv2DPDpq1AECr9tE0GZDc0OS1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsW8H/2p54qynLbu0UIh1gh0M+if7ZRs2yqKMdiHrH4=;
 b=ctTE/qp2I0md7ckDCu7d82i59sF/8d77pmLGWfIEvGeHntMoXY/518a0wHoT29TjmuMgudjTsuXFvYXLgNsWlakG6TfbY0eC/M/qwx59UQES1hGvFScIhminDaCGNkxx2XClrUTyYEKBE/wwbnRGboXPQGhkCXEjRKgMa9Zzxao=
Received: from BN8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:408:ac::44)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 08:48:13 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::e0) by BN8PR07CA0031.outlook.office365.com
 (2603:10b6:408:ac::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Fri, 22 Nov 2024 08:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 08:48:12 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 02:48:04 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<vineethr@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>
Subject: [PATCH v2 6/6] perf sched stats: Add support for diff subcommand
Date: Fri, 22 Nov 2024 08:44:52 +0000
Message-ID: <20241122084452.1064968-7-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 83684f61-af4b-4e6c-2431-08dd0ad26626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NCarFj13KmKjrTBDu8lYW+QBJKAW62UHxrzQGiKCkrhjHNzz+YdXpC66rdh+?=
 =?us-ascii?Q?jTzcI1UcAbHlcQeZHUT3M0/tDBqs3yRCsg2g81nFEiy0TMcK/m7E8LHoqDS+?=
 =?us-ascii?Q?ugzjXTLOrgm6nSYLrdHqaELDMFBTm2f/80R7TxMUA/xgl1suZYpHtYBEuqH+?=
 =?us-ascii?Q?xdbr1902tHUrFluyeUPooxuoTszQ234i9tmgnLgXT1gRsxCDfm54eIvPszKH?=
 =?us-ascii?Q?/+RYaGMNll04alml6JjF7QovcRa8cTbkrsFlgzrhDMTSs4jQUX6utXMSfp3V?=
 =?us-ascii?Q?y0jpufNVxIYvYDGp3NT7Yyi8WM1+/14Y91mjHN1uH1B18rm3kAc9FnXHmvKD?=
 =?us-ascii?Q?4zv/mDMoKusPbBrgenQPvibyGKCfMxax560oB8b3/6B/5lShO8nyYVtObPNe?=
 =?us-ascii?Q?VkOzkHc1WIRjnKM1RSvM0YJc8js6AkNqPTODxYOGtBnzrxkKW0402BePDvck?=
 =?us-ascii?Q?1wUeYV0AvI0kvyxE19f+VW6AGrUbpq5HZFGTacRgpMzgv6f2VUHX6E/q+1UN?=
 =?us-ascii?Q?PrL3/UUDGMUAibeHh9xTve+d2KqM2mK05tyeiSti/q45xU7Zo5lCRwR8Iq7L?=
 =?us-ascii?Q?cKTFZ1cqTC0tylrhO8co7R1OpCl50q5oksB6vRypQwmBMyl5nqBlTGilqBf+?=
 =?us-ascii?Q?hcK7DevcpO12yHv7QOxOdYYhFvupMocWW4kU+bbdCG6AWIE37Ehp58iXdWwT?=
 =?us-ascii?Q?otkh3KsGtWLbt8tT3zKtqr8ekwzUZ55wQgS8RyrYLr7nN3tHiJiDCapkinD6?=
 =?us-ascii?Q?bQx/oZoOSQt0D2U0uqvxkVYGk+eSASEpiqUMIqfgPKVOm7ZzhV3SuJupj6IB?=
 =?us-ascii?Q?H6AG5gSMN2Ak2ZemD6tAOzDmLn9EUkgvAxnsM8lIfMMwp1wfXNHoPQJ8+ZMB?=
 =?us-ascii?Q?+Ad8HJ8EXi7BJwBVOburjYdOp1yrr4s4gl4qTymr1e5osrIRk1oXAsZ8ayPn?=
 =?us-ascii?Q?zABhEE6hIVxWJHsMM3lBTgWFuACAWcP9wCRWpcg8nUISM0mUI03GE93+4Mqj?=
 =?us-ascii?Q?v3jhk0tIaEBynIkOlmnyR5P00px8TA51hePIRtvah+EjqlkfDS4ekgrsp8Nf?=
 =?us-ascii?Q?hsY4l26TJoxmjjORd4eLcuMGlLbTLdUyKwFVASOSuIR9bZkOFtLsBbasjRsS?=
 =?us-ascii?Q?qmKH46QG/5l/Enm0eTZMYe7XOIiCZD3dGV6EYjYWGJYDbx2SSLe0OEPXX5Hh?=
 =?us-ascii?Q?kuiZh5NYrgeZkRz9A0rN9YFhu1dFqXvW6UAOX6SqpjkEDzTdoTKsl/DsN8T5?=
 =?us-ascii?Q?tgGX8TzyXCcLGlOYjetztBsle+w51n957/ht6c8uDdQakz3e+5iuR3Jcuh8o?=
 =?us-ascii?Q?SCb2uDr39KQeJI3TXRh4zewGBRvx8WjkJU4A+jfe6o2uyv974pX62DTgkNXz?=
 =?us-ascii?Q?yk8BerLKbmg0AHgG5mvW+JAcIeBYPESXR5GQtNtJEfc7vdfTWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:48:12.8882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83684f61-af4b-4e6c-2431-08dd0ad26626
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

`perf sched stats diff` subcommand will take two perf.data files as an
input and it will print the diff between the two perf.data files. The
default input to this subcommnd is perf.data.old and perf.data.

Example usage:

 # perf sched stats diff sample1.data sample2.data

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 270 +++++++++++++++++++++++++++++--------
 1 file changed, 217 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 004ad0952338..d9a3412ed749 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3924,26 +3924,42 @@ static void print_separator(size_t pre_dash_cnt, const char *s, size_t post_dash
 	printf("\n");
 }
 
-static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
+#define PCT_CHNG(_x, _y)        ((_x) ? ((double)((double)(_y) - (_x)) / (_x)) * 100 : 0.0)
+static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs1,
+				   struct perf_record_schedstat_cpu *cs2)
 {
-	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
+	printf("%-65s ", "DESC");
+	if (!cs2)
+		printf("%12s %12s", "COUNT", "PCT_CHANGE");
+	else
+		printf("%12s %11s %12s %14s %10s", "COUNT1", "COUNT2", "PCT_CHANGE",
+		       "PCT_CHANGE1", "PCT_CHANGE2");
+
+	printf("\n");
 	print_separator(100, "", 0);
 
 #define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
-
-#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
-	do {									\
-		printf("%-65s: " _format, _desc, cs->_ver._name);		\
-		if (_is_pct) {							\
-			printf("  ( %8.2lf%% )",				\
-			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
-		}								\
-		printf("\n");							\
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)			\
+	do {										\
+		printf("%-65s: " _format, _desc, cs1->_ver._name);			\
+		if (!cs2) {								\
+			if (_is_pct)							\
+				printf("  ( %8.2lf%% )",				\
+				       CALC_PCT(cs1->_ver._name, cs1->_ver._pct_of));	\
+		} else {								\
+			printf("," _format "  | %8.2lf%% |", cs2->_ver._name,		\
+			       PCT_CHNG(cs1->_ver._name, cs2->_ver._name));		\
+			if (_is_pct)							\
+				printf("  ( %8.2lf%%,  %8.2lf%% )",			\
+				       CALC_PCT(cs1->_ver._name, cs1->_ver._pct_of),	\
+				       CALC_PCT(cs2->_ver._name, cs2->_ver._pct_of));	\
+		}									\
+		printf("\n");								\
 	} while (0)
 
-	if (cs->version == 15) {
+	if (cs1->version == 15) {
 #include <perf/schedstat-v15.h>
-	} else if (cs->version == 16) {
+	} else if (cs1->version == 16) {
 #include <perf/schedstat-v16.h>
 	}
 
@@ -3951,10 +3967,17 @@ static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
 #undef CALC_PCT
 }
 
-static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
-				      __u64 jiffies)
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds1,
+				      struct perf_record_schedstat_domain *ds2,
+				      __u64 jiffies1, __u64 jiffies2)
 {
-	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
+	printf("%-65s ", "DESC");
+	if (!ds2)
+		printf("%12s %14s", "COUNT", "AVG_JIFFIES");
+	else
+		printf("%12s %11s %12s %16s %12s", "COUNT1", "COUNT2", "PCT_CHANGE",
+		       "AVG_JIFFIES1", "AVG_JIFFIES2");
+	printf("\n");
 
 #define DOMAIN_CATEGORY(_desc)							\
 	do {									\
@@ -3968,25 +3991,52 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 
 #define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
 	do {									\
-		printf("%-65s: " _format, _desc, ds->_ver._name);		\
-		if (_is_jiffies) {						\
-			printf("  $ %11.2Lf $",					\
-			       CALC_AVG(jiffies, ds->_ver._name));		\
+		printf("%-65s: " _format, _desc, ds1->_ver._name);		\
+		if (!ds2) {							\
+			if (_is_jiffies)					\
+				printf("  $ %11.2Lf $",				\
+				       CALC_AVG(jiffies1, ds1->_ver._name));	\
+		} else {							\
+			printf("," _format "  | %8.2lf%% |", ds2->_ver._name,	\
+			       PCT_CHNG(ds1->_ver._name, ds2->_ver._name));	\
+			if (_is_jiffies)					\
+				printf("  $ %11.2Lf, %11.2Lf $",		\
+				       CALC_AVG(jiffies1, ds1->_ver._name),	\
+				       CALC_AVG(jiffies2, ds2->_ver._name));	\
 		}								\
 		printf("\n");							\
 	} while (0)
 
 #define DERIVED_CNT_FIELD(_desc, _format, _x, _y, _z, _ver)			\
-	printf("*%-64s: " _format "\n", _desc,					\
-	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, _desc, t1);				\
+		if (ds2) {							\
+			__u32 t2 = ds2->_ver._x - ds2->_ver._y - ds2->_ver._z;	\
+			printf("," _format "  | %8.2lf%% |", t2,		\
+			       PCT_CHNG(t1, t2));				\
+		}								\
+		printf("\n");							\
+	} while (0)
 
 #define DERIVED_AVG_FIELD(_desc, _format, _x, _y, _z, _w, _ver)			\
-	printf("*%-64s: " _format "\n", _desc, CALC_AVG(ds->_ver._w,		\
-	       ((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, _desc,				\
+		       CALC_AVG(ds1->_ver._w, t1));				\
+		if (ds2) {							\
+			__u32 t2 = ds2->_ver._x - ds2->_ver._y - ds2->_ver._z;	\
+			printf("," _format "  | %8.2Lf%% |",			\
+			       CALC_AVG(ds2->_ver._w, t2),			\
+			       PCT_CHNG(CALC_AVG(ds1->_ver._w, t1),		\
+					CALC_AVG(ds2->_ver._w, t2)));		\
+		}								\
+		printf("\n");							\
+	} while (0)
 
-	if (ds->version == 15) {
+	if (ds1->version == 15) {
 #include <perf/schedstat-v15.h>
-	} else if (ds->version == 16) {
+	} else if (ds1->version == 16) {
 #include <perf/schedstat-v16.h>
 	}
 
@@ -3996,6 +4046,7 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #undef CALC_AVG
 #undef DOMAIN_CATEGORY
 }
+#undef PCT_CHNG
 
 static void print_domain_cpu_list(struct perf_record_schedstat_domain *ds)
 {
@@ -4148,12 +4199,12 @@ static void get_all_cpu_stats(struct schedstat_cpu **cptr)
 }
 
 /* FIXME: The code fails (segfaults) when one or ore cpus are offline. */
-static void show_schedstat_data(struct schedstat_cpu *cptr)
+static void show_schedstat_data(struct schedstat_cpu *cptr1, struct schedstat_cpu *cptr2)
 {
-	struct perf_record_schedstat_domain *ds = NULL;
-	struct perf_record_schedstat_cpu *cs = NULL;
-	__u64 jiffies = cptr->cpu_data->timestamp;
-	struct schedstat_domain *dptr = NULL;
+	struct perf_record_schedstat_domain *ds1 = NULL, *ds2 = NULL;
+	struct perf_record_schedstat_cpu *cs1 = NULL, *cs2 = NULL;
+	struct schedstat_domain *dptr1 = NULL, *dptr2 = NULL;
+	__u64 jiffies1 = 0, jiffies2 = 0;
 	bool is_summary = true;
 
 	printf("Columns description\n");
@@ -4164,50 +4215,82 @@ static void show_schedstat_data(struct schedstat_cpu *cptr)
 	printf("AVG_JIFFIES\t\t-> Avg time in jiffies between two consecutive occurrence of event\n");
 
 	print_separator(100, "", 0);
-	printf("Time elapsed (in jiffies)                                        : %11llu\n",
-	       jiffies);
+	printf("Time elapsed (in jiffies)                                        : ");
+	jiffies1 = cptr1->cpu_data->timestamp;
+	printf("%11llu", jiffies1);
+	if (cptr2) {
+		jiffies2 = cptr2->cpu_data->timestamp;
+		printf(",%11llu", jiffies2);
+	}
+	printf("\n");
+
 	print_separator(100, "", 0);
 
-	get_all_cpu_stats(&cptr);
+	get_all_cpu_stats(&cptr1);
+	if (cptr2)
+		get_all_cpu_stats(&cptr2);
+
+	while (cptr1) {
+		cs1 = cptr1->cpu_data;
+		if (cptr2) {
+			cs2 = cptr2->cpu_data;
+			dptr2 = cptr2->domain_head;
+		}
+
+		if (cs2 && cs1->cpu != cs2->cpu) {
+			pr_err("Failed because matching cpus not found for diff\n");
+			return;
+		}
 
-	while (cptr) {
-		cs = cptr->cpu_data;
 		printf("\n");
 		print_separator(100, "", 0);
 		if (is_summary)
 			printf("CPU <ALL CPUS SUMMARY>\n");
 		else
-			printf("CPU %d\n", cs->cpu);
+			printf("CPU %d\n", cs1->cpu);
 
 		print_separator(100, "", 0);
-		print_cpu_stats(cs);
+		print_cpu_stats(cs1, cs2);
 		print_separator(100, "", 0);
 
-		dptr = cptr->domain_head;
+		dptr1 = cptr1->domain_head;
+
+		while (dptr1) {
+			ds1 = dptr1->domain_data;
+
+			if (dptr2)
+				ds2 = dptr2->domain_data;
+
+			if (dptr2 && ds1->domain != ds2->domain) {
+				pr_err("Failed because matching domain not found for diff\n");
+				return;
+			}
 
-		while (dptr) {
-			ds = dptr->domain_data;
 			if (is_summary)
-				if (ds->name[0])
-					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", ds->name);
+				if (ds1->name[0])
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", ds1->name);
 				else
-					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", ds->domain);
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", ds1->domain);
 			else {
-				if (ds->name[0])
-					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, ds->name);
+				if (ds1->name[0])
+					printf("CPU %d, DOMAIN %s CPUS ", cs1->cpu, ds1->name);
 				else
-					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, ds->domain);
+					printf("CPU %d, DOMAIN %d CPUS ", cs1->cpu, ds1->domain);
 
-				print_domain_cpu_list(ds);
+				print_domain_cpu_list(ds1);
 			}
 			print_separator(100, "", 0);
-			print_domain_stats(ds, jiffies);
+			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
 			print_separator(100, "", 0);
 
-			dptr = dptr->next;
+			dptr1 = dptr1->next;
+			if (dptr2)
+				dptr2 = dptr2->next;
 		}
 		is_summary = false;
-		cptr = cptr->next;
+		cptr1 = cptr1->next;
+		if (cptr2)
+			cptr2 = cptr2->next;
 	}
 }
 
@@ -4336,12 +4419,88 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	perf_session__delete(session);
 	if (!err) {
 		setup_pager();
-		show_schedstat_data(cpu_head);
+		show_schedstat_data(cpu_head, NULL);
 		free_schedstat(cpu_head);
 	}
 	return err;
 }
 
+static int perf_sched__schedstat_diff(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct schedstat_cpu *cpu_head_ses0 = NULL, *cpu_head_ses1 = NULL;
+	struct perf_session *session[2];
+	struct perf_data data[2];
+	int ret, err;
+	static const char *defaults[] = {
+		"perf.data.old",
+		"perf.data",
+	};
+
+	if (argc) {
+		if (argc == 1)
+			defaults[1] = argv[0];
+		else if (argc == 2) {
+			defaults[0] = argv[0];
+			defaults[1] = argv[1];
+		} else {
+			pr_err("perf sched stats diff is not supported with more than 2 files.\n");
+			goto out_ret;
+		}
+	}
+
+	sched->tool.schedstat_cpu = perf_sched__process_schedstat;
+	sched->tool.schedstat_domain = perf_sched__process_schedstat;
+
+	data[0].path = defaults[0];
+	data[0].mode  = PERF_DATA_MODE_READ;
+	session[0] = perf_session__new(&data[0], &sched->tool);
+	if (IS_ERR(session[0])) {
+		ret = PTR_ERR(session[0]);
+		pr_err("Failed to open %s\n", data[0].path);
+		goto out_delete_ses0;
+	}
+
+	err = perf_session__process_events(session[0]);
+	if (err)
+		goto out_delete_ses0;
+
+	cpu_head_ses0 = cpu_head;
+	after_workload_flag = false;
+	cpu_head = NULL;
+
+	data[1].path = defaults[1];
+	data[1].mode  = PERF_DATA_MODE_READ;
+	session[1] = perf_session__new(&data[1], &sched->tool);
+	if (IS_ERR(session[1])) {
+		ret = PTR_ERR(session[1]);
+		pr_err("Failed to open %s\n", data[1].path);
+		goto out_delete_ses1;
+	}
+
+	err = perf_session__process_events(session[1]);
+	if (err)
+		goto out_delete_ses1;
+
+	cpu_head_ses1 = cpu_head;
+	after_workload_flag = false;
+	setup_pager();
+	show_schedstat_data(cpu_head_ses0, cpu_head_ses1);
+	free_schedstat(cpu_head_ses0);
+	free_schedstat(cpu_head_ses1);
+
+out_delete_ses1:
+	if (!IS_ERR(session[1]))
+		perf_session__delete(session[1]);
+
+out_delete_ses0:
+	if (!IS_ERR(session[0]))
+		perf_session__delete(session[0]);
+
+out_ret:
+	return ret;
+}
+
 static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
 					  union perf_event *event,
 					  struct perf_sample *sample __maybe_unused,
@@ -4420,7 +4579,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 		goto out_target;
 
 	setup_pager();
-	show_schedstat_data(cpu_head);
+	show_schedstat_data(cpu_head, NULL);
 	free_schedstat(cpu_head);
 out_target:
 	free(target);
@@ -4747,6 +4906,11 @@ int cmd_sched(int argc, const char **argv)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
+		} else if (argv[0] && !strcmp(argv[0], "diff")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_diff(&sched, argc, argv);
 		}
 		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
-- 
2.43.0

