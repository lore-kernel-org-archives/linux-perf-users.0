Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090515E5C8;
	Mon, 16 Sep 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505388; cv=fail; b=K3rb5bliJovucqvO8J70i8DsP5AfuyBBlnzxyQ3sNNdDbagFQawYsetOv09EQ+JBXqd9bFtZP+f6VcziK4eIGZ1eHSnP6jj1nmoB7O5Td8yTmR6xyqOkYESgmjFWhYeTPP9YJZ2U4Ak2QwhJvCW77+xfO3kWRV0u/2g68WPfTXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505388; c=relaxed/simple;
	bh=t1CLbjydD9FQeJtqZaPBvArlWRePaTdbIVgDIFd2bZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UillWzf97Pg0+P5r347ByFJ6P35c/g2gSnBxRcUqTaEVFmx6Ey5E7Q/LyLwpCMYW82QasUezIajeltVcrbK7l3YFegShBD3LI40fY/ZffCfGinJmoIGRAz9aim+UmbsOD1E6aWKnBZmKxWEaTBcZVIhTd1UNBuuTEShUZf1OMLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fDQjSPwF; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fDQjSPwF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAGz5evikoGpzrDMwVNMKq043RDELmHERfdzqtOU36sZ9jKDlFXR6oo1+fEGAflXI08dsebdoPyTKCHemF+LTEREip33R2PcbIjxDy4wiKGXPD2VM6EhM9RZ74F1l5fdUbybBKmtTZ0bmwruFsBucjGipJG2OifpL8gZ1WwcjkmdldFOB9CxrBHhkkONKhcCjzs8UsiaCTdhlBhSBKk4flokDuC9kE8ZWDbZlGdF/gZGd/UCx1Xy4n5vJwsHNxwx9CXTWTksGuvaBehY6hBLLKW5I/q9rdY+G+znd+aSa8raUACnOkMRKQL0DuZnQnzYmNudCLtJ0Ky8d+kUjUc58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqpccU0sUyCCbwZDg2Nbv+B+2eYjaKlyh7sUGtHGQTw=;
 b=ttx9sgkypGk5Ujrl3rZRgcOTr3T8Ghf2XzYiLPMERaqADH42QAqR1ppeMcO93bsoB35w9cP7BjFnyuOCh4pD4YORulUGYZS1B4gy3XZt09mOlu2BuhhKqGBdbTPJdOaVe4nS+WYojYsiYXxLf/eT7aUSXIG9WnqiUZf4J2ufxIptVQVd+BwZDjudJhRCMnB/SzAJRlcG95Q6esueCYILRPnP2cIbzqkPKW8GYU13+yqiYJiNNqES1PNZA3LIRjcumiE3+ItCBT2++fafxgEtTB3y0LeIkqM6K/uIuW6olWZGdw8awlr58iJ9s0VeBvhagI0lWqueUIODELbPCb1mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqpccU0sUyCCbwZDg2Nbv+B+2eYjaKlyh7sUGtHGQTw=;
 b=fDQjSPwFRFwZmynCCigZijXzi1OCGW98nl6ELsATKhOVEe2R1UYY4xpeiJssAZdMtsElrEmM6TLcQ8gV7llaLSd7dJILnir9Yq2uhmNJ55trvLpWfaMOk0p0vEf3GWMqThiEZBKiDFdNt1DFX0VaDYIbDSS7ITy1D4Clyje1owc=
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 16:49:39 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::2d) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Mon, 16 Sep 2024 16:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:49:33 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:49:25 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<bristot@redhat.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 4/5] perf sched stats: Add support for report subcommand
Date: Mon, 16 Sep 2024 16:47:21 +0000
Message-ID: <20240916164722.1838-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a227db-a28a-4bf8-69a5-08dcd66f8ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d37B/UGKJHoQ6XtrvWSH3ZtNIEYjL23qtMHJiKiNhJmZVS7mWqIQ1DG+PCyu?=
 =?us-ascii?Q?GfZoccFxe6puuCUnRdtO4Htbmlm0nxLOl2yaN0ye9sS2J7xr2EU09kfKO5cG?=
 =?us-ascii?Q?umzPE3MpxxCNZ8zk4i6MjEgQ0Yz6mtaPFjjzVqmKVkHYh9VtoJzS/KUtuwRi?=
 =?us-ascii?Q?+3HwZD62J2cHqOCiOM6S9Xt/gV+7obwnoIUzJht4zEV1ZxGZWOgG5QwA7hU5?=
 =?us-ascii?Q?zsc/pIz/pAPjaQowOIl/8Oqspbt0L2NNu2Gd1IYCF5U1QGG8Jf8oRVKz3BOL?=
 =?us-ascii?Q?OUhGQ5hMF8pQunFvU2t3jHVV5slsKgd+hP/EKzDv/IChVtoLC1zh+dPfj+M0?=
 =?us-ascii?Q?PQZdTZqfVQSquO9+zwx3c6nMS0H5R9A+S0UgIzVV34qHhhR3l9qxPWNBuXNx?=
 =?us-ascii?Q?OsQrAXjf/wl30n/nhsSeFJhuUyeNkJdom9YXteeWqB/+NBefeRavqQ0Ja/Yw?=
 =?us-ascii?Q?mhu0ObnEpWzR4IdjlfvN/4dNhFzU8rTrK4bKW0SrxBRoVBPi0nIKoalrM4py?=
 =?us-ascii?Q?YR5Pa86sZq0/asxk+7Y6ePKBVRl1lb1d8moXdm8s2mn0pdU33xI9tfBz+DEa?=
 =?us-ascii?Q?+YDbCUvDAP4WK/rdaMHATaWGw6DWBLCwCjEWEcfFiobhrPzNfmFTj5AMwXcq?=
 =?us-ascii?Q?Q+oQSCB0ljW5ugKnlLrbvXnEzaecIsk6zr1h0mtPyKaQH3spU7QlCQkup2A4?=
 =?us-ascii?Q?1wE6TeiBCNkvSZVxX6wSNft52NYuirBFIZzceokEb/PbLMaLmX/xAzccFI7E?=
 =?us-ascii?Q?x52CGW0Dq2cL5uW3qheL5vK//BEIxBfQTLzcKQ8Ii9chZUMjLxHvsLJEy2VC?=
 =?us-ascii?Q?Evp3wie4v+tOtKR8HB+0FL5ZTGJW2EXq7xfq+S+DMPI7RX+uyM+EO3CZXX/o?=
 =?us-ascii?Q?5Hz5U3vIYWDeLRjMLaegalykbmYJ1npL+2fSunvKh/b2ZSyyGgZNNqK+NLkq?=
 =?us-ascii?Q?bzo+lwaHzGQ3w1Sv9wtiXgWTOcTyBt2/9quEi0mmf/c5ft6OpwaCU5EeTnII?=
 =?us-ascii?Q?mRLDaReWo5XaHFyK2eLV7a2xPY2PlgJHD0IcvDQsLQZCfv5XcQxnFpobzww8?=
 =?us-ascii?Q?McO5HDSbrp+w+Fv4ankEdiltb2W/58IqfneDc7hpkPm3OXRH23plaTeOcKkl?=
 =?us-ascii?Q?I8bDVywB3GG9yCiiJPEg/tOMocs5NdoEPRbklvmtmfB4aapL2tYH65/f9YK7?=
 =?us-ascii?Q?0QTm7L8FSeWiNq/y9fAzU2vHAMFRpEkzInQGKhCXuxNXRCy+DqDuMOTdcqnH?=
 =?us-ascii?Q?1nM7gqcUUdBt+tdghNXWGj8faj2Z6cadun8+cdJculHGGmRG6zMoAlAEceX5?=
 =?us-ascii?Q?2V9AN+H7B4qVrRjW4WcJVG4D56i9msVEkMJB0C1Fk7uE2tqT/Mm+IPVC2W+9?=
 =?us-ascii?Q?GO53xSUvgUxPP/s4DRmoxG73UsXCIMgwkAFauGAi+r1QbwEwR+k+jYYDdCRj?=
 =?us-ascii?Q?QUeiJ3ky9XJNYTccRcSqI995pM0LABlU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:49:33.6339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a227db-a28a-4bf8-69a5-08dcd66f8ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

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

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/lib/perf/include/perf/event.h           |   8 +-
 .../lib/perf/include/perf/schedstat-cpu-v15.h |  27 +-
 .../lib/perf/include/perf/schedstat-cpu-v16.h |  27 +-
 .../perf/include/perf/schedstat-domain-v15.h  | 153 ++++--
 .../perf/include/perf/schedstat-domain-v16.h  | 153 ++++--
 tools/perf/builtin-sched.c                    | 475 +++++++++++++++++-
 tools/perf/util/event.c                       |   4 +-
 tools/perf/util/synthetic-events.c            |   4 +-
 8 files changed, 751 insertions(+), 100 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index c332d467c9c9..dca03b585766 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -458,13 +458,13 @@ struct perf_record_compressed {
 };
 
 struct perf_record_schedstat_cpu_v15 {
-#define CPU_FIELD(_type, _name, _ver)		_type _name;
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	_type _name;
 #include "schedstat-cpu-v15.h"
 #undef CPU_FIELD
 };
 
 struct perf_record_schedstat_cpu_v16 {
-#define CPU_FIELD(_type, _name, _ver)		_type _name;
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	_type _name;
 #include "schedstat-cpu-v16.h"
 #undef CPU_FIELD
 };
@@ -481,13 +481,13 @@ struct perf_record_schedstat_cpu {
 };
 
 struct perf_record_schedstat_domain_v15 {
-#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	_type _name;
 #include "schedstat-domain-v15.h"
 #undef DOMAIN_FIELD
 };
 
 struct perf_record_schedstat_domain_v16 {
-#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	_type _name;
 #include "schedstat-domain-v16.h"
 #undef DOMAIN_FIELD
 };
diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v15.h b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
index 8e4355ee3705..f1d7f8363f39 100644
--- a/tools/lib/perf/include/perf/schedstat-cpu-v15.h
+++ b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
@@ -1,13 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef CPU_FIELD
-CPU_FIELD(__u32, yld_count, v15)
-CPU_FIELD(__u32, array_exp, v15)
-CPU_FIELD(__u32, sched_count, v15)
-CPU_FIELD(__u32, sched_goidle, v15)
-CPU_FIELD(__u32, ttwu_count, v15)
-CPU_FIELD(__u32, ttwu_local, v15)
-CPU_FIELD(__u64, rq_cpu_time, v15)
-CPU_FIELD(__u64, run_delay, v15)
-CPU_FIELD(__u64, pcount, v15)
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v15)
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v15)
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v15)
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v15)
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v15)
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v15)
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v15)
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v15)
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v15)
 #endif
diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v16.h b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
index f3a55131a05a..ac58d68ec661 100644
--- a/tools/lib/perf/include/perf/schedstat-cpu-v16.h
+++ b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
@@ -1,13 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef CPU_FIELD
-CPU_FIELD(__u32, yld_count, v16)
-CPU_FIELD(__u32, array_exp, v16)
-CPU_FIELD(__u32, sched_count, v16)
-CPU_FIELD(__u32, sched_goidle, v16)
-CPU_FIELD(__u32, ttwu_count, v16)
-CPU_FIELD(__u32, ttwu_local, v16)
-CPU_FIELD(__u64, rq_cpu_time, v16)
-CPU_FIELD(__u64, run_delay, v16)
-CPU_FIELD(__u64, pcount, v16)
+CPU_FIELD(__u32, yld_count, "sched_yield() count",
+	  "%11u", false, yld_count, v16)
+CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
+	  "%11u", false, array_exp, v16)
+CPU_FIELD(__u32, sched_count, "schedule() called",
+	  "%11u", false, sched_count, v16)
+CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
+	  "%11u", true, sched_count, v16)
+CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
+	  "%11u", false, ttwu_count, v16)
+CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
+	  "%11u", true, ttwu_count, v16)
+CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
+	  "%11llu", false, rq_cpu_time, v16)
+CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
+	  "%11llu", true, rq_cpu_time, v16)
+CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
+	  "%11llu", false, pcount, v16)
 #endif /* CPU_FIELD */
diff --git a/tools/lib/perf/include/perf/schedstat-domain-v15.h b/tools/lib/perf/include/perf/schedstat-domain-v15.h
index 422e713d617a..c1f782e08c1f 100644
--- a/tools/lib/perf/include/perf/schedstat-domain-v15.h
+++ b/tools/lib/perf/include/perf/schedstat-domain-v15.h
@@ -1,40 +1,121 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef DOMAIN_FIELD
-DOMAIN_FIELD(__u32, idle_lb_count, v15)
-DOMAIN_FIELD(__u32, idle_lb_balanced, v15)
-DOMAIN_FIELD(__u32, idle_lb_failed, v15)
-DOMAIN_FIELD(__u32, idle_lb_imbalance, v15)
-DOMAIN_FIELD(__u32, idle_lb_gained, v15)
-DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15)
-DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15)
-DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15)
-DOMAIN_FIELD(__u32, busy_lb_count, v15)
-DOMAIN_FIELD(__u32, busy_lb_balanced, v15)
-DOMAIN_FIELD(__u32, busy_lb_failed, v15)
-DOMAIN_FIELD(__u32, busy_lb_imbalance, v15)
-DOMAIN_FIELD(__u32, busy_lb_gained, v15)
-DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15)
-DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15)
-DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15)
-DOMAIN_FIELD(__u32, newidle_lb_count, v15)
-DOMAIN_FIELD(__u32, newidle_lb_balanced, v15)
-DOMAIN_FIELD(__u32, newidle_lb_failed, v15)
-DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15)
-DOMAIN_FIELD(__u32, newidle_lb_gained, v15)
-DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15)
-DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15)
-DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15)
-DOMAIN_FIELD(__u32, alb_count, v15)
-DOMAIN_FIELD(__u32, alb_failed, v15)
-DOMAIN_FIELD(__u32, alb_pushed, v15)
-DOMAIN_FIELD(__u32, sbe_count, v15)
-DOMAIN_FIELD(__u32, sbe_balanced, v15)
-DOMAIN_FIELD(__u32, sbe_pushed, v15)
-DOMAIN_FIELD(__u32, sbf_count, v15)
-DOMAIN_FIELD(__u32, sbf_balanced, v15)
-DOMAIN_FIELD(__u32, sbf_pushed, v15)
-DOMAIN_FIELD(__u32, ttwu_wake_remote, v15)
-DOMAIN_FIELD(__u32, ttwu_move_affine, v15)
-DOMAIN_FIELD(__u32, ttwu_move_balance, v15)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ")
+#endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, idle_lb_imbalance,
+	     "imbalance sum on cpu idle", "%11u", false, v15)
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v15)
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v15)
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v15)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v15)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v15)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ")
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v15)
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v15)
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v15)
+DOMAIN_FIELD(__u32, busy_lb_imbalance,
+	     "imbalance sum on cpu busy", "%11u", false, v15)
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v15)
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v15)
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v15)
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v15)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v15)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v15)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ")
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, newidle_lb_imbalance,
+	     "imbalance sum on cpu newly idle", "%11u", false, v15)
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v15)
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v15)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v15)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v15)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v15)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v15)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ")
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v15)
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v15)
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v15)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ")
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v15)
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v15)
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v15)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ")
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v15)
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v15)
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v15)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ")
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v15)
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v15)
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v15)
 #endif /* DOMAIN_FIELD */
diff --git a/tools/lib/perf/include/perf/schedstat-domain-v16.h b/tools/lib/perf/include/perf/schedstat-domain-v16.h
index d6ef895c9d32..b8038048e662 100644
--- a/tools/lib/perf/include/perf/schedstat-domain-v16.h
+++ b/tools/lib/perf/include/perf/schedstat-domain-v16.h
@@ -1,40 +1,121 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef DOMAIN_FIELD
-DOMAIN_FIELD(__u32, busy_lb_count, v16)
-DOMAIN_FIELD(__u32, busy_lb_balanced, v16)
-DOMAIN_FIELD(__u32, busy_lb_failed, v16)
-DOMAIN_FIELD(__u32, busy_lb_imbalance, v16)
-DOMAIN_FIELD(__u32, busy_lb_gained, v16)
-DOMAIN_FIELD(__u32, busy_lb_hot_gained, v16)
-DOMAIN_FIELD(__u32, busy_lb_nobusyq, v16)
-DOMAIN_FIELD(__u32, busy_lb_nobusyg, v16)
-DOMAIN_FIELD(__u32, idle_lb_count, v16)
-DOMAIN_FIELD(__u32, idle_lb_balanced, v16)
-DOMAIN_FIELD(__u32, idle_lb_failed, v16)
-DOMAIN_FIELD(__u32, idle_lb_imbalance, v16)
-DOMAIN_FIELD(__u32, idle_lb_gained, v16)
-DOMAIN_FIELD(__u32, idle_lb_hot_gained, v16)
-DOMAIN_FIELD(__u32, idle_lb_nobusyq, v16)
-DOMAIN_FIELD(__u32, idle_lb_nobusyg, v16)
-DOMAIN_FIELD(__u32, newidle_lb_count, v16)
-DOMAIN_FIELD(__u32, newidle_lb_balanced, v16)
-DOMAIN_FIELD(__u32, newidle_lb_failed, v16)
-DOMAIN_FIELD(__u32, newidle_lb_imbalance, v16)
-DOMAIN_FIELD(__u32, newidle_lb_gained, v16)
-DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v16)
-DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v16)
-DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v16)
-DOMAIN_FIELD(__u32, alb_count, v16)
-DOMAIN_FIELD(__u32, alb_failed, v16)
-DOMAIN_FIELD(__u32, alb_pushed, v16)
-DOMAIN_FIELD(__u32, sbe_count, v16)
-DOMAIN_FIELD(__u32, sbe_balanced, v16)
-DOMAIN_FIELD(__u32, sbe_pushed, v16)
-DOMAIN_FIELD(__u32, sbf_count, v16)
-DOMAIN_FIELD(__u32, sbf_balanced, v16)
-DOMAIN_FIELD(__u32, sbf_pushed, v16)
-DOMAIN_FIELD(__u32, ttwu_wake_remote, v16)
-DOMAIN_FIELD(__u32, ttwu_move_affine, v16)
-DOMAIN_FIELD(__u32, ttwu_move_balance, v16)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category busy> ")
+#endif
+DOMAIN_FIELD(__u32, busy_lb_count,
+	     "load_balance() count on cpu busy", "%11u", true, v16)
+DOMAIN_FIELD(__u32, busy_lb_balanced,
+	     "load_balance() found balanced on cpu busy", "%11u", true, v16)
+DOMAIN_FIELD(__u32, busy_lb_failed,
+	     "load_balance() move task failed on cpu busy", "%11u", true, v16)
+DOMAIN_FIELD(__u32, busy_lb_imbalance,
+	     "imbalance sum on cpu busy", "%11u", false, v16)
+DOMAIN_FIELD(__u32, busy_lb_gained,
+	     "pull_task() count on cpu busy", "%11u", false, v16)
+DOMAIN_FIELD(__u32, busy_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v16)
+DOMAIN_FIELD(__u32, busy_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v16)
+DOMAIN_FIELD(__u32, busy_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v16)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v16)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
+		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v16)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category idle> ")
+#endif
+DOMAIN_FIELD(__u32, idle_lb_count,
+	     "load_balance() count on cpu idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, idle_lb_balanced,
+	     "load_balance() found balanced on cpu idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, idle_lb_failed,
+	     "load_balance() move task failed on cpu idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, idle_lb_imbalance,
+	     "imbalance sum on cpu idle", "%11u", false, v16)
+DOMAIN_FIELD(__u32, idle_lb_gained,
+	     "pull_task() count on cpu idle", "%11u", false, v16)
+DOMAIN_FIELD(__u32, idle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v16)
+DOMAIN_FIELD(__u32, idle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, idle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v16)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v16)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
+		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v16)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category newidle> ")
+#endif
+DOMAIN_FIELD(__u32, newidle_lb_count,
+	     "load_balance() count on cpu newly idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, newidle_lb_balanced,
+	     "load_balance() found balanced on cpu newly idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, newidle_lb_failed,
+	     "load_balance() move task failed on cpu newly idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, newidle_lb_imbalance,
+	     "imbalance sum on cpu newly idle", "%11u", false, v16)
+DOMAIN_FIELD(__u32, newidle_lb_gained,
+	     "pull_task() count on cpu newly idle", "%11u", false, v16)
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
+	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v16)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
+	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v16)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
+	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v16)
+#ifdef DERIVED_CNT_FIELD
+DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v16)
+#endif
+#ifdef DERIVED_AVG_FIELD
+DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
+		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v16)
+#endif
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category active_load_balance()> ")
+#endif
+DOMAIN_FIELD(__u32, alb_count,
+	     "active_load_balance() count", "%11u", false, v16)
+DOMAIN_FIELD(__u32, alb_failed,
+	     "active_load_balance() move task failed", "%11u", false, v16)
+DOMAIN_FIELD(__u32, alb_pushed,
+	     "active_load_balance() successfully moved a task", "%11u", false, v16)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_exec()> ")
+#endif
+DOMAIN_FIELD(__u32, sbe_count,
+	     "sbe_count is not used", "%11u", false, v16)
+DOMAIN_FIELD(__u32, sbe_balanced,
+	     "sbe_balanced is not used", "%11u", false, v16)
+DOMAIN_FIELD(__u32, sbe_pushed,
+	     "sbe_pushed is not used", "%11u", false, v16)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Category sched_balance_fork()> ")
+#endif
+DOMAIN_FIELD(__u32, sbf_count,
+	     "sbf_count is not used", "%11u", false, v16)
+DOMAIN_FIELD(__u32, sbf_balanced,
+	     "sbf_balanced is not used", "%11u", false, v16)
+DOMAIN_FIELD(__u32, sbf_pushed,
+	     "sbf_pushed is not used", "%11u", false, v16)
+#ifdef DOMAIN_CATEGORY
+DOMAIN_CATEGORY(" <Wakeup Info> ")
+#endif
+DOMAIN_FIELD(__u32, ttwu_wake_remote,
+	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v16)
+DOMAIN_FIELD(__u32, ttwu_move_affine,
+	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v16)
+DOMAIN_FIELD(__u32, ttwu_move_balance,
+	     "try_to_wake_up() started passive balancing", "%11u", false, v16)
 #endif /* DOMAIN_FIELD */
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 6ea0db05aa41..cd465644fce5 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3855,6 +3855,470 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
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
+
+static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
+{
+	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
+	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
+	__u16 version = after_workload->cpu_data->version;
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
+	(before->_ver._name = after->_ver._name - before->_ver._name);
+
+	if (version == 15) {
+#include <perf/schedstat-cpu-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-cpu-v16.h>
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
+	(before->_ver._name = after->_ver._name - before->_ver._name);
+
+	if (version == 15) {
+#include <perf/schedstat-domain-v15.h>
+	} else if (version == 16) {
+#include <perf/schedstat-domain-v16.h>
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
+#define CALC_PCT(_x, _y)	((_y) ? ((double)(_x) / (_y)) * 100 : 0.0)
+
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
+	do {									\
+		if (_is_pct) {							\
+			printf("%-60s: " _format " ( %3.2lf%% )\n", _desc,	\
+			       cs->_ver._name,					\
+			       CALC_PCT(cs->_ver._name, cs->_ver._pct_of));	\
+		} else {							\
+			printf("%-60s: " _format "\n", _desc, cs->_ver._name);	\
+		}								\
+	} while (0);
+
+	if (cs->version == 15) {
+#include <perf/schedstat-cpu-v15.h>
+	} else if (cs->version == 16) {
+#include <perf/schedstat-cpu-v16.h>
+	}
+
+#undef CPU_FIELD
+#undef CALC_PCT
+}
+
+static inline void print_domain_stats(struct perf_record_schedstat_domain *ds,
+				      __u64 jiffies)
+{
+#define DOMAIN_CATEGORY(_desc)							\
+	do {									\
+		size_t _len = strlen(_desc);					\
+		size_t _pre_dash_cnt = (100 - _len) / 2;			\
+		size_t _post_dash_cnt = 100 - _len - _pre_dash_cnt;		\
+		print_separator(_pre_dash_cnt, _desc, _post_dash_cnt);		\
+	} while (0);
+
+#define CALC_AVG(_x, _y)	((_y) ? (long double)(_x) / (_y) : 0.0)
+
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
+	do {									\
+		if (_is_jiffies) {						\
+			printf("%-65s: " _format "   $ %11.2Lf $\n", _desc,	\
+			       ds->_ver._name,					\
+			       CALC_AVG(jiffies, ds->_ver._name));		\
+		} else {							\
+			printf("%-65s: " _format "\n", _desc, ds->_ver._name);	\
+		}								\
+	} while (0);
+
+#define DERIVED_CNT_FIELD(_desc, _format, _x, _y, _z, _ver)			\
+	do {									\
+		printf("*%-64s: " _format "\n", _desc,				\
+		       (ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z));		\
+	} while (0);
+
+#define DERIVED_AVG_FIELD(_desc, _format, _x, _y, _z, _w, _ver)		\
+	do {									\
+		printf("*%-64s: " _format "\n", _desc, CALC_AVG(ds->_ver._w,	\
+		       ((ds->_ver._x) - (ds->_ver._y) - (ds->_ver._z))));	\
+	} while (0);
+
+	if (ds->version == 15) {
+#include <perf/schedstat-domain-v15.h>
+	} else if (ds->version == 16) {
+#include <perf/schedstat-domain-v16.h>
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
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
+	do {									\
+		summary_cs->_ver._name += temp_cs->_ver._name;			\
+		if (is_last)							\
+			summary_cs->_ver._name /= cnt;				\
+	} while (0);
+
+	if (cptr->cpu_data->version == 15) {
+#include <perf/schedstat-cpu-v15.h>
+	} else if (cptr->cpu_data->version == 16) {
+#include <perf/schedstat-cpu-v16.h>
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
+	} while (0);
+
+	if (dptr->domain_data->version == 15) {
+#include <perf/schedstat-domain-v15.h>
+	} else if (dptr->domain_data->version == 16) {
+#include <perf/schedstat-domain-v16.h>
+	}
+#undef DOMAIN_FIELD
+}
+
+/* FIXME: The code fails (segfaults) when one or ore cpus are offline. */
+static void show_schedstat_data(void)
+{
+	struct schedstat_domain *dptr = NULL, *tdptr = NULL, *dtail = NULL;
+	struct schedstat_cpu *cptr = cpu_head, *summary_head;
+	struct perf_record_schedstat_domain *ds = NULL;
+	struct perf_record_schedstat_cpu *cs = NULL;
+	__u64 jiffies = cptr->cpu_data->timestamp;
+	bool is_last = false, is_summary = true;
+	int cnt = 0;
+
+	print_separator(100, "", 0);
+	printf("Time elapsed (in jiffies)                                   : %11llu\n", jiffies);
+	print_separator(100, "", 0);
+
+	if (cptr) {
+		summary_head = zalloc(sizeof(*summary_head));
+		summary_head->cpu_data = zalloc(sizeof(*cs));
+		memcpy(summary_head->cpu_data, cptr->cpu_data, sizeof(*cs));
+		summary_head->next = NULL;
+		summary_head->domain_head = NULL;
+		dptr = cptr->domain_head;
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
+	cptr = cpu_head;
+	while (cptr) {
+		if (!cptr->next)
+			is_last = true;
+
+		cnt++;
+		summarize_schedstat_cpu(summary_head, cptr, cnt, is_last);
+		tdptr = summary_head->domain_head;
+		dptr = cptr->domain_head;
+
+		while (tdptr) {
+			summarize_schedstat_domain(tdptr, dptr, cnt, is_last);
+			tdptr = tdptr->next;
+			dptr = dptr->next;
+		}
+		cptr = cptr->next;
+	}
+
+	cptr = cpu_head;
+	summary_head->next = cptr;
+	cptr = summary_head;
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
+	static bool after_workload_flag;
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
+		show_schedstat_data();
+		free_schedstat();
+	}
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4031,6 +4495,8 @@ int cmd_sched(int argc, const char **argv)
 	OPT_PARENT(sched_options)
 	};
 	const struct option stats_options[] = {
+	OPT_STRING('i', "input", &input_name, "file",
+		   "`stats report` with input filename"),
 	OPT_STRING('o', "output", &output_name, "file",
 		   "`stats record` with output filename"),
 	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
@@ -4054,7 +4520,7 @@ int cmd_sched(int argc, const char **argv)
 		NULL
 	};
 	const char * stats_usage[] = {
-		"perf sched stats {record} [<options>]",
+		"perf sched stats {record|report} [<options>]",
 		NULL
 	};
 	const char *const sched_subcommands[] = { "record", "latency", "map",
@@ -4156,7 +4622,7 @@ int cmd_sched(int argc, const char **argv)
 
 		return perf_sched__timehist(&sched);
 	} else if (!strcmp(argv[0], "stats")) {
-		const char *const stats_subcommands[] = {"record", NULL};
+		const char *const stats_subcommands[] = {"record", "report", NULL};
 
 		argc = parse_options_subcommand(argc, argv, stats_options,
 						stats_subcommands,
@@ -4168,6 +4634,11 @@ int cmd_sched(int argc, const char **argv)
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
index d138e4a5787c..0f14fe225be0 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -560,7 +560,7 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
 
 	size = fprintf(fp, "\ncpu%u ", cs->cpu);
 
-#define CPU_FIELD(_type, _name, _ver)						\
+#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		\
 	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name);	\
 
 	if (version == 15) {
@@ -638,7 +638,7 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
 	size += fprintf(fp, "%s ", cpu_mask);
 	free(cpu_mask);
 
-#define DOMAIN_FIELD(_type, _name, _ver)					\
+#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		\
 	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name);	\
 
 	if (version == 15) {
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 73b2492a4cde..24f9cb95d07d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2535,7 +2535,7 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
 	if (io__get_dec(io, (__u64 *)&cs->cpu) != ' ')
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
2.46.0

