Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290C2F4A12;
	Tue,  9 Sep 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418466; cv=fail; b=qmVEg5GK+VwsFD/gK7KBNvb+njvoG/UbJvM5AqXIMq3ZZGuyCB0iLCzvUvW7DXEE8oCnUmv9bCGFLVta8D4tkrOJMaaboqkRIbEcFTcQ9TeQ8PK/qgCPhbrQ3+b0xM796ZLcYYBl+C5l5nh/CvXZMLQlG5auP8N65EFf9a9NggE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418466; c=relaxed/simple;
	bh=SBsqX4CeInj4sWuL7kZmsQuwMKuDg09fvMlG1BX+VWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHA61d2ocbIY0/zJMDG4psKe92rIiDe9if17y7ULUKjlmHq+iwniVYuCeFxjJgcwVONn5l1CId8saVVbLZejAK6rD47j1JK66/BuvL5XVBpw1o0tDl/wamWUFn0GbhQoMF2nSCb/Gu69iKJM47oPBnP9sbykvAjHIf/jb9oOJ0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iOoGB6BR; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iOoGB6BR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4l/TZLwJsID4hq9RiTQrkSGFFoGWGCHeQ6Z7bc5WIFZvep5EkPUSsGE4KXJAmqVASswfOVo3s8HTXx/JmIZgi3+aK3YV/uUBBcEMU0PNX0uRYZEmi5QlHWkSMX26TcfzYfn54eJVSNDneVkV5uGtwrw/1NC3XO0D75xh51vGI9Ui0afaWUmkQuMCWKnVwvwLQ/cuoTKS9794z11nWmr2MAcVWKCpvkjtPl/L44tlyEzdyfsxqCbyfkaEXhbARVxh0XA2jpckTPDDDaHnkl4Br4XYu+bVcdM87A63zGUYef6QhDexsgRMEaM3VzdSoZQVMgqOh0stuf5y/eYDH4auA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIE5Gw/1BIn5T1u0lQSCQIA2+Z8heWmoReYZku0YHWc=;
 b=r/reND5wuzAj/ivyfKbESKguNImo/rWPenSMveGb7OTDYnMgv2GlUCC7aiDVcXk+aUJ7oiOSOLVjr4MS/PHi4Qufhp6NL+A9ReTGIl9Jd2Y5XeaVgO9vmijPU1+NdvqDgSV/2Mw+m9feMB7CnUILg2BZxEfz89TW78dMur5PK5QqHcKklimFCmEVfAqoWxPCF3vT8/Hm0lIi2ZzRiNZsZWCdBehVfearXZhAf02EKGK0QCYl/bXuttiUREXpw8moMy1Ff16lgdExxji3z9S9wKA9a/nncD1n83ETpCFNAcx0rYI/9vPxss7kGS/WL6Ehsx4nOuSvHoYEur792n88mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIE5Gw/1BIn5T1u0lQSCQIA2+Z8heWmoReYZku0YHWc=;
 b=iOoGB6BRg2waJyxRm/rJk1HIIEVFlU+uomdRv2XMDOwnnq3NTlygGT2D/DMZpw07ViM29+g0ohUYs/uopYNXTwI/9BFHDwrLrDXY44bPhXlfXuetxgsVznp9oKsgFOhO1HSn/43YVAXBZEMxEpOt+wh6mj/9Oi1zo8OxkiIyjc0=
Received: from MW4PR03CA0252.namprd03.prod.outlook.com (2603:10b6:303:b4::17)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:47:35 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::69) by MW4PR03CA0252.outlook.office365.com
 (2603:10b6:303:b4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 11:47:33 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:47:18 -0700
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH RESEND v4 09/11] perf sched stats: Add support for diff subcommand
Date: Tue, 9 Sep 2025 11:42:25 +0000
Message-ID: <20250909114227.58802-10-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909114227.58802-1-swapnil.sapkal@amd.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 74eab9ac-639a-48a7-ab48-08ddef96aa6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3H+sQAQCioVPwkVyMMa/63R5u5naTVIV5WGTjEcM+KoMMiO+erNB/BTN2koZ?=
 =?us-ascii?Q?GBlZQaHTfn3SGlZDos932sEZ41occkt3ZO+GedmngRJ7mwyid3P6qvZZM1Vq?=
 =?us-ascii?Q?yi7w1BB/cQeN7dcoVs3hF8V0hQvqKoClsU4d+WXmdZqz1kO3j1Qyt4EqoIN9?=
 =?us-ascii?Q?wXiF/qNHDXk2ezh9TQK4oEZyuOIXP5emYD2vov8hyHALGIXSqRozeXIgjGbW?=
 =?us-ascii?Q?PCSmzVI8DoLx4wsL5ghTg99+/ae9i8ViNvUnQZwDcHFUyJz69pBIK/wOhLfI?=
 =?us-ascii?Q?moJQx8TGvQXG0otlRZjrOu7yJrFTF6cloKOh/CiyU+uswRej/6xqAC4rii2b?=
 =?us-ascii?Q?b9++UpPKmPTA/tFbTXwyu4V7e5lxeaDn+dqxsWYUFYQLNoyuAiEz8OJxwZfI?=
 =?us-ascii?Q?eFWKYQ7wOvzBVXV2pFYxVYeaGn1XLwZjZU6XVh6Oweeip5l/WTHxk8Y61r0y?=
 =?us-ascii?Q?iAI0wZopcO+8ydFtALQ5F49bTjBRIFU58CzvYa+F+JiAjq/lkqP8T9946K4i?=
 =?us-ascii?Q?+DyQuVWez1PVocjbx5a6Hfrdwt2gwBIGAStDbQR0t6uN2nb4la5ZTj0f6eGY?=
 =?us-ascii?Q?xHHHS66ZHwnI29/KOpmFuT7hj9ixa6OQ2p9K6WdW5ULmB29r/ducjewBzfu3?=
 =?us-ascii?Q?hlocSajv4ciHVG5bhoJbqL/WqhLinc27EB+vvuIcpIaycF+NGyPv6HvVK9yJ?=
 =?us-ascii?Q?lTN84tO2/lTEzs+VXpjcWIZU7Fmd48dBVYML3el6lXlHM0QKortqOFcfhN4L?=
 =?us-ascii?Q?882e/uV1G6csWIeHfDQoC7XKmdZymBhUf92EeYo2j54hW4D4oPqThnXhqCN/?=
 =?us-ascii?Q?o7Rfqndh8M1FHtTb/1Z3heZCmL9fMvHttPV9EPqRsIDNrD6fl1KCBjE1rlcJ?=
 =?us-ascii?Q?9X7sXnLV2yZIwfzQRc987xbHyR0exrwEI8JAf5vq6qnjUdqlbwiPbrvz7f6a?=
 =?us-ascii?Q?Etn4hCvyvEqjxjKmbsIuMsHIIgz9Xd50adW1iRRaXne/p8QBZtgZoM78fO95?=
 =?us-ascii?Q?rYQt8CKDgs4uPGNqnlYxt98WH3laIkvTmW/xZ6REL8K2JVcyfAY2uleZ3QcO?=
 =?us-ascii?Q?Q/q+eJab/Kd9VCCWpDVqgiNlY5iadV9hKwaOjiek/o/wGgi1wBvrVr/bFFbM?=
 =?us-ascii?Q?Og7hKkp3criTSADp2kQG9HgoLLbO0gcJYr704mgHQbbGq+TicBbtt2+dpMA3?=
 =?us-ascii?Q?AhNaUdxYgqBgUFgO/KPuh48kieXtVIP74YcWwJonEzI3k869dhNxTk4QNHqX?=
 =?us-ascii?Q?kMjvZG8bhIC9V0uwiXiPCdXRCEgSz4oXaFwgsoedMUpPgECJmHOIutGQyBSd?=
 =?us-ascii?Q?3NhP4rrPNx0majdoST3m7JDbisUuSnFtpfNEmvrYbFWCgGeK3OxMK8rJ1NFG?=
 =?us-ascii?Q?sbCHZPZ0CTkLYiGOL0XNsqCfU8qAVyOuPeSoCyh8iLaFhB9BSPtH86XfaPmJ?=
 =?us-ascii?Q?G6VYKR1XPFKRlfBfIwGOItagrNvSvcQ6wB/J6zjVr7VeH70p03Sr2r8siGxI?=
 =?us-ascii?Q?11ShGQX3Mzln5FhgRci6QVcsbfFEsdpzFKfz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:47:33.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eab9ac-639a-48a7-ab48-08ddef96aa6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

`perf sched stats diff` subcommand will take two perf.data files as an
input and it will print the diff between the two perf.data files. The
default input to this subcommnd is perf.data.old and perf.data.

Example usage:

 # perf sched stats diff sample1.data sample2.data

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 315 ++++++++++++++++++++++++++++++-------
 1 file changed, 258 insertions(+), 57 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ce04349cc4ff..ebce69180330 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3996,29 +3996,46 @@ static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
 #undef DOMAIN_FIELD
 }
 
-static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
+#define PCT_CHNG(_x, _y)        ((_x) ? ((double)((double)(_y) - (_x)) / (_x)) * 100 : 0.0)
+static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs1,
+				   struct perf_record_schedstat_cpu *cs2)
 {
-	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
-	printf("%.*s\n", 100, graph_dotted_line);
+	printf("%-65s ", "DESC");
+	if (!cs2)
+		printf("%12s %12s", "COUNT", "PCT_CHANGE");
+	else
+		printf("%12s %11s %12s %14s %10s", "COUNT1", "COUNT2", "PCT_CHANGE",
+		       "PCT_CHANGE1", "PCT_CHANGE2");
+
+	printf("\n");
+	print_separator(100, "", 0);
 
 #define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
 
-#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
-	do {									\
-		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
-		       cs->_ver._name);						\
-		if (_is_pct) {							\
-			printf("  ( %8.2lf%% )",				\
-			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
-		}								\
-		printf("\n");							\
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)			\
+	do {										\
+		printf("%-65s: " _format, verbose_field ? _desc : #_name,		\
+		       cs1->_ver._name);						\
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
-	} else if (cs->version == 17) {
+	} else if (cs1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -4026,10 +4043,17 @@ static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
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
@@ -4044,28 +4068,54 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
 	do {									\
 		printf("%-65s: " _format, verbose_field ? _desc : #_name,	\
-		       ds->_ver._name);						\
-		if (_is_jiffies) {						\
-			printf("  $ %11.2Lf $",					\
-			       CALC_AVG(jiffies, ds->_ver._name));		\
+		       ds1->_ver._name);					\
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
 
 #define DERIVED_CNT_FIELD(_name, _desc, _format, _x, _y, _z, _ver)		\
-	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
-	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, verbose_field ? _desc : #_name, t1);	\
+		if (ds2) {							\
+			__u32 t2 = ds2->_ver._x - ds2->_ver._y - ds2->_ver._z;	\
+			printf("," _format "  | %8.2lf%% |", t2,		\
+			       PCT_CHNG(t1, t2));				\
+		}								\
+		printf("\n");							\
+	} while (0)
 
 #define DERIVED_AVG_FIELD(_name, _desc, _format, _x, _y, _z, _w, _ver)		\
-	printf("*%-64s: " _format "\n", verbose_field ? _desc : #_name,		\
-	       CALC_AVG(ds->_ver._w,						\
-			((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
+	do {									\
+		__u32 t1 = ds1->_ver._x - ds1->_ver._y - ds1->_ver._z;		\
+		printf("*%-64s: " _format, verbose_field ? _desc : #_name,	\
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
-	} else if (ds->version == 17) {
+	} else if (ds1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -4075,6 +4125,7 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #undef CALC_AVG
 #undef DOMAIN_CATEGORY
 }
+#undef PCT_CHNG
 
 static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
 				    struct schedstat_cpu *cptr,
@@ -4219,13 +4270,16 @@ static void print_field_description(struct schedstat_cpu *cptr)
 #undef DOMAIN_FIELD
 }
 
-static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **cd_map)
+static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **cd_map1,
+			       struct list_head *head2, struct cpu_domain_map **cd_map2,
+			       bool summary_only)
 {
-	struct schedstat_cpu *cptr = list_first_entry(head, struct schedstat_cpu, cpu_list);
-	__u64 jiffies = cptr->cpu_data->timestamp;
-	struct perf_record_schedstat_domain *ds;
-	struct perf_record_schedstat_cpu *cs;
-	struct schedstat_domain *dptr;
+	struct schedstat_cpu *cptr1 = list_first_entry(head1, struct schedstat_cpu, cpu_list);
+	struct perf_record_schedstat_domain *ds1 = NULL, *ds2 = NULL;
+	struct perf_record_schedstat_cpu *cs1 = NULL, *cs2 = NULL;
+	struct schedstat_domain *dptr1 = NULL, *dptr2 = NULL;
+	struct schedstat_cpu *cptr2 = NULL;
+	__u64 jiffies1 = 0, jiffies2 = 0;
 	bool is_summary = true;
 	int ret = 0;
 
@@ -4239,53 +4293,103 @@ static int show_schedstat_data(struct list_head *head, struct cpu_domain_map **c
 
 	if (!verbose_field) {
 		print_separator(100, "", 0);
-		print_field_description(cptr);
+		print_field_description(cptr1);
 	}
 
 	print_separator(100, "", 0);
 	printf("\n");
 
-	printf("%-65s: %11llu\n", "Time elapsed (in jiffies)", jiffies);
+	printf("%-65s: ", "Time elapsed (in jiffies)");
+	jiffies1 = cptr1->cpu_data->timestamp;
+	printf("%11llu", jiffies1);
+	if (head2) {
+		cptr2 = list_first_entry(head2, struct schedstat_cpu, cpu_list);
+		jiffies2 = cptr2->cpu_data->timestamp;
+		printf(",%11llu", jiffies2);
+	}
+	printf("\n");
+
 	print_separator(100, "", 0);
 
-	ret = get_all_cpu_stats(head);
+	ret = get_all_cpu_stats(head1);
+	if (cptr2)
+		ret = get_all_cpu_stats(head2);
+
+	list_for_each_entry(cptr1, head1, cpu_list) {
+		struct cpu_domain_map *cd_info1 = NULL, *cd_info2 = NULL;
+
+		cs1 = cptr1->cpu_data;
+		cd_info1 = cd_map1[cs1->cpu];
+		if (cptr2) {
+			cs2 = cptr2->cpu_data;
+			cd_info2 = cd_map2[cs2->cpu];
+			dptr2 = list_first_entry(&cptr2->domain_head, struct schedstat_domain,
+						 domain_list);
+		}
+
+		if (cs2 && cs1->cpu != cs2->cpu) {
+			pr_err("Failed because matching cpus not found for diff\n");
+			return -1;
+		}
+
+		if (cd_info2 && cd_info1->nr_domains != cd_info2->nr_domains) {
+			pr_err("Failed because nr_domains is not same for cpus\n");
+			return -1;
+		}
 
-	list_for_each_entry(cptr, head, cpu_list) {
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
 
-		list_for_each_entry(dptr, &cptr->domain_head, domain_list) {
-			struct domain_info *dinfo;
+		list_for_each_entry(dptr1, &cptr1->domain_head, domain_list) {
+			struct domain_info *dinfo1 = NULL, *dinfo2 = NULL;
+
+			ds1 = dptr1->domain_data;
+			dinfo1 = cd_info1->domains[ds1->domain];
+			if (dptr2) {
+				ds2 = dptr2->domain_data;
+				dinfo2 = cd_info2->domains[ds2->domain];
+			}
+
+			if (dinfo2 && dinfo1->domain != dinfo2->domain) {
+				pr_err("Failed because matching domain not found for diff\n");
+				return -1;
+			}
 
-			ds = dptr->domain_data;
-			dinfo = cd_map[ds->cpu]->domains[ds->domain];
 			if (is_summary)
-				if (dinfo->dname)
-					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", dinfo->dname);
+				if (dinfo1->dname)
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", dinfo1->dname);
 				else
-					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", dinfo->domain);
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", dinfo1->domain);
 			else {
-				if (dinfo->dname)
-					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, dinfo->dname);
+				if (dinfo1->dname)
+					printf("CPU %d, DOMAIN %s CPUS ", cs1->cpu, dinfo1->dname);
 				else
-					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, dinfo->domain);
+					printf("CPU %d, DOMAIN %d CPUS ", cs1->cpu, dinfo1->domain);
 
-				printf("%s\n", dinfo->cpulist);
+				printf("%s\n", dinfo1->cpulist);
 			}
 			print_separator(100, "", 0);
-			print_domain_stats(ds, jiffies);
+			print_domain_stats(ds1, ds2, jiffies1, jiffies2);
 			print_separator(100, "", 0);
+
+			if (dptr2)
+				dptr2 = list_next_entry(dptr2, domain_list);
 		}
+		if (summary_only)
+			break;
+
+		if (cptr2)
+			cptr2 = list_next_entry(cptr2, cpu_list);
+
 		is_summary = false;
 	}
 	return ret;
@@ -4430,7 +4534,7 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 		}
 
 		cd_map = session->header.env.cpu_domain;
-		err = show_schedstat_data(&cpu_head, cd_map);
+		err = show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
 	}
 
 out:
@@ -4439,6 +4543,98 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int perf_sched__schedstat_diff(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct list_head *cpu_head_ses0 = NULL, *cpu_head_ses1 = NULL;
+	struct cpu_domain_map **cd_map0 = NULL, **cd_map1 = NULL;
+	struct perf_session *session[2];
+	struct perf_data data[2];
+	int ret = 0, err = 0;
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
+	cd_map0 = session[0]->header.env.cpu_domain;
+	cpu_head_ses0 = &cpu_head;
+	after_workload_flag = false;
+	INIT_LIST_HEAD(&cpu_head);
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
+	cd_map1 = session[1]->header.env.cpu_domain;
+	cpu_head_ses1 = &cpu_head;
+	after_workload_flag = false;
+	setup_pager();
+
+	if (list_empty(cpu_head_ses1)) {
+		pr_err("Data is not available\n");
+		ret = -1;
+		goto out_delete_ses1;
+	}
+
+	if (list_empty(cpu_head_ses0)) {
+		pr_err("Data is not available\n");
+		ret = -1;
+		goto out_delete_ses0;
+	}
+
+	show_schedstat_data(cpu_head_ses0, cd_map0, cpu_head_ses1, cd_map1, true);
+
+out_delete_ses1:
+	free_schedstat(cpu_head_ses1);
+	if (!IS_ERR(session[1]))
+		perf_session__delete(session[1]);
+
+out_delete_ses0:
+	free_schedstat(cpu_head_ses0);
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
@@ -4528,7 +4724,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 
 	nr = cpu__max_present_cpu().cpu;
 	cd_map = build_cpu_domain_map(&sv, &md, nr);
-	show_schedstat_data(&cpu_head, cd_map);
+	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
 out:
 	free_cpu_domain_info(cd_map, sv, nr);
 	free_schedstat(&cpu_head);
@@ -4860,6 +5056,11 @@ int cmd_sched(int argc, const char **argv)
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

