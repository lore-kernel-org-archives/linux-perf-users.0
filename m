Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9458322A15;
	Tue,  9 Sep 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418484; cv=fail; b=h8n4vGgcJT/MtFjKDMcAN19Lcz06SkTjIOJ5D1/YQlz1floPLdq8eoxz6Z6zhZB8GhZHkKywJH8fVQgHp84vWL4XQnWL5LZNz9YKkr7S0I77TVoKVUStRqHvTnxx6dzAqowJohB/J4wwWfkmZVURvUtFp2zhhY3rjgq/OWRs3QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418484; c=relaxed/simple;
	bh=EfcLY3NDp1lMvkV1Jfb+289V3teDCdYSigVXRWpSN7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYra9hIaHCJ9jRUkyA9uNaL+4kFmdYYmBD62koAwwRgXVIIpI2IRudxq6orTOL2QhVcpIgdxRehQ7Vudjcy2ErKu2vWHCYUhk8et7bbGFmSlTtbZas3lcZPlFLDQaOk3zjDDOYDHtwBtRNC6YFbHMbDtZsV09s/kwcHLpXaJvTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EcHzSlEI; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EcHzSlEI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFet5MTkx8fPRLPmqgJAX6bgep/0c+OZon0KFuwrX6XYiUTXjwj04j5RnEboLOUVvAQhs2fx/g5NtHJUYo+QlFAXcyp7Dv9QiKiqbWSlbHtbQ0gadunnoW/mhIrvuyluUUbisFbjviW/WDP5EqBF/8Zz/TZ0M2oaVpcOndaIbnZDDASMB3NyQYJ/a6I7ZSAaX+uahE81YuuDy+HxwZMr/HfdhQcY33pBXQ7zRFzVkBO3JuzMSxvk4ittsZIecqGSEIuNwj3D01A5wbQf7F8nRdeAT9lOxalWzJDoDLj1wkzF4RzkNP/Unq3mvXazTjFf7ZAohogXVQFa9YLS5zHr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSWJRxFUSRR/75Ge00v7x+d4eXsR1bungyJ55lp1BIU=;
 b=tOTpYJVp67qoK9UD8hcdInCpu/EGXKJlrW2hLu0qPwpJ4BMt4SuInatZn3iRgmiJ4tJSuNF8Ds/T9DhcGPYGeZNpjfm9HFw3MqjzyMUjZBW6itzVxxRSMtIA3WO0ZVIzEO1xoLO+3Butfp4Y6+6fbBzF295lhb5n16k/KE0+gLj9ZWn3U/X/tK+OZoq7Cn6AI3LJWGHuAlpp6UOo/8XIEjOIiC+Cg1+XItldYBnRVdRhMHuMRc0C5iWa/l8HLYlHy2QAklNkBBBrsyNB3/gMa4cRL6lmmccSoSqvVyJCDLBo6Nm0u4rtB+pfWRnUH2h6U0WG8FZCl/mwoECMaurcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSWJRxFUSRR/75Ge00v7x+d4eXsR1bungyJ55lp1BIU=;
 b=EcHzSlEIvhKScNjRLMtqxAVAEOeEjCEmkvQMcnWB3sPxbhjjT3rRqByhTsMZa0aCdyfcu3eMu1BFFrPVovN5s0Kyt/0StHBPwpaNN0q5i2thDMaQWLy5s0x9HSuwMAh2a/7vyHF7b7SaGN3JYsqnUzuHda0ktdfmH08ToXwdhw4=
Received: from BYAPR07CA0077.namprd07.prod.outlook.com (2603:10b6:a03:12b::18)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 11:47:58 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:12b:cafe::fc) by BYAPR07CA0077.outlook.office365.com
 (2603:10b6:a03:12b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 11:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 11:47:57 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:47:45 -0700
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
Subject: [PATCH RESEND v4 10/11] perf sched stats: Add basic perf sched stats test
Date: Tue, 9 Sep 2025 11:42:26 +0000
Message-ID: <20250909114227.58802-11-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c7c995-c196-49c8-5cb3-08ddef96b89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IGYnRUBokuvYUP0JmHpQ+wW/fE32vhGM1BDppRSMA7WAkH1E7KqTmmMqsYDf?=
 =?us-ascii?Q?eAJVTlfn4/CbsUR0XIMDLboTX7yQj4xGsSrnpKUF8fHSP5gS5ld9DzF++HAV?=
 =?us-ascii?Q?0zST1S9PmI8ChO1/6/r88tkIZFJLQi+6NFIdJgBJ9ZNW+q6GcHxwQIlCzId9?=
 =?us-ascii?Q?iBJMirvrheZ6QtgSPa5Qy6X+PW4W4mEeELpeyx+o/KZF1WHBdjuEIu2nnsGh?=
 =?us-ascii?Q?LnHGL69QTHNlsOLmdlZ9/u/E1MUxrt3BYWug0LbPMEqX73Srakbv980YKKQu?=
 =?us-ascii?Q?FL4DmeGpcpjer2mDXb7wGw70OBgNE1Qaef2xSR1mbQiQo26pOMCdJ1vqn3Kx?=
 =?us-ascii?Q?1mjZB/2gEDt2BG02eEI4GiNFwK3Znm6mbz1jdsV6DGWXcH4etJqhh6aTW4fW?=
 =?us-ascii?Q?jsKUKkTYcHljMniIkRVjTEo4e8HB1CYpulCI3TPNIWHkew1LGJAfLa6eoJ4n?=
 =?us-ascii?Q?Ot0aNXl8AdFUmueA9bITm+2EgSEZnG9oIy84O7rGjKkmaobdfcy9Lh+nFw2P?=
 =?us-ascii?Q?/I5K7FCZHA4kxGA8wStnxWanlTz9qjvxhhX95jEurVSIVCFmtm/9f6p6s+XA?=
 =?us-ascii?Q?4RgIM9wy1EyZQ0d78UI23uxBLNhlvKo2Ze2Nhea1UTPX2oN+Joq6Rm8UiZJH?=
 =?us-ascii?Q?NzSbV8/CW/A9AFLpNnMROZutD0g3TPG4DUeAhhRwkG6y3B//zth9QF009YjD?=
 =?us-ascii?Q?ZmoLK/JfY5jtExVQ9R3vKVO8zcxAx6wT3A+I8BHGUnWQ5oVIHc6INa9qNzIb?=
 =?us-ascii?Q?wkXh+NXI7CgHleGwB+paF/kqLn1Cf/c1PO4dtRnAfpti+Um4RlTD2x4Y/ODi?=
 =?us-ascii?Q?S3YaDtqfUNGUoRlNRvk5C2UOzfwa35XGOy04qe/nNEYrjzcN5PF3kBRdXAfx?=
 =?us-ascii?Q?mFjgeF/52fu26IjCD+nu2W/u0CMKLSPsn0WvgT/BrI7vyq4mnpSPVeOm/ZIe?=
 =?us-ascii?Q?eJ16FO8BgBM+UZIhQhKhxhPAMr+qrnAzjYL42yYb8GkTYUfmr+8yK0MpbznI?=
 =?us-ascii?Q?87hmhT3GEXPLqahZnejHCWvrQxd4mQM5OJDx9YnAKO98WfnCDF72wwrZocyn?=
 =?us-ascii?Q?BW1PrZ5DKYVyx1IfbFOBsheA9qOuTY5akY/YxoZ6bCeGsay4BoCc35fJyLPH?=
 =?us-ascii?Q?QuNiNMz4LV9U+TkT9J0CdFyOeCA4MNbX4wLk9O9H4AWTOrWmweIGbga3N/gg?=
 =?us-ascii?Q?E4Bqdf5D4/Pp9zXmWOTs3NQRWP6fj9SgR89D/f/g1jBnhX5ego0BSwmQe/aF?=
 =?us-ascii?Q?wG11tkgEpi6yT6Qotm2nKOfVdJ+TsmOQnBFPAGUD9/1SuCbsmEo05HHjSdZQ?=
 =?us-ascii?Q?R2q20kxbF3oanEB65A52w1qAmHAVEZq6NUbPnPijKjyadJvg5OzF0fDujoMs?=
 =?us-ascii?Q?8Jo5RIG4XARCGdG7UQwwgiXV8iUlTOBNVq5GDoSAyCgaGKNNSMiesQfJ8dNY?=
 =?us-ascii?Q?6q+Dul/nKs2ZECtvJ6oTUoBdHXcuYzf3L/ENl10jfEeQ5Kk/6POb37vF87GH?=
 =?us-ascii?Q?erPzDxOOq12hXW/GfpGwsS7G3+5N0YfZ5w4s?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:47:57.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c7c995-c196-49c8-5cb3-08ddef96b89a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184

Add basic test for perf sched stats {record|report|diff} subcommand.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/tests/shell/perf_sched_stats.sh | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh

diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
new file mode 100755
index 000000000000..2b1410b050d0
--- /dev/null
+++ b/tools/perf/tests/shell/perf_sched_stats.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+# perf sched stats tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+test_perf_sched_stats_record() {
+  echo "Basic perf sched stats record test"
+  if ! perf sched stats record true 2>&1 | \
+    grep -E -q "[ perf sched stats: Wrote samples to perf.data ]"
+  then
+    echo "Basic perf sched stats record test [Failed]"
+    err=1
+    return
+  fi
+  echo "Basic perf sched stats record test [Success]"
+}
+
+test_perf_sched_stats_report() {
+  echo "Basic perf sched stats report test"
+  perf sched stats record true > /dev/null
+  if ! perf sched stats report 2>&1 | grep -E -q "Description"
+  then
+    echo "Basic perf sched stats report test [Failed]"
+    err=1
+    rm perf.data
+    return
+  fi
+  rm perf.data
+  echo "Basic perf sched stats report test [Success]"
+}
+
+test_perf_sched_stats_live() {
+  echo "Basic perf sched stats live mode test"
+  if ! perf sched stats true 2>&1 | grep -E -q "Description"
+  then
+    echo "Basic perf sched stats live mode test [Failed]"
+    err=1
+    return
+  fi
+  echo "Basic perf sched stats live mode test [Success]"
+}
+
+test_perf_sched_stats_diff() {
+  echo "Basic perf sched stats diff test"
+  perf sched stats record true > /dev/null
+  perf sched stats record true > /dev/null
+  if ! perf sched stats diff > /dev/null
+  then
+    echo "Basic perf sched stats diff test [Failed]"
+    err=1
+    rm perf.data.old perf.data
+    return
+  fi
+  rm perf.data.old perf.data
+  echo "Basic perf sched stats diff test [Success]"
+}
+
+test_perf_sched_stats_record
+test_perf_sched_stats_report
+test_perf_sched_stats_live
+test_perf_sched_stats_diff
+exit $err
-- 
2.43.0

