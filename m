Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80B23778;
	Wed,  8 May 2024 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148353; cv=fail; b=NoqysczsNPKSGJ3QniGsqo44sDH6rF0XAe3zbx9BPw9BWQGPPhtDfkrMn3niH50WUKO7ogreISkGlKZm0gLXk86Qoo4/EVA4BwrlI4K9bicykqpFkFPdattqyhGqanZdj788kzJRYvypRfFtAupHsyKc+jQZKTy7XwVtkB0c2sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148353; c=relaxed/simple;
	bh=h1jCIxOzJoa0YwMCYeSZ6vZTGJXSjWp5ZrZGn/hcwbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcAk2xrI/3J9pM18/dDJ+9Hn+a0YKMKDVPjQrv/6wsIAqrdRCYHVKwQwcMv6pE9kfNwrN2oQqrk8CSpn2wLkN7JnWoWY+zZde5rLvrxsIZj1HgT7UIb55JOsSAidnbIJ6Pz0PzOIqY51Cnw+uRye1eqfTQSmGQKix00e+a6H5fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRNPfzUF; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRNPfzUF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSGrz+Ml7QbbHOn+OoeArOJ86+MDKTOf2dF7TjUP5mMMOKdqKWil5biC9VLdmjOou2ndzH0/xbA1SPdRytmQMCaYhbK473LMw8nUPAa7I1WS0bourwVQ4AKbo6etIcb/FViSY5U0Sertrz6s7ITnjzGN06UujHsXCf+pH4XMpmpg/KgJvJGqYEY92nMv3vM9zNA/tezMOAGCV/ndH51xUP9xWlvlIufFZ691xp1LSt2oZw1o0uyNwWlAS4KSMvnlZ7qzU223mlvOgwchXrxQRRzByRV3Xak0WHo9+e9ReVBWmq93q/z7WcQHrWTAcz6RYGbvZroOeDg3gBxqp3sF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JykRg42pkYFH1NPnpO37Y76iVqFWpjez1BPDlx5YHE=;
 b=UbRLyYnMT3LrLGOREjz+Qv+CEoqqCb2qsy/k+Ecj/0GiPjWAVWU6wOCRcnjAxskqBaGkje6jS68oVMc4+gjmkyvZzaecWtN5ALmqZgbldAOoVQSilrxpxGactXKViqsVDS55vQ6qw6nrOpqVPZCHCJgWPhnAAvIjK40sk0JqRDdFOB2mE2+rZVGs7VRAUt/rvIjqHYT2uGrE8WQ/AB/DL2MTxAEoEMBUkzoshlfWjohwbeVV2oFeHii1qhdVH8oaf76vyATf+IpNUaFHLl6pDJfV9eG9KmBVFudk3q205VYlU1+udvMU5R9aK38IRjA0g+cxsPo7tdTZVv05GoOK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JykRg42pkYFH1NPnpO37Y76iVqFWpjez1BPDlx5YHE=;
 b=xRNPfzUFCFJjcEaTWwIEm+cmqkq7uKehuwrjQafaPFp7bxdNB19rHzYXBCnL/tiNfhjgQ+tvGNwCUiitKwKiTBdTyP5mI7lEHTujDGliHBj7HFNCYnZfLO9dkXLatAz+OOUHVmCuJbDLbk65vbLSk8cMn90cuo1bzKPIBZXyCDU=
Received: from PH0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:510:5::11)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.42; Wed, 8 May 2024 06:05:47 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::26) by PH0PR07CA0006.outlook.office365.com
 (2603:10b6:510:5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Wed, 8 May 2024 06:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 06:05:46 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 01:05:36 -0500
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
Subject: [RFC 4/4] perf sched schedstat: Add support for report subcommand
Date: Wed, 8 May 2024 11:34:27 +0530
Message-ID: <20240508060427.417-5-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 390e00a7-746a-4b95-719d-08dc6f24e72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxV5KiSFM0FEy+iitqbn+uBUt+C6SaKUNGPfrgE0gd2Mpxs/v3tgrSNlPFgI?=
 =?us-ascii?Q?H5PJJ+Eu+ZSmWvDfIH5pORWvSANl26ASBet2Y2jPVjleCClPR+pYN9xRM4R9?=
 =?us-ascii?Q?nExrXzPQWQX4m8Jt8cbSW7MspsHpslD36iQK3shV6bamu9LcYjHopdjP4d5z?=
 =?us-ascii?Q?2hvzdZ6rRSlE47/AMjfRi2A8pydBgdqUyY8w4JuTP+h0Iu/JLbM9uTUZM/qz?=
 =?us-ascii?Q?XNq1I/RP0rIwxsnTgtYc86YNXffZ9Ju/J1GxZPptXoy0b36se9NV7m/IIg3y?=
 =?us-ascii?Q?UmGONlk+dd3ENA1f4Z1YW//9Zd0b7L42XWwKQ7qodrDhRnOz04cBPYddL/cr?=
 =?us-ascii?Q?+raTg0R+mnAIs0BUhg6PG0qQNED37Q/5B7wrRQt4rFvENSOP00ZWrfHA0aNx?=
 =?us-ascii?Q?jA8h047OkohkNj+zwwUaPhaUAMOJvEeOW2nObuAsJctgbat3uOCVlzNNfbV2?=
 =?us-ascii?Q?SJlAzfQhK6xYEC9p2jkv4Drp6DlGn7Zs/y+f7KjznGaNZv8Uo5URCf9Yv6CK?=
 =?us-ascii?Q?7TenL6HxHwsr2YCsW0AOZno3wgwBMt4ZpRybhH9+vL4HUgTpIW1FV97f4aXN?=
 =?us-ascii?Q?2VLtDvL6Vj7AUYK8VZLmu2JELIaLxXbXzxWbmOmNT1HBtbVjGEt6n16Xthzc?=
 =?us-ascii?Q?hFICsGC8CONJr8Bz/sLViMrQ0QsvE0WFEXnf7wUVj2NXGCeGjI2GhLVLhilu?=
 =?us-ascii?Q?dpkdBc/EXINVLNM/sCxX1xAQUv1cwCxuXJfWAKJhafyaPJe1dqB6TFdDqCbA?=
 =?us-ascii?Q?LIjDqtFIC+qLl5ZA2AP/dRd0cZV7XbjesM4rOdA17GAEjwr3vrhK1oBgsPCL?=
 =?us-ascii?Q?3V7rQVDKGqaqdIfhGTrvtrMKbwcNJTU2hO+4GhF/53tabpp79HDqUskz8Gg9?=
 =?us-ascii?Q?xgd1e2qtjt3pppm/6DH7k7fthPT+UNKP9ZrYeP34t4AlEkGXMBup20v14z2D?=
 =?us-ascii?Q?SwkNbYLi5Iz8JwOBxbs9HgwdpQSiGYpUqkXEQnCVCHFYMd150RxYad62pNqy?=
 =?us-ascii?Q?2Fjb5zwP6H7wXZs6D8aJRv2TPyvByKuJVvYljyB6tKutkMOh3bryclfqp8Ez?=
 =?us-ascii?Q?EwlPly/Q9blLeZkcAoyQHILlIKYx1kDo5gGeGvaRQGEiC4ctUWnot/u+12VB?=
 =?us-ascii?Q?Qz/8Ub4Uy3nYWF5rN7Ox24nL0boXCv93rUo3iP76TQbt3FJ9k5NzcHoen1iJ?=
 =?us-ascii?Q?w9fqCX9jfOdtOSsAg7EkOSRvZ68KWYIGPBNDyygCzDUQlVH3J+q0kOSRqps0?=
 =?us-ascii?Q?K/Y4c1qnU1qnteCCC+/WbDq8gD/TZ/Tx0YX4VB7EM22Szo9uAT/OFVFrZBOi?=
 =?us-ascii?Q?qclCfmESE58ue8Ef0r+3rmRqmcVWO3a00oqV6QnCiLfSzwDBkatAjdITXByj?=
 =?us-ascii?Q?SOEowU+iFp+HsNdbXbAHTSs1PiWg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 06:05:46.6563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e00a7-746a-4b95-719d-08dc6f24e72b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

`perf sched schedstat record` captures two sets of samples. For workload
profile, first set right before workload starts and second set after
workload finishes. For the systemwide profile, first set at the beginning
of profile and second set on receiving SIGINT signal.

Add `perf sched schedstat report` subcommand that will read both the set
of samples, get the diff and render a final report. Final report prints
scheduler stat at cpu granularity as well as sched domain granularity.

Usage example:

  # perf sched schedstat record
  # perf sched schedstat report

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/lib/perf/include/perf/event.h           |   4 +-
 .../lib/perf/include/perf/schedstat-cpu-v15.h |  29 +-
 .../perf/include/perf/schedstat-domain-v15.h  | 153 ++++++++---
 tools/perf/builtin-sched.c                    | 254 +++++++++++++++++-
 tools/perf/util/event.c                       |   4 +-
 tools/perf/util/synthetic-events.c            |   4 +-
 6 files changed, 395 insertions(+), 53 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 835bb3e2dcbf..53a58d4ebd17 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -452,7 +452,7 @@ struct perf_record_compressed {
 };
 
 struct perf_record_schedstat_cpu_v15 {
-#define CPU_FIELD(type, name)	type name;
+#define CPU_FIELD(type, name, desc, format, is_pct, pct_of)	type name;
 #include "schedstat-cpu-v15.h"
 #undef CPU_FIELD
 };
@@ -468,7 +468,7 @@ struct perf_record_schedstat_cpu {
 };
 
 struct perf_record_schedstat_domain_v15 {
-#define DOMAIN_FIELD(type, name)	type name;
+#define DOMAIN_FIELD(type, name, desc, format, is_jiffies)	type name;
 #include "schedstat-domain-v15.h"
 #undef DOMAIN_FIELD
 };
diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v15.h b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
index 8dca84b11902..96a9aba3d2cf 100644
--- a/tools/lib/perf/include/perf/schedstat-cpu-v15.h
+++ b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
@@ -1,13 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef CPU_FIELD
-CPU_FIELD(__u32, yld_count)
-CPU_FIELD(__u32, array_exp)
-CPU_FIELD(__u32, sched_count)
-CPU_FIELD(__u32, sched_goidle)
-CPU_FIELD(__u32, ttwu_count)
-CPU_FIELD(__u32, ttwu_local)
-CPU_FIELD(__u64, rq_cpu_time)
-CPU_FIELD(__u64, run_delay)
-CPU_FIELD(__u64, pcount)
-#endif
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count)
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp)
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count)
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count)
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count)
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count)
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time)
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time)
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount)
+#endif /* CPU_FIELD */
diff --git a/tools/lib/perf/include/perf/schedstat-domain-v15.h b/tools/lib/perf/include/perf/schedstat-domain-v15.h
index 181b1c10395c..5d8d65f79674 100644
--- a/tools/lib/perf/include/perf/schedstat-domain-v15.h
+++ b/tools/lib/perf/include/perf/schedstat-domain-v15.h
@@ -1,40 +1,121 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef DOMAIN_FIELD
-DOMAIN_FIELD(__u32, idle_lb_count)
-DOMAIN_FIELD(__u32, idle_lb_balanced)
-DOMAIN_FIELD(__u32, idle_lb_failed)
-DOMAIN_FIELD(__u32, idle_lb_imbalance)
-DOMAIN_FIELD(__u32, idle_lb_gained)
-DOMAIN_FIELD(__u32, idle_lb_hot_gained)
-DOMAIN_FIELD(__u32, idle_lb_nobusyq)
-DOMAIN_FIELD(__u32, idle_lb_nobusyg)
-DOMAIN_FIELD(__u32, busy_lb_count)
-DOMAIN_FIELD(__u32, busy_lb_balanced)
-DOMAIN_FIELD(__u32, busy_lb_failed)
-DOMAIN_FIELD(__u32, busy_lb_imbalance)
-DOMAIN_FIELD(__u32, busy_lb_gained)
-DOMAIN_FIELD(__u32, busy_lb_hot_gained)
-DOMAIN_FIELD(__u32, busy_lb_nobusyq)
-DOMAIN_FIELD(__u32, busy_lb_nobusyg)
-DOMAIN_FIELD(__u32, newidle_lb_count)
-DOMAIN_FIELD(__u32, newidle_lb_balanced)
-DOMAIN_FIELD(__u32, newidle_lb_failed)
-DOMAIN_FIELD(__u32, newidle_lb_imbalance)
-DOMAIN_FIELD(__u32, newidle_lb_gained)
-DOMAIN_FIELD(__u32, newidle_lb_hot_gained)
-DOMAIN_FIELD(__u32, newidle_lb_nobusyq)
-DOMAIN_FIELD(__u32, newidle_lb_nobusyg)
-DOMAIN_FIELD(__u32, alb_count)
-DOMAIN_FIELD(__u32, alb_failed)
-DOMAIN_FIELD(__u32, alb_pushed)
-DOMAIN_FIELD(__u32, sbe_count)
-DOMAIN_FIELD(__u32, sbe_balanced)
-DOMAIN_FIELD(__u32, sbe_pushed)
-DOMAIN_FIELD(__u32, sbf_count)
-DOMAIN_FIELD(__u32, sbf_balanced)
-DOMAIN_FIELD(__u32, sbf_pushed)
-DOMAIN_FIELD(__u32, ttwu_wake_remote)
-DOMAIN_FIELD(__u32, ttwu_move_affine)
-DOMAIN_FIELD(__u32, ttwu_move_balance)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY("<Category idle>")
 #endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true)
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true)
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true)
+DOMAIN_FIELD(__u32, idle_lb_imbalance,
+	     "imbalance sum on cpu idle", "%11u", false)
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false)
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false)
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true)
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY("<Category busy>")
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true)
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true)
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true)
+DOMAIN_FIELD(__u32, busy_lb_imbalance,
+	     "imbalance sum on cpu busy", "%11u", false)
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false)
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false)
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true)
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY("<Category newidle>")
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true)
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true)
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true)
+DOMAIN_FIELD(__u32, newidle_lb_imbalance,
+	     "imbalance sum on cpu newly idle", "%11u", false)
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false)
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY("<Category active_load_balance()>")
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false)
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false)
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY("<Category sched_balance_exec()>")
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false)
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false)
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY("<Category sched_balance_fork()>")
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false)
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false)
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY("<Wakeup Info>")
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false)
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false)
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false)
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 70bcd36fe1d3..26f7b2ee12e1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3663,11 +3663,263 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	return err;
 }
 
-static int perf_sched__schedstat_report(struct perf_sched *sched __maybe_unused)
+struct schedstat_domain {
+	struct perf_record_schedstat_domain domain_data;
+	struct schedstat_domain *next;
+};
+
+struct schedstat_cpu {
+	struct perf_record_schedstat_cpu cpu_data;
+	struct schedstat_domain *domain_head;
+	struct schedstat_cpu *next;
+};
+
+struct schedstat_cpu *cpu_head = NULL, *cpu_tail = NULL, *cpu_second_pass = NULL;
+struct schedstat_domain *domain_tail = NULL, *domain_second_pass = NULL;
+
+static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
+{
+	struct perf_record_schedstat_cpu *before = &cpu_second_pass->cpu_data;
+	struct perf_record_schedstat_cpu *after = &after_workload->cpu_data;
+
+#define CPU_FIELD(type, name, desc, format, is_pct, pct_of)	\
+	(before->v15.name = after->v15.name - before->v15.name);
+
+#include <perf/schedstat-cpu-v15.h>
+#undef CPU_FIELD
+}
+
+static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
+{
+	struct perf_record_schedstat_domain *before = &domain_second_pass->domain_data;
+	struct perf_record_schedstat_domain *after = &after_workload->domain_data;
+
+#define DOMAIN_FIELD(type, name, desc, format, is_jiffies)	\
+	(before->v15.name = after->v15.name - before->v15.name);
+
+#include <perf/schedstat-domain-v15.h>
+#undef DOMAIN_FIELD
+}
+
+static void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt)
 {
+	int i;
+
+	for (i = 0; i < pre_dash_cnt; ++i)
+		printf("-");
+
+	printf("%s", s);
+
+	for (i = 0; i < post_dash_cnt; ++i)
+		printf("-");
+
+	printf("\n");
+}
+
+static inline void print_cpu_stats(struct perf_record_schedstat_cpu *cs)
+{
+#define CALC_PCT(x, y)	((y) ? ((double)(x) / (y)) * 100 : 0.0)
+
+#define CPU_FIELD(type, name, desc, format, is_pct, pct_of)			\
+	do {									\
+		if (is_pct) {							\
+			printf("%-60s: " format " ( %3.2lf%% )\n", desc,	\
+			       cs->v15.name,					\
+			       CALC_PCT(cs->v15.name, cs->v15.pct_of));		\
+		} else {							\
+			printf("%-60s: " format "\n", desc, cs->v15.name);	\
+		}								\
+	} while (0);
+
+#include <perf/schedstat-cpu-v15.h>
+
+#undef CPU_FIELD
+#undef CALC_PCT
+}
+
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
+				      __u64 jiffies)
+{
+#define DOMAIN_CATEGORY(desc)							\
+	do {									\
+		int len = strlen(desc);						\
+		int pre_dash_cnt = (100 - len) / 2;				\
+		int post_dash_cnt = 100 - len - pre_dash_cnt;			\
+		print_separator(pre_dash_cnt, desc, post_dash_cnt);		\
+	} while (0);
+
+#define CALC_AVG(x, y)	((y) ? (long double)(x) / (y) : 0.0)
+
+#define DOMAIN_FIELD(type, name, desc, format, is_jiffies)			\
+	do {									\
+		if (is_jiffies) {						\
+			printf("%-65s: " format "   $ %11.2Lf $\n", desc,	\
+			       ds->v15.name,					\
+			       CALC_AVG(jiffies, ds->v15.name));		\
+		} else {							\
+			printf("%-65s: " format "\n", desc, ds->v15.name);	\
+		}								\
+	} while (0);
+
+#define DERIVED_CNT_FIELD(desc, format, x, y, z)				\
+	do {									\
+		printf("*%-64s: " format "\n", desc,				\
+		       (ds->v15.x) - (ds->v15.y) - (ds->v15.z));		\
+	} while (0);
+
+#define DERIVED_AVG_FIELD(desc, format, x, y, z, w)				\
+	do {									\
+		printf("*%-64s: " format "\n", desc, CALC_AVG(ds->v15.w,	\
+				((ds->v15.x) - (ds->v15.y) - (ds->v15.z))));	\
+	} while (0);
+
+#include <perf/schedstat-domain-v15.h>
+
+#undef DERIVED_AVG_FIELD
+#undef DERIVED_CNT_FIELD
+#undef DOMAIN_FIELD
+#undef CALC_AVG
+#undef DOMAIN_CATEGORY
+}
+
+static void show_schedstat_data(void)
+{
+	struct perf_record_schedstat_domain *ds = NULL;
+	struct perf_record_schedstat_cpu *cs = NULL;
+	struct schedstat_cpu *cptr = cpu_head;
+	struct schedstat_domain *dptr = NULL;
+	__u64 jiffies = cptr->cpu_data.timestamp;
+
+	print_separator(100, "", 0);
+	printf("Time elapsed (in jiffies)                                  : %11llu\n", jiffies);
+
+	while (cptr) {
+		cs = &cptr->cpu_data;
+
+		print_separator(100, "", 0);
+		printf("CPU %u\n", cs->cpu);
+		print_separator(100, "", 0);
+
+		print_cpu_stats(cs);
+		print_separator(100, "", 0);
+
+		dptr = cptr->domain_head;
+		ds = &dptr->domain_data;
+
+		while (dptr) {
+			printf("CPU %u DOMAIN %u\n", cs->cpu, ds->domain);
+			print_separator(100, "", 0);
+			print_domain_stats(ds, jiffies);
+
+			dptr = dptr->next;
+			ds = &dptr->domain_data;
+			print_separator(100, "", 0);
+		}
+		cptr = cptr->next;
+	}
+}
+
+static int perf_sched__process_schedstat(struct perf_session *session __maybe_unused,
+					 union perf_event *event)
+{
+	static bool after_workload_flag;
+
+	if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
+		struct schedstat_cpu *temp =
+			(struct schedstat_cpu *)malloc(sizeof(struct schedstat_cpu));
+		temp->cpu_data = event->schedstat_cpu;
+		temp->next = NULL;
+		temp->domain_head = NULL;
+
+		if (cpu_head && temp->cpu_data.cpu == 0)
+			after_workload_flag = true;
+
+		if (!after_workload_flag) {
+			if (temp->cpu_data.cpu == 0)
+				cpu_head = temp;
+			else
+				cpu_tail->next = temp;
+
+			cpu_tail = temp;
+		} else {
+			if (temp->cpu_data.cpu == 0) {
+				cpu_second_pass = cpu_head;
+				cpu_head->cpu_data.timestamp =
+					temp->cpu_data.timestamp - cpu_second_pass->cpu_data.timestamp;
+			} else {
+				cpu_second_pass = cpu_second_pass->next;
+			}
+			domain_second_pass = cpu_second_pass->domain_head;
+			store_schedtstat_cpu_diff(temp);
+		}
+	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
+		struct schedstat_domain *temp =
+			(struct  schedstat_domain *)malloc(sizeof(struct schedstat_domain));
+		temp->domain_data = event->schedstat_domain;
+		temp->next = NULL;
+
+		if (!after_workload_flag) {
+			if (cpu_tail->domain_head == NULL) {
+				cpu_tail->domain_head = temp;
+				domain_tail = temp;
+			} else {
+				domain_tail->next = temp;
+				domain_tail = temp;
+			}
+		} else {
+			store_schedstat_domain_diff(temp);
+			domain_second_pass = domain_second_pass->next;
+		}
+	}
+
 	return 0;
 }
 
+static void free_schedstat(void)
+{
+	struct schedstat_cpu *cptr = cpu_head, *tmp_cptr;
+	struct schedstat_domain *dptr = NULL, *tmp_dptr;
+
+	while (cptr) {
+		tmp_cptr = cptr;
+		dptr = cptr->domain_head;
+
+		while (dptr) {
+			tmp_dptr = dptr;
+			dptr = dptr->next;
+			free(tmp_dptr);
+		}
+		cptr = cptr->next;
+		free(tmp_cptr);
+	}
+}
+
+static int perf_sched__schedstat_report(struct perf_sched *sched)
+{
+	struct perf_session *session;
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+	};
+	int err;
+
+	sched->tool.schedstat_cpu = perf_sched__process_schedstat;
+	sched->tool.schedstat_domain = perf_sched__process_schedstat;
+
+	session = perf_session__new(&data, &sched->tool);
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed.\n");
+		return PTR_ERR(session);
+	}
+
+	err = perf_session__process_events(session);
+
+	perf_session__delete(session);
+	show_schedstat_data();
+	free_schedstat();
+	return err;
+}
+
 static const char default_sort_order[] = "avg, max, switch, runtime";
 static struct perf_sched perf_sched = {
 	.tool = {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f2b10bc44a9e..ad2f5392f145 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -597,7 +597,7 @@ static size_t __fprintf_schedstat_cpu_v15(union perf_event *event, FILE *fp)
 	size = fprintf(fp, "\ncpu%u ", event->schedstat_cpu.cpu);
 	csv15 = &event->schedstat_cpu.v15;
 
-#define CPU_FIELD(type, name)	\
+#define CPU_FIELD(type, name, desc, format, is_pct, pct_of)	\
 	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)csv15->name);
 
 #include <perf/schedstat-cpu-v15.h>
@@ -623,7 +623,7 @@ static size_t __fprintf_schedstat_domain_v15(union perf_event *event, FILE *fp)
 	size = fprintf(fp, "\ndomain%u ", event->schedstat_domain.domain);
 	dsv15 = &event->schedstat_domain.v15;
 
-#define DOMAIN_FIELD(type, name)	\
+#define DOMAIN_FIELD(type, name, desc, format, is_jiffies)	\
 	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)dsv15->name);
 
 #include <perf/schedstat-domain-v15.h>
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b5cfd4797495..1da0cc02e801 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2442,7 +2442,7 @@ static bool read_schedstat_cpu_v15(struct io *io,
 	if (io__get_dec(io, (__u64 *) &cs->cpu) != ' ')
 		return false;
 
-#define CPU_FIELD(type, name)						\
+#define CPU_FIELD(type, name, desc, format, is_pct, pct_of)		\
 	do {								\
 		ch = io__get_dec(io, (__u64 *) &cs->v15.name);		\
 		if (ch != ' ' && ch != '\n')				\
@@ -2469,7 +2469,7 @@ static bool read_schedstat_domain_v15(struct io *io,
 
 	while (io__get_char(io) != ' ');
 
-#define DOMAIN_FIELD(type, name)				\
+#define DOMAIN_FIELD(type, name, desc, format, is_jiffies)	\
 	do {							\
 		ch = io__get_dec(io, (__u64 *) &ds->v15.name);	\
 		if (ch != ' ' && ch != '\n')			\
-- 
2.44.0

