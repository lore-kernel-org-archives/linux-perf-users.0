Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FD256C99;
	Tue, 11 Mar 2025 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694665; cv=fail; b=AguKBu1xq2ldnJqiGXhhdv9cOCB/R+TY5eQabsj5egTQ6ZywXqV5n+63wQPB0Imk5giPi/EBk7Tt7V/I3nx2KrTaRcS3hiol/QiRSKYSwiL+gU/rf2tGTipev4ZPeHHQksCRmrctYq0GhlSJl0C+kT/XY3cpbxexd7zADjxShU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694665; c=relaxed/simple;
	bh=GJPz6WxmjA3mClvXU056ckDgXAxUDikRx8QNIgpJYZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvWlpsZazlHccD3mSTnSWb8cBGX7mi9OxgHqBdADmhRRuVnGkjMP607o67w1f8+s2XD0APJ3C8+e5nge+snVPy2HQBaJiYgww9G34VIttjmU1+L0+TgoXjPTvaF6HCNCu6kDAJx/CYkNZnY4AxTrDvbZoB4D4RxQorfRoTHaWlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EbqqhnKG; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EbqqhnKG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiIsUnnQLBVxP0HLwETOFWRc04L8cXCcPfeofYOd4QR8GJb5QrZKUn7hSuRUfu54QL6vX1q0NtzBQSj9GTmJfaFZGKmDb7PBVtvQKIhhfOcvEltsMkVyj5IFd84aGLB4ZBGIL1d68C1gOIfzOwBTWvHCouR8xWIO8p8uSxyq409cJGyn1pnHpjnQg1/z2aKTVDu1nX6wnfJ5a4ZulEtL3nJKF3H/B1NwO6nPLwIjvFXjyyMfX0EmJTWdQUhbQ8SqEEHKMY7B2MqaLiEZdIODsZo7FsslZcAy7j98+pccHk5rnLHkYvjMvpOfehbPsR/t5czUNKkP2dYCtAx6JNEVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ8HwjkCDJTufXLopEvPwOCxSTeoImnphInByqjJwwU=;
 b=MQc/ixZNzCqw2UhfGYPRgCHQ9LwigNyYow6OqVQve81xo/FpwmCBF7ONX2+FgSjLVLgDRGeNZViTMZFRVzmWJ1XP58ZRT5y169Y78h3JLlMsI2aRC6tHIvinNg9W8+F7K0XKy3rrzn3SQfyAa7m8+Tg1rvfUlwNZ7gkDzrtuZJ3HJmg5p9bHhUdDD4HryD1q7m/ozTxF5Ad2qGkPzKXTCaDEiav1ikV20rLcRWUOgoYNEJ/aQyDLHbiMfVf9DGg+f7UbxVus0oikBUZDIMZwZ9CT/Y3HBnSVnhAMgqJo5MiXcxhLEzuNjs+MiSVWSIghdiff9+0gFpipxQEaHJZvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ8HwjkCDJTufXLopEvPwOCxSTeoImnphInByqjJwwU=;
 b=EbqqhnKGiMU+HSpAIBVAOu7GrkkMtSboA4Ltm7McBGTp371EDriDlTR2ssa/RREUvcYG78dja6GUMjmUIur8VCGrY2ZolLhsHQOB7eQAqytmRzpZh0AroteJGcOwe8F0UnWFZ8XfC2Kgcf9W4r2xGlHU2Ov1rJkrCg/PCCsYztY=
Received: from MW4PR03CA0082.namprd03.prod.outlook.com (2603:10b6:303:b6::27)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:04:18 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::84) by MW4PR03CA0082.outlook.office365.com
 (2603:10b6:303:b6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 12:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:04:17 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 07:04:09 -0500
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
Subject: [PATCH v3 3/8] perf sched stats: Add schedstat v17 support
Date: Tue, 11 Mar 2025 12:02:25 +0000
Message-ID: <20250311120230.61774-4-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 89df8e0c-2afe-4647-4186-08dd6094d96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RAXMgZCjc0gtogmnTUgnWDFFnx03z6fIyk9mc2QzUft0HLUetj57CqVuN4+6?=
 =?us-ascii?Q?QK4hrk/lq6eCviuSBBpzXdlvezyYkGJdUtx7HTBQeRWmHxrYNPmcKvJYaXof?=
 =?us-ascii?Q?m+5xShTER/bjN4jS7a+klQ1Ru4QM8Kk7NLts92Hwaf0K856fvf0WSwbjXxBj?=
 =?us-ascii?Q?WfCCkmeXIVH/+l8sHxjx2NchefoQl7HNmv3K6RifOIG2F0OK2nW2PrR+vagy?=
 =?us-ascii?Q?KdKM/cRRwvJZAmITFSDcpdALD+J6m9EVk6WXPQzNhcjL22sQ40laMt3oMJPC?=
 =?us-ascii?Q?wUnAbz3wDPjddQeZQbdaW75TRiKDcPOrvfoEwpCp6UKGSektO7An57duEfY3?=
 =?us-ascii?Q?whP8+jn6C03dZDXKSs2FS1oUVPq9+csnPx3cKYUpOLqhRcKaQ8lGsgwIhfP4?=
 =?us-ascii?Q?onJTZ/YRNL/pVlSL5jHAcL0smKSgxZPE1xaAMSiBDX6R4S83Ru/R6YsCk0aw?=
 =?us-ascii?Q?i7HpSVWQW1PPVy2urjQ6zEevqRc0KTi9FVaYIHMHA1NkCxrQe7Wv7pvjECcl?=
 =?us-ascii?Q?uW7PtdN2k8s1GBTUAoC+LjzfqMDyqdgvf3EO7eMP32EX4CmNbb+QUATbhdiC?=
 =?us-ascii?Q?Hep6RyUooR/xHX0OhDUH3Yc7JpqOflDPItKD2EeMUg0PXLjLq74uE7BCgFMy?=
 =?us-ascii?Q?YnFCk64ZGS2VxsrtzdlQqZa8FqX/bHBittC/QvT1QdROz/OEJyDD9yZ2sjgN?=
 =?us-ascii?Q?xPkJqlBAiPT5/pg65diRtDulqCxWPMyGYzAopcqqrJb3E7XYGC3kJcZMMRfi?=
 =?us-ascii?Q?soLooMFVlvYpkNlynU9IMPrdmSKpgEyMu7owa+z7f2gyuH6ADBCU0fYA613v?=
 =?us-ascii?Q?OiS84LcwgJF2CqViM8rHI05I+hXKe5uWGMckKMsExlSE/N5ysACBYo/9u6cS?=
 =?us-ascii?Q?HDNHzNQIHH4h9DMgkSxm0sRGNT0+wv9vmBVsuxEjhzDXCGNTyhbXG3YtOIzY?=
 =?us-ascii?Q?MuJxGb6wo5ittAc3HaUYANHCY7x1IiTiPcFFLRoG+bpN0A3LeSpg+RfbC0wX?=
 =?us-ascii?Q?Fn/ARekm+US2lhT4b5kaczqejj9kY6zwCmyPAJfyehEZpfcZ3q3QjlNB8tj9?=
 =?us-ascii?Q?TlOecZ+OHB05tZcdsu+L9DCiwmvvbfTLzSX6oDFpPipA4Ovc8aH5vFOL0uc6?=
 =?us-ascii?Q?AN+6HeND2raeLeZ8K9rtuzJmlhoKlh+MAApKhgilwqwTp9rNaDIBcuEarQaI?=
 =?us-ascii?Q?20/6Ljwx0lzIUiN7oe3gxbwqAiHBJqTQDNK7Cw+tyX4cDQqpUkmXuy3A6UyT?=
 =?us-ascii?Q?CtbP/RWYkq0g1s5AhacbUHqvyaAkZE6LQnudVbc+53PJ2k4X34SB09DS2iIT?=
 =?us-ascii?Q?McRcBLYU0y3GWO2IMm7do/y/2BsT33l0AoptS0JCBYT6QYcUN6o2/ui7gYsy?=
 =?us-ascii?Q?3O2fJ2sROxDFcncFzjWLynbgqvj+Bnf5vl7KG55XA+juXCiQkwnr+XJhxscn?=
 =?us-ascii?Q?tJoRyz5Jh8R/6VXTGTcdnWiyJ4MlLVV94EQN2BUdO23Gl++ygE8+Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:04:17.4289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89df8e0c-2afe-4647-4186-08dd6094d96f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v17 version layout.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/Makefile                     |  2 +-
 tools/lib/perf/include/perf/event.h         | 14 +++++
 tools/lib/perf/include/perf/schedstat-v17.h | 61 +++++++++++++++++++++
 tools/perf/util/event.c                     |  6 ++
 tools/perf/util/synthetic-events.c          | 15 +++++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index d0506a13a97f..30712ce8b6b1 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -174,7 +174,7 @@ install_lib: libs
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
-HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h schedstat-v16.h
+HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h schedstat-v16.h schedstat-v17.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 8ef70799e070..0d1983ad9a41 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -469,12 +469,19 @@ struct perf_record_schedstat_cpu_v16 {
 #undef CPU_FIELD
 };
 
+struct perf_record_schedstat_cpu_v17 {
+#define CPU_FIELD(_type, _name, _ver)		_type _name
+#include "schedstat-v17.h"
+#undef CPU_FIELD
+};
+
 struct perf_record_schedstat_cpu {
 	struct perf_event_header header;
 	__u64			 timestamp;
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
 		struct perf_record_schedstat_cpu_v16 v16;
+		struct perf_record_schedstat_cpu_v17 v17;
 	};
 	__u32			 cpu;
 	__u16			 version;
@@ -492,6 +499,12 @@ struct perf_record_schedstat_domain_v16 {
 #undef DOMAIN_FIELD
 };
 
+struct perf_record_schedstat_domain_v17 {
+#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
+#include "schedstat-v17.h"
+#undef DOMAIN_FIELD
+};
+
 #define DOMAIN_NAME_LEN		16
 
 struct perf_record_schedstat_domain {
@@ -504,6 +517,7 @@ struct perf_record_schedstat_domain {
 	union {
 		struct perf_record_schedstat_domain_v15 v15;
 		struct perf_record_schedstat_domain_v16 v16;
+		struct perf_record_schedstat_domain_v17 v17;
 	};
 	__u16			 nr_cpus;
 	__u8			 cpu_mask[];
diff --git a/tools/lib/perf/include/perf/schedstat-v17.h b/tools/lib/perf/include/perf/schedstat-v17.h
new file mode 100644
index 000000000000..851d4f1f4ecb
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-v17.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, v17);
+CPU_FIELD(__u32, array_exp, v17);
+CPU_FIELD(__u32, sched_count, v17);
+CPU_FIELD(__u32, sched_goidle, v17);
+CPU_FIELD(__u32, ttwu_count, v17);
+CPU_FIELD(__u32, ttwu_local, v17);
+CPU_FIELD(__u64, rq_cpu_time, v17);
+CPU_FIELD(__u64, run_delay, v17);
+CPU_FIELD(__u64, pcount, v17);
+#endif
+
+#ifdef DOMAIN_FIELD
+DOMAIN_FIELD(__u32, busy_lb_count, v17);
+DOMAIN_FIELD(__u32, busy_lb_balanced, v17);
+DOMAIN_FIELD(__u32, busy_lb_failed, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_load, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_util, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_task, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_misfit, v17);
+DOMAIN_FIELD(__u32, busy_lb_gained, v17);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained, v17);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq, v17);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg, v17);
+DOMAIN_FIELD(__u32, idle_lb_count, v17);
+DOMAIN_FIELD(__u32, idle_lb_balanced, v17);
+DOMAIN_FIELD(__u32, idle_lb_failed, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_load, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_util, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_task, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_misfit, v17);
+DOMAIN_FIELD(__u32, idle_lb_gained, v17);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained, v17);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq, v17);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg, v17);
+DOMAIN_FIELD(__u32, newidle_lb_count, v17);
+DOMAIN_FIELD(__u32, newidle_lb_balanced, v17);
+DOMAIN_FIELD(__u32, newidle_lb_failed, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_load, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_util, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_task, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_misfit, v17);
+DOMAIN_FIELD(__u32, newidle_lb_gained, v17);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v17);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v17);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v17);
+DOMAIN_FIELD(__u32, alb_count, v17);
+DOMAIN_FIELD(__u32, alb_failed, v17);
+DOMAIN_FIELD(__u32, alb_pushed, v17);
+DOMAIN_FIELD(__u32, sbe_count, v17);
+DOMAIN_FIELD(__u32, sbe_balanced, v17);
+DOMAIN_FIELD(__u32, sbe_pushed, v17);
+DOMAIN_FIELD(__u32, sbf_count, v17);
+DOMAIN_FIELD(__u32, sbf_balanced, v17);
+DOMAIN_FIELD(__u32, sbf_pushed, v17);
+DOMAIN_FIELD(__u32, ttwu_wake_remote, v17);
+DOMAIN_FIELD(__u32, ttwu_move_affine, v17);
+DOMAIN_FIELD(__u32, ttwu_move_balance, v17);
+#endif
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 64f81e7b7f70..d09c3c99ab48 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -569,6 +569,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -647,6 +650,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index e9dc1e14cfea..fad0c472f297 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2551,6 +2551,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 #include <perf/schedstat-v15.h>
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
 	}
 #undef CPU_FIELD
 
@@ -2589,6 +2591,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 	int nr_cpus_avail = perf_env__nr_cpus_avail(&env);
 	struct perf_record_schedstat_domain *ds;
 	union perf_event *event;
+	size_t d_name_len = 0;
 	char *d_name = NULL;
 	size_t cpu_mask_len = 0;
 	char *cpu_mask = NULL;
@@ -2604,6 +2607,12 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 		return NULL;
 
 	ch = io__get_dec(io, &d_num);
+	if (version >= 17) {
+		if (io__getdelim(io, &d_name, &d_name_len, ' ') < 0 || !d_name_len)
+			return NULL;
+		d_name[d_name_len - 1] = '\0';
+		d_name_len--;
+	}
 
 	if (io__getdelim(io, &cpu_mask, &cpu_mask_len, ' ') < 0 || !cpu_mask_len)
 		goto out;
@@ -2650,6 +2659,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 		low = !low;
 	}
 
+	free(d_name);
 	free(cpu_mask);
 
 #define DOMAIN_FIELD(_type, _name, _ver)				\
@@ -2665,6 +2675,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 #include <perf/schedstat-v15.h>
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2676,6 +2688,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 out_cpu_mask:
 	free(cpu_mask);
 out:
+	free(d_name);
 	return NULL;
 }
 
@@ -2709,6 +2722,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 		version = 15;
 	} else if (!strcmp(line, "version 16\n")) {
 		version = 16;
+	} else if (!strcmp(line, "version 17\n")) {
+		version = 17;
 	} else {
 		pr_err("Unsupported %s version: %s", path, line + 8);
 		goto out_free_line;
-- 
2.43.0

