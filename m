Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB238B984;
	Thu,  8 Jan 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858819; cv=fail; b=d6uofRTDaczbQYP/BRhCItZdtz00EIwn3uGXCz3Ofw0/+WPckpmgSYJ9TZrPbB6420couTFDjf8DIKrgp4Lsx48+YCAnJW/4BgkCt7je/r8TV3y49J5DJ6d/YqSi98EOO2n/VI8uBKSXI2b6VwLhXiQuD/QzCmDeMt+KVQ0UdFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858819; c=relaxed/simple;
	bh=Jf+nTgmEezPBc93Qy+xQUfKP5V5LO8CfFzXEJGxoydU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXNKlg/qTh8Fhy5mVZQZP40k/ZHuz9uIlWqe+DJ7A3mAxoxH+++9lZCLzoAzzTJMZQnnT+0vJIFczX20CBEUqUl52M+h37dGC89k5PlLv9f/LbEKKyqZCXM8CheXcZrjDFVvzkvbxfBGpAIsokYndSW2OxrTu1fJyGMeMzqiD4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ba7V5Md0; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ba7V5Md0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+d0vD4Rlqp5exfcF/F4BIynIz1lDJvlbLUQ0R96kLmkhCCkVUhnrKyHcSjMh229VGQH4OzYKncddP0uCTpVXrBq+78ODpUTVtCjhyQuo2SXXq4Xnm/Xlp/qRmVvyq2u/RcGTVOIIuFCm2M4Joq4Z4FgFH+sRsO3p9KRp5fJYhene51Klg4aI2/r4jqndRqemJ1A0abbns4RsP6ahs7qgLUt2o4HMjQsKnnUsOE4FHOTI7r5EADw6W2OxfHBX3as+OGUVPMl+3Hyu8L833ZjMv6avKCO5kq0B/ar38WrhnKARjrH/w7/qxyf9PFd66Maxhvg0zDoHHKjJcxs80Wf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YfKJ+Qj3R7JtqUutRlwM+SNqFLSWaftEcLVy4KsoOo=;
 b=OXWChq6t3CI/mkHSeB50LchwmPfq13lDye8HdQiiFMM0eDLSwvCiBDvDq3hRKQCwpTeqXjw61JO5Aeaq3tX2uYTtvoAT0M8h3Z6OwgC3nZRzjAZliMzgW3v0ilmnXWo1LPTi8v6IAWjNOG+g9uCD+jDudpSOQLc7ALndFT8wa2Hcx/2pa0tyWSSCnpebH2KR+RfHI2T69AY2lwJUmBcRQoZTYIQyQnmatR+BoqysFObYcskr4v7P/yC0j9B3Yd2H3FN0HzLNh7poFC8Z2SFngJbH7pP+/XAYRrMWCFIXcdGrwlT+jEybZEGiC1uqB5ckdbpEZvyJM51E8039+TCmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YfKJ+Qj3R7JtqUutRlwM+SNqFLSWaftEcLVy4KsoOo=;
 b=ba7V5Md0YxF+NrUNqmyOoGbJDyZpb2qoQr4nnfgS6Ztw9iF8N9jmQToN2EJ3zY0jeB92hh6JlVU0EcjisIH2QxJyOrzGjfbesHK89YlKlODQemWGbisiwauO+pSbs89uk9G8y7W97mmponSp3qjXXuW8+U4VZrjgaqcnD+izsS0=
Received: from BYAPR11CA0058.namprd11.prod.outlook.com (2603:10b6:a03:80::35)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:53:23 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::17) by BYAPR11CA0058.outlook.office365.com
 (2603:10b6:a03:80::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 07:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 07:53:23 +0000
Received: from sindhu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 01:53:17 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 3/4] perf vendor events amd: Add Zen 6 metrics
Date: Thu, 8 Jan 2026 13:22:16 +0530
Message-ID: <f7f46892b9df4c16c0ab118a0fac309c7c14270f.1767858676.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767858676.git.sandipan.das@amd.com>
References: <cover.1767858676.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 642d1ec0-315d-400e-5947-08de4e8aff94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+rsL+yX7djXt5GvPVrn4Wi7A4ZnD9nfPgiiHp0U/Aq8tCiFqFkfKRRbBYqy?=
 =?us-ascii?Q?5knJtdQhj1z5U9+0hvgJt7T5/88+gbPgkWwu6lRlIgCm2Kla3IU4/89Rn6fH?=
 =?us-ascii?Q?fXnlYZNWt2tbGhXoFae/v0Yo2Pndpc04jLx7S1A9ttyi2luh9bv2Jb6OV1aj?=
 =?us-ascii?Q?iFuYOWvstiIZSn3+XetrwkeIF5ZCN27b9ZoF1vIDHNYDB63PiIRv3jRCd6Tk?=
 =?us-ascii?Q?Vz+Qx9nivB4vfeFCC66DOo3ckiUU1ValUI+sjbfY4Zbw9louhoR29ocMhETi?=
 =?us-ascii?Q?wtqzJsEZPgzXyuf9DtVJnQDEdfwoJhABIrX4qUW9MblYEvfF86EGpBmolRpR?=
 =?us-ascii?Q?iH+6rFoT/cfdwMvzRyViJAmjj/eHgVywxevBihIgUB6X8ZgRVWulRwp9Hw2s?=
 =?us-ascii?Q?F4D/r+3Sn8S6/P0li4aH0Y7BC0W+pCwmwoJpR+anXPxq8v1g6huwRMrKM2c4?=
 =?us-ascii?Q?M2ogNRHoS+u+DZJI7BwvVpQtrIY4JT6HQFpyAMkiOzWM0JAV0BBNY74IWyut?=
 =?us-ascii?Q?w+6R3Eq/ppS5syXmVkTLGDPoWHzYIVgI7HnHdQiN4hBq8e+JI/VM9yzRYlEB?=
 =?us-ascii?Q?1I0KhQ4e/0DTQngsOGKgkW4MCFip1+I6i6n89Wtu+qnPZ1xazcoRvD8eDkFh?=
 =?us-ascii?Q?YoBVIsUTj55MH7IcNJ8EgYxLGYf6/6Q968cd+yZ3QkgIUAkpyGd1pbJCdH49?=
 =?us-ascii?Q?hE/50VBpIPD0FLh3QMQn8bfMVGdpmdgnSYZCluVjXi6B+OW7aKuy5ttIFUTP?=
 =?us-ascii?Q?6e9H2Bzo7qbraWCX0uSfzKu7dWiHm6Wvb7sqjcbt6dR8n8PICtCNLfB89tuN?=
 =?us-ascii?Q?4PGjVkz6SHGpSQj4I+GEcCQtaTJ00N++GF0yxCLg2gvPzscl2vd5mjJ3OgIz?=
 =?us-ascii?Q?z3+HUz28vfIllqjDIEOVsrP307XmA6cGCH0dWj0JdD3montoPf8gtwcERX6r?=
 =?us-ascii?Q?NDeLKpJmhuPMWRK51uWXRdRrJipebVbasnSnWvmrR1G5Y4DxoYEzSCDhFoK7?=
 =?us-ascii?Q?DCMp2a2PWU/7lFUXTs4dAseIosEd7AHG9iLRergxLnYxU2lPwP0evWipyK4/?=
 =?us-ascii?Q?C+r/8Fle9omHEg0MZXKLpsxQRnAmI/LZq73ucMerfv3GilWUVXaUTVqqy16t?=
 =?us-ascii?Q?Aam2BmTjBWZ3KXYTnPd1FSaxNbLWJDXZB6JdeSj+DYU8l8a51Yah4IZcpjXe?=
 =?us-ascii?Q?uwPIcc5NX3ArYdDCnIIZiOw7MumFwoVF8YTJURUOYhqLQ62OHtonBSlioec5?=
 =?us-ascii?Q?6LGQJMEi5nz/siY0tjvMnvG2JFTftbGPRksCPTYsWbB5yW3WPODIuRaOg2yY?=
 =?us-ascii?Q?1NEKTcFiBOdfN5oKY1UJbr4CkoU2X5Q2h2b0tXy1faN0Tu44+NIOgiy8ZAGp?=
 =?us-ascii?Q?CtkHQPuCGZ3ZSDm8ExjmX2h5PvvbdB+giEve3yDoHpJtYeC3Kv1CfUQWSqm9?=
 =?us-ascii?Q?aa4DKRC7UUnK99LftooqPPRTqFSGO9X9EjRLfyypyktsMFs/xOpfjC0RnsJw?=
 =?us-ascii?Q?S2O/YJCF2N9xk84KshjNfa7pqn+dLTZdjW+NH7wF9hHv/cDGzpGhYZA44pB7?=
 =?us-ascii?Q?p7AHC+vMGB43WMcl7l4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:53:23.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642d1ec0-315d-400e-5947-08de4e8aff94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

Add metrics taken from Section 1.2 "Performance Measurement" of the
Performance Monitor Counters for AMD Family 1Ah Model 50h-57h Processors
document available at the link below.

The recommended metrics are sourced from Table 1 "Guidance for Common
Performance Statistics with Complex Event Selects".

The pipeline utilization metrics are sourced from Table 2 "Guidance
for Pipeline Utilization Analysis Statistics". These are useful for
finding performance bottlenecks by analyzing activity at different
stages of the pipeline. There are metric groups available for Level 1
and Level 2 analysis.

Link: https://bugzilla.kernel.org/attachment.cgi?id=309149
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen6/pipeline.json |  99 +++++
 .../arch/x86/amdzen6/recommended.json         | 339 ++++++++++++++++++
 2 files changed, 438 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/recommended.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/pipeline.json b/tools/perf/pmu-events/arch/x86/amdzen6/pipeline.json
new file mode 100644
index 000000000000..48c501d8a097
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/pipeline.json
@@ -0,0 +1,99 @@
+[
+  {
+    "MetricName": "total_dispatch_slots",
+    "BriefDescription": "Total dispatch slots (up to 8 instructions can be dispatched in each cycle).",
+    "MetricExpr": "8 * ls_not_halted_cyc",
+    "ScaleUnit": "1slots"
+  },
+  {
+    "MetricName": "frontend_bound",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because the frontend did not supply enough instructions/ops.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "bad_speculation",
+    "BriefDescription": "Percentage of dispatched ops that did not retire.",
+    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%ops"
+  },
+  {
+    "MetricName": "backend_bound",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of backend stalls.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "smt_contention",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because the other thread was selected.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "retiring",
+    "BriefDescription": "Percentage of dispatch slots used by ops that retired.",
+    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "frontend_bound_by_latency",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of a latency bottleneck in the frontend (such as instruction cache or TLB misses).",
+    "MetricExpr": "d_ratio((8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "frontend_bound_by_bandwidth",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of a bandwidth bottleneck in the frontend (such as decode or op cache fetch bandwidth).",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend - (8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "bad_speculation_from_mispredicts",
+    "BriefDescription": "Percentage of dispatched ops that were flushed due to branch mispredicts.",
+    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn_misp + bp_fe_redir.resync)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%ops"
+  },
+  {
+    "MetricName": "bad_speculation_from_pipeline_restarts",
+    "BriefDescription": "Percentage of dispatched ops that were flushed due to pipeline restarts (resyncs).",
+    "MetricExpr": "d_ratio(bad_speculation * bp_fe_redir.resync, ex_ret_brn_misp + bp_fe_redir.resync)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%ops"
+  },
+  {
+    "MetricName": "backend_bound_by_memory",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of stalls due to the memory subsystem.",
+    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete)",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "backend_bound_by_cpu",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of stalls not related to the memory subsystem.",
+    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete))",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "retiring_from_fastpath",
+    "BriefDescription": "Percentage of dispatch slots used by fastpath ops that retired.",
+    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops))",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "retiring_from_microcode",
+    "BriefDescription": "Percentage of dispatch slots used by microcode ops that retired.",
+    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%slots"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
new file mode 100644
index 000000000000..2849a8c159f6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
@@ -0,0 +1,339 @@
+[
+  {
+    "MetricName": "branch_misprediction_rate",
+    "BriefDescription": "Execution-time branch misprediction rate (non-speculative).",
+    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
+    "MetricGroup": "branch_prediction",
+    "ScaleUnit": "1per_branch"
+  },
+  {
+    "MetricName": "all_data_cache_accesses_pti",
+    "BriefDescription": "All data cache accesses per thousand instructions.",
+    "MetricExpr": "ls_dispatch.all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l2_cache_accesses_pti",
+    "BriefDescription": "All L2 cache accesses per thousand instructions.",
+    "MetricExpr": "(l2_request_g1.no_pf_all + l2_pf_hit_l2.l2_hwpf + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_ic_misses_pti",
+    "BriefDescription": "L2 cache accesses from L1 instruction cache misses (including prefetch) per thousand instructions.",
+    "MetricExpr": "l2_request_g1.cacheable_ic_read / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_dc_misses_pti",
+    "BriefDescription": "L2 cache accesses from L1 data cache misses (including prefetch) per thousand instructions.",
+    "MetricExpr": "l2_request_g1.dc_all / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache accesses from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "(l2_pf_hit_l2.l1_dc_l2_hwpf + l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l2_cache_misses_pti",
+    "BriefDescription": "All L2 cache misses per thousand instructions.",
+    "MetricExpr": "(l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_ic_miss_pti",
+    "BriefDescription": "L2 cache misses from L1 instruction cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ic_fill_miss / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_dc_miss_pti",
+    "BriefDescription": "L2 cache misses from L1 data cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ls_rd_blk_c / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache misses from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "(l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l2_cache_hits_pti",
+    "BriefDescription": "All L2 cache hits per thousand instructions.",
+    "MetricExpr": "(l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_ic_miss_pti",
+    "BriefDescription": "L2 cache hits from L1 instruction cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ic_hit_in_l2 / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_dc_miss_pti",
+    "BriefDescription": "L2 cache hits from L1 data cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.dc_hit_in_l2 / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache hits from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "l2_pf_hit_l2.l1_dc_l2_hwpf / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l3_cache_accesses",
+    "BriefDescription": "L3 cache accesses.",
+    "MetricExpr": "l3_lookup_state.all_coherent_accesses_to_l3",
+    "MetricGroup": "l3_cache"
+  },
+  {
+    "MetricName": "l3_misses",
+    "BriefDescription": "L3 misses (including cacheline state change requests).",
+    "MetricExpr": "l3_lookup_state.l3_miss",
+    "MetricGroup": "l3_cache"
+  },
+  {
+    "MetricName": "l3_read_miss_latency",
+    "BriefDescription": "Average L3 read miss latency (in core clocks).",
+    "MetricExpr": "(l3_xi_sampled_latency.all * 10) / l3_xi_sampled_latency_requests.all",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1ns"
+  },
+  {
+    "MetricName": "l3_read_miss_latency_for_local_dram",
+    "BriefDescription": "Average L3 read miss latency (in core clocks) for local DRAM.",
+    "MetricExpr": "(l3_xi_sampled_latency.dram_near * 10) / l3_xi_sampled_latency_requests.dram_near",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1ns"
+  },
+  {
+    "MetricName": "l3_read_miss_latency_for_remote_dram",
+    "BriefDescription": "Average L3 read miss latency (in core clocks) for remote DRAM.",
+    "MetricExpr": "(l3_xi_sampled_latency.dram_far * 10) / l3_xi_sampled_latency_requests.dram_far",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1ns"
+  },
+  {
+    "MetricName": "op_cache_fetch_miss_ratio",
+    "BriefDescription": "Op cache miss ratio for all fetches.",
+    "MetricExpr": "d_ratio(op_cache_hit_miss.miss, op_cache_hit_miss.all)",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_memory_pti",
+    "BriefDescription": "L1 data cache fills from DRAM or MMIO in any NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.dram_io_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_remote_node_pti",
+    "BriefDescription": "L1 data cache fills from a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.far_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_same_ccx_pti",
+    "BriefDescription": "L1 data cache fills from within the same CCX per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.local_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_different_ccx_pti",
+    "BriefDescription": "L1 data cache fills from another CCX cache in any NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.remote_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l1_data_cache_fills_pti",
+    "BriefDescription": "All L1 data cache fills per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_local_l2_pti",
+    "BriefDescription": "L1 demand data cache fills from local L2 cache per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_l2 / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_same_ccx_pti",
+    "BriefDescription": "L1 demand data cache fills from within the same CCX per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_ccx / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_cache_pti",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in the same NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.near_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_memory_pti",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in the same NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_near / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_cache_pti",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.far_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_memory_pti",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_far / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_itlb_misses_pti",
+    "BriefDescription": "L1 instruction TLB misses per thousand instructions.",
+    "MetricExpr": "(bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_miss.all) / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_itlb_misses_pti",
+    "BriefDescription": "L2 instruction TLB misses and instruction page walks per thousand instructions.",
+    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_miss.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_dtlb_misses_pti",
+    "BriefDescription": "L1 data TLB misses per thousand instructions.",
+    "MetricExpr": "ls_l1_d_tlb_miss.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_dtlb_misses_pti",
+    "BriefDescription": "L2 data TLB misses and data page walks per thousand instructions.",
+    "MetricExpr": "ls_l1_d_tlb_miss.l2_miss_all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_tlbs_flushed_pti",
+    "BriefDescription": "All TLBs flushed per thousand instructions.",
+    "MetricExpr": "ls_tlb_flush.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "macro_ops_dispatched",
+    "BriefDescription": "Macro-ops dispatched.",
+    "MetricExpr": "de_src_op_disp.all",
+    "MetricGroup": "decoder"
+  },
+  {
+    "MetricName": "sse_avx_stalls",
+    "BriefDescription": "Mixed SSE/AVX stalls.",
+    "MetricExpr": "fp_disp_faults.sse_avx_all"
+  },
+  {
+    "MetricName": "macro_ops_retired",
+    "BriefDescription": "Macro-ops retired.",
+    "MetricExpr": "ex_ret_ops"
+  },
+  {
+    "MetricName": "umc_data_bus_utilization",
+    "BriefDescription": "Memory controller data bus utilization.",
+    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_rate",
+    "BriefDescription": "Memory controller CAS command rate.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1per_memclk"
+  },
+  {
+    "MetricName": "umc_cas_cmd_read_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_write_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for writes.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_mem_read_bandwidth",
+    "BriefDescription": "Estimated memory read bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_write_bandwidth",
+    "BriefDescription": "Estimated memory write bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_bandwidth",
+    "BriefDescription": "Estimated combined memory bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_activate_cmd_rate",
+    "BriefDescription": "Memory controller ACTIVATE command rate.",
+    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1per_memclk"
+  },
+  {
+    "MetricName": "umc_precharge_cmd_rate",
+    "BriefDescription": "Memory controller PRECHARGE command rate.",
+    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1per_memclk"
+  }
+]
-- 
2.43.0

