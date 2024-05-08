Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017417BB6;
	Wed,  8 May 2024 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148345; cv=fail; b=tl2Bp/N5ukjOp+CBXGAblUiOVWC3PuuoycU5ZOi6CZ2eqBzzNZPVpogPA7FibDoUef02f3/WS1a6S+M34c3SA+RdVo67J+cscTbr0NAAA3XpXEaEgqgILgUoja2xc1mrFKtJyHpG1uuAAb58mcdIFrn3DuRZV2Cy8nCyiq1ywCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148345; c=relaxed/simple;
	bh=7pz2YzvvL9K4lY3+cKp753pecpmgOc6SuhQA9axd9I0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2hFNv1VlvmExyTlGnuejuRqWtqPWHEikrzeExVzEVGagckkRsvBN8EqwT4T+1bR6n2upP46B4XrYlYk1ZJOe6PaNrazU/eWSHX5QIBN2PGgH2alRW2i38UkGwkeJYzzYMOAG68cX7WS4CanXvkJSSHZbVYl1E9cUiXybJBo53c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iG/jOY6I; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iG/jOY6I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgsn7GgDUuFoU5uD8yU41VH6nRKwspgsXF9xzqifTOszSk65oj+DnXEHW9HbATTlS6G5Md5BDcxEsG/Alb3vEUD6UGi3lZf7Mxar97Ni/4OMgBRMeeOFtKVdruendeMcFZsaxi7zZKwthxlNGzaqFcZdZD33pdL49hY17Vw4ekLGden0ukGFDYGFitZlElxrKgf8mYU15uLjZzv4xhIt6fz29ar5HhuXyDW8/G+5e0n563pnflk1iBvCMYeYplXlQ7yQpjhAehVXY4mTfylGXkddz/hvkoUkKhaoYTnxDf2d/37CqHkEyxLgTgyd6QRuygO26ORb3MEXQoC5iNFORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPkYm8d9JXt+Q1BGB3ivJ2qbk+4ypuN61EGg5IfvmjM=;
 b=AUsMsVQLafKBWsTdC2Psq68v7EsD7H7cauW8M+Kus360bbV9Sk2Iql1YQoeZ/0TJd4rZ5y0xLWaCBYfc6tKIJtw/K/kEklpcsA4Md1LmelNvxOzjPnd80AmZ15lx5rvGSEn6pNDnDJFwOgmwkAl8JtuCiLvG1oZ8620zYFyL54xgCSMMl+PdSACGZBlE0DC3NH41e9Gs9bBt9nfE18Y0XEMmNKBPTpYF5mXdpAnuffP4PreEeyLYRXg/7RwDrIFXDyvV7IlGR56AyoJKBAe5ta+TgmE0xlOxUHL48/PVmUplGMAWdOAihaY7MkcxKCGJFsW0iahFXAgT0+QTIzKW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPkYm8d9JXt+Q1BGB3ivJ2qbk+4ypuN61EGg5IfvmjM=;
 b=iG/jOY6IfwfKDviaVsGoE13uZN8867XU6wxRxQzqJToN9ORmMFwZdAvSNb64W8aGMyr34INA1Kpcrs1SwEwcBvKN06lX5XanRHnZtnDqY8fIjr0GK6WJGrqukF7XK0OXQ5TYGm3wGIDOfTflLblHVTClP9W5Yr+BbWCA4lCNlnk=
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 06:05:37 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::29) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 06:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 06:05:36 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 01:05:25 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>, <bristot@redhat.com>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [RFC 3/4] perf sched schedstat: Add record and rawdump support
Date: Wed, 8 May 2024 11:34:26 +0530
Message-ID: <20240508060427.417-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508060427.417-1-ravi.bangoria@amd.com>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: a947e426-4d3d-48f0-5e20-08dc6f24e132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hLpxVXapyg7EUrkG8WpRNOD8pts6/ZmJDGlaxz6aYxgg29K2vmZBlhgsS951?=
 =?us-ascii?Q?AsmJRQZ9d20VyZ/oIPRdM3xxruYFDm8dZnsodJz5pA46fWAmnp8qT0MQ8D97?=
 =?us-ascii?Q?ljPGVg3WohJrKUAQ7tQXMUxIaLWhtXrPxBzK1VesQBBUFcJlmOt1njF4kZKN?=
 =?us-ascii?Q?bkU0FQPZJvWVEtHR62tmxp8I1ZTtm1jHD/Oltii/0k8Idr7IiMXG9KNSx9OM?=
 =?us-ascii?Q?LBOgRNj9yFbmHzY+ImfOTPgoTjzoCfI0HKEAcartNpbv1im6ZV1l6bhDDrS+?=
 =?us-ascii?Q?byuj2+wi1UrORVSHL8i+++QVa3uIvrNzul265ivTIGicF/cyym6rRwgERSkv?=
 =?us-ascii?Q?1+C7u9fLE5pzdvQ02eeroikRUJJJQvbtLaRuOrS6VfD3jXDyG/LVbg6SvtSW?=
 =?us-ascii?Q?jdx+8Ee+dGRvCylxdkpANBTDN51OybhkKIB4fBMLDfUZyMHgOrgUbz7QiLYk?=
 =?us-ascii?Q?1PIbZDRxvgLUgjEZPBz0j5xZD6SIX5Y36X2Wk64AiG+Sn1jBYXWcLsJ/vMqN?=
 =?us-ascii?Q?hFVxWYmeYfah9EsgPgcqF3Q0nc8rVufMqZawijGF+Qs4g1+bIs5BEMHg1F1E?=
 =?us-ascii?Q?gKb3cwwGeSjUf4ycU1vyz699A7weOgo9XDhgjp9i6RehkPPqVsPB5BeM8lKc?=
 =?us-ascii?Q?JgUOL/avk6lHf5o2SOjPfuYDelF4J+iT0CyBXG38RJ02PcZVublwyiV4NfJx?=
 =?us-ascii?Q?qtoij29R3JsodtRR7fkpcSS0Kc2KnvVLvR0DIuq1NRNgIolEwTfzqhfJ8gcy?=
 =?us-ascii?Q?byULpU7nTeJB+RvUQvFykgi0ykup66T230x+n9bFHkenXQpJjsuydAi8pJL9?=
 =?us-ascii?Q?4gze1V6wA5pgqkz0p8nER9vvfsFdVean9TT2ynV8/gVPrzOfTZ3TsF6WXZsX?=
 =?us-ascii?Q?Q9qORNnty4J5y338GFNDzhyCz9BL/PHIO8LJC14R1IH7c37LccJxkrS/Q0Yo?=
 =?us-ascii?Q?+tLr3Uuiki9uhSsRY1i8eP6uQ1mbYhJ/M3QsmfBlF/42U9NJaNV0YasdOYOr?=
 =?us-ascii?Q?h2ssTB0hI7mBCORwtwYxXZLojBoCUSsJhTtzj9LFmpR85QDRi3L8ixGO4vpO?=
 =?us-ascii?Q?lbaPy0u04+KA8Rk2mwfeAnvN+2z5x4rS7BxMyNdX6OsVn/74rA1oN3zIQu5y?=
 =?us-ascii?Q?MiD3vdU+jkF4QO43GFoacMDQ72nhh4jW8Wwxr8ufYTpq+hkP4DNiE2Irx+x+?=
 =?us-ascii?Q?r5jghKZSHyq9PHO6B8e6kuuxD7zBAONNKnBQFmb5ZvB2C0LJqURkEr05NiQt?=
 =?us-ascii?Q?3v9U9p2WvzlII7zMXFacMJ1TaPsbXHzHOBNP4VbfmO5tsSoDf6me4OEwljTT?=
 =?us-ascii?Q?Bt4nOxV4NMhdpwhPlVHCb2yvPlLh98a5p7i0uzSy/GWFLAgVr5leuLNsS4j1?=
 =?us-ascii?Q?uF1zlQAlDtlJ6xocifbvv8Apl3N2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 06:05:36.5885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a947e426-4d3d-48f0-5e20-08dc6f24e132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

Define new, perf tool only, sample types and their layouts. Add logic
to parse /proc/schedstat, convert it to perf sample format and save
samples to perf.data file with `perf sched schedstat record` subcommand.
Also add logic to read perf.data file, interpret schedstat samples and
print rawdump of samples with `perf script -D`.

Note that, /proc/schedstat file output is standardized with version
number. The patch supports v15 but older or newer version can be added
easily.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/lib/perf/Documentation/libperf.txt      |   2 +
 tools/lib/perf/Makefile                       |   2 +-
 tools/lib/perf/include/perf/event.h           |  37 ++++
 .../lib/perf/include/perf/schedstat-cpu-v15.h |  13 ++
 .../perf/include/perf/schedstat-domain-v15.h  |  40 +++++
 tools/perf/builtin-inject.c                   |   2 +
 tools/perf/builtin-sched.c                    | 157 +++++++++++++++-
 tools/perf/util/event.c                       |  54 ++++++
 tools/perf/util/event.h                       |   2 +
 tools/perf/util/session.c                     |  44 +++++
 tools/perf/util/synthetic-events.c            | 170 ++++++++++++++++++
 tools/perf/util/synthetic-events.h            |   4 +
 tools/perf/util/tool.h                        |   4 +-
 13 files changed, 525 insertions(+), 6 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v15.h

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..39c78682ad2e 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -211,6 +211,8 @@ SYNOPSIS
   struct perf_record_time_conv;
   struct perf_record_header_feature;
   struct perf_record_compressed;
+  struct perf_record_schedstat_cpu;
+  struct perf_record_schedstat_domain;
 --
 
 DESCRIPTION
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3a9b2140aa04..ebbfea891a6a 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -187,7 +187,7 @@ install_lib: libs
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
-HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
+HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ae64090184d3..835bb3e2dcbf 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -451,6 +451,39 @@ struct perf_record_compressed {
 	char			 data[];
 };
 
+struct perf_record_schedstat_cpu_v15 {
+#define CPU_FIELD(type, name)	type name;
+#include "schedstat-cpu-v15.h"
+#undef CPU_FIELD
+};
+
+struct perf_record_schedstat_cpu {
+	struct perf_event_header header;
+	__u16			 version;
+	__u64			 timestamp;
+	__u32			 cpu;
+	union {
+		struct perf_record_schedstat_cpu_v15 v15;
+	};
+};
+
+struct perf_record_schedstat_domain_v15 {
+#define DOMAIN_FIELD(type, name)	type name;
+#include "schedstat-domain-v15.h"
+#undef DOMAIN_FIELD
+};
+
+struct perf_record_schedstat_domain {
+	struct perf_event_header header;
+	__u16			 version;
+	__u64			 timestamp;
+	__u32			 cpu;
+	__u16			 domain;
+	union {
+		struct perf_record_schedstat_domain_v15 v15;
+	};
+};
+
 enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_USER_TYPE_START		= 64,
 	PERF_RECORD_HEADER_ATTR			= 64,
@@ -472,6 +505,8 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_HEADER_FEATURE		= 80,
 	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_FINISHED_INIT		= 82,
+	PERF_RECORD_SCHEDSTAT_CPU		= 83,
+	PERF_RECORD_SCHEDSTAT_DOMAIN		= 84,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -512,6 +547,8 @@ union perf_event {
 	struct perf_record_time_conv		time_conv;
 	struct perf_record_header_feature	feat;
 	struct perf_record_compressed		pack;
+	struct perf_record_schedstat_cpu	schedstat_cpu;
+	struct perf_record_schedstat_domain	schedstat_domain;
 };
 
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v15.h b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
new file mode 100644
index 000000000000..8dca84b11902
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count)
+CPU_FIELD(__u32, array_exp)
+CPU_FIELD(__u32, sched_count)
+CPU_FIELD(__u32, sched_goidle)
+CPU_FIELD(__u32, ttwu_count)
+CPU_FIELD(__u32, ttwu_local)
+CPU_FIELD(__u64, rq_cpu_time)
+CPU_FIELD(__u64, run_delay)
+CPU_FIELD(__u64, pcount)
+#endif
diff --git a/tools/lib/perf/include/perf/schedstat-domain-v15.h b/tools/lib/perf/include/perf/schedstat-domain-v15.h
new file mode 100644
index 000000000000..181b1c10395c
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-domain-v15.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef DOMAIN_FIELD
+DOMAIN_FIELD(__u32, idle_lb_count)
+DOMAIN_FIELD(__u32, idle_lb_balanced)
+DOMAIN_FIELD(__u32, idle_lb_failed)
+DOMAIN_FIELD(__u32, idle_lb_imbalance)
+DOMAIN_FIELD(__u32, idle_lb_gained)
+DOMAIN_FIELD(__u32, idle_lb_hot_gained)
+DOMAIN_FIELD(__u32, idle_lb_nobusyq)
+DOMAIN_FIELD(__u32, idle_lb_nobusyg)
+DOMAIN_FIELD(__u32, busy_lb_count)
+DOMAIN_FIELD(__u32, busy_lb_balanced)
+DOMAIN_FIELD(__u32, busy_lb_failed)
+DOMAIN_FIELD(__u32, busy_lb_imbalance)
+DOMAIN_FIELD(__u32, busy_lb_gained)
+DOMAIN_FIELD(__u32, busy_lb_hot_gained)
+DOMAIN_FIELD(__u32, busy_lb_nobusyq)
+DOMAIN_FIELD(__u32, busy_lb_nobusyg)
+DOMAIN_FIELD(__u32, newidle_lb_count)
+DOMAIN_FIELD(__u32, newidle_lb_balanced)
+DOMAIN_FIELD(__u32, newidle_lb_failed)
+DOMAIN_FIELD(__u32, newidle_lb_imbalance)
+DOMAIN_FIELD(__u32, newidle_lb_gained)
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg)
+DOMAIN_FIELD(__u32, alb_count)
+DOMAIN_FIELD(__u32, alb_failed)
+DOMAIN_FIELD(__u32, alb_pushed)
+DOMAIN_FIELD(__u32, sbe_count)
+DOMAIN_FIELD(__u32, sbe_balanced)
+DOMAIN_FIELD(__u32, sbe_pushed)
+DOMAIN_FIELD(__u32, sbf_count)
+DOMAIN_FIELD(__u32, sbf_balanced)
+DOMAIN_FIELD(__u32, sbf_pushed)
+DOMAIN_FIELD(__u32, ttwu_wake_remote)
+DOMAIN_FIELD(__u32, ttwu_move_affine)
+DOMAIN_FIELD(__u32, ttwu_move_balance)
+#endif
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a212678d47be..28b8c1366446 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2204,6 +2204,8 @@ int cmd_inject(int argc, const char **argv)
 			.finished_init	= perf_event__repipe_op2_synth,
 			.compressed	= perf_event__repipe_op4_synth,
 			.auxtrace	= perf_event__repipe_auxtrace,
+			.schedstat_cpu	= perf_event__repipe_op2_synth,
+			.schedstat_domain = perf_event__repipe_op2_synth,
 		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 717bdf113241..70bcd36fe1d3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -19,6 +19,8 @@
 #include "util/string2.h"
 #include "util/callchain.h"
 #include "util/time-utils.h"
+#include "util/synthetic-events.h"
+#include "util/target.h"
 
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -229,8 +231,13 @@ struct perf_sched {
 	struct perf_time_interval ptime;
 	struct perf_time_interval hist_time;
 	volatile bool   thread_funcs_exit;
+
+	struct perf_session *session;
+	struct perf_data *data;
 };
 
+static struct perf_sched perf_sched;
+
 /* per thread run time data */
 struct thread_runtime {
 	u64 last_time;      /* time of previous sched in/out event */
@@ -3504,14 +3511,156 @@ static int __cmd_record(int argc, const char **argv)
 	return ret;
 }
 
+static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
+				     union perf_event *event,
+				     struct perf_sample *sample __maybe_unused,
+				     struct machine *machine __maybe_unused)
+{
+	if (perf_data__write(perf_sched.data, event, event->header.size) <= 0) {
+		pr_err("failed to write perf data, error: %m\n");
+		return -1;
+	}
+
+	perf_sched.session->header.data_size += event->header.size;
+	return 0;
+}
+
+static void sighandler(int sig __maybe_unused)
+{
+}
+
 /* perf.data or any other output file name used by schedstat subcommand (only). */
 const char *output_name;
+static struct target target;
 
-static int perf_sched__schedstat_record(struct perf_sched *sched __maybe_unused,
-					int argc __maybe_unused,
-					const char **argv __maybe_unused)
+static int perf_sched__schedstat_record(struct perf_sched *sched,
+					int argc, const char **argv)
 {
-	return 0;
+	struct perf_session *session;
+	struct evlist *evlist;
+	int err = 0;
+	FILE *fp;
+	int flag;
+	char ch;
+	int fd;
+	struct perf_data data = {
+		.path  = output_name,
+		.mode  = PERF_DATA_MODE_WRITE,
+	};
+
+	signal(SIGINT, sighandler);
+	signal(SIGCHLD, sighandler);
+	signal(SIGTERM, sighandler);
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	session = perf_session__new(&data, &sched->tool);
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed.\n");
+		return PTR_ERR(session);
+	}
+
+	session->evlist = evlist;
+
+	perf_sched.session = session;
+	perf_sched.data = &data;
+
+	fd = perf_data__fd(&data);
+
+	/*
+	 * Capture all important metadata about the system. Although they
+	 * are not used by schedstat tool directly, they provide useful
+	 * information about profiled environment.
+	 */
+	perf_header__set_feat(&session->header, HEADER_HOSTNAME);
+	perf_header__set_feat(&session->header, HEADER_OSRELEASE);
+	perf_header__set_feat(&session->header, HEADER_VERSION);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
+	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_CPUDESC);
+	perf_header__set_feat(&session->header, HEADER_CPUID);
+	perf_header__set_feat(&session->header, HEADER_TOTAL_MEM);
+	perf_header__set_feat(&session->header, HEADER_CMDLINE);
+	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_NUMA_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_CACHE);
+	perf_header__set_feat(&session->header, HEADER_MEM_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_CPU_PMU_CAPS);
+	perf_header__set_feat(&session->header, HEADER_HYBRID_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_PMU_CAPS);
+
+	err = perf_session__write_header(session, evlist, fd, false);
+	if (err < 0)
+		goto out;
+
+	/* FIXME. Quirk for evlist__prepare_workload() */
+	target.system_wide = true;
+
+	/* FIXME: -p <pid> support */
+	if (argc) {
+		err = evlist__prepare_workload(evlist, &target, argv, false, NULL);
+		if (err)
+			goto out;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool), session,
+					       &session->machines.host /* machine */,
+					       process_synthesized_event);
+	if (err < 0)
+		goto out;
+
+	fp = fopen("/proc/sys/kernel/sched_schedstats", "w+");
+	if (!fp) {
+		printf("Failed to open /proc/sys/kernel/sched_schedstats");
+		goto out;
+	}
+
+	ch = getc(fp);
+	if (ch == '0') {
+		flag = 1;
+		rewind(fp);
+		putc('1', fp);
+		fclose(fp);
+	}
+
+	if (argc)
+		evlist__start_workload(evlist);
+
+	/* wait for signal */
+	pause();
+
+	err = perf_event__synthesize_schedstat(&(sched->tool), session,
+					       &session->machines.host /* machine */,
+					       process_synthesized_event);
+
+	if (flag == 1) {
+		fp = fopen("/proc/sys/kernel/sched_schedstats", "w");
+		if (!fp) {
+			printf("Failed to open /proc/sys/kernel/sched_schedstats");
+			goto out;
+		}
+
+		putc('0', fp);
+		fclose(fp);
+	}
+
+	if (err < 0)
+		goto out;
+
+	err = perf_session__write_header(session, evlist, fd, true);
+
+	if (!err)
+		fprintf(stderr, "[ perf sched schedstat: Wrote samples to %s ]\n", data.path);
+	else
+		fprintf(stderr, "[ perf sched schedstat: Failed !! ]\n");
+
+out:
+	close(fd);
+	perf_session__delete(session);
+
+	return err;
 }
 
 static int perf_sched__schedstat_report(struct perf_sched *sched __maybe_unused)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f32f9abf6344..f2b10bc44a9e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -77,6 +77,8 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
+	[PERF_RECORD_SCHEDSTAT_CPU]		= "SCHEDSTAT_CPU",
+	[PERF_RECORD_SCHEDSTAT_DOMAIN]		= "SCHEDSTAT_DOMAIN",
 };
 
 const char *perf_event__name(unsigned int id)
@@ -587,6 +589,58 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 	return ret;
 }
 
+static size_t __fprintf_schedstat_cpu_v15(union perf_event *event, FILE *fp)
+{
+	struct perf_record_schedstat_cpu_v15 *csv15;
+	size_t size = 0;
+
+	size = fprintf(fp, "\ncpu%u ", event->schedstat_cpu.cpu);
+	csv15 = &event->schedstat_cpu.v15;
+
+#define CPU_FIELD(type, name)	\
+	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)csv15->name);
+
+#include <perf/schedstat-cpu-v15.h>
+#undef CPU_FIELD
+
+	return size;
+}
+
+size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
+{
+	if (event->schedstat_cpu.version == 15)
+		return __fprintf_schedstat_cpu_v15(event, fp);
+
+	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
+		       event->schedstat_cpu.version);
+}
+
+static size_t __fprintf_schedstat_domain_v15(union perf_event *event, FILE *fp)
+{
+	struct perf_record_schedstat_domain_v15 *dsv15;
+	size_t size = 0;
+
+	size = fprintf(fp, "\ndomain%u ", event->schedstat_domain.domain);
+	dsv15 = &event->schedstat_domain.v15;
+
+#define DOMAIN_FIELD(type, name)	\
+	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)dsv15->name);
+
+#include <perf/schedstat-domain-v15.h>
+#undef DOMAIN_FIELD
+
+	return size;
+}
+
+size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
+{
+	if (event->schedstat_domain.version == 15)
+		return __fprintf_schedstat_domain_v15(event, fp);
+
+	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
+		       event->schedstat_domain.version);
+}
+
 int perf_event__process(struct perf_tool *tool __maybe_unused,
 			union perf_event *event,
 			struct perf_sample *sample,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index d8bcee2e9b93..c6ac391ce09c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -356,6 +356,8 @@ size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *machine,FILE *fp);
+size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a10343b9dcd4..676bfe022afd 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -480,6 +480,26 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
        return 0;
 }
 
+static int
+process_schedstat_cpu_stub(struct perf_session *perf_session __maybe_unused,
+			   union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_schedstat_cpu(event, stdout);
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int
+process_schedstat_domain_stub(struct perf_session *perf_session __maybe_unused,
+			      union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_schedstat_domain(event, stdout);
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
 void perf_tool__fill_defaults(struct perf_tool *tool)
 {
 	if (tool->sample == NULL)
@@ -562,6 +582,10 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->compressed = perf_session__process_compressed_event;
 	if (tool->finished_init == NULL)
 		tool->finished_init = process_event_op2_stub;
+	if (tool->schedstat_cpu == NULL)
+		tool->schedstat_cpu = process_schedstat_cpu_stub;
+	if (tool->schedstat_domain == NULL)
+		tool->schedstat_domain = process_schedstat_domain_stub;
 }
 
 static void swap_sample_id_all(union perf_event *event, void *data)
@@ -996,6 +1020,20 @@ static void perf_event__time_conv_swap(union perf_event *event,
 	}
 }
 
+static void
+perf_event__schedstat_cpu_swap(union perf_event *event __maybe_unused,
+			       bool sample_id_all __maybe_unused)
+{
+	/* FIXME */
+}
+
+static void
+perf_event__schedstat_domain_swap(union perf_event *event __maybe_unused,
+				  bool sample_id_all __maybe_unused)
+{
+	/* FIXME */
+}
+
 typedef void (*perf_event__swap_op)(union perf_event *event,
 				    bool sample_id_all);
 
@@ -1034,6 +1072,8 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
+	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
 };
 
@@ -1744,6 +1784,10 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return err;
 	case PERF_RECORD_FINISHED_INIT:
 		return tool->finished_init(session, event);
+	case PERF_RECORD_SCHEDSTAT_CPU:
+		return tool->schedstat_cpu(session, event);
+	case PERF_RECORD_SCHEDSTAT_DOMAIN:
+		return tool->schedstat_domain(session, event);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 5498048f56ea..b5cfd4797495 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2430,3 +2430,173 @@ int parse_synth_opt(char *synth)
 
 	return ret;
 }
+
+static bool read_schedstat_cpu_v15(struct io *io,
+				   struct perf_record_schedstat_cpu *cs)
+{
+	char ch;
+
+	if (io__get_char(io) != 'p' || io__get_char(io) != 'u')
+		return false;
+
+	if (io__get_dec(io, (__u64 *) &cs->cpu) != ' ')
+		return false;
+
+#define CPU_FIELD(type, name)						\
+	do {								\
+		ch = io__get_dec(io, (__u64 *) &cs->v15.name);		\
+		if (ch != ' ' && ch != '\n')				\
+			return false;					\
+	} while (0);
+
+#include <perf/schedstat-cpu-v15.h>
+#undef CPU_FIELD
+
+	return true;
+}
+
+static bool read_schedstat_domain_v15(struct io *io,
+				      struct perf_record_schedstat_domain *ds)
+{
+	char ch;
+
+	if (io__get_char(io) != 'o' || io__get_char(io) != 'm' || io__get_char(io) != 'a' ||
+	    io__get_char(io) != 'i' || io__get_char(io) != 'n')
+		return false;
+
+	if (io__get_dec(io, (__u64 *) &ds->domain) != ' ')
+		return false;
+
+	while (io__get_char(io) != ' ');
+
+#define DOMAIN_FIELD(type, name)				\
+	do {							\
+		ch = io__get_dec(io, (__u64 *) &ds->v15.name);	\
+		if (ch != ' ' && ch != '\n')			\
+			return false;				\
+	} while (0);
+
+#include <perf/schedstat-domain-v15.h>
+#undef DOMAIN_FIELD
+
+	return true;
+}
+
+static union perf_event *__synthesize_schedstat_cpu_v15(struct io *io, __u16 *cpu,
+							__u64 timestamp,
+							struct machine *machine)
+{
+	union perf_event *event;
+	size_t size;
+
+	size = sizeof(struct perf_record_schedstat_cpu);
+	event = zalloc(size + machine->id_hdr_size);
+
+	if (!event)
+		return NULL;
+
+	event->schedstat_cpu.header.type = PERF_RECORD_SCHEDSTAT_CPU;
+	event->schedstat_cpu.version = 15;
+	event->schedstat_cpu.timestamp = timestamp;
+	event->schedstat_cpu.header.size = size + machine->id_hdr_size;
+
+	if (read_schedstat_cpu_v15(io, &event->schedstat_cpu)) {
+		*cpu = event->schedstat_cpu.cpu;
+	} else {
+		free(event);
+		return NULL;
+	}
+
+	return event;
+}
+
+static union perf_event *__synthesize_schedstat_domain_v15(struct io *io, __u16 cpu,
+							   __u64 timestamp,
+							   struct machine *machine)
+{
+	union perf_event *event;
+	size_t size;
+
+	size = sizeof(struct perf_record_schedstat_domain);
+	event = zalloc(size + machine->id_hdr_size);
+
+	if (!event)
+		return NULL;
+
+	event->schedstat_domain.header.type = PERF_RECORD_SCHEDSTAT_DOMAIN;
+	event->schedstat_domain.version = 15;
+	event->schedstat_domain.timestamp = timestamp;
+	event->schedstat_domain.header.size = size + machine->id_hdr_size;
+
+	if (read_schedstat_domain_v15(io, &event->schedstat_domain)) {
+		event->schedstat_domain.cpu = cpu;
+	} else {
+		free(event);
+		return NULL;
+	}
+
+	return event;
+}
+
+int perf_event__synthesize_schedstat(struct perf_tool *tool,
+				     struct perf_session *session __maybe_unused,
+				     struct machine *machine,
+				     perf_event__handler_t process)
+{
+	union perf_event *event = NULL;
+	size_t line_len = 0;
+	char *line = NULL;
+	char bf[BUFSIZ];
+	__u64 timestamp;
+	__u16 cpu = -1;
+	struct io io;
+	int ret = -1;
+	char ch;
+
+	io.fd = open("/proc/schedstat", O_RDONLY, 0);
+	if (io.fd < 0) {
+		pr_debug("Failed to open /proc/schedstat\n");
+		return -1;
+	}
+	io__init(&io, io.fd, bf, sizeof(bf));
+
+	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
+		goto out;
+	if (strcmp(line, "version 15\n")) {
+		pr_debug("Unsupported /proc/schedstat version\n");
+		goto out_free_line;
+	}
+
+	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
+		goto out_free_ev;
+	timestamp = atol(line + 10);
+
+	ch = io__get_char(&io);
+
+	while (!io.eof) {
+		if (ch == 'c') {
+			event = __synthesize_schedstat_cpu_v15(&io, &cpu, timestamp,
+							       machine);
+		} else if (ch == 'd') {
+			event = __synthesize_schedstat_domain_v15(&io, cpu, timestamp,
+								  machine);
+		}
+		if (!event)
+			goto out_free_line;
+
+		if (process(tool, event, NULL, NULL) < 0)
+			goto out_free_ev;
+
+		ch = io__get_char(&io);
+	}
+
+	ret = 0;
+
+out_free_ev:
+	free(event);
+out_free_line:
+	free(line);
+out:
+	close(io.fd);
+	return ret;
+}
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index 53737d1619a4..31498b8426fc 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -122,4 +122,8 @@ int perf_event__synthesize_for_pipe(struct perf_tool *tool,
 				    struct perf_data *data,
 				    perf_event__handler_t process);
 
+int perf_event__synthesize_schedstat(struct perf_tool *tool,
+				     struct perf_session *session,
+				     struct machine *machine,
+				     perf_event__handler_t process);
 #endif // __PERF_SYNTHETIC_EVENTS_H
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index c957fb849ac6..fe763db8a7ad 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -77,7 +77,9 @@ struct perf_tool {
 			stat,
 			stat_round,
 			feature,
-			finished_init;
+			finished_init,
+			schedstat_cpu,
+			schedstat_domain;
 	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
-- 
2.44.0

