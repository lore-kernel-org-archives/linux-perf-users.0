Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA032D0DC;
	Mon, 19 Jan 2026 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845688; cv=fail; b=m0fT57R2gFe7Nry375ikH2P5dVqO3QJ6HRkZ62S1qz8buTu6sZ5sma01qbOLb+wfg38gl+HkHxdD3bXWwJniobs/R4kU9jUTC0FtU4JMVfQK3miOdUstRNeLQmcDr11Y5hxQVJ/i27+JqeIimKTWGSGUUDIHoB01COSC9aMQv9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845688; c=relaxed/simple;
	bh=rDhE3Ux5cZVTParHEZl2QoOADBykEQQhBFVUZRdU47k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qv/hZqUUX4CU9+gtX+3L+S1f4AVhxpFkLJkKNjastJsH2+NDH0jKfKX6BEVzCfhSiTz51wKwao/S4LPEtO5q8qGTwPFvdLYGIt+EuhNi6jE3yd+CH1NCr8562xQFMwf2zKavA4dJg5mI3zXjIUNt6ZaUopGxxAE7hYaffC5N5L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1SU/vKEk; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1SU/vKEk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGME+0kkwoU3gpvWX1s7Y/Ww5XymNYo+vcWrrL48K92Ko4EHJJqYTHrbN+WCSR2v/He8n/eUqS2eq1hTe5aPmxWSzr+BVQVgID6ECPT3TDdB+8NeBmDID3IiImf8yopc4usi77yvL2Z3PgjN8gHgEiae8aeN5Ldn8iACa/u/sSS4OaQh+1jU+Xcr0fWl87AHPaWsjYQ6KqzY3U2HgYXlI22D8Kj7jAG6h1O+xQ9PgXO1JM5g0M0YViTwlH0g1UW+iadZ6KQr5F5qYWTMHJWjWxt3++vVMRudhA/Sef24gXEPPDjAa/HghOkS5g+soj3XCu9bSXgtSkOxHDO5bc9q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uN8SeQa1Mv7hN4ATDO82Lzp2YWUTdJf1WKf8+sXDSw=;
 b=Y/hNE+qx0KhSJhRmGytBAlXz1n6lNtFfGHYACZOPjCWF5EgBgW9QYSBvb0MOab2Ia2rATHz/IM8zxz6ltG0OXrO6WLYIEqRzkJiClonxDF8alMW7oS2HMLuDKDd11EbDU9cA6r0S2QvVCQHELdcEvUiXXFrQ8ZX87ssa0p1S719I8bCkiy5u5vM28qN4Hdj3HNSYEQIySK22bpjQ0Zain3PmtfVL1aDpDA+n5e/w+Dg3RMJb+8kwBDtEUa1wwnqByDQmSDR0CsXF+7wOBz57Osp6eUQf56Fjz92CPz0YT8ZZj65JDH6LRrxlyQmsj9LgqQDzyRVm0gc4ZaQi8F9E+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uN8SeQa1Mv7hN4ATDO82Lzp2YWUTdJf1WKf8+sXDSw=;
 b=1SU/vKEkHDGFNPdQdA/CgxuQ8XIcMAHsXS/VKk/1QYMUdnsx+8iJKASS9DWXp2S6T5oVXWZdBUSUE8U322+afkd4RDz6zi9FoQ89YDf/kxF9PFoCEY+tePu1tOW3Ou4bSDVRn4XqB8vLeemrqSOckNy/L9PmHH0dmApsOXe6FYg=
Received: from IA4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::9)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 19 Jan
 2026 18:01:08 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::9) by IA4P221CA0006.outlook.office365.com
 (2603:10b6:208:559::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:01:08 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:00:56 -0600
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
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v5 05/10] perf sched stats: Add schedstat v17 support
Date: Mon, 19 Jan 2026 17:58:27 +0000
Message-ID: <20260119175833.340369-6-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb4be16-08a2-4dce-d078-08de5784b90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wVIkKJNSKpD8XWbh6ykjPB6z6oOofNXXU8JhIx1IpB0UiBGS+pA5f96YYS3?=
 =?us-ascii?Q?XQsO4SL2w32x9tH0WvUJDjUhbth90RAHFpuzbWvTLjPvPgnA8iQz8y4YULSc?=
 =?us-ascii?Q?ugaBnD+G6/9hw8qkCTNN55V8I9J8t5VmL/jENhWvg2qBSjg1ScePSNade3WI?=
 =?us-ascii?Q?wsndkH+KF2yfASvqNf38pScC9OcAdJNdlpLtvHJJbPkcFphkL946fFy6Jt/M?=
 =?us-ascii?Q?/xY/CnYPJCuYC2yC0qPe86uFg7RXpB016FLf3Xl8vEOCku1sWFhfmFjmhTOL?=
 =?us-ascii?Q?tHLKvh0gRkLcRcw9CEH1yICApNi7CKic7ljtPAqqGjEoSTwdlzF/hukSUf8w?=
 =?us-ascii?Q?Szgns6LCZRwVxYHwFCZJ20sBlduOp8DgxPrwzD/wqtpdhQYkwc6WQrwrVWja?=
 =?us-ascii?Q?ZFqccReN1KWTyl9VTnyjECseN1mBFMXhS9cmSAmL2gla0Sramd68rKronw5n?=
 =?us-ascii?Q?CvY+cLFzblKkqBcsNqtkPGw6xN3p+BfZdncDo94i1gEwHBE+NpDj6++ixtRF?=
 =?us-ascii?Q?/W4ZxjeRVqFHI8HXMY7PULoWkIS9mVMtXPyuWF4O5rlPjnx3Yomo7IeZsxHH?=
 =?us-ascii?Q?CTVk7jIbpGqQLqDRqog3D/qKuCI/GpUP15YFqrgTSUtNZTqH7+myCw+6Gvob?=
 =?us-ascii?Q?Y6IVubPcJ0zpVRqwVg3THvHYf3fKTinGmT3ObHctL/4rbIm6tq8nxN2mdPMH?=
 =?us-ascii?Q?xoEE/DIYUAC48u9gaDpLcSsMYGRLw6FDCLSugpIDuOUptKo91Xl4nJS+jzKr?=
 =?us-ascii?Q?SAHCR+HU6msRt8tyyDJOckM7k9LNE6751+uglJ49GXz6C8dz4zaqr2e8bLdy?=
 =?us-ascii?Q?lOJzf2cw4EIcsBYbr3pFd3+cQL0LKXNwB7Nea/eZIrhanq/QuPYIwRutAXlj?=
 =?us-ascii?Q?SJUDguTTEqLlPgSm0ibh/fJahWomAhSZvDscMXtzUQfW8xEMUMzmcDji64pD?=
 =?us-ascii?Q?Tzc/BLgAa1Q2NQJAF5LQZvYRb+4oRqtPtl8RIDzQTlR2kuzyOUKV2lgSlmGs?=
 =?us-ascii?Q?apSndTu7j4emaz3F+KUISv15c5NcAS8Wlhu+3OmGalTNL4dqi7eFE96Mplxu?=
 =?us-ascii?Q?wAwSC0BNkSDnqEJ3Erbdo0jt8mT4FzuYsxOGZyZcsz7WQTfWgyEKTaQKomU7?=
 =?us-ascii?Q?bOkh67qmfjNSvqXDQbBVc8XEASkdpxoPXAoNwbgBFLtxdv/uZ5wOvZvIrcul?=
 =?us-ascii?Q?VSmuZoXHd2AvZ+kAvDqKGxVyNwwinJ7pP4vdfrgF2gCTzczjQWNieFTJzHVf?=
 =?us-ascii?Q?uAEbdqt3s6geCnJruVVyHzYwHUJD8ijNR5tNxEX9fl5Z5N9/MJAahz8BSHlz?=
 =?us-ascii?Q?5ZZ1R1WAXdkZp/spMujNIT9AvlTXquaJwDBtst1c2LPd+KiP5FYV60b0Sc36?=
 =?us-ascii?Q?PR+tw1wKHtOgKoVsVVyhPTumH9sJkl26SR84ugnkDNPt3TiElRdk71FTeEEF?=
 =?us-ascii?Q?Pk2wxzDv3vz18OftXh1kLL1A5C70kBtSmYKk7/h1DMUpdafhhbpKzJJgpPxf?=
 =?us-ascii?Q?IuqFRMLGNnpfaifPh5kAm5oVzKyrUrwcNoAWg6aKl6wdVGaxnoJ8ZqTIP7g1?=
 =?us-ascii?Q?YxeaRCg1lpyzVQYe3gpm+SEQTBIq/9kdBYSBxMimRqmz0QYYgMjK6CDC3Ato?=
 =?us-ascii?Q?J6x6ZYPdC/KvyxzWOxa4EyfnqNBno4jeaeyQwP2eWrjYTVMZUxNEufxBC9MU?=
 =?us-ascii?Q?5qHEmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:01:08.3181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb4be16-08a2-4dce-d078-08de5784b90b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627

/proc/schedstat file output is standardized with version number.
Add support to record and raw dump v17 version layout.
Version 17 of schedstats removed 'lb_imbalance' field as it has no
significance anymore and instead added more relevant fields namely
'lb_imbalance_load', 'lb_imbalance_util', 'lb_imbalance_task' and
'lb_imbalance_misfit'. The domain field prints the name of the
corresponding sched domain from this version onwards.

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
index bd4d507ea8ab..9043dc72b5d6 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -508,6 +508,12 @@ struct perf_record_schedstat_cpu_v16 {
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
@@ -518,6 +524,7 @@ struct perf_record_schedstat_cpu {
 	union {
 		struct perf_record_schedstat_cpu_v15 v15;
 		struct perf_record_schedstat_cpu_v16 v16;
+		struct perf_record_schedstat_cpu_v17 v17;
 	};
 };
 
@@ -533,6 +540,12 @@ struct perf_record_schedstat_domain_v16 {
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
@@ -544,6 +557,7 @@ struct perf_record_schedstat_domain {
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
index 9a434e2e480f..f40419d21034 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -588,6 +588,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef CPU_FIELD
 
@@ -610,6 +613,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	} else if (version == 16) {
 #include <perf/schedstat-v16.h>
 		return size;
+	} else if (version == 17) {
+#include <perf/schedstat-v17.h>
+		return size;
 	}
 #undef DOMAIN_FIELD
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 4ce37357db05..ef79433ebc3a 100644
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

