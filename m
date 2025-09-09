Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AD322DBA;
	Tue,  9 Sep 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418379; cv=fail; b=hNi62rIm4GzDTT54/dmgTa+fff/Ve6b6FkIaK8RKT6t/YsnSRPNL9Zafwi3WV3GB6+KOrripZXFyzoHjWDVuzRFCu/umnBqQB9CekI3lbvTcfZSgRiHeSrRM4ygbv3awdCjgjf/PQmIyjWyo+I+j3hxW7Xsc+QxO2Rr7nrOGf94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418379; c=relaxed/simple;
	bh=ffxZZVxcCMTd5sNfKEQjltVA8IDqY0raRClZTCvHXz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFvyj4vq73NkcBYK4vPRBtUq9FIcokhQq2qHWLvFLoGerGGUmlDEpapV8Lpblz/uXg+ftPCkBn1V0bnOr4sD6GqqmLJeWsawo6dmxqkEhycqqfcQu82HF5tkDUsqZ3K35YQOzkRo6a2g0MbP8vreIGUmUvEgCs1v7vGeuD+mKmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fwTPC/i8; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fwTPC/i8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/WLFsEQWSZLutQA1yJNIFtK1KKwuj8QCA4vxZTv2J8wxbu1Fjx8VusJm+/IkJ7NlSx+kRlcqokDubnL9TE77RSHyjfOizdZPgFNBtt6sLb8WPpQKeeLjP4jkU0U5d/DEnNB1nNrzpdsVlI65+842yxaF7hVszzsQ8BqlumqaWfAKq5x20OnCMxvxqVfJLg+6cVjVtsHPO8YNhDB5hZeR1OpEo13oFHU1O2AFxL/UfBtiCslwu0Kqtcw3N3vFObu5KQQ9mTp5WThchTqlMpJU9GJqgvIi2Xi42ToO1pjfiX9AHmwF/3IzjHObnhxcKvEUa4q381iUDEk0PpdKRumsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7sR6OqLrrB8HM+mtGl71OnW6DKfS4QcLrsHkSsr4kM=;
 b=lCAm2sKEx93EjRhEQPBlYvlvkB+83jAGpGwzHoNqxV1Zz2TT6NherN8PCk82loUaOvK5W3k7+9iKCpd2TZbeEWXl7i1Bu3TQXRediy+npVEB/x2iMETtcoXhO1JuJ843U+W+EjyBnF1iTP23+P4v1EM1+yc6BR1B5AJriiuEOx7BBGGW979n8TIZMFmbL/iPjzYlnlMewNzzz3GCRAPI1DJJEtU8ttF0J2RSaM7oNfiD7cR5k13JKt9ywEIHrfbTcBG8HZhKEK3sFJLt+afkLEU9hPbvQsAVLEYwjdC5Vt6Sf0Y9yfvcSdMwRTJ8gIhk2haiXuLlbyb+HZbjjZDtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7sR6OqLrrB8HM+mtGl71OnW6DKfS4QcLrsHkSsr4kM=;
 b=fwTPC/i8a+9aq9vdNgM/9GgXpKTlER1mLsRyngMPKL3x5piWC50u6goeMmbo8+8YNmEDgTkbroRx2JjmGYCGsBP4qRULfaU76aG0Wb6tYbF41vfOjnuSdzZTURcafIEgGFwHVZKLswUGW8hReQ8k6gwhDM63IL4xcTLD463Hg7o=
Received: from BY3PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:39b::14)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:46:11 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:39b:cafe::b0) by BY3PR05CA0039.outlook.office365.com
 (2603:10b6:a03:39b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.14 via Frontend Transport; Tue,
 9 Sep 2025 11:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 11:46:10 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:45:57 -0700
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
Subject: [PATCH RESEND v4 06/11] perf sched stats: Add schedstat v17 support
Date: Tue, 9 Sep 2025 11:42:22 +0000
Message-ID: <20250909114227.58802-7-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 40dfebb1-67e4-4240-71cd-08ddef9678b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gEe76buHM2s6k162/OEVg40Gr7MSetqM10Wsct+PTLefCSw44KtrDDO7NqhO?=
 =?us-ascii?Q?+d8EAHZ3ghkWeARia0gJQaGkRP9hUe9VkDos6YiuHL8zUudh/U2U7s4j5dUh?=
 =?us-ascii?Q?yMylgAz1jrFVuqEEMM1d0T7+EWooqtpdCN5oAvm7psvtlXaIy475oWCyG3VX?=
 =?us-ascii?Q?D4Sr+rCiwd/lhAbQ4vaukR8UdmULbRiohpWrjgM69BpWEh33xZ0OJKYbjoVZ?=
 =?us-ascii?Q?kVh6INNR3G28+JrcuSfe1fymw9W9PPdXoRwNzLetLeKA5bTg7HIxubx1n+79?=
 =?us-ascii?Q?jNeh6lMkmbE9S3UbaBWZFFeFmlmr1xitIf0yJONvlGwS6MkP0epFMMQdjQHO?=
 =?us-ascii?Q?xgkN+29M1YIfcbFzk+UXieF/nFT9Fgjco7u4bYiGDAcxqs9zvNGjACOPkUQ+?=
 =?us-ascii?Q?cDXndct85YNIrUqfIJPvLJmBflHL+VreOUxNuHODP13ebfbO5qYaal0IZ0Q+?=
 =?us-ascii?Q?qEZ1/QgcHsIqvB8EiZD+usOuGZH47nRrJ+OY+7lLLhcqXGvlmvgxfFF1yQ75?=
 =?us-ascii?Q?B6W63bHPqSG3g1zM94lYic3hGskOtnDo1D5nDT8JpQah+WeMwxA1yRX8XaO0?=
 =?us-ascii?Q?CTjepsAx2KMSJGovyj0A7LnemraXy3I5kXQUcGaqefXLRaDaP1V9UY2o/vEL?=
 =?us-ascii?Q?WYQgHHK7RYDCOiwe1fBvWcyZaoHYL1HpDLmWnZhFgYjmar+kqiLjSRZ9+1KI?=
 =?us-ascii?Q?B5cIkaviiJpdF1DclDDCyrHk+FklnhwTcUUD/MlGtc0CCWthyLEnxVSY8ie2?=
 =?us-ascii?Q?ccYahQGIe/NgLfydTFYynguIbBy+HcGIpq2pgha4MafXuRF1jC8fo7js1JpL?=
 =?us-ascii?Q?CSIjfKh8fj/+tD4G5zJXzBYjZm4x44hN4xiU0OUCBsoZ7UbtoFw1wn1PCZ+V?=
 =?us-ascii?Q?tgG+X59dXIJZ70l5SWMTUGdPYOEKDCXGD2KUL7Y3e7UV2FZVDmWR5gbjatYU?=
 =?us-ascii?Q?PNQxIwtTUklm9KNNMaxDsTcjeqt1HPMr7dO8W33pJcDNX4iHEf8Sd/4LmokL?=
 =?us-ascii?Q?dS0vl4q6dg+k5AYzlknUwH1izlHccNdJ0PUVjzAOkObcDojjVfWDxxY+n5zm?=
 =?us-ascii?Q?0olJlUMG9d+04Hp4nfgeyww4VyZQJRTxkK+cj2jJJiUPW4QbECaW5i/SuiiY?=
 =?us-ascii?Q?mp0LtIH09rCuQ8gsGBrfcJIrlMzh3m1ZFft4OYsMhyHiNLgIXZ7BTLx4zgKi?=
 =?us-ascii?Q?Q05q8puqgtHFv70P5XqwD9/UdSKRPWSzggushWXC7eihjwzd1EoomJY/Uqtp?=
 =?us-ascii?Q?ATs7+oLF5XRl59DVw1NdeDszEUGTqIrqOGFMBNneZwaFUmcZPeCLcyDfy94C?=
 =?us-ascii?Q?Om30CDdQsdHQ6mVajZAK8T4JkYpLmB8eHOQmLLqplGmt/MQ7HVGaiJKmtTtd?=
 =?us-ascii?Q?rv8JBG0SuuPFbAbL2KzpOHpTWNhXRb4rYbWjUAEo4RdyyqpgiZMdaclGEpzt?=
 =?us-ascii?Q?k0heT8G3xR4EleSmkFh7Kcao+Pv5snJoMLlVYWhF8RWw1klf0O9RH65smwrL?=
 =?us-ascii?Q?GPWwDmkTDz/50H19+PTxauR/Pi/lJPNWtgHH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:46:10.4501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40dfebb1-67e4-4240-71cd-08ddef9678b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v17 version layout.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/Makefile                     |   2 +-
 tools/lib/perf/include/perf/event.h         |  14 ++
 tools/lib/perf/include/perf/schedstat-v17.h | 164 ++++++++++++++++++++
 tools/perf/util/event.c                     |   6 +
 tools/perf/util/synthetic-events.c          |  11 ++
 5 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 965e066fd780..27e6490f64dc 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -179,7 +179,7 @@ install_lib: libs
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
 HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
-HDRS += schedstat-v15.h schedstat-v16.h
+HDRS += schedstat-v15.h schedstat-v16.h schedstat-v17.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 4c38a58e19c3..5a93a84f49f8 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -495,6 +495,12 @@ struct perf_record_schedstat_cpu_v16 {
 #undef CPU_FIELD
 };
 
+struct perf_record_schedstat_cpu_v17 {
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
+#include "schedstat-v17.h"
+#undef CPU_FIELD
+};
+
 struct perf_record_schedstat_cpu {
 	struct perf_event_header header;
 	__u64			 timestamp;
@@ -505,6 +511,7 @@ struct perf_record_schedstat_cpu {
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
 		struct perf_record_schedstat_cpu_v16 v16;
+		struct perf_record_schedstat_cpu_v17 v17;
 	};
 };
 
@@ -520,6 +527,12 @@ struct perf_record_schedstat_domain_v16 {
 #undef DOMAIN_FIELD
 };
 
+struct perf_record_schedstat_domain_v17 {
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
+#include "schedstat-v17.h"
+#undef DOMAIN_FIELD
+};
+
 #define DOMAIN_NAME_LEN		16
 
 struct perf_record_schedstat_domain {
@@ -531,6 +544,7 @@ struct perf_record_schedstat_domain {
 	union {
 		struct perf_record_schedstat_domain_v15 v15;
 		struct perf_record_schedstat_domain_v16 v16;
+		struct perf_record_schedstat_domain_v17 v17;
 	};
 };
 
diff --git a/tools/lib/perf/include/perf/schedstat-v17.h b/tools/lib/perf/include/perf/schedstat-v17.h
new file mode 100644
index 000000000000..865dc7c1039c
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-v17.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v17);
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v17);
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v17);
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v17);
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v17);
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v17);
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v17);
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v17);
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v17);
+#endif /* CPU_FIELD */
+
+#ifdef DOMAIN_FIELD
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ");
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_load,
+	     "imbalance in load on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_util,
+	     "imbalance in utilization on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_task,
+	     "imbalance in number of tasks on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_imbalance_misfit,
+	     "imbalance in misfit tasks on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v17);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v17);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(busy_lb_success_count, "load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v17);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(busy_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v17);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ");
+#endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_load,
+	     "imbalance in load on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_util,
+	     "imbalance in utilization on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_task,
+	     "imbalance in number of tasks on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_imbalance_misfit,
+	     "imbalance in misfit tasks on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v17);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(idle_lb_success_count, "load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v17);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(idle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v17);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ");
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_load,
+	     "imbalance in load on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_util,
+	     "imbalance in utilization on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_task,
+	     "imbalance in number of tasks on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance_misfit,
+	     "imbalance in misfit tasks on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v17);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v17);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(newidle_lb_success_count,
+		  "load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v17);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(newidle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v17);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ");
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v17);
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v17);
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v17);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v17);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v17);
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v17);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ");
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v17);
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v17);
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v17);
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 88a5dad240ac..d50fd1c00dfc 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -587,6 +587,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -609,6 +612,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 499c819bb8ff..0c97ed711b60 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2569,6 +2569,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 #include <perf/schedstat-v15.h>
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
 	}
 #undef CPU_FIELD
 
@@ -2595,6 +2597,11 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 		return NULL;
 
 	ch = io__get_dec(io, &d_num);
+	if (version >= 17) {
+		/* Skip domain name as it can be extracted from perf header */
+		while (io__get_char(io) != ' ')
+			continue;
+	}
 
 	/* Skip cpumask as it can be extracted from perf header */
 	while (io__get_char(io) != ' ')
@@ -2624,6 +2631,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 #include <perf/schedstat-v15.h>
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2667,6 +2676,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
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

