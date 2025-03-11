Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446A9221F03;
	Tue, 11 Mar 2025 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694725; cv=fail; b=PqAyI2r1N0zZ0+rTmCWx9/BsHDnsHeu4P8pf7mCJKFrAI8s/AaPzoNcPmKjoLsEWAFUW2CB9l8hiibC1prL+Y76V89yYlKtU0QtJV9ghzbpSpqFg9qKVOeoyc01Z2GCIAmkcLMV48S3zxLDLJyxSj6xWdRmK5i8khD1+Pqn7j0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694725; c=relaxed/simple;
	bh=FV4vZTOeRUe3PeoRLa8cbMpokBonRes0sCrRFIhBtPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1QmpDm/qsepGDxvXRXJw8cJS9e/VswwEWkvp54Vz3le/nWs3DQpZIiY1arVADZvu7xB+DpwwWw5hNTareBMJ/86J7ywck3kIhD2/bE3RiVHMgLeNTmnLkYHK7417u/gwMGcHxOw5Ybp0EiK12cV36SxOfq+aPm3zYjGx/mbkY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rRLp5RDM; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rRLp5RDM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYBCeh37FDCm9FFH2qkccOlQK6xE7g0jEzsay1CLyBCJdJZyFAqa0WHkVpzJ9XEg/y8jf8dA8fAi+KQ8AhlC04tE2cjK60i5/kFKxOdXteU1xtMFsR4MBw6qpx0xbxsSFsDGCyiEfmrRclIAo9QndHVdgHm88DfBJuV2C9f3RxTbcYBCd9dmCOUYC65rcBfRY/gBLqwC9OBz3XhJbBiiRuajdO7eCNGe33B731Vw9RLq73yB98jZEX+uUhUr53y55YAMfC1ZXqoiCWKI1S+ZoNEveB0GlyGpjiSPJIJTmZH5a0s18p0aBqFD3QHW60sfmesecSF87/CubbOmudzWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UphJ92aazSkNPyK5n0atPTQmWHt7/pcHpxzTV/Yqx0=;
 b=fDJHmcN+0kBQbOjej0WAiG2d9AAw+WLrkcC3QsT55uh4WuQmcm9SmG/eZLPlm29+Olo4QLa4etJZJx4qJJMKrldodc5/UfWwUUj/96uXk+5E6TtwTYprJHQWZwnHuDgVcwsH93hlsuodPCuya1XmzUYMeqnKw2y+7CPGdiwOFxLqi56PY4E3b3vpGGXzuIfMhyFOrKJXZt/NV6Eha28kgMCXbkdsHjSFyYfeCvSOMDoDq9dYp2WHFLNnBkx/3w3d1IuOXE9+LeAkvdDhlcTfjH9ENJJVo/z1YHTRDXFpBBaf7hDpzwOt4yM9FxjVP7bVi6XgdDLpTVMN3/E3GHNRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UphJ92aazSkNPyK5n0atPTQmWHt7/pcHpxzTV/Yqx0=;
 b=rRLp5RDM/6oWrB+XnmTRN0qVC/OXR2btVOmtRhRUZn9IuLvd6IHfYlYU5XSieQjPKNPZf5X2GooMt3grujVB2M782XVYRnn6ccXMyL7AU5a7fBr0KonQxZJ16Spx+tZny+TqyiQk9WbUo4LtVEjeCfGOLXyxwkPuR+Hel0gV6hs=
Received: from BYAPR08CA0030.namprd08.prod.outlook.com (2603:10b6:a03:100::43)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:05:19 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::67) by BYAPR08CA0030.outlook.office365.com
 (2603:10b6:a03:100::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 12:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:05:18 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 07:05:10 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 6/8] perf sched stats: Add support for diff subcommand
Date: Tue, 11 Mar 2025 12:02:28 +0000
Message-ID: <20250311120230.61774-7-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311120230.61774-1-swapnil.sapkal@amd.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 77552329-c427-44f8-e579-08dd6094fddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cA+oHqcRthGWimvvcAfgYqKkYkK9+qh75elnxX7BFw/2uXVnRqwJLMkBNRbw?=
 =?us-ascii?Q?nqHR67nALU8dKxE3CR3r91ZSmtNfXJL+7bFeK7foHPq0jqA5UEO+4LM3h3fl?=
 =?us-ascii?Q?dpdHB8cxfYWTJbZaUlih7kK0qrWm61S+1tNp9WC7lROV+cKH47cehYDHQfAX?=
 =?us-ascii?Q?nsE1d6pGvpFDFOXsBguEjlHe4uM/R2JfabDEJL5JhbJ9T802t14WGcKbVcz1?=
 =?us-ascii?Q?OZlutBquBXxk413HVLTeFpPXHxDRDrVuTrDnA/fskIjwRuBobw9RWEVlFRkY?=
 =?us-ascii?Q?YV063UoUXO7KnrY4ghnUNzY5LZG3jNeQw5+HT/JsrKYY73ya0BeAu6BEbQup?=
 =?us-ascii?Q?A+RVYN6HGYWnEQP8zFxUDzTZVfpprlA5oa45iqPU1fFlcNxEJU/bmY4/4iCb?=
 =?us-ascii?Q?bHsjwcVT67gSVLIgdhKa2BGJ6LRGTg8imtQ8i/2vbWUWpFQc64V99hgfGOoQ?=
 =?us-ascii?Q?lL3QkhYTBcR/xG3TNASZcxSK1crSk0BS4s+vaytoNlPTK/I4TZf9ZQQ8P2AU?=
 =?us-ascii?Q?uShloNC83zSLTDJXPOGhB/0L65cHNz2hJ85478cmliTSLso3oBZfczJ1/kW7?=
 =?us-ascii?Q?Cenx9bCszOaLzNv8HQDkgzxKxw52hxEtfTL7JzSqqmm5CEb5UHhHmLBagv0A?=
 =?us-ascii?Q?fuHDtCplTERR3P7XNc/sBhApBcgum8yfnZU4ZPtbwlciT34HEQ5fC5yfKzma?=
 =?us-ascii?Q?dIHJmPWHMIj/AFtaGUphs4fXJffepIRBX9PKGYRHOcv9FYxZ7RYROdGmI6KR?=
 =?us-ascii?Q?F5owSJmNSQI7vYlbniaNoWy/ETuh4lqPiVjDx/6kFE0AnaUwJDy9ZT628/5X?=
 =?us-ascii?Q?88oI+WD/GYoVwhQWspy1zFhwfW6LPlUx/j6vW6/gTZ/sSSZxag504mzeZmIH?=
 =?us-ascii?Q?ERzwJkdPQV+/VmntA+oZxCdhQZ8WtIMWKBMKPOs/ynIgtvMjbDP9owy233pI?=
 =?us-ascii?Q?krMjSDdQvppBU/mYoBfFr2QOrlT8ugUGJ/6J4VC7QZbqBeIYmrxNU+2rHMrp?=
 =?us-ascii?Q?ZXzeRwyQDqBMQErUaR6QuR7UyjGavHVDec+1GUW2o96ICSzirz0Z3nZ9KnEK?=
 =?us-ascii?Q?DjYsryIO/PdmLCH5Z1VHsov9HhPT6q20W+RtxfMtc2AFdIiTPau3KB2iW86Z?=
 =?us-ascii?Q?GDWy+cQyc7bsLZ3ThnYkGlPNt9QSaO2GApOu3AYIXn8tNbtdlXxVMGFuRv1t?=
 =?us-ascii?Q?s2AiDYWQx84VeD0n5H7nmpDP4Q7lHrSkzz3wcHbP7T2O48sTayups5EizeXi?=
 =?us-ascii?Q?X6e0OlXPWnXGaMZ1dcYM2h1qS63VaUJhImUt4Rj7j/JPpPNzlSIbIyycQjYN?=
 =?us-ascii?Q?JN1WLKywubjSoc2T8B91jkWqfUM7GAXio2+r3GMnbJAm4IIrooa8PJTu60pw?=
 =?us-ascii?Q?415CsVqcMPkq8uWPyAM+tH76Kls/JtPAld7gspule9VKpJtJ/Pbe24n+21lE?=
 =?us-ascii?Q?ffiTix7KBEcyqP4bI0JkHm7tsAp5vNoqJMabBHTdjQ13T3lkOAaugBTovRio?=
 =?us-ascii?Q?rM0/sRRD/38qGt4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:05:18.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77552329-c427-44f8-e579-08dd6094fddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

`perf sched stats diff` subcommand will take two perf.data files as an
input and it will print the diff between the two perf.data files. The
default input to this subcommnd is perf.data.old and perf.data.

Example usage:

 # perf sched stats diff sample1.data sample2.data

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 277 +++++++++++++++++++++++++++++--------
 1 file changed, 221 insertions(+), 56 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9813e25b54b8..bd86cc73e156 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3938,28 +3938,44 @@ static void print_separator(size_t pre_dash_cnt, const char *s, size_t post_dash
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
-	} else if (cs->version == 17) {
+	} else if (cs1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -3967,10 +3983,17 @@ static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
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
@@ -3984,27 +4007,54 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 
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
-	} else if (ds->version == 17) {
+	} else if (ds1->version == 17) {
 #include <perf/schedstat-v17.h>
 	}
 
@@ -4014,6 +4064,7 @@ static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
 #undef CALC_AVG
 #undef DOMAIN_CATEGORY
 }
+#undef PCT_CHNG
 
 static void print_domain_cpu_list(struct perf_record_schedstat_domain *ds)
 {
@@ -4169,13 +4220,13 @@ static void get_all_cpu_stats(struct schedstat_cpu **cptr)
 	*cptr = summary_head;
 }
 
-/* FIXME: The code fails (segfaults) when one or ore cpus are offline. */
-static void show_schedstat_data(struct schedstat_cpu *cptr)
+static void show_schedstat_data(struct schedstat_cpu *cptr1, struct schedstat_cpu *cptr2,
+				bool summary_only)
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
@@ -4186,50 +4237,83 @@ static void show_schedstat_data(struct schedstat_cpu *cptr)
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
+		if (summary_only)
+			break;
+
 		is_summary = false;
-		cptr = cptr->next;
+		cptr1 = cptr1->next;
 	}
 }
 
@@ -4358,12 +4442,88 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	perf_session__delete(session);
 	if (!err) {
 		setup_pager();
-		show_schedstat_data(cpu_head);
+		show_schedstat_data(cpu_head, NULL, false);
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
+	show_schedstat_data(cpu_head_ses0, cpu_head_ses1, true);
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
@@ -4442,7 +4602,7 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 		goto out_target;
 
 	setup_pager();
-	show_schedstat_data(cpu_head);
+	show_schedstat_data(cpu_head, NULL, false);
 	free_schedstat(cpu_head);
 out_target:
 	free(target);
@@ -4770,6 +4930,11 @@ int cmd_sched(int argc, const char **argv)
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

