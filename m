Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96315B98D;
	Mon, 16 Sep 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505383; cv=fail; b=bYY5J2TrDpAy9Ec25TyOB9D8mF6cHrIQlMui7EXntbKTKOMs6veBlRclLR2vZexr5jMKvLuzFRg3oh9aTHQosCSxGsqExgRLzGa1VNd5F2huSHsX14VA35eM3lhnXp//Yf//Dx0QUMITlmgGvOt6H/1Mt6sy6+2PR5qQJoS+cYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505383; c=relaxed/simple;
	bh=VYadq/pQdFtlHwvLBpwDZ4iuFVSbNlXLON2+RZOqemg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5RYlx/pYdWZWBiZMb3CGSXvCQNIavYV9CNKBSlfsh0RIMxf0fdKGvKbha35ND9IKO7vpTW9xBILy7hswRuPStruYutm8ZudIXdvDPMNPRBBukylnxqSMOhJivZHzM48i1SyHIbam1c/jOwKcDA7AZ2wFEUwIg9DZeX5qHL5inU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oxIbiDRk; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oxIbiDRk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkVelYa2SO2+Nz0NfTkN6s6pG+uQTWMk4d1yb1Mthfet8t/QEvCQwzIgG8WenEzK66QSB6FQlz/KozfX78Tz7cd+L5npW9bJTt1siF2cr2yqZeZpSqngxHvPQvTz+PiZSC3pc9kmfQLwnBe1BEE91oxyScmibBuXDpzUQaVymerAXR+oQ57D+A6LdIaOFNS6PjyFX4BbfverD2vzlXTVm+84l+cj1bepxi/SQF3aRJeoB9uLh0QIXbjbPQMMc+CfDNQPH5NUJ6XiqVwlnOa+QQx2yj/DqpwEEozxAudxMgSf+EzcyinDOiagsjAoV4/c3LQUpKaFS7rUiInGqncrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY0TYS50jFo4uHrm0lugMUIlpOgjCH8mTorv2Ukl500=;
 b=c2o2UIvwhod5J5lUJeTJElY1TXbDbwpjgnXY55+NT180yOdgLtMOGEBfdsqif+gqt/FZ5aTcw8ePk/CZ6qZixcs4QFAb2WmvCxq8ARLenZociXE1ZgZTIZoNwyfAP3tPfK4olWjVHvr9ZGQ5mLM03w/gze3WXUF5FrIpxp/OvTcSWeJqOMGI0DCwxGSFq/Tor4q6E/3aKUbOLThCBdAEB+34+GXAMHqDr/ItUVjb0gnYRpPX9XsSrwNuUXwnqKPG1EsbSGpBeRsRSgiw+jIE6rTSMzhxnJZSCjWntJ6mNEhFH+IHvun3JeSIJceo3RT2E9bYzmhVLI0I4rozjcnxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY0TYS50jFo4uHrm0lugMUIlpOgjCH8mTorv2Ukl500=;
 b=oxIbiDRkDYnAoM5fbhJPBl+gAXNI0bX5gBOGwaOwdDk6Pw5LYAMIK+SkE5aiyBzuRNTAPUppvJyRItJO9xChlOtdJGFBuCfoSonhzZM5ybztVdvLi/pNx9hQKl16BPpDhqaznpZuC/Yn4+oFveBAL140wWGbHnwMmMdypZTtP3w=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 16:49:27 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::e3) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 16:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:49:25 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:49:17 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<bristot@redhat.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 3/5] perf sched stats: Add schedstat v16 support
Date: Mon, 16 Sep 2024 16:47:20 +0000
Message-ID: <20240916164722.1838-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8cdeaa-b69e-4bdc-ce70-08dcd66f860a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c22ivYHwxXQsWsPyujqSEPc7IEKne56znlTSkGqYAUbjU6ZMIH2J66VVWkGT?=
 =?us-ascii?Q?ZXzAHVsAm1W1tgMQLchjmQ3vkCKHohrjHCy8SBmVI/uKfd0r6REJ4sL2Lion?=
 =?us-ascii?Q?aQQh6W9f3v+nN6jfm2iUcfUPomXJTxASTDiweLc74AAtCnFNNZedlJKTHTzI?=
 =?us-ascii?Q?vktn3HI2ERKPPAdU9CjyCK2prHWZmCyU9t075WC8ogIiFBhqRwHw90DKF9L4?=
 =?us-ascii?Q?FVusAH8ewigb2ajPz21kBTUqNMA+slYlNHl2bdHaoENgke4qV3dyvXG/mF8i?=
 =?us-ascii?Q?1WGEX8lDJLIN8hY073A1ee2JP7K7XRoZ9JylEIWPRxfCFMXvIC8li3mJ/ycw?=
 =?us-ascii?Q?rcFxLhkIpsJhbNbyyQ9WsndKchO1jsXSWcS+ewPXDijWpNPNRMUj0L0R8htB?=
 =?us-ascii?Q?OlPpT/7P/Sgg2d6Xnvpfr0yQiN+yI+xKYTBMzD/l/PvTl/XRTpLuyY+Vc3x4?=
 =?us-ascii?Q?AoLf5nOX6cEzLoH3ydTw0a2kiX91KxrNg/IPp08xcdObg74g4ur9XTTic+TA?=
 =?us-ascii?Q?BlQYhdaNV5Ovms6yBQG8d/HxsK/14s/gJuRzbNA1VcqOIe684UAQCYbkO7WC?=
 =?us-ascii?Q?nnAK/O2kGR3ng5pLVlXXYCRoYSdeVh8Nvnv7PCgZmH4cn0d9c79puxb/PBZJ?=
 =?us-ascii?Q?OVs04NnT/uqhY4yyrmzuTnhp5dygr3YntaF3bu7JigVMgq2u04D2FRrIPeKQ?=
 =?us-ascii?Q?1lQUuXvB3wTOU7RM2mBq+sVIkSsErtplbgqFna/8WhNTcYnFXaY4k60IxVB+?=
 =?us-ascii?Q?jC2LUUfJPYkacOSv6uD3et2VTYNzgtps/Hr4TkmRNb6Aiav/Qb07UwS+fzM8?=
 =?us-ascii?Q?6GOGDeB/eFiWxHmm/4bckBKObF99G2UKnk1DDW+DjDnQ/coOn4ZT/HmgnL4U?=
 =?us-ascii?Q?DxlpzPRrUy1uvgJf/vBdy0U0UpFCxdqa7EKv3IVSB1rFararJ+rWm1ROaHkc?=
 =?us-ascii?Q?OdvKu9OjMhVcfvmp9Q/BI62y44bz5Ret4LosUYG1ewQdV+e4pUPOCo8HYkkz?=
 =?us-ascii?Q?k656fknYKeCwwl4GQ2hmlMUqexMHT5x4vpgW+OUoNRzxbrHy77dR3fk+VE9W?=
 =?us-ascii?Q?64dLyGd2Q9LiQlnVPnsgSKzct3KGWqRpeuQ0wS27DmfvPXly0wIYgeH+yD+H?=
 =?us-ascii?Q?aqhZ/WJCApvfS3i8HSTVHZSEeiHfeC5ZTIhJfm6H2FVCsngxD8EnaA13r/L0?=
 =?us-ascii?Q?9KcHb+by30mpzgtP8cqXdaMA8We5OZEe1+k0aQO7LuFG6/gakfZr/7RFWODm?=
 =?us-ascii?Q?UlOwBvr3qV8mmPe9Wuxdgc/caglbFPa8QClibaTjYg7iyZJAMOIJMuzmDAUP?=
 =?us-ascii?Q?jc2yRUAJkkcquuNS2okCPWbTZPgvT8KB+9ILvTBsoYiGat51XzKEZibjF+kc?=
 =?us-ascii?Q?eA8W+fTF75jDkVISsSp4e9/X9bxbmRMGnG2CQ8u9uEApz/zw+/NF00u2hUe+?=
 =?us-ascii?Q?CHcRy3KC8t991RlB76jW4vYEpmqu04mv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:49:25.6930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8cdeaa-b69e-4bdc-ce70-08dcd66f860a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v16 version layout.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/lib/perf/Makefile                       |  2 +-
 tools/lib/perf/include/perf/event.h           | 14 +++++++
 .../lib/perf/include/perf/schedstat-cpu-v16.h | 13 ++++++
 .../perf/include/perf/schedstat-domain-v16.h  | 40 +++++++++++++++++++
 tools/perf/util/event.c                       |  6 +++
 tools/perf/util/synthetic-events.c            |  6 +++
 6 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v16.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v16.h

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index ebbfea891a6a..de0f4ffd9e16 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -187,7 +187,7 @@ install_lib: libs
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
-HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h
+HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h schedstat-cpu-v16.h schedstat-domain-v16.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 35be296d68d5..c332d467c9c9 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -463,6 +463,12 @@ struct perf_record_schedstat_cpu_v15 {
 #undef CPU_FIELD
 };
 
+struct perf_record_schedstat_cpu_v16 {
+#define CPU_FIELD(_type, _name, _ver)		_type _name;
+#include "schedstat-cpu-v16.h"
+#undef CPU_FIELD
+};
+
 struct perf_record_schedstat_cpu {
 	struct perf_event_header header;
 	__u16			 version;
@@ -470,6 +476,7 @@ struct perf_record_schedstat_cpu {
 	__u32			 cpu;
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
+		struct perf_record_schedstat_cpu_v16 v16;
 	};
 };
 
@@ -479,6 +486,12 @@ struct perf_record_schedstat_domain_v15 {
 #undef DOMAIN_FIELD
 };
 
+struct perf_record_schedstat_domain_v16 {
+#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
+#include "schedstat-domain-v16.h"
+#undef DOMAIN_FIELD
+};
+
 #define DOMAIN_NAME_LEN		16
 
 struct perf_record_schedstat_domain {
@@ -490,6 +503,7 @@ struct perf_record_schedstat_domain {
 	char			 name[DOMAIN_NAME_LEN];
 	union {
 		struct perf_record_schedstat_domain_v15 v15;
+		struct perf_record_schedstat_domain_v16 v16;
 	};
 	__u16			 nr_cpus;
 	__u8			 cpu_mask[];
diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v16.h b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
new file mode 100644
index 000000000000..f3a55131a05a
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, v16)
+CPU_FIELD(__u32, array_exp, v16)
+CPU_FIELD(__u32, sched_count, v16)
+CPU_FIELD(__u32, sched_goidle, v16)
+CPU_FIELD(__u32, ttwu_count, v16)
+CPU_FIELD(__u32, ttwu_local, v16)
+CPU_FIELD(__u64, rq_cpu_time, v16)
+CPU_FIELD(__u64, run_delay, v16)
+CPU_FIELD(__u64, pcount, v16)
+#endif /* CPU_FIELD */
diff --git a/tools/lib/perf/include/perf/schedstat-domain-v16.h b/tools/lib/perf/include/perf/schedstat-domain-v16.h
new file mode 100644
index 000000000000..d6ef895c9d32
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-domain-v16.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef DOMAIN_FIELD
+DOMAIN_FIELD(__u32, busy_lb_count, v16)
+DOMAIN_FIELD(__u32, busy_lb_balanced, v16)
+DOMAIN_FIELD(__u32, busy_lb_failed, v16)
+DOMAIN_FIELD(__u32, busy_lb_imbalance, v16)
+DOMAIN_FIELD(__u32, busy_lb_gained, v16)
+DOMAIN_FIELD(__u32, busy_lb_hot_gained, v16)
+DOMAIN_FIELD(__u32, busy_lb_nobusyq, v16)
+DOMAIN_FIELD(__u32, busy_lb_nobusyg, v16)
+DOMAIN_FIELD(__u32, idle_lb_count, v16)
+DOMAIN_FIELD(__u32, idle_lb_balanced, v16)
+DOMAIN_FIELD(__u32, idle_lb_failed, v16)
+DOMAIN_FIELD(__u32, idle_lb_imbalance, v16)
+DOMAIN_FIELD(__u32, idle_lb_gained, v16)
+DOMAIN_FIELD(__u32, idle_lb_hot_gained, v16)
+DOMAIN_FIELD(__u32, idle_lb_nobusyq, v16)
+DOMAIN_FIELD(__u32, idle_lb_nobusyg, v16)
+DOMAIN_FIELD(__u32, newidle_lb_count, v16)
+DOMAIN_FIELD(__u32, newidle_lb_balanced, v16)
+DOMAIN_FIELD(__u32, newidle_lb_failed, v16)
+DOMAIN_FIELD(__u32, newidle_lb_imbalance, v16)
+DOMAIN_FIELD(__u32, newidle_lb_gained, v16)
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v16)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v16)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v16)
+DOMAIN_FIELD(__u32, alb_count, v16)
+DOMAIN_FIELD(__u32, alb_failed, v16)
+DOMAIN_FIELD(__u32, alb_pushed, v16)
+DOMAIN_FIELD(__u32, sbe_count, v16)
+DOMAIN_FIELD(__u32, sbe_balanced, v16)
+DOMAIN_FIELD(__u32, sbe_pushed, v16)
+DOMAIN_FIELD(__u32, sbf_count, v16)
+DOMAIN_FIELD(__u32, sbf_balanced, v16)
+DOMAIN_FIELD(__u32, sbf_pushed, v16)
+DOMAIN_FIELD(__u32, ttwu_wake_remote, v16)
+DOMAIN_FIELD(__u32, ttwu_move_affine, v16)
+DOMAIN_FIELD(__u32, ttwu_move_balance, v16)
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c9bc8237e3fa..d138e4a5787c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -566,6 +566,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-cpu-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-cpu-v16.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -641,6 +644,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-domain-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-domain-v16.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9d8450b6eda9..73b2492a4cde 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2546,6 +2546,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 
 	if (version == 15) {
 #include <perf/schedstat-cpu-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-cpu-v16.h>
 	}
 #undef CPU_FIELD
 
@@ -2667,6 +2669,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 
 	if (version == 15) {
 #include <perf/schedstat-domain-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-domain-v16.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2709,6 +2713,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 
 	if (!strcmp(line, "version 15\n")) {
 		version = 15;
+	} else if (!strcmp(line, "version 16\n")) {
+		version = 16;
 	} else {
 		pr_err("Unsupported /proc/schedstat version: %s", line + 8);
 		goto out_free_line;
-- 
2.46.0

