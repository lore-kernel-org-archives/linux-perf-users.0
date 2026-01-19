Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1A2C21DD;
	Mon, 19 Jan 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845659; cv=fail; b=UBOtv7AIdAOxyat0k70Zzw4+AjBQ0uDEPJM0dk2koQUpcsnOA0Rse6ibsWuOhnoc5hMk+q5BsSn3nKdAoiOPOqOHTWNVwSlAzHQD+Ay46MZXcwg26T9Rkv2PvymjayZGewMYsBjU5pb3+MYAxJPVv6Zlaq0eBBUYnNiVDYLYddY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845659; c=relaxed/simple;
	bh=nbRL3KO7D3zwjA2WEr8ernjYwi9uFhYgup1bHMhOa0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+qv9fKIh+lKWJLZGyAtoVTEhPbX1hCkkk+EQvo0qMDpycvaSOQxlwpUOR7k4fvUIKJh2Lvmd+QhS0hKfGYW8I4RXk3x+QB/5hyZEnWiyHvwZop73eVlmMRLnJV6nycxj39MpNf1wdOvmN569QqYWJ3YjYRwsRDCmxxWIijYrsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0jWR++kX; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0jWR++kX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So0K1irIOSZLYG61n/slnfhwyU5zAurzbO1V3BaBHlrwG6hXFyG44zXv/gzLRHX4FQ991IGUlM3+pQFmivKAI6VteapYHo6bp4CbbCTNGp8NrOT4eiSAnpIzegHAN77XTjVIxldy0MwZNLFARUeoAvBabUzQ2k9OHpqKyqXW69HFWKz3iQIDpGGCb01j/vsZczq8gJn9gVn/eXVgU7XanBjoG4mPgTu+yyMnLLAOKBRRm0KN6DlsyZpHbacpQ6sguGBbJWfnlGUePc0eT7exIhEBmgA3GPN+ZLCWhqyAE+prGO6CklIdR/PaoVRrnR2ERDhQa7I4zI57Vk8YWMMVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnvcyynvvtJtY1bnqeKR4NqgZHqKh4tIjFiClq17IQo=;
 b=Q1XCiV9qkCbHGWtHeJlPcbMVJ6XKBQqDATz3VnssJ2M/qscx4UVZVvXL+CTJOaSNh9lCJQ2VG6Vo/tOV3vFuxB8nJsJL8+qDDZovdKlF2LwIKigBHsPs82hfbS+Lux2Y9SMU4r3dM/wc9a3geqeUAdlwcGuXZcllIINuech5LM1N6tPVT4G5g7UlGAawLUwaSO/n0thp0Z+xbsukJ6g2IujGGP85X1V2njXiqoV7PjX2hN+F4bWSOlcsXEvcpPklfjHYOxBn0bwfhNGOKNfEGR1jO1a5l0QtbSOTcbWJyVipOHQbAr0IGKzN3F8UrBn4+WVjacFmfNjxLqvWx5JMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnvcyynvvtJtY1bnqeKR4NqgZHqKh4tIjFiClq17IQo=;
 b=0jWR++kXKLMv6FNU4nCZli4zUDeeJpM1PytsclvMfLCA9J6TC1PXsm71aVegMF+0BqEqczJSn8ptXwY3C3I02NJUAGiVFkAPFnxBZNWCFiQzpjFUfxavGkA8Ib9q92UbhGgtr0/bw1LVAajnvmSDSt+ppk1IMdh01uKDTxbvz74=
Received: from MN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:208:52d::29)
 by SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:00:43 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::e) by MN0PR04CA0030.outlook.office365.com
 (2603:10b6:208:52d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:00:43 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:00:32 -0600
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
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "James
 Clark" <james.clark@linaro.org>
Subject: [PATCH v5 04/10] perf sched stats: Add schedstat v16 support
Date: Mon, 19 Jan 2026 17:58:26 +0000
Message-ID: <20260119175833.340369-5-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119175833.340369-1-swapnil.sapkal@amd.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 861aa4ae-8300-46d2-083b-08de5784aa11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fxZEdE99RgimxBzf/lJ9ObmbR3SPKqWDWcgAejXxJIRQHoSiiC4iDEwnW2kO?=
 =?us-ascii?Q?kXfYA2wAmYMp3WhC7XVYIWzkE0RwA2PJ+9kfcq4/HHhhKs1z7v2Vq3mz7fpq?=
 =?us-ascii?Q?BfQDHQmlNyBYUmxk7tmOOrRiZ5DqvF32cmp1cmiMAt4oonBYSHXsZTPF0Y7q?=
 =?us-ascii?Q?3GCeB0NDmAejANWKKn+sSr5tg0u5rUzQpgXGafIU7THlftgXTN9p1m7jxZN4?=
 =?us-ascii?Q?v0vLKBtzdKGGFjTDIH2Z56dkTg2OjR98rUM7IRovm5zAzOamgMNfXE22LH+f?=
 =?us-ascii?Q?XvufSooQMR06DFBmttAeUl8mbtcpz/12mEtPOQ3P0sK8eJSgvEYyr5m3h5zJ?=
 =?us-ascii?Q?Wdziej443W+u9XFLUAzeQH0PVTkOHOxVTm2dFRr4y+ft20BQYozxBU+5WtRx?=
 =?us-ascii?Q?CpDbdti7/UdP4B6l26ub914ZbeU+FmdRvrK6NgBj3ykrNfRcESuFUIlNcruZ?=
 =?us-ascii?Q?oYmGuIzu7oNmMry30w/Jrb9qqjjW+BXTmSRUueCoAVbiNzut4MSmPWBew/PG?=
 =?us-ascii?Q?67MvYDbyeKndxZs+sbIZN79fxsrr/XEdQEb/jYhOBQZ1ip4//JKcdxvW5TiF?=
 =?us-ascii?Q?IDke5PwMtLrQws2IQYy4XMcJvx8oS1WOl8uzzSijXiGu3COF+r1lJP/hsTCh?=
 =?us-ascii?Q?8yHDg4MdGdnqkyLO0PPNm/mApMOfhO16PXzIZNFcYHRio3x0H46T4xEPL/Qp?=
 =?us-ascii?Q?Ice2aPXs1ANz8A7Uxq6NTQjpoG8fEh34uw5FMAmv0soHBlGaK0U4514VqAQs?=
 =?us-ascii?Q?RigI2BhUnfQgXVcNoHXIHSYIswDgqnbYtWBD4FuYq1eZbmbOwPz3MScxCqqd?=
 =?us-ascii?Q?88WnNby4h1d8mS80+FLNd6RisSxAPIcT+f5wdSrn/xYmgn0gm+fdw1ZIYWCO?=
 =?us-ascii?Q?TWw/S2vlZYoVd0Fkt4Z0+pn98m9PgQ9kBa5xMTcdr/AYNQdE5v68jBRMh4RG?=
 =?us-ascii?Q?D0RBm4r3k6HKCZDab7D2JToT00OvMFC46f6gQBEzMwZ+9V1fVhKOL1/SY7Wg?=
 =?us-ascii?Q?kB3MKLHh4Og2Gp5wzVCl14FKr1xRhKkgdJembxody7JnEKHqSUDb7rUh6fFt?=
 =?us-ascii?Q?C98wcYmhBl4dpqwz+VXFFQQDG+UUdHSpa1MiDl0Nrd838Oh6LosCZOPo7bv8?=
 =?us-ascii?Q?UJdubPG6ZOdlKDF4L5/ly2JH75F5XiDqvP6wJ5+HS5y25NmVpfrCL2CbxWSL?=
 =?us-ascii?Q?4+mG7dUWsaOGfY26tkLYYV5NUH/gh3vN+zjGyivrGyB9jILVLUyWlGCnRgBB?=
 =?us-ascii?Q?G0nB1YuKv/OuWwx0I24pYkAtIsTAni00QDz6mif6l/8fh5SRu4mwbrBuYr2X?=
 =?us-ascii?Q?K0Vir67uHMNcEQM8FZZFINFVKtMLeECEZ8BGo4JJ8jZFW8KTdZar4mCFoTzD?=
 =?us-ascii?Q?KlFKcXu1h49Cs8UWoOBxK0+aNcTUzX0NQJJNz4O2oUjSmg7O5xTv/lQ0okj0?=
 =?us-ascii?Q?2KnBn7RzW72MqYiMHkDZYHDNljkfKJ+hPCmMwZqIqPsVnCq9oINx1LRxeBpn?=
 =?us-ascii?Q?wOF1BppTDKY7B3V88S89ZSLfsNX/ki0yhmTnrpi/gg95IDoz0cPu3XQkgzrp?=
 =?us-ascii?Q?KUw3Trc8JvguPWBUruZfRCnppGW5b3xzONQbvVwcmQg3N0ReaBRe3gzbOk/1?=
 =?us-ascii?Q?qAz1jmv8JDtrVXWwoyAEHROAUzapCWMGcqyll0yNnzN1F14wbTEzT8LzOQhZ?=
 =?us-ascii?Q?FmeGxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:00:43.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861aa4ae-8300-46d2-083b-08de5784aa11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v16 version layout.
Version 16 of schedstats changed the order of definitions within
'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
columns in show_schedstat(). In particular the position of CPU_IDLE
and __CPU_NOT_IDLE changed places.

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
index ce04fed7cefc..bd4d507ea8ab 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -502,6 +502,12 @@ struct perf_record_schedstat_cpu_v15 {
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
@@ -511,6 +517,7 @@ struct perf_record_schedstat_cpu {
 	char			 __pad[2];
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
+		struct perf_record_schedstat_cpu_v16 v16;
 	};
 };
 
@@ -520,6 +527,12 @@ struct perf_record_schedstat_domain_v15 {
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
@@ -530,6 +543,7 @@ struct perf_record_schedstat_domain {
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
index edacf13455d8..9a434e2e480f 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -585,6 +585,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -604,6 +607,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
 		return size;
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 5366ea921e70..4ce37357db05 100644
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

