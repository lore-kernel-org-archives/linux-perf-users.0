Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E32580D5;
	Tue, 11 Mar 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694744; cv=fail; b=r0tcU4kH7x5pCPtjMIkSirikf5CKJruiug2XgZpXz+Ag2LGRj0Gqp/brCABqx6sf5mevX4r3ME9m2UndJiEDlUhF8o1L2zfVIuNk2PfDOuj4InOJ03Avl/sbusWurSA0ogWaEDAjgI9bxrGw6pcen6QM9xPi2CCm1nm3nVRslDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694744; c=relaxed/simple;
	bh=l6GNwZcMnN/qgqNQShSDL06ofJ6FNQVPSCZXtj7bWNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1YRLZQ1Ow7qNrXWQihLlykF1lCMvbwC7SsOOIGDwqmT7JPwj9VEDJv+JJKKm+OWEZVJfIlfozajk3sABvSEzRuGL/UbD4TierJAhRpwBb57dJw61Zbp9BYR9xHZlZ5MBcIbW9w/vOBoFHEJb8HKDBm7ikciHUdcZygQGDBUda4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xSvs7qUb; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xSvs7qUb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viqrX8RHDpkdcHO9eVUA67QupOLGeHFPR3b560rphmHsK5OgpL2rm6xD+yBCS1yeNm27nXmLgVM8YwYiNkXX+WTURzhM0eGUMvknFTi+tnkZ9eKiQEgihq0GTFUKFSX2OOb38Qd5RNoQ+TJV3Q9UrQ8i4HKdfzl6ntyZGSqog38mEWTD+xdSQMURwdJ5w7HJllItvbSIJ076P5FNoVs/VBBrZuJIvNhV4GKjXP1zrTk859MlxpVgA53qgJXFsEIfjuzoGXlk8pJ/WC8n4kiPvSraN2uXOAnjH5y/QpJGK1y+POUAbexQO6h+A23Bwup1uwGr1n63CqRbNeBH5CDDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDcIazJjoxJUtki1TZGYEFqdWWipLbusehrQTyPX5QQ=;
 b=VlS0pbeCjAsLxs2D57uD+lh9RA1gdK/jJKcwJSVFmNWhMgmKsoUdKrFQ5P7LNJSsJC9ARUSvCQqj+P4CPIVMUhdkaOYLEXlam5oF0PAr3IwXXqSNNEUxG1vIx7VLhocgpMyh9Rjz5kjmACTKb+BXAcZ+0GHzBG2Exfs8nOUPJxp/AARJ7+MkoIPNX5jMBbzFYWinmIeOqXV2tZTpdDOR1ccHtRTjNnPNT4vZ650UgFaBYZb1Q4aO7ckM84Ozlnw5hr2dBhe6KOZLdTw9XORvS7JXUqteZy+PDL4dPcGVbyR0fqxhO53AzK37fzNQY1jrV6JQjDMHV7rCqY7hiQOOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDcIazJjoxJUtki1TZGYEFqdWWipLbusehrQTyPX5QQ=;
 b=xSvs7qUbES1N7W93yX3kgIC/dEiQUXy5Tb2En1O01omIQIHSZ+Wmnexhd0Rl8lAhTFEod1ELhjHbhHi3pTk61vrK+rgMLs1O60FSe0zZNYNAKBm6tU8tNF6ZNfA4Z0EL2wftwvXpAs8nA/RRCi/GAstfDzfydUeB1tAYKoLiErg=
Received: from BY5PR17CA0045.namprd17.prod.outlook.com (2603:10b6:a03:167::22)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:05:39 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::f8) by BY5PR17CA0045.outlook.office365.com
 (2603:10b6:a03:167::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 12:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:05:38 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 07:05:30 -0500
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
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 7/8] perf sched stats: Add basic perf sched stats test
Date: Tue, 11 Mar 2025 12:02:29 +0000
Message-ID: <20250311120230.61774-8-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d91be9-7b0b-4e0a-b447-08dd609509f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wTEBR20zp/l3CSaXerhl906/A1UpHYbFfV2HZyaZBvknGT7GLk5mTV0kUelC?=
 =?us-ascii?Q?bZeOq2656kVDdaCpkNZTEb8wvP9fxIyARP52KF0/yntdha+dfeCKRktIhfN/?=
 =?us-ascii?Q?Ld6HR6b4vcQQVlugXNT63Zf1K1iOk/9lVToXjfFPtRPVcf3w7n7v9fNdtiKQ?=
 =?us-ascii?Q?+ogSEdU1pSoOQCHw3kK13yoPj6vMCCfvXTWo/qjOSQeMyOEK1OhNnwoUd1jG?=
 =?us-ascii?Q?WYbgYEzRmchedEjzllBtm6tYYWc85tPEAc+w1Qb071o/I94ADFynZquZui4h?=
 =?us-ascii?Q?/cxreLq+hSEYO8UJ9RXt82VjlqR0gDFdBaAMGkxdta/BfKILsXQsIRbNGZD6?=
 =?us-ascii?Q?G9yHUoRLPeY+ZFrNGkfvg6jMs/fDUXmtnyT0kQUaXOunVmFmtwWC9pAapclt?=
 =?us-ascii?Q?/+U+59CVSX2Dn64yZ061fqChaExPn/7simi+guJoj98j8P2J8m50Ita1OkuX?=
 =?us-ascii?Q?/LakoVUjDvyZ64wL1kiWeSk2NafWZ9ORqpf7yOqztANM1h0E2yt3iTI1r2ek?=
 =?us-ascii?Q?GEMApe78Dk8+Dw1Nl5xehO1b2WdMxXoVERaKs155pVOp52YEMwSTRjnS8aIv?=
 =?us-ascii?Q?a3LzehlItlkbzuUvxZEsNNgCx3mVEft4Zdj3YYaaqblO4Fk3QsCmyvXt34+g?=
 =?us-ascii?Q?u+aoVlkqS0ilLzxxT9N6oFzY25wLDDwHVp8KuXBpZOhDrjKQ8mzsu/hsK0LC?=
 =?us-ascii?Q?Ui1WyWAoGnxsjaqvqNNwB4h9Hf6+mhcyuR2P2exYIe0Y8VzvQALW/ZrCIbeu?=
 =?us-ascii?Q?N4VATNnnxdUUeehOXLF58D3xD6m51awcsLkb8wgSMbVafhWCZp7MCXBNNiw9?=
 =?us-ascii?Q?xEJJTFIc/ibYdVI78q8WDeZ4qx2iJ4qBxgESStYRr5I2dCH6xaBqVkuRphZd?=
 =?us-ascii?Q?2AwCboRLypgDMlcQAc2yy86pJXjDIJoAeQ5WE+dO37Ij/Ob6g6fkmkv+o9ON?=
 =?us-ascii?Q?0J9Va73/dFhafNZ2btgbx6mROoAelnzhWH27ze8n/8a9tlwWA/ufVbHpkYNx?=
 =?us-ascii?Q?Cv11WUTRZgP/g1Fzhe+SSgIrtlBfXNP9joL/+XNM2XZQB0dorrXN3TH0GJh4?=
 =?us-ascii?Q?6OTdL+GL6fi+HO2/8nWVJx+EXBUmfLMs9vQ+WC4IudBAPQxZxjvF5Z12AFM2?=
 =?us-ascii?Q?K/ECeNtBW+p5QDZlEJY247nP7D1jLB21zX0kK85W6D+HmwTJ3Gr4kv1dl4SH?=
 =?us-ascii?Q?qIdEoy0q4OX6aqRWu24K8e/RD1hg4NAcqaqMB3acgdzKm5L2XjY1RuoRd/QB?=
 =?us-ascii?Q?rdrAoLxALsb4ea+A8WyLoSYoVrrJoHwUW9onWUR0vwZI4LWR9kRmdDMlufTn?=
 =?us-ascii?Q?3cZ3JPAssXEb6LXsmYko5wGAderB+B34AIYtw64HU5Na9+HHun1PBoWsfczO?=
 =?us-ascii?Q?WPXSa+/T6OIVFZOaOxTZDgdtDI6w2DZNmMrdHTy1yi+v4thuzyKXK1uAy7QR?=
 =?us-ascii?Q?wCwwneyrROpGupFZWB4oZDIbcgcBfNQlB4Tob6H0VG4V96W7ndvSdk6tUv4k?=
 =?us-ascii?Q?Kql6ohblceE/8jI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:05:38.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d91be9-7b0b-4e0a-b447-08dd609509f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

Add basic test for perf sched stats {record|report|diff} subcommand.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/tests/shell/perf_sched_stats.sh | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh

diff --git a/tools/perf/tests/shell/perf_sched_stats.sh b/tools/perf/tests/shell/perf_sched_stats.sh
new file mode 100755
index 000000000000..ddc926f50129
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
+  if ! perf sched stats report 2>&1 | grep -E -q "Columns description"
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
+  if ! perf sched stats true 2>&1 | grep -E -q "Columns description"
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

