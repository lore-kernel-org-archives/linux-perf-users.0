Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0712571C0;
	Tue, 11 Mar 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694644; cv=fail; b=SV/Gr2XR9wT+aq6B2qk1nm/PYdd7rnYzbk30oMWwI8TtRxvlHtUQW2QM6v0O2WYWYD2eZAf/pKPzc9Py9CY78JpwGOCw9sT9O/OtnYkHSjKcjE42t8JbOLEoPkpbv/qKPCX/bqgcNpyEcjogzyBkJY4LjiP3RbEkqEchxRu10rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694644; c=relaxed/simple;
	bh=snVyT7DweD6z9x9YYIQRonURyxo3FA1snU3TGoPtTsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4MwFltrFIbptCxFCsipSEmhbtcmYQToGfQh1pMrRG4FWpzspIaZIunQbank47leobW5e9JsDGhaaDnrV4Ss+4+F4YBRlQEh3qjTq3AgrYEIptdXjwYb0B68lnhIcBnM/PIbgbTyH7/n0nvkRSed8UN1nMa6NLijNX9AH539Tcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K8e1w40v; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K8e1w40v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJeouB2JrIAW26mwW09p2obty4+1vqLgP6EkqxfcQMZvgrISjx+YYeQ8Th/5p6KRG7KZQkuxDL1SYUcTH4QLwRpRZhb36R1kyBNZJxRhRXNekOijWOdXwaPNHbL98OEJsVts00VzKGUDDtH8dRB7a1glYfp8hbhKVNPvROIEYseny0rqGL2mvwMwfsbhGW1IzsmM5fxGlCArDII154w44t9dnHwCB+dCtzIrBIL36XxRMnGs6wHuAk/xhp4Sl61rAt2fLsLIC5Pp7bCJ6CuU5FXgQyW6UdGBlZ9tKqq7PqKbGSloOWD/WznvP8OiEP37zVdgMu6PniOhymizC9guiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+ZePpJMsTD8Pc2geUXiwbSz3a62KZe/Xwd6UPmI64E=;
 b=V3yLoG1dg2biSpIDpVw1k+Ma0gPoh4LW+u8lruhfflvNXfPsaInxMbrj3Z4i1s0DDY+1J0WgrK2cQ8QHl51bqINoeQ0Keu8jy4Ogo62rXfn44Jn4KkZLv4TI+eej8z/zOKarxAcYQSxuRmm2rf0vnULC2kwD+F3nqj/6RoJOy3xiZQtUtw3K3vYZK1VBCPJz/kZkcgV9UlCRkPeFP1Qg0SdpEj27Oi+gsqKu8a2pzMagx5MyPKfeTxnmgBKg/lfuMrgibdjWd3XkGQUWREElJmexV12xIShk+sGU+8dNmZur+Yty+Gq4T1+LSJ6KUUZYAK3WSAioXi3ofdWaNaU+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+ZePpJMsTD8Pc2geUXiwbSz3a62KZe/Xwd6UPmI64E=;
 b=K8e1w40vM6mJ1U4Cj7UsZAxX/T+UCArPzefWUfBC7HueWs2bJ1ItZ1wg3yyOgIjyHBSnJpCrN1ogN6hCjWdxdDDQ6T1K+495gmbWEIbPx8+WMJeupyrxFaxTpojsuwQ0GHDaj8HNk3ve2ADV2Y6b8n9xNhVi7aqOGMIW3SCQDhA=
Received: from MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::11)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:03:57 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::82) by MW4P221CA0006.outlook.office365.com
 (2603:10b6:303:8b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 12:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:03:57 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 07:03:49 -0500
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
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
Subject: [PATCH v3 2/8] perf sched stats: Add schedstat v16 support
Date: Tue, 11 Mar 2025 12:02:24 +0000
Message-ID: <20250311120230.61774-3-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eec9722-5a7c-46c6-6882-08dd6094cd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J7/rcOieHTCG1kDmFxhuS7sy3VWLcMeRttnhqCI6l3tMCRDZlEH8T3rTXbJ4?=
 =?us-ascii?Q?gdsJfxB3y5aFglxS9RrtejgnJSZQTMchdEKY9IoQVOh24pbVfx2+nuGMX+kT?=
 =?us-ascii?Q?G9MCMyBt9sCxtv30FShbwsZ6zsHiU7j6yuPM65rgNV4UiJQBxg1FcYCBtfiF?=
 =?us-ascii?Q?LnkSvEdZxIBNz2ZxQtoh7WosEmXK44vl6GaWoslpABhiLcOv+iF2tQyQ5xXH?=
 =?us-ascii?Q?abL3MLRattiGtvpUysyb2nJ1259sSA797UINJ1Uu87dQw2ZsQ7Sec0tPM6bM?=
 =?us-ascii?Q?RfYL91b+WjCVZfbTSi/VJEWV3q0NBEXIKh3k6+LZKaHPfvyx7ptE+XTnhrXG?=
 =?us-ascii?Q?DXs7xRkiCpxZwYO/FlAbDM3NDGKfIXu/UdEXUU7Bg4V0zt3LdDj7rOjnBA8p?=
 =?us-ascii?Q?r8DlODCu6nhHdQRdsI7279pX2cPrBfZO8PSTf/d5O2PKOPlUNMMiyfmhP58E?=
 =?us-ascii?Q?nr4cEZLA1D2MIVOqcGH/33dQ2oNin7wfuB2JpSQOUvMWsMC7icC/0emGi4X0?=
 =?us-ascii?Q?3CDPPPF1lThtu3aZem5Fhv75nhDOivBD0+t7E42y1UFHASR/7gau80m9+sjl?=
 =?us-ascii?Q?xxaM0CoakhU38WfUSs6VI/t/Gd4s9dOqn+RtMSb44i3h/B6swVzcA48qCe8o?=
 =?us-ascii?Q?LqUYPwPEe4HCa+PmuyT5I6gVvPdtnixMu7QQ4W6IjRizJrDheFx8wRv8OWvi?=
 =?us-ascii?Q?rOF8WKs5wrcnJiZVr5r8I0daG7ewOzExcbBdR0JTf0jBv42LSMoGCAfEJdS7?=
 =?us-ascii?Q?N25bQbKA7VxE4a1aOsoqr6YjrK+5mDMnpwVOEk0DBehmy6+G23Y3JhcAdSN0?=
 =?us-ascii?Q?msz0WvAYfiqQvFxtiDzLS+Mr4QNefOFtDjMozrxnnarcRypQl1aG3rpWc9XG?=
 =?us-ascii?Q?elkUGUl/BQebjPGiTz65lO95RjH7sYWL+a8kcawlcaunrXbqq3jwGWC0LzM9?=
 =?us-ascii?Q?z+VLX/Sr5gSs3VB2UeZAX2HvFsaQ2hXFL9yfx9iHdBzSF3iIgRRziUDb6vRn?=
 =?us-ascii?Q?ikv3QPPbji7rAGktzowYdKxWB7FvBz90+ZNmB+2crNXZdugBdALQX51iKXE6?=
 =?us-ascii?Q?ZfYMW5PMr28yJb6PA31BzDb4kifF2H1kic9R4NNGOPys8HV88DfhpZ8h3Hfn?=
 =?us-ascii?Q?rXwNQXTSTs4Fdk8W9cQS47SiXdbc5SH6/gz5TrTKJuVhwsD/kSErvse5nT7O?=
 =?us-ascii?Q?V4igcgoWhzCAuja62b5MSVscyZIhoENfZIB+NIHr1cZg4dvT84edSRL8/Bmb?=
 =?us-ascii?Q?M+l+XvlbTnlfwWzV0qSKDKd1C9UasjjPkbM0IOAXhUt/fC094Ut/exXIix/l?=
 =?us-ascii?Q?wBthb2TcKvADGfIZvANtNUm0ENmHY+cBMsQWybuM5lDoURtbNayTzabi2/+N?=
 =?us-ascii?Q?7nyRctvkUSKdarKWgdty19t54frLz2RKel+oGkp77vAYUmLkO0sjmf5RwYi9?=
 =?us-ascii?Q?KvvZTe/GElceaUMid/5ffVnStHUhxNW/pTwq5yDiRNO98Iqg/8RxJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:03:57.6118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eec9722-5a7c-46c6-6882-08dd6094cd9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401

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
index 4b60804aa0b6..d0506a13a97f 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -174,7 +174,7 @@ install_lib: libs
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
index f928f07bea15..e9dc1e14cfea 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2549,6 +2549,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef CPU_FIELD
 
@@ -2661,6 +2663,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 
 	if (version == 15) {
 #include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
 	}
 #undef DOMAIN_FIELD
 
@@ -2703,6 +2707,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
 
 	if (!strcmp(line, "version 15\n")) {
 		version = 15;
+	} else if (!strcmp(line, "version 16\n")) {
+		version = 16;
 	} else {
 		pr_err("Unsupported %s version: %s", path, line + 8);
 		goto out_free_line;
-- 
2.43.0

