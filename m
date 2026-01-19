Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326373128BE;
	Mon, 19 Jan 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845768; cv=fail; b=W7Is0qc2KGZTpEeNiKfxy92wP8//JaBs0HQZnx8mDxgMfuVUxncdbKlteKV4J3b0AtivKbskUwa/TpS6uIQgdlFSt3GFBaW9Kex+lYEu38MXvdlqio7h1ZJLAz8UdqoNB45eEk5a9jyoIqpr4o5lLLlQtWKco8sKuNddcEi0DdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845768; c=relaxed/simple;
	bh=EfcLY3NDp1lMvkV1Jfb+289V3teDCdYSigVXRWpSN7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwCdaNLc6E8kikRORXgSG66Yq6FkGuLKoDyjO8lcLC+dqP8g17+GDVtsq/Rt9DwezGFviAbWnXlIQ1Gx+4J9ZokrT1pQQ6T7heXhqS9uZW5H08Hgrv18Y32wA7pVzQssWOtJaIOgoYU0lvvWTeTnMUHfqQSlkuBRHBf78/7AWsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IE9AF3Yx; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IE9AF3Yx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1BhkxVFwUA+aRJReAhW9Xr/6TF0awiNsgaSqPE+VStpTlA5oY5QAeuGBKdrDDuYdF1WXkLf3Yrm0aC3Z4ctr/iJyK+9OPlD5RlKqoGBfTLTFmUCGSIti64lIbvvdJd3oqHt76/PmHE84YdwShZdsb5haDWulUn6AGo4ElXBtBNdK+cNVLdnA2M9NEEpEBkQvEJ3knecdg/qWZ2/EeYK8Xu5gjA60OGzvcVbjqrGiKQtF66qP5fzOyStwaC5ru0BxkZetxLQm+Y83Kb9EbFrPEKO4qoGtuDKVN1YsEPGijqTs4STUtkd6aKJNffUWnCO+hRRcnP34ZhoXs4xGZyqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSWJRxFUSRR/75Ge00v7x+d4eXsR1bungyJ55lp1BIU=;
 b=hX/ULZ2YNaNFbvPPNwiwupBxaiM2jd49dDcAlg8E7LiMiTSMjR+Vvr0VMeQjJPw4wGitDduX3/MH1wOh9Wh8dNjkjFP/5lK+A8NhMPBM9iU98ghftCfoiZ1jE2HaJerQRh7SvFpFYAtFoQ8h5+upkW9E4IVLmzdchiNX4YjE/KqfkFONhf24XXoFuwlZDm5iN4xmN3cnfhtqi31JU7MPAYOp0ldG0tAKAMQdB5JjrSLt1TUiMLfxfm5CN19kRxvsJa+bO2UFsxdWsdAfTyPba0y07+jYoWHyLgNS/dxoRDcgQBR3LD6Y3/zPQC3m46Bk9qKKBpXXzNlRvE0nrL61Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSWJRxFUSRR/75Ge00v7x+d4eXsR1bungyJ55lp1BIU=;
 b=IE9AF3Yxy1Fme8kgy+vSTjLlNUeIzOE+Vr3mx4ByAjUIgIpx204Ip94fp7T3e2x8JDZZ5Sauj+esJ750i8s20CT7v1po2CDPoWjc4qNlv2js5hAod+npLZLphwNTHdl7Nje2rsBXJ5vlUyZqe2QibHwvR8afjjBV58wy4u8uJ3s=
Received: from CH2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:610:57::39)
 by SA5PPFA403A61D8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:02:41 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::81) by CH2PR12CA0029.outlook.office365.com
 (2603:10b6:610:57::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:02:40 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:02:29 -0600
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
Subject: [PATCH v5 09/10] perf sched stats: Add basic perf sched stats test
Date: Mon, 19 Jan 2026 17:58:31 +0000
Message-ID: <20260119175833.340369-10-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA5PPFA403A61D8:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a496af-2f1e-48c4-5f5e-08de5784efb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xaG2bmwWQm5rCaLKDcDiXqfNSxK9x7G5ENHP8w2D2oAJ/HRrwaNnEoUiA1F5?=
 =?us-ascii?Q?+4/2zKmSF7GpZT9J4kl1u4chK0hZrQeh569pFkXsM8QoKWcxS2lP8+fKymHz?=
 =?us-ascii?Q?8R/whj7S70pJRO+MWKVREBcRD9rzAl2svSs8GMjDiM5baAHgzLqgrgM6JyHG?=
 =?us-ascii?Q?RW/MaMULPzMwrH/AapblglACsPmXiQmB8vgXud+acU7tijn36hJCR9U5nH3x?=
 =?us-ascii?Q?2lH+Ez1m6aLnvqTQjVXjSPtx/J3A/1k66peXcEywxqVe07Lz9T635Ed/coCA?=
 =?us-ascii?Q?8Ss6OYchZDJahyVKubi76Ch1dHjWJFCDJmhtEDjLDSPm+z06oTmgEtO6gF9F?=
 =?us-ascii?Q?lfGYi8o3+GvdzerJg+NRAbbiLQvfaVcheZYdj/KysT034qPlkgzZekC47NWA?=
 =?us-ascii?Q?BgfZ5i0GuVzS/iQFW9V5NyBszDyhzZh3fj1zcOtdm1GrVZL1yIqR3AYZ+kXp?=
 =?us-ascii?Q?RGMmNNxb4/Amg6Mn6rCVLRrKvaXeQ6QEatitH2u2OPMH4L16scIQrwVkRUus?=
 =?us-ascii?Q?TUsIR+qVGlIt98DKtocZ3na537D+3wQD9ZC/iAllONt0n0o9ih+Uvv0Z4ANO?=
 =?us-ascii?Q?ZzsfgNTinTUwMK4VDzKMFnlMtFCP+2dz01V6m7y/w5zIPHeZWzj7SsRt69Q3?=
 =?us-ascii?Q?brlo2/2yXm5tHwM7G+kVPNVxZNsjPq/C+pre4bXvCwxav6JII+g/juXXG+WK?=
 =?us-ascii?Q?zsCJ+4a18sNOqxvaCaJGut7klKPdH2JJlCWbfz8rpxaq1yvIZqa23yJ+m3bk?=
 =?us-ascii?Q?3jRUrU6OdtYj0KzP3lA/6f5mTnvhSR/JmGtS4lz2koNqUHMybBKC7ofZKEdT?=
 =?us-ascii?Q?O7blPEOtB8HPAcGC2Yrw7tFBT9mw4SmMbuGuHgmo75BWaUGS0tJaKOr9xHSC?=
 =?us-ascii?Q?PgyiHtQskouorkZyUWwArlmKBqpGtyoTPJv9BzRVf4DKH28CG2gJKF1V9qck?=
 =?us-ascii?Q?PR+g6vPRMjSU+sByC936KuYOoAE7Th5GG/bSYvn8nmJCembpcZt9kvBqWNe5?=
 =?us-ascii?Q?VZVZXLDN2/sQtfZPW1uq4mDLSavmXVWlV2chOlI2hVl4p/U3QmQEkKhgPyWh?=
 =?us-ascii?Q?sq+KAONIn9SpM3nz+JuR7dnx2erU25HDUUWPWdFbmmtJ48Tjqb+hQ924F2/c?=
 =?us-ascii?Q?xVtdldEHkXQ0lhl7RcwjFCKybXunOD3QKOxrb8qyt3D+fZ1H1wX9V6OGcp5G?=
 =?us-ascii?Q?sSSO2CgNEkNaqNPHkeqT6VeOaddxXRXBbMXfVaAUolHBYtS5Csr6r4XyDKQL?=
 =?us-ascii?Q?DF2tIA56O+U47efYLVE68TsKV2SXuBm4HmrWCacv6r6Z+fMw0Oo1EVstVC8m?=
 =?us-ascii?Q?orC2zsPpTyJI8kuJ150Bi2VVrS18Aopu8ETXU1KLrHXJcrRy8tR70+MqzFtC?=
 =?us-ascii?Q?Bxe1Kj0Oecsbq4WmOXYhmSdz5yEkEanbQLE9S486lEGgQVXqqMAAiFH3RFFD?=
 =?us-ascii?Q?KNKavzJikXXYlLIdFBAB5C21WLGRv+SNL6Kore0lQ/UCVW9NCzqg9tcsDGke?=
 =?us-ascii?Q?801oa3x7DkBbreP7WqrAOtoIaNQzp2rVsSJoojwiSaMcLEbIZmscSqAl3WVn?=
 =?us-ascii?Q?EBP3aJj9wPbabkZ6pGsoVLJDlhI8Br/qIyAegmzViTPrcgzSGqn+nyrZynxE?=
 =?us-ascii?Q?jw4JFc2Cxv+gb/gWGNRaNCMyLrYKFQG7KQlfpcbbCPhJbnndU8ecuiRIxs9y?=
 =?us-ascii?Q?bQQNmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:02:40.1483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a496af-2f1e-48c4-5f5e-08de5784efb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFA403A61D8

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

