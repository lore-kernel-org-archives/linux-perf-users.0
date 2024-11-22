Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140D18A6A0;
	Fri, 22 Nov 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265233; cv=fail; b=aO7C3kSJwqgFEOMYiTvoCYMpl9y7jASZcHskNX0OXN8qmEjZd05oQajN8f4DvKhqGc2ExZPG6Mkj6n9y7Vec6gg/I1v2cmpdzpkfpvGYFcfzcr60KdWZX5/EnV4UuZr0DEEviVBmNGQEfD0vM3Md+eDY5zk2ZCizMmuHfVF3VEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265233; c=relaxed/simple;
	bh=L1uhnVYrkcJnTBeOoJX6ETJmd9Tqm8Fpldrh6NBAl/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KA6vTsSfS6gsdr94vTkiNPQInNgkW0mbzu+mzLl4eqhX/lIqiMeS3lwZRWjWyC/c+087OR6AIy+3dVCMt8M+JrBO1qAkjYTTpmq6NOjJB7/ySrLKx7USpbnNW83pWSSucY0T2MO2SVhsEBLLNVIA8irUsZ6Fz8JxUIOGNlVzZJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SM+bSd3v; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SM+bSd3v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJvlWKQZeTnXOeMV1pXp8iUQ4xH6dPE5oqELAVga+359IL3gyo9v2BHZ6sbFLJvk+GVhNAuiJBUwjm1QWM+BOep26GWVuGwLiwxMWUxK2RiGmTgKwnJ7SSZKCICYBmFYNWAW9VoJFR9aXYv3JgKRfuLTCKtWqh7QCZVmSnzFaFNSLZcT9bEZTEpOk9pCUu6vHe8FBIBWwXL5+EQyrCN6Qw4U/or35aXfsSz8B8aAvUqoO2DPVPDlY3txB95taLVLuTTMoyPsgP94JWvUaODCC4hR/ynQ1b0n1EswBs/0my9nzvMDudcakpHhMq+RSSZio0+TkSunfiN4Gp+eFVJLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YtOYfrtR6ex2FFTrsSBIvUsz5pDrdA6NJBvTleRGPg=;
 b=cc2Z83cxclCTn+9vigDnjkotdQexGh6tXk7PtACX10YarQ4ZuYu7syMR1L7atA4lYflahqcrOcEWFH7b/sMWaBwEZFMVdcfy+sBzURrrTOd3GaLgJMj5Q5OQL0wx4aZyqrNyazbBD5wUvLf3lPdp9VOthroRUjxMpz1lEDnq5C5tA5XnqBG7ts+j7H0kQpTlVA43BCBhqBoTCl5WUAAl+eJ/OBcQYrbOwGKwV8OvuD3NJ/wYs5mYwuP1SV0LVpnSj8RjBAfL56OxRc1Ou8eDlNUfyk+PsZevnxRMF8whrj+0WpW9/xueB7GD6A+vFgjL3VzbiNXCZJbh2GJu7z89/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YtOYfrtR6ex2FFTrsSBIvUsz5pDrdA6NJBvTleRGPg=;
 b=SM+bSd3vnYjXK6lzL19F0/4drgBf77RWvp1Z8qGqOc+8YbVPAh1qx2mONrO9+ie6YNWxr+4OVkUN0UNeG2CKtr2qMgdt7pHSVCT9YqDx+prfskmMK7QgSl31oBcxB7j3cUUECijkMKETp9oS2yMlFtmNTUMQ6w5zhfBVPH9ddnE=
Received: from BLAP220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::27)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 08:47:06 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::e9) by BLAP220CA0022.outlook.office365.com
 (2603:10b6:208:32c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 08:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 08:47:05 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 02:46:54 -0600
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
	<swapnil.sapkal@amd.com>, James Clark <james.clark@linaro.org>
Subject: [PATCH v2 3/6] perf sched stats: Add schedstat v16 support
Date: Fri, 22 Nov 2024 08:44:49 +0000
Message-ID: <20241122084452.1064968-4-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: b8aa4393-f188-4968-9b19-08dd0ad23dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fj0DPry7XTo7AN3aw2Jm+8lP6hAZanLgny7lwHTAa+7tIA2QmmcfHDbUBNIG?=
 =?us-ascii?Q?i3ppXYdOfqAx3RERr15SOzlLiCTO8TfDoXOuZkZgkcEd3jGqfnw8sxINv8Ue?=
 =?us-ascii?Q?Z7Sv+Ezl8QCUdqDWsWZgPwkvZYZW1EjK4B2NZTi1yR5AUHLCAQjwrUBntil6?=
 =?us-ascii?Q?p7q52LvHMzwGtYK1svXOMWRpwr+L1/E2bw1q9oQNh+o8+mKoxXBizkRisv6E?=
 =?us-ascii?Q?NARXJV2u/5fVnoLLzHGGvrW0G1g0H6u8i4Jct7BuToEM5DFQhjBf9YEAGHS5?=
 =?us-ascii?Q?dXeKN89Mm/Bqr9zglLlPmZzLy8yDfa6AFQVR2rfpAv92XUWnK/lDNCwOWxhL?=
 =?us-ascii?Q?WAF+J3qd+K8YkgO0oyIhUyjpw7q4KvZoSbunWvIoDcG81IyHDyAJBj3A8RUR?=
 =?us-ascii?Q?kLIGdBvDbXrtOrQ8GKFwXmHb1+Wb+FOUUjwUJZoINTRviVw419+2hd4dm+xi?=
 =?us-ascii?Q?/lnZUzk0l1pUTLhxxiz1SVt00tvji5pu+s9BAsVk2dLlEGqVkyqLJnnrduK0?=
 =?us-ascii?Q?kb4+G0sMr5owzPXWpayxkN+jrFLisI4ExGD44M7HTLeDZA2geMJmkIL3EDai?=
 =?us-ascii?Q?gX4Ku+qgBlmj5mV76/WON3zwpPnSwnKGl/5O+wUvMw3RZq3f46Z1+x0jhYjS?=
 =?us-ascii?Q?IfxUnvDyMbh3OuiJye+Qe4Wy53l7R3kRuh9LRrl3nVCQ6hfZIz6QPwepRvK+?=
 =?us-ascii?Q?59DtoBCN5WNktRWkxMGegTuzhgTOmpv0thtW9K9bVvWchhdbKSmB3rNN8Dv1?=
 =?us-ascii?Q?qzmz5jLfYlFSFqO3PZ5AEtLkYiN7w41FgZXoNlGy64T+C541aLBJjOKonovd?=
 =?us-ascii?Q?yKTvN86CCPHfGtAQJxnZsX06VBEwkUyVmF+BudaOSAPnsUYpHvoS002xzqv6?=
 =?us-ascii?Q?yPx4f/9g5Sqf2z2NagB65PlK9xfSvm0Li58gvFwK4fPV6ixsrtOenTuy9hG5?=
 =?us-ascii?Q?Dqee9+0l7FOGZ2S5vOqTNgRR76k3bvDLoYZU+kmEDiuRzfW69s0ptMwbeLiX?=
 =?us-ascii?Q?HUvbuTJ9JwqFCj+JOIiQAmlCNHnPf70EbdvNbodX5Z2qv7H5NJl4YGp7OMAz?=
 =?us-ascii?Q?O9OvMTNnxpCheJJuRoTGVIriGu4kkJyyKhWejnWoL42MM/nMDpuHoNN6IyUx?=
 =?us-ascii?Q?3w2psLChqSIip2wZ9UB5LlnlqT6qVUh+ok4C4+lZ1xfcOnw+qpaF+ylea0tz?=
 =?us-ascii?Q?nVHoM1uhN1iewOrLdC9AxRtxaMCyjx69LTAp3abzYOe34vUyBn5lhFZEJnZk?=
 =?us-ascii?Q?WY6PTqdCLIJavohURPTAIDkD8KaqGvKUNwu2miIRo5opbaI0XoEMfZbPg9/I?=
 =?us-ascii?Q?FhN2sin+tytIpiYTw5xotPWauBwS9SDEz02C8ihzLBZFHlvACdiBSa8XbbC/?=
 =?us-ascii?Q?S7bSKZIROuEyDynaHZDsgjn8AqrRyJG/VaY/WQXuHY+vNK8IAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:47:05.4850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8aa4393-f188-4968-9b19-08dd0ad23dfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v16 version layout.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/Makefile                     |  2 +-
 tools/lib/perf/include/perf/event.h         | 14 ++++++
 tools/lib/perf/include/perf/schedstat-v16.h | 52 +++++++++++++++++++++
 tools/perf/util/event.c                     |  6 +++
 tools/perf/util/synthetic-events.c          |  6 +++
 5 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 43a8642e4bab..066c1d85425a 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -187,7 +187,7 @@ install_lib: libs
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
-HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h
+HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h schedstat-v16.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 189106874063..8ef70799e070 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -463,11 +463,18 @@ struct perf_record_schedstat_cpu_v15 {
 #undef CPU_FIELD
 };
 
+struct perf_record_schedstat_cpu_v16 {
+#define CPU_FIELD(_type, _name, _ver)		_type _name
+#include "schedstat-v16.h"
+#undef CPU_FIELD
+};
+
 struct perf_record_schedstat_cpu {
 	struct perf_event_header header;
 	__u64			 timestamp;
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
+		struct perf_record_schedstat_cpu_v16 v16;
 	};
 	__u32			 cpu;
 	__u16			 version;
@@ -479,6 +486,12 @@ struct perf_record_schedstat_domain_v15 {
 #undef DOMAIN_FIELD
 };
 
+struct perf_record_schedstat_domain_v16 {
+#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
+#include "schedstat-v16.h"
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
diff --git a/tools/lib/perf/include/perf/schedstat-v16.h b/tools/lib/perf/include/perf/schedstat-v16.h
new file mode 100644
index 000000000000..d6a4691b2fd5
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-v16.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, v16);
+CPU_FIELD(__u32, array_exp, v16);
+CPU_FIELD(__u32, sched_count, v16);
+CPU_FIELD(__u32, sched_goidle, v16);
+CPU_FIELD(__u32, ttwu_count, v16);
+CPU_FIELD(__u32, ttwu_local, v16);
+CPU_FIELD(__u64, rq_cpu_time, v16);
+CPU_FIELD(__u64, run_delay, v16);
+CPU_FIELD(__u64, pcount, v16);
+#endif
+
+#ifdef DOMAIN_FIELD
+DOMAIN_FIELD(__u32, busy_lb_count, v16);
+DOMAIN_FIELD(__u32, busy_lb_balanced, v16);
+DOMAIN_FIELD(__u32, busy_lb_failed, v16);
+DOMAIN_FIELD(__u32, busy_lb_imbalance, v16);
+DOMAIN_FIELD(__u32, busy_lb_gained, v16);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained, v16);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq, v16);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg, v16);
+DOMAIN_FIELD(__u32, idle_lb_count, v16);
+DOMAIN_FIELD(__u32, idle_lb_balanced, v16);
+DOMAIN_FIELD(__u32, idle_lb_failed, v16);
+DOMAIN_FIELD(__u32, idle_lb_imbalance, v16);
+DOMAIN_FIELD(__u32, idle_lb_gained, v16);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained, v16);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq, v16);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg, v16);
+DOMAIN_FIELD(__u32, newidle_lb_count, v16);
+DOMAIN_FIELD(__u32, newidle_lb_balanced, v16);
+DOMAIN_FIELD(__u32, newidle_lb_failed, v16);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance, v16);
+DOMAIN_FIELD(__u32, newidle_lb_gained, v16);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v16);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v16);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v16);
+DOMAIN_FIELD(__u32, alb_count, v16);
+DOMAIN_FIELD(__u32, alb_failed, v16);
+DOMAIN_FIELD(__u32, alb_pushed, v16);
+DOMAIN_FIELD(__u32, sbe_count, v16);
+DOMAIN_FIELD(__u32, sbe_balanced, v16);
+DOMAIN_FIELD(__u32, sbe_pushed, v16);
+DOMAIN_FIELD(__u32, sbf_count, v16);
+DOMAIN_FIELD(__u32, sbf_balanced, v16);
+DOMAIN_FIELD(__u32, sbf_pushed, v16);
+DOMAIN_FIELD(__u32, ttwu_wake_remote, v16);
+DOMAIN_FIELD(__u32, ttwu_move_affine, v16);
+DOMAIN_FIELD(__u32, ttwu_move_balance, v16);
+#endif
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0f863d38abe2..64f81e7b7f70 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -566,6 +566,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -641,6 +644,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b2f9ddba8a54..f200f7ece3ef 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2545,6 +2545,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef CPU_FIELD
 
@@ -2667,6 +2669,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2710,6 +2714,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 
 	if (!strcmp(line, "version 15\n")) {
 		version = 15;
+	} else if (!strcmp(line, "version 16\n")) {
+		version = 16;
 	} else {
 		pr_err("Unsupported %s version: %s", path, line + 8);
 		goto out_free_line;
-- 
2.43.0

