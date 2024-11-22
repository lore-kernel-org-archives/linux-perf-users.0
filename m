Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6161BDA85;
	Fri, 22 Nov 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265260; cv=fail; b=TDlMOUclkjzWfUgponPASemYOGpNB6y9uQaRxMsNqxP7UqbRQL06Au+QALhPbw2qsOPf42vn5bQ+VQ5RBk6tHxuYd3brLeZgfPl2WklY0feolo+E1GHEpzJpBm5MuWSEYZHfcdAJzueDyhMxp5sHuGxra+0e1A2K7D1L4pSYh2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265260; c=relaxed/simple;
	bh=VnIJYlawHlQVTwBnKI8nCNuxEnISR3yVMtq3MPErCnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDzQDzayleJB7QuubMhg1xWSxuWsNQN+9GWk/PS+TVgFoh3R+OwESsWEOO2T/9lIMowXxZn9K68UILPrapOjrlfzMMe7dYCnYRCvPTvF5q1CfKUtH64HanbNibWp2sdPaLtTHrIOdfbnuPwDO6QIgRFtyzNmT05MAUYFDnUIPgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fLb0+jx+; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fLb0+jx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxqDSNLQhIOuauTtoTS1DOoEGq+VGBiH9bFJxuFULKWeZN7DKZfUrAhJLLbZ0EGkfTt2BobBf5BjQSnop7666vJstMR0jrNEgL0eQaVWuqDYYcZouXnqMLrmQtjuFmEBMoEEFi64F8U9QXE/FkoPmtrpl+NYT0s9aew0bInmdXRlsfVkB2a6k+sJ0+zjwYFPvAexTtkc66BsrLtjCPdyxev0iH9UmsN4nLLiuREm1XNlhCVGAD4PwEig4Z6MjIQLKu6SQy9WnFTGSsiMK0F+abcyGevERPEuRiWUFeouncYcRSeyYUJSkAHnYuXiFr+eZJ2EL7LVJfM7Qt2hqojZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS2zJtIHSwuH8PO6wT1qomKERgCAegnDfXxpGPxDgrE=;
 b=nY48o/It9GoSB2EboNcQ0BZm47MsVzfdT7r5ke+pY8WbOUo/2eTnaNxcZL/7QxOWVTxy4jJQOPu3dyD/BNmfjl0/yZ6j4LD3ivWm05lnFAM8rPqCNhOA/DqHZG8IIyp1PvuY/4M3jcJ9YTzC5uACLPAvlt4RbygQs//TB4/Uw6D9GyS7AKsWVj7G+fApysD3Fv7ozKzA630j/77zGrWqga8YHQsKqYIPD7gpl8hl1HSVciLDDA3KuACVui8YRnF1D6lYO7J0RPjrBP329dWwynyVafNS2y4KXbbzQSTzLvztnw2o8L9WTX7wGmQWE/PMylMaKcx+fJbRMgslw8Vw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS2zJtIHSwuH8PO6wT1qomKERgCAegnDfXxpGPxDgrE=;
 b=fLb0+jx+ctMCw/2izjp0o3FKEA0Lb2cOuw1cUBIEoSzjnbPQD/0ZOhbggfMNAFG+6Ggjd7RPg1fWHZhk+MGq54cQApq2mq6ZeHioel/jLzFVFJffe9jtgg4JP0vH5qAmu4AnwPqyQesc3fVy+AK1EqJHypNwY0diAKKpl+jmCtY=
Received: from MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 08:47:27 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::28) by MN2PR05CA0022.outlook.office365.com
 (2603:10b6:208:c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 08:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 08:47:26 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 02:47:17 -0600
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
Subject: [PATCH v2 4/6] perf sched stats: Add support for report subcommand
Date: Fri, 22 Nov 2024 08:44:50 +0000
Message-ID: <20241122084452.1064968-5-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9f5104-985b-4fe3-ac2b-08dd0ad24a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R8c2se0A3/HsAkBRhN1Al7vX3tFjBlsF5T2Jh00Y9Ud8S0BDqDrhz3t6Y2bg?=
 =?us-ascii?Q?Mjtboitfmj2vzyn6vfK9cjnqnMm25QCRmmzlNi5YWkVUKl+VOdtzCJz0VrSP?=
 =?us-ascii?Q?543d9I9Pf1FkVEiaLGLLYUspSMXGNfBJBd8KKnkK0HqCYqquSUlPxBK6jEPt?=
 =?us-ascii?Q?r5cUNnCIOoTGbUa4tvoX6Q0YzhZ4SVeaCwZgU79nuea34CSKtEcOPfa4ZKY/?=
 =?us-ascii?Q?exUafv/3rwKIv6eicZNPb8GoOiZ6dyRJ/SmIkxk9nzmnBsyVBdtiarJ0WBip?=
 =?us-ascii?Q?2kOK+vhu8uYDbqD643DEjdkSRtcSjPSiJ8sAYQD/wzQoJWfRnhMhwySH4/93?=
 =?us-ascii?Q?QM8wpVNLU/OHcyOFrvgz6LYvRsrtOem2zwnnExDdYNL4iC2JqcLqreZJ4Lhz?=
 =?us-ascii?Q?ETDFJ/UzKB7PZ7bFVQ7zRYFpke0kdjK+5bU82NTvGIfEo8N740F9ttri/gmG?=
 =?us-ascii?Q?OaGmrDlEgBk1oyJNJFbdbD2CMDklRYjPZ39IQY7okcFDeETFhLGTorYoLV57?=
 =?us-ascii?Q?tEVicnRK0XDIEPYi0dA2oQPoQJCGKGz6RncXg8sk+KT+Smi5VUw/6YcytqjM?=
 =?us-ascii?Q?YzaawiDwVhkbkkaJCbTzQKWLDYKBszAg4Ti51JKjJ5WiQUtO9CfC+OVjxbJU?=
 =?us-ascii?Q?SKOYN90aofnWYTNtYue4HKuCzc/4ldx1ZdaLbsQXx7M6ezkuztxW7b93eMuQ?=
 =?us-ascii?Q?Gq3IaQezUxAuxJei58xGnjZsngkOasNVgjCUf/FiPLwuAIAu6Xm/Pmdk9kq7?=
 =?us-ascii?Q?4EN6QQatrV/kYdRu+15EeiATc2PjMaiayS0NcikuUfU7IsiJDa2vchzqlw9N?=
 =?us-ascii?Q?wfCXfTVIpBR/1HVxHPgnvbFFxYnBlDCCqhbb/7+eURxsh7wDowaE0id5NPLl?=
 =?us-ascii?Q?Ve61FnMEW55LSwgXn2e/aAXO/+fQu688GntUGrUsw/E7gsQQ98m6oZ3XxUSA?=
 =?us-ascii?Q?AQS71FjqdYIEVI3FP9NIDjUi5MKjXfj08/2N601nJIME+2MFKmf5/mMxUNw9?=
 =?us-ascii?Q?ISWjM8u7qOpYyNzprcuhjANlRdWzIs9NLejFX5JZaLWrXfX9poTeAeLEy5F7?=
 =?us-ascii?Q?YmNbyBw2nfxR9roG5kElSC1DSOFtuIr+PzZtUgG01LF1Y5Pn2DRZ28K8qylT?=
 =?us-ascii?Q?rPa2jPeQz1wJsuWYHZAratXzgqp1IVHTG8PYko8LFKyS5iw9HfYPET36JJNB?=
 =?us-ascii?Q?KFC0U+9D4UYwyhWAiE2DFQDfEL9YArwNlD1PdQY971FxUS0OGiuWkrZkaxtV?=
 =?us-ascii?Q?RP4uiUrjGIFoNXJNMrnj9oFhuLa8sB0ejby7nFb5Pen33m7etTMQjqVCTPuB?=
 =?us-ascii?Q?NNV0iUlBz8TuvZ45GcyND34DjktU5eKGGEaibc8PL8nBbOw44I0XwZKQR5PI?=
 =?us-ascii?Q?Ss653IF3/+rr0ssQ+zPpltPnwIlQ3SZWiTaV8VNLHsNQ1rGubQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:47:26.2316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9f5104-985b-4fe3-ac2b-08dd0ad24a5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831

`perf sched stats record` captures two sets of samples. For workload
profile, first set right before workload starts and second set after
workload finishes. For the systemwide profile, first set at the
beginning of profile and second set on receiving SIGINT signal.

Add `perf sched stats report` subcommand that will read both the set
of samples, get the diff and render a final report. Final report prints
scheduler stat at cpu granularity as well as sched domain granularity.

Example usage:

  # perf sched stats record
  # perf sched stats report

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/lib/perf/include/perf/event.h         |   8 +-
 tools/lib/perf/include/perf/schedstat-v15.h | 180 +++++--
 tools/lib/perf/include/perf/schedstat-v16.h | 183 ++++++--
 tools/perf/builtin-sched.c                  | 492 +++++++++++++++++++-
 tools/perf/util/event.c                     |   4 +-
 tools/perf/util/synthetic-events.c          |   4 +-
 6 files changed, 771 insertions(+), 100 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 8ef70799e070..f6e68eb27dd5 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -458,13 +458,13 @@ struct perf_record_compressed {
 };
 
 struct perf_record_schedstat_cpu_v15 {
-#define CPU_FIELD(_type, _name, _ver)		_type _name
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
 #include "schedstat-v15.h"
 #undef CPU_FIELD
 };
 
 struct perf_record_schedstat_cpu_v16 {
-#define CPU_FIELD(_type, _name, _ver)		_type _name
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
 #include "schedstat-v16.h"
 #undef CPU_FIELD
 };
@@ -481,13 +481,13 @@ struct perf_record_schedstat_cpu {
 };
 
 struct perf_record_schedstat_domain_v15 {
-#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
 #include "schedstat-v15.h"
 #undef DOMAIN_FIELD
 };
 
 struct perf_record_schedstat_domain_v16 {
-#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
 #include "schedstat-v16.h"
 #undef DOMAIN_FIELD
 };
diff --git a/tools/lib/perf/include/perf/schedstat-v15.h b/tools/lib/perf/include/perf/schedstat-v15.h
index 43f8060c5337..011411ac0f7e 100644
--- a/tools/lib/perf/include/perf/schedstat-v15.h
+++ b/tools/lib/perf/include/perf/schedstat-v15.h
@@ -1,52 +1,142 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef CPU_FIELD
-CPU_FIELD(__u32, yld_count, v15);
-CPU_FIELD(__u32, array_exp, v15);
-CPU_FIELD(__u32, sched_count, v15);
-CPU_FIELD(__u32, sched_goidle, v15);
-CPU_FIELD(__u32, ttwu_count, v15);
-CPU_FIELD(__u32, ttwu_local, v15);
-CPU_FIELD(__u64, rq_cpu_time, v15);
-CPU_FIELD(__u64, run_delay, v15);
-CPU_FIELD(__u64, pcount, v15);
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v15);
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v15);
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v15);
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v15);
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v15);
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v15);
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v15);
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v15);
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v15);
 #endif
 
 #ifdef DOMAIN_FIELD
-DOMAIN_FIELD(__u32, idle_lb_count, v15);
-DOMAIN_FIELD(__u32, idle_lb_balanced, v15);
-DOMAIN_FIELD(__u32, idle_lb_failed, v15);
-DOMAIN_FIELD(__u32, idle_lb_imbalance, v15);
-DOMAIN_FIELD(__u32, idle_lb_gained, v15);
-DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15);
-DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15);
-DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15);
-DOMAIN_FIELD(__u32, busy_lb_count, v15);
-DOMAIN_FIELD(__u32, busy_lb_balanced, v15);
-DOMAIN_FIELD(__u32, busy_lb_failed, v15);
-DOMAIN_FIELD(__u32, busy_lb_imbalance, v15);
-DOMAIN_FIELD(__u32, busy_lb_gained, v15);
-DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15);
-DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15);
-DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15);
-DOMAIN_FIELD(__u32, newidle_lb_count, v15);
-DOMAIN_FIELD(__u32, newidle_lb_balanced, v15);
-DOMAIN_FIELD(__u32, newidle_lb_failed, v15);
-DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15);
-DOMAIN_FIELD(__u32, newidle_lb_gained, v15);
-DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15);
-DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15);
-DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15);
-DOMAIN_FIELD(__u32, alb_count, v15);
-DOMAIN_FIELD(__u32, alb_failed, v15);
-DOMAIN_FIELD(__u32, alb_pushed, v15);
-DOMAIN_FIELD(__u32, sbe_count, v15);
-DOMAIN_FIELD(__u32, sbe_balanced, v15);
-DOMAIN_FIELD(__u32, sbe_pushed, v15);
-DOMAIN_FIELD(__u32, sbf_count, v15);
-DOMAIN_FIELD(__u32, sbf_balanced, v15);
-DOMAIN_FIELD(__u32, sbf_pushed, v15);
-DOMAIN_FIELD(__u32, ttwu_wake_remote, v15);
-DOMAIN_FIELD(__u32, ttwu_move_affine, v15);
-DOMAIN_FIELD(__u32, ttwu_move_balance, v15);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ");
 #endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_imbalance,
+	     "imbalance sum on cpu idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v15);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v15);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v15);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ");
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_imbalance,
+	     "imbalance sum on cpu busy", "%11u", false, v15);
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v15);
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v15);
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v15);
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v15);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v15);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v15);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ");
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_imbalance,
+	     "imbalance sum on cpu newly idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v15);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v15);
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v15);
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v15);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v15);
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ");
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v15);
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v15);
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v15);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v15);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v15);
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v15);
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ");
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v15);
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v15);
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v15);
+#endif /* DOMAIN_FIELD */
diff --git a/tools/lib/perf/include/perf/schedstat-v16.h b/tools/lib/perf/include/perf/schedstat-v16.h
index d6a4691b2fd5..aebbed6a6151 100644
--- a/tools/lib/perf/include/perf/schedstat-v16.h
+++ b/tools/lib/perf/include/perf/schedstat-v16.h
@@ -1,52 +1,143 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef CPU_FIELD
-CPU_FIELD(__u32, yld_count, v16);
-CPU_FIELD(__u32, array_exp, v16);
-CPU_FIELD(__u32, sched_count, v16);
-CPU_FIELD(__u32, sched_goidle, v16);
-CPU_FIELD(__u32, ttwu_count, v16);
-CPU_FIELD(__u32, ttwu_local, v16);
-CPU_FIELD(__u64, rq_cpu_time, v16);
-CPU_FIELD(__u64, run_delay, v16);
-CPU_FIELD(__u64, pcount, v16);
-#endif
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
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef DOMAIN_FIELD
-DOMAIN_FIELD(__u32, busy_lb_count, v16);
-DOMAIN_FIELD(__u32, busy_lb_balanced, v16);
-DOMAIN_FIELD(__u32, busy_lb_failed, v16);
-DOMAIN_FIELD(__u32, busy_lb_imbalance, v16);
-DOMAIN_FIELD(__u32, busy_lb_gained, v16);
-DOMAIN_FIELD(__u32, busy_lb_hot_gained, v16);
-DOMAIN_FIELD(__u32, busy_lb_nobusyq, v16);
-DOMAIN_FIELD(__u32, busy_lb_nobusyg, v16);
-DOMAIN_FIELD(__u32, idle_lb_count, v16);
-DOMAIN_FIELD(__u32, idle_lb_balanced, v16);
-DOMAIN_FIELD(__u32, idle_lb_failed, v16);
-DOMAIN_FIELD(__u32, idle_lb_imbalance, v16);
-DOMAIN_FIELD(__u32, idle_lb_gained, v16);
-DOMAIN_FIELD(__u32, idle_lb_hot_gained, v16);
-DOMAIN_FIELD(__u32, idle_lb_nobusyq, v16);
-DOMAIN_FIELD(__u32, idle_lb_nobusyg, v16);
-DOMAIN_FIELD(__u32, newidle_lb_count, v16);
-DOMAIN_FIELD(__u32, newidle_lb_balanced, v16);
-DOMAIN_FIELD(__u32, newidle_lb_failed, v16);
-DOMAIN_FIELD(__u32, newidle_lb_imbalance, v16);
-DOMAIN_FIELD(__u32, newidle_lb_gained, v16);
-DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v16);
-DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v16);
-DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v16);
-DOMAIN_FIELD(__u32, alb_count, v16);
-DOMAIN_FIELD(__u32, alb_failed, v16);
-DOMAIN_FIELD(__u32, alb_pushed, v16);
-DOMAIN_FIELD(__u32, sbe_count, v16);
-DOMAIN_FIELD(__u32, sbe_balanced, v16);
-DOMAIN_FIELD(__u32, sbe_pushed, v16);
-DOMAIN_FIELD(__u32, sbf_count, v16);
-DOMAIN_FIELD(__u32, sbf_balanced, v16);
-DOMAIN_FIELD(__u32, sbf_pushed, v16);
-DOMAIN_FIELD(__u32, ttwu_wake_remote, v16);
-DOMAIN_FIELD(__u32, ttwu_move_affine, v16);
-DOMAIN_FIELD(__u32, ttwu_move_balance, v16);
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
+DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
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
+DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
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
+DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v16);
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
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
 #endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v16);
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v16);
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v16);
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7dfce34748e4..58a4f6ce0448 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3859,6 +3859,489 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	return err;
 }
 
+struct schedstat_domain {
+	struct perf_record_schedstat_domain *domain_data;
+	struct schedstat_domain *next;
+};
+
+struct schedstat_cpu {
+	struct perf_record_schedstat_cpu *cpu_data;
+	struct schedstat_domain *domain_head;
+	struct schedstat_cpu *next;
+};
+
+struct schedstat_cpu *cpu_head = NULL, *cpu_tail = NULL, *cpu_second_pass = NULL;
+struct schedstat_domain *domain_tail = NULL, *domain_second_pass = NULL;
+bool after_workload_flag;
+
+static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
+{
+	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
+	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
+	__u16 version = after_workload->cpu_data->version;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
+	(before->_ver._name = after->_ver._name - before->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+	}
+
+#undef CPU_FIELD
+}
+
+static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
+{
+	struct perf_record_schedstat_domain *before = domain_second_pass->domain_data;
+	struct perf_record_schedstat_domain *after = after_workload->domain_data;
+	__u16 version = after_workload->domain_data->version;
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
+	(before->_ver._name = after->_ver._name - before->_ver._name)
+
+	if (version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-v16.h>
+	}
+#undef DOMAIN_FIELD
+}
+
+static void print_separator(size_t pre_dash_cnt, const char *s, size_t post_dash_cnt)
+{
+	size_t i;
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
+	printf("%-65s %12s %12s\n", "DESC", "COUNT", "PCT_CHANGE");
+	print_separator(100, "", 0);
+
+#define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+	do {									\
+		printf("%-65s: " _format, _desc, cs->_ver._name);		\
+		if (_is_pct) {							\
+			printf("  ( %8.2lf%% )",				\
+			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
+		}								\
+		printf("\n");							\
+	} while (0)
+
+	if (cs->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cs->version == 16) {
+#include <perf/schedstat-v16.h>
+	}
+
+#undef CPU_FIELD
+#undef CALC_PCT
+}
+
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
+				      __u64 jiffies)
+{
+	printf("%-65s %12s %14s\n", "DESC", "COUNT", "AVG_JIFFIES");
+
+#define DOMAIN_CATEGORY(_desc)							\
+	do {									\
+		size_t _len = strlen(_desc);					\
+		size_t _pre_dash_cnt = (100 - _len) / 2;			\
+		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
+		print_separator(_pre_dash_cnt, _desc, _post_dash_cnt);		\
+	} while (0)
+
+#define CALC_AVG(_x, _y)	((_y) ? (long double)(_x) / (_y) : 0.0)
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	do {									\
+		printf("%-65s: " _format, _desc, ds->_ver._name);		\
+		if (_is_jiffies) {						\
+			printf("  $ %11.2Lf $",					\
+			       CALC_AVG(jiffies, ds->_ver._name));		\
+		}								\
+		printf("\n");							\
+	} while (0)
+
+#define DERIVED_CNT_FIELD(_desc, _format, _x, _y, _z, _ver)			\
+	printf("*%-64s: " _format "\n", _desc,					\
+	       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))
+
+#define DERIVED_AVG_FIELD(_desc, _format, _x, _y, _z, _w, _ver)			\
+	printf("*%-64s: " _format "\n", _desc, CALC_AVG(ds->_ver._w,		\
+	       ((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))))
+
+	if (ds->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (ds->version == 16) {
+#include <perf/schedstat-v16.h>
+	}
+
+#undef DERIVED_AVG_FIELD
+#undef DERIVED_CNT_FIELD
+#undef DOMAIN_FIELD
+#undef CALC_AVG
+#undef DOMAIN_CATEGORY
+}
+
+static void print_domain_cpu_list(struct perf_record_schedstat_domain *ds)
+{
+	char bin[16][5] = {"0000", "0001", "0010", "0011",
+			   "0100", "0101", "0110", "0111",
+			   "1000", "1001", "1010", "1011",
+			   "1100", "1101", "1110", "1111"};
+	bool print_flag = false, low = true;
+	int cpu = 0, start, end, idx;
+
+	idx = ((ds->nr_cpus + 7) >> 3) - 1;
+
+	printf("<");
+	while (idx >= 0) {
+		__u8 index;
+
+		if (low)
+			index = ds->cpu_mask[idx] & 0xf;
+		else
+			index = (ds->cpu_mask[idx--] & 0xf0) >> 4;
+
+		for (int i = 3; i >= 0; i--) {
+			if (!print_flag && bin[index][i] == '1') {
+				start = cpu;
+				print_flag = true;
+			} else if (print_flag && bin[index][i] == '0') {
+				end = cpu - 1;
+				print_flag = false;
+				if (start == end)
+					printf("%d, ", start);
+				else
+					printf("%d-%d, ", start, end);
+			}
+			cpu++;
+		}
+
+		low = !low;
+	}
+
+	if (print_flag) {
+		if (start == cpu-1)
+			printf("%d, ", start);
+		else
+			printf("%d-%d, ", start, cpu-1);
+	}
+	printf("\b\b>\n");
+}
+
+static void summarize_schedstat_cpu(struct schedstat_cpu *summary_cpu,
+				    struct schedstat_cpu *cptr,
+				    int cnt, bool is_last)
+{
+	struct perf_record_schedstat_cpu *summary_cs = summary_cpu->cpu_data,
+					 *temp_cs = cptr->cpu_data;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
+	do {									\
+		summary_cs->_ver._name += temp_cs->_ver._name;			\
+		if (is_last)							\
+			summary_cs->_ver._name /= cnt;				\
+	} while (0)
+
+	if (cptr->cpu_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (cptr->cpu_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	}
+#undef CPU_FIELD
+}
+
+static void summarize_schedstat_domain(struct schedstat_domain *summary_domain,
+				       struct schedstat_domain *dptr,
+				       int cnt, bool is_last)
+{
+	struct perf_record_schedstat_domain *summary_ds = summary_domain->domain_data,
+					    *temp_ds = dptr->domain_data;
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	do {									\
+		summary_ds->_ver._name += temp_ds->_ver._name;			\
+		if (is_last)							\
+			summary_ds->_ver._name /= cnt;				\
+	} while (0)
+
+	if (dptr->domain_data->version == 15) {
+#include <perf/schedstat-v15.h>
+	} else if (dptr->domain_data->version == 16) {
+#include <perf/schedstat-v16.h>
+	}
+#undef DOMAIN_FIELD
+}
+
+static void get_all_cpu_stats(struct schedstat_cpu **cptr)
+{
+	struct schedstat_domain *dptr = NULL, *tdptr = NULL, *dtail = NULL;
+	struct schedstat_cpu *tcptr = *cptr, *summary_head = NULL;
+	struct perf_record_schedstat_domain *ds = NULL;
+	struct perf_record_schedstat_cpu *cs = NULL;
+	bool is_last = false;
+	int cnt = 0;
+
+	if (tcptr) {
+		summary_head = zalloc(sizeof(*summary_head));
+		summary_head->cpu_data = zalloc(sizeof(*cs));
+		memcpy(summary_head->cpu_data, tcptr->cpu_data, sizeof(*cs));
+		summary_head->next = NULL;
+		summary_head->domain_head = NULL;
+		dptr = tcptr->domain_head;
+
+		while (dptr) {
+			size_t cpu_mask_size = (dptr->domain_data->nr_cpus + 7) >> 3;
+
+			tdptr = zalloc(sizeof(*tdptr));
+			tdptr->domain_data = zalloc(sizeof(*ds) + cpu_mask_size);
+			memcpy(tdptr->domain_data, dptr->domain_data, sizeof(*ds) + cpu_mask_size);
+
+			tdptr->next = NULL;
+			if (!dtail) {
+				summary_head->domain_head = tdptr;
+				dtail = tdptr;
+			} else {
+				dtail->next = tdptr;
+				dtail = dtail->next;
+			}
+			dptr = dptr->next;
+		}
+	}
+
+	tcptr = (*cptr)->next;
+	while (tcptr) {
+		if (!tcptr->next)
+			is_last = true;
+
+		cnt++;
+		summarize_schedstat_cpu(summary_head, tcptr, cnt, is_last);
+		tdptr = summary_head->domain_head;
+		dptr = tcptr->domain_head;
+
+		while (tdptr) {
+			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
+			tdptr = tdptr->next;
+			dptr = dptr->next;
+		}
+		tcptr = tcptr->next;
+	}
+
+	tcptr = *cptr;
+	summary_head->next = tcptr;
+	*cptr = summary_head;
+}
+
+/* FIXME: The code fails (segfaults) when one or ore cpus are offline. */
+static void show_schedstat_data(struct schedstat_cpu *cptr)
+{
+	struct perf_record_schedstat_domain *ds = NULL;
+	struct perf_record_schedstat_cpu *cs = NULL;
+	__u64 jiffies = cptr->cpu_data->timestamp;
+	struct schedstat_domain *dptr = NULL;
+	bool is_summary = true;
+
+	printf("Columns description\n");
+	print_separator(100, "", 0);
+	printf("DESC\t\t\t-> Description of the field\n");
+	printf("COUNT\t\t\t-> Value of the field\n");
+	printf("PCT_CHANGE\t\t-> Percent change with corresponding base value\n");
+	printf("AVG_JIFFIES\t\t-> Avg time in jiffies between two consecutive occurrence of event\n");
+
+	print_separator(100, "", 0);
+	printf("Time elapsed (in jiffies)                                        : %11llu\n",
+	       jiffies);
+	print_separator(100, "", 0);
+
+	get_all_cpu_stats(&cptr);
+
+	while (cptr) {
+		cs = cptr->cpu_data;
+		printf("\n");
+		print_separator(100, "", 0);
+		if (is_summary)
+			printf("CPU <ALL CPUS SUMMARY>\n");
+		else
+			printf("CPU %d\n", cs->cpu);
+
+		print_separator(100, "", 0);
+		print_cpu_stats(cs);
+		print_separator(100, "", 0);
+
+		dptr = cptr->domain_head;
+
+		while (dptr) {
+			ds = dptr->domain_data;
+			if (is_summary)
+				if (ds->name[0])
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %s\n", ds->name);
+				else
+					printf("CPU <ALL CPUS SUMMARY>, DOMAIN %d\n", ds->domain);
+			else {
+				if (ds->name[0])
+					printf("CPU %d, DOMAIN %s CPUS ", cs->cpu, ds->name);
+				else
+					printf("CPU %d, DOMAIN %d CPUS ", cs->cpu, ds->domain);
+
+				print_domain_cpu_list(ds);
+			}
+			print_separator(100, "", 0);
+			print_domain_stats(ds, jiffies);
+			print_separator(100, "", 0);
+
+			dptr = dptr->next;
+		}
+		is_summary = false;
+		cptr = cptr->next;
+	}
+}
+
+static int perf_sched__process_schedstat(struct perf_session *session __maybe_unused,
+					 union perf_event *event)
+{
+	struct perf_cpu this_cpu;
+	static __u32 initial_cpu;
+
+	switch (event->header.type) {
+	case PERF_RECORD_SCHEDSTAT_CPU:
+		this_cpu.cpu = event->schedstat_cpu.cpu;
+		break;
+	case PERF_RECORD_SCHEDSTAT_DOMAIN:
+		this_cpu.cpu = event->schedstat_domain.cpu;
+		break;
+	default:
+		return 0;
+	}
+
+	if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
+		return 0;
+
+	if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
+		struct schedstat_cpu *temp = zalloc(sizeof(struct schedstat_cpu));
+
+		temp->cpu_data = zalloc(sizeof(struct perf_record_schedstat_cpu));
+		memcpy(temp->cpu_data, &event->schedstat_cpu,
+		       sizeof(struct perf_record_schedstat_cpu));
+		temp->next = NULL;
+		temp->domain_head = NULL;
+
+		if (cpu_head && temp->cpu_data->cpu == initial_cpu)
+			after_workload_flag = true;
+
+		if (!after_workload_flag) {
+			if (!cpu_head) {
+				initial_cpu = temp->cpu_data->cpu;
+				cpu_head = temp;
+			} else
+				cpu_tail->next = temp;
+
+			cpu_tail = temp;
+		} else {
+			if (temp->cpu_data->cpu == initial_cpu) {
+				cpu_second_pass = cpu_head;
+				cpu_head->cpu_data->timestamp =
+					temp->cpu_data->timestamp - cpu_second_pass->cpu_data->timestamp;
+			} else {
+				cpu_second_pass = cpu_second_pass->next;
+			}
+			domain_second_pass = cpu_second_pass->domain_head;
+			store_schedtstat_cpu_diff(temp);
+		}
+	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
+		size_t cpu_mask_size = (event->schedstat_domain.nr_cpus + 7) >> 3;
+		struct schedstat_domain *temp = zalloc(sizeof(struct schedstat_domain));
+
+		temp->domain_data = zalloc(sizeof(struct perf_record_schedstat_domain) + cpu_mask_size);
+		memcpy(temp->domain_data, &event->schedstat_domain,
+		       sizeof(struct perf_record_schedstat_domain) + cpu_mask_size);
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
+	return 0;
+}
+
+static void free_schedstat(struct schedstat_cpu *cptr)
+{
+	struct schedstat_domain *dptr = NULL, *tmp_dptr;
+	struct schedstat_cpu *tmp_cptr;
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
+	if (cpu_list) {
+		user_requested_cpus = perf_cpu_map__new(cpu_list);
+		if (!user_requested_cpus)
+			return -EINVAL;
+	}
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
+	if (!err) {
+		setup_pager();
+		show_schedstat_data(cpu_head);
+		free_schedstat(cpu_head);
+	}
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4035,6 +4518,8 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option stats_options[] = {
+	OPT_STRING('i', "input", &input_name, "file",
+		   "`stats report` with input filename"),
 	OPT_STRING('o', "output", &output_name, "file",
 		   "`stats record` with output filename"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
@@ -4160,7 +4645,7 @@ int cmd_sched(int argc, const char **argv)
 
 		return perf_sched__timehist(&sched);
 	} else if (!strcmp(argv[0], "stats")) {
-		const char *const stats_subcommands[] = {"record", NULL};
+		const char *const stats_subcommands[] = {"record", "report", NULL};
 
 		argc = parse_options_subcommand(argc, argv, stats_options,
 						stats_subcommands,
@@ -4172,6 +4657,11 @@ int cmd_sched(int argc, const char **argv)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
 			return perf_sched__schedstat_record(&sched, argc, argv);
+		} else if (argv[0] && !strcmp(argv[0], "report")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_report(&sched);
 		}
 		usage_with_options(stats_usage, stats_options);
 	} else {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 64f81e7b7f70..72aaf1991b6c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -560,7 +560,7 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 
 	size = fprintf(fp, "\ncpu%u ", cs->cpu);
 
-#define CPU_FIELD(_type, _name, _ver)						\
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
 	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name)
 
 	if (version == 15) {
@@ -638,7 +638,7 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	size += fprintf(fp, "%s ", cpu_mask);
 	free(cpu_mask);
 
-#define DOMAIN_FIELD(_type, _name, _ver)					\
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
 	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name)
 
 	if (version == 15) {
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f200f7ece3ef..03f72cc5d5fa 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2534,7 +2534,7 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 	if (io__get_dec(io, (__u64 *)cpu) != ' ')
 		goto out_cpu;
 
-#define CPU_FIELD(_type, _name, _ver)					\
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
 	do {								\
 		__u64 _tmp;						\
 		ch = io__get_dec(io, &_tmp);				\
@@ -2658,7 +2658,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
 	free(d_name);
 	free(cpu_mask);
 
-#define DOMAIN_FIELD(_type, _name, _ver)				\
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
 	do {								\
 		__u64 _tmp;						\
 		ch = io__get_dec(io, &_tmp);				\
-- 
2.43.0

