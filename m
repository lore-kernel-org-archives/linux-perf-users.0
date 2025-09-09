Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18805321F35;
	Tue,  9 Sep 2025 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418355; cv=fail; b=iFrSri9qezx0459bzI9QgqbiRSRu1dIygissFWqmvFLUe0wGuxytJ15C4tuX9YkV26yRK5Gbcbzwq7famcSiJLtn5AIGlempfhPABIAMQjUspGNLuFzVRXBByZlwZ4sx9fPu5jbWNm7BYuohZGDnJe8g0Zd0/DMH5o9dpaPN/JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418355; c=relaxed/simple;
	bh=qtZwo2XZ86qa7rhGYVx0dQ9HvDqk/vP9r30T2ULzEJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmTv93ZPyPec9PKAfj3Fj4xPhwIB4CW+Ossnr603J2uUEBXRmqneMeIoMW2VE9MbhRo/ckdkS3TxAXnAvj/AWNDFqF/wBpMga1gPdjlJvNlC2P9pL4pleZYSqmxy7sXUqES9v2251NOJ4lXCytqKOtx8UXtjwJ5qD9iB9xf5OTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rZEZAFKg; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rZEZAFKg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM/b3+HmUtCy//L8Ab5Na6gPaLl8OK1YgHg61UVEoJEDyApia92j8MaPsNccJo7GNBwvuCKnX50RWr2tSFx/yzi3bAPwSSdMR9G2PKlYJ9pEzKiJsMAAba7KCRuivYCzmln57YsVLrgknMYcbsY1LMlO+qAOJZOINkW9QPwu5il9Let0ztclT7PkLIdBz0RB1Y+S9nHHX0S2X8H4rlVM65QLT8sPLBEOw4qqurCb6n7LetuFSZdtJp7xK8cck0/6N9oF6k5oh9rXHlj3Y3CTsMpPqaLowuwZHnwb1gVcVN4kC1ZQc4bjNSTMEVzfyEjdBSsS9vvFq7EWllphikfwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTSzOrKurbppXO0C4bFzFezNBGEF+5jvee4BxA72MDM=;
 b=nzXwGUVM3XbcgmkYjJtjCX4q8tovZMI6wdiwDWd7QPHz7ESD1VnZN19bNYy0+fB7g1VdhpyzOjPRhVRhxr7BHfF/VU+CT+VjjKo0Wiq7JuSpJMKcizo1V2js8qo8JXVGA1ZA/nnTrrJf72eBePullO2w+Ht7BSrXXF5nG+qEScLPVpK1vCkzmAqVOoZlDBQF3DlFFANdMboDa2UzaPl+VOC1E9TEpnEvk6f5ijuU3QGwLnkqiFbS61fvbNX2Uj3dRSh9/GdYvr9eQ7N5vVvYs/59C14BhqlBL5G78oNv2JTlrHoW4gdx8UG2SbtLExIUSf6dpGBn3cyCdopV26edIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTSzOrKurbppXO0C4bFzFezNBGEF+5jvee4BxA72MDM=;
 b=rZEZAFKgsW65C0PUJAvNoxUROIS9876ePthBqfVtxZnKu+uzIfok5CzxImyDtLMhBTr+TY6hyEHXKrer9Oc+AWUI3ashAr3lmh+Hou3u3jl8vJx+cHVrKIIm6bxBfk0S19I7YUVpHv12FXnWw/s8xx6Lj4ZSziR5UlPiVijFy9U=
Received: from BYAPR07CA0021.namprd07.prod.outlook.com (2603:10b6:a02:bc::34)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:45:43 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a02:bc:cafe::2a) by BYAPR07CA0021.outlook.office365.com
 (2603:10b6:a02:bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 11:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 11:45:42 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:45:30 -0700
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
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
Subject: [PATCH RESEND v4 05/11] perf sched stats: Add schedstat v16 support
Date: Tue, 9 Sep 2025 11:42:21 +0000
Message-ID: <20250909114227.58802-6-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d70807-9292-4e97-3968-08ddef966838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVG+5SG5n9VS882SbqRlsF6NgU8nTErQS4DVl1XavgTGVsLvILwE6dDbRavT?=
 =?us-ascii?Q?3a06lIkw49eo9s5Jn+wU8rIwD+pgidvycb7utzfVfP2/PWNNkH84Tqc89E6K?=
 =?us-ascii?Q?E4scJrtKnFVfwoFaReI4hAiHiLdV1Mxbg60IYTgHKw2lkP8W8mXx7CiNlwJX?=
 =?us-ascii?Q?K5Qi0zx0QdiG/m0t4zUaYTOZV7G6UtvobsI6GQ5A1//J6NPjjd+/eISLozT3?=
 =?us-ascii?Q?T60J+7BwgFJhyu+/g7cl+MLnBwuZrwCz7N1vL+bnFKcQQkr1nqJTC5QFXppJ?=
 =?us-ascii?Q?RUHDnzZoL7sc56nSRFay/GIN/6l8lmk4yi4Rh/w22PzF+1sV9CiK/FG9XSbh?=
 =?us-ascii?Q?ZU4dHvKv+FAoUOxZeHcMVhQz5vXcUVEgvkF2gJAx+niQXJUUgZouCjWlFIEl?=
 =?us-ascii?Q?Y2Qblv864WA0QI9OGAPJfS3l247klQ1UhslEcl0DKIOdO3E4P9F53HsLJcQb?=
 =?us-ascii?Q?+0xiai+kmxjbOdtNthTI65r1pvYyujKLtiGwJOtjqy75IYVt7v8qVVl1Tdrf?=
 =?us-ascii?Q?LFw+mxE+1mcb//lLs5nQPJX5waDoo/LrdXTBoy4JrGgs6B+hjzODjuJ74JuG?=
 =?us-ascii?Q?g7O6YHMfyLofihs3pL89/X4dHLKa6FGrHU8tlq778BXB9RWceSfcwSvVxfX0?=
 =?us-ascii?Q?d7m7IvhS+0gE5wLAK9agFTPfk8ITVj/OwD1V0QagXgVW1X7a5qbcVPf33CAW?=
 =?us-ascii?Q?iF0IUG3SjvJQm9NMB7HhxPph/mxHs9mIaShVz0N/UpjsbU8dP0kxhBIrmrm7?=
 =?us-ascii?Q?WjcEHotoDfltuYJQuVAYqD8GX05WzcG/dSVQBkqj082B3o9Fm9qPEkMuQkU2?=
 =?us-ascii?Q?LMeRlDSy/D7iQA4rNNsWQd3udfpwVpd7WUoBy6TMH2V239s1o3gHRo0VR+Jz?=
 =?us-ascii?Q?+mz0dmoLvj6RVseUcM0yzSNdiqR2ngINsqaPy5eGffqthIYhoEyogJQluSeX?=
 =?us-ascii?Q?bEFdyNKHtJN/CFe2GB8UoNG+zeP8CBpe06zR8QqY15JNpbIur7G6WZJGJcFK?=
 =?us-ascii?Q?u+SxuoJYrRzQVofSooxlvlkHqIsvPE11xMj+3M5XgkTvxCuvohiNxuNI14f2?=
 =?us-ascii?Q?YyGjdjZ5+vUY0rEwvmdX8ynMyTTFBmEjNMRVdQeWJKSW/zkaFZFKbXaxTkL3?=
 =?us-ascii?Q?6UKR47x7PKoOw0LWp6wULEPa5MB9YiqOHeGHL4i11MbGXAO5vDbOaBHBlfcc?=
 =?us-ascii?Q?NwTZcgs6klzxTxy1sZKfasg3w0N0KKe/1v2SN3iAARrc9AG3DKH4KtXNspHB?=
 =?us-ascii?Q?nJIiBLKJkWpZTbmT/+LZb+Cy1UfKfo/q+5QMM3ZMWLCAL6OwrURTabkaXdiW?=
 =?us-ascii?Q?FNK/OBO1si5IKxWLB9cBEk/kMt/3COw3MIZnL1F7RZIVahjNtD42jPkL2eiZ?=
 =?us-ascii?Q?fEOkAxXPiZh1XLUW/96l4x/UfHdBrjZml2MlbyN95iku8B/URIsh8N829KeW?=
 =?us-ascii?Q?i4exN3A7fW3KhoCtKI5T09kwsGQl+cnQcqpU+2bgA5RMjQD2llX/ntSsEcII?=
 =?us-ascii?Q?bA2z4XZzNRlUUZv8DNEEM7/9WqUOnKua5MKY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:45:42.7790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d70807-9292-4e97-3968-08ddef966838
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v16 version layout.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/Makefile                     |   2 +-
 tools/lib/perf/include/perf/event.h         |  14 ++
 tools/lib/perf/include/perf/schedstat-v16.h | 146 ++++++++++++++++++++
 tools/perf/util/event.c                     |   6 +
 tools/perf/util/synthetic-events.c          |   6 +
 5 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 9fa28e512ca8..965e066fd780 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -179,7 +179,7 @@ install_lib: libs
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
 HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
-HDRS += schedstat-v15.h
+HDRS += schedstat-v15.h schedstat-v16.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 7ed7bae73b55..4c38a58e19c3 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -489,6 +489,12 @@ struct perf_record_schedstat_cpu_v15 {
 #undef CPU_FIELD
 };
 
+struct perf_record_schedstat_cpu_v16 {
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
+#include "schedstat-v16.h"
+#undef CPU_FIELD
+};
+
 struct perf_record_schedstat_cpu {
 	struct perf_event_header header;
 	__u64			 timestamp;
@@ -498,6 +504,7 @@ struct perf_record_schedstat_cpu {
 	char			 __pad[2];
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
+		struct perf_record_schedstat_cpu_v16 v16;
 	};
 };
 
@@ -507,6 +514,12 @@ struct perf_record_schedstat_domain_v15 {
 #undef DOMAIN_FIELD
 };
 
+struct perf_record_schedstat_domain_v16 {
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
+#include "schedstat-v16.h"
+#undef DOMAIN_FIELD
+};
+
 #define DOMAIN_NAME_LEN		16
 
 struct perf_record_schedstat_domain {
@@ -517,6 +530,7 @@ struct perf_record_schedstat_domain {
 	__u16			 domain;
 	union {
 		struct perf_record_schedstat_domain_v15 v15;
+		struct perf_record_schedstat_domain_v16 v16;
 	};
 };
 
diff --git a/tools/lib/perf/include/perf/schedstat-v16.h b/tools/lib/perf/include/perf/schedstat-v16.h
new file mode 100644
index 000000000000..3462b79c29af
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-v16.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v16);
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v16);
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v16);
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v16);
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v16);
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v16);
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v16);
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v16);
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v16);
+#endif /* CPU_FIELD */
+
+#ifdef DOMAIN_FIELD
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ");
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_imbalance,
+	     "imbalance sum on cpu busy", "%11u", false, v16);
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v16);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v16);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v16);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v16);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(busy_lb_success_count, "load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(busy_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v16);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ");
+#endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_imbalance,
+	     "imbalance sum on cpu idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v16);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(idle_lb_success_count, "load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(idle_lb_avg_pulled,
+		  "avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v16);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ");
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance,
+	     "imbalance sum on cpu newly idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v16);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v16);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v16);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD(newidle_lb_success_count,
+		  "load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD(newidle_lb_avg_count,
+		  "avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v16);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ");
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v16);
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v16);
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v16);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v16);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v16);
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v16);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ");
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v16);
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v16);
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v16);
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 41fb942ef701..88a5dad240ac 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -584,6 +584,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -603,6 +606,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 01135d80fde5..499c819bb8ff 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2567,6 +2567,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef CPU_FIELD
 
@@ -2620,6 +2622,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2661,6 +2665,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 
 	if (!strcmp(line, "version 15\n")) {
 		version = 15;
+	} else if (!strcmp(line, "version 16\n")) {
+		version = 16;
 	} else {
 		pr_err("Unsupported %s version: %s", path, line + 8);
 		goto out_free_line;
-- 
2.43.0

