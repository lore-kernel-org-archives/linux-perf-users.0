Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6325A33A;
	Tue, 11 Mar 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694768; cv=fail; b=iSbbXKMtYNhkuSRc2E3BdW58svySI4wGimBUGWPLsJabl050HYB3rBiK/wbwnqKtmMLWpV3VCHQpTJp2l4WrSNgCA4RldFmT8aC/AiJeY7szWMhAEdcT4exua+a6LoD7LADRaIKr/9YiIrenOhGKoeqLNwDCAahZlUHIyV6K1CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694768; c=relaxed/simple;
	bh=Yh1o9rgFLBl9BDa/YcldugNz2kJpZMS8NpYQO1EzaQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjIwf9+Z0fdq5VoebeN5lPhLxcdxh8s2SczCvmtF2E19LwEx4JucG5pKmJHq6KsZs8/uPwRVO3L+c8Qayix1JHG3dwtYCypGmmHpeS3gKMWQYVKkzw/WeCz/ekguaJPPtHW+cH1uUx71tdEHufywCVi2ZTM8H+H/MigbXt5hhBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dycRB5Tp; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dycRB5Tp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csEFLYw9VaVkMYQ9qOx55csQ5BP11YrlgaLTdSt/clZ9NblXKjgZGjJ823tz3oa/iGaXQT1hFFkG3+QWtXAPCdnaKi53Gp23S0GYcSlk726zxYpLccj0yrehvaTYo6BVpZkT+vlsLBvs04bneDSpCE9pq6/OAtEYIJff0pE9LrQ88Fz2HvsV+O8oNQox3NpxwIvRANO8yCsIV1Mtsg0haIsMKFINogtuv47wqNa1PCVfkeCE9kZ56Hl2tMbK0SBSylNOEUbfcMqE/y/EcYDA3xgE0YoAGRCPj0CWn6bjWoquvTBWTXeuMfrpkkFcb/ekZED3ucEFP8Zf9KEJ2ISnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0Szet5zxm0zXidzP83AMFma6wKKQgT2C3tPnKkFVb0=;
 b=kDfbixNnXOH+a0qNcc91C7W5uiz/C/rsUhuvi+jbwSNagHiA4bKMsdyRaN9RG0CKORLztF/Re+WRhvjMX6aPJDZK47x5MI6ApuuLOmgzUNbtkeftHPYMpNojROfKu46XaoSQhuphRSewUSHvTy9oIuJ7zc0DGOfNaQ3F+k9RhEMV58ciK+qpFWO3LkXtyTW3AAgpGnroCSaj3tDP3Iv8NJ8/zex5tdKXAXbIDRYXwTJHpHfQ7SbhQE8d28SGffrMJwCw+rVOPAHE0SLVEXALA/okumzvE7rVONu7q2Cr7fPkDn9+FkTwPmeH/KPN0nDu8+gOTcK33VxHULd/x4ltow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0Szet5zxm0zXidzP83AMFma6wKKQgT2C3tPnKkFVb0=;
 b=dycRB5TpYD8Xks6zVZDpIsL1cjsP8TUAH4BxkT09jY1fiVPudXonJszDZccKgXJ6rlqXiQFBD1OBtkHrz816Llc7USqR70xOPlEKvd8zAQXVlvOC0B2Dxwdq9gcTtWmBXGM33OwaBwjRnj/YGecSozYKT0deFe6XXoK82xIzvIQ=
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:05:59 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c8) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 12:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:05:59 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 07:05:51 -0500
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
Subject: [PATCH v3 8/8] perf sched stats: Add details in man page
Date: Tue, 11 Mar 2025 12:02:30 +0000
Message-ID: <20250311120230.61774-9-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: b651e82f-cbe7-4b63-60fe-08dd60951605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m6W9VcHB1RaKUepswfhbKh8pGcypehyR8GyTZScGfXmX+XfdjgBjEjhXPwGb?=
 =?us-ascii?Q?muzJ6/ZukXoXT/Rkl21bj/Kdl5+sUynmENzEzPvBGl26mUL016xig/q6RCMR?=
 =?us-ascii?Q?94GE372sMDwSKNJekPowAGiZwLuzz806GU4UhOmxm4yUCTcJzZJyB6FyeqRb?=
 =?us-ascii?Q?zIlvMfa2NYR5c+jNblrwqi6zDldNeUvlx1YB/1Ow8J7dn7NDHdf4gIEmQ2Ty?=
 =?us-ascii?Q?4ZLkFvR8zvT8dmFpNmwIpHOBfTpcGJsc0hktBjTPD0+6Jg8h0TAAYzkmFnMz?=
 =?us-ascii?Q?W8m3pc3ZkTfOU6ChMHedr8w1RBrksidDEgS4YVxJbeX6Bk8MhyMp5fF+wFQW?=
 =?us-ascii?Q?N7tOetLYFYLpFGrokZDoANZ2mwCUfMiZhSKCg8G7iXeRddI0hr7SlSZAVl/y?=
 =?us-ascii?Q?wSO2nbYs3uTkU9fiSF8XK6UgoW3+ag06gWE7I2YloW5yMK8JltcjBxVSm/l+?=
 =?us-ascii?Q?drSiwHwWXg1cTK+rXHX/YHE4UCCK26pk5t2IgH6ee+3vtjqwOTuB6FO9oaQ9?=
 =?us-ascii?Q?QR151ElxY9NFycViuZzyTADTqAFaO/PEiHEFc8M89AcAJKOR0IwjMyDrGPny?=
 =?us-ascii?Q?1r8lvv4bppcGi5BuH0FTTMBeOJcC634M43O36ddHXdTtdneJnM5Sohd1OC/4?=
 =?us-ascii?Q?uURjk/qzeGhoIF8WylvDSukGy4GFcT2c3dJ962JLcM055HVVVowRRym3lQdc?=
 =?us-ascii?Q?C6wnLm5ep3rrkP2a8gOG26pwFWyekAqqCeO5kohfKm+sS5xmI3lP872W4fBz?=
 =?us-ascii?Q?7EztfA53H3Zwg32AlFbVlKhLfc1uYHt0g5lxqWMPVV64LSp7jfH+y9n5nTZv?=
 =?us-ascii?Q?nWMuWXSanVzWaNcKftHphPpCZfbeHaEspKKDMMH0y1bLh0vcJ0mXO9Tzqgq3?=
 =?us-ascii?Q?RYPJvspSz1M/4ZsC1CSIspyOs6SWXyyOmq7MNV0hlmvh4zE3YMDWnHu0O86T?=
 =?us-ascii?Q?EsNWEiVF8W7B7JqZnk6J8an8U87EmoH0FtvA76p0g1QoocGXWBX3yDq2GyK1?=
 =?us-ascii?Q?hcaf3LoBhwCNHai0/aYMq1xupy0/xphnerwnChuJavlEE9RbA4Q0cInXWC2w?=
 =?us-ascii?Q?zBfsaEED6/heXpzYcleRzy1LIlI0J2WJ1x66jiNACIQDLRc0yJrlmLHKo5Ur?=
 =?us-ascii?Q?CWrZfMEwNcs+FLyb9A+bZ/wqTQZ+5R3bM9Rdpwe/JY0aQXMmTLU8RQkehz+g?=
 =?us-ascii?Q?ZWvVxHhTxZ1t5VRAC2UirPFQDahQSNYASZGVEA72nKwXZY2dW+xZwsCmn9VP?=
 =?us-ascii?Q?wZmPZg3TLj0DUcsRoaanhx3BiVZtBppJNm+gL0ldD6y6CokjafjnaZAof5Zq?=
 =?us-ascii?Q?T19yon/XE5GYSqm5xAgUH+hFOjNnI5svJJrQ2iqbCgQuekZsYgRJz9O06zcr?=
 =?us-ascii?Q?SJG4+/Dzo/W4EI/J/CyHR8EM83jkUVPdhtHytIyoGRxNDtg6JkEUuxXb9vQ1?=
 =?us-ascii?Q?UFaUkB0miLtW3Sc5z9RcEnHN+gS2WFgwvo1uVnj34yf0uhL5+QJZqu8anTEg?=
 =?us-ascii?Q?MxDIXTBc6nN38Oo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:05:59.0604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b651e82f-cbe7-4b63-60fe-08dd60951605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388

Document perf sched stats purpose, usage examples and guide on
how to interpret the report data in the perf-sched man page.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-sched.txt | 243 +++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 6dbbddb6464d..c674d95e2811 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -8,7 +8,7 @@ perf-sched - Tool to trace/measure scheduler properties (latencies)
 SYNOPSIS
 --------
 [verse]
-'perf sched' {record|latency|map|replay|script|timehist}
+'perf sched' {record|latency|map|replay|script|timehist|stats}
 
 DESCRIPTION
 -----------
@@ -80,8 +80,249 @@ There are several variants of 'perf sched':
     
    Times are in msec.usec.
 
+   'perf sched stats {record | report | diff} <command>' to capture, report the diff
+   in schedstat counters and show the difference between perf sched stats report.
+   schedstat counters which are present in the linux kernel which are exposed through
+   the file ``/proc/schedstat``. These counters are enabled or disabled via the
+   sysctl governed by the file ``/proc/sys/kernel/sched_schedstats``. These counters
+   accounts for many scheduler events such as ``schedule()`` calls, load-balancing
+   events, ``try_to_wakeup()`` call among others. This is useful in understading the
+   scheduler behavior for the workload.
+
+   Note: The tool will not give correct results if there is topological reordering or
+         online/offline of cpus in between capturing snapshots of `/proc/schedstat`.
+
+    Example usage:
+        perf sched stats record -- sleep 1
+        perf sched stats report
+        perf sched stats diff
+
+   A detailed description of the schedstats can be found in the Kernel Documentation:
+   https://www.kernel.org/doc/html/latest/scheduler/sched-stats.html
+
+   The result can be interprested as follows:
+
+   The `perf sched stats report` starts with description of the columns present in
+   the report. These column names are gievn before cpu and domain stats to improve
+   the readability of the report.
+
+   ----------------------------------------------------------------------------------------------------
+   DESC                    -> Description of the field
+   COUNT                   -> Value of the field
+   PCT_CHANGE              -> Percent change with corresponding base value
+   AVG_JIFFIES             -> Avg time in jiffies between two consecutive occurrence of event
+   ----------------------------------------------------------------------------------------------------
+
+   Next is the total profiling time in terms of jiffies:
+
+   ----------------------------------------------------------------------------------------------------
+   Time elapsed (in jiffies)                                   :       24537
+   ----------------------------------------------------------------------------------------------------
+
+   Next is CPU scheduling statistics. These are simple diffs of /proc/schedstat
+   CPU lines along with description. The report also prints % relative to base stat.
+
+   In the example below, schedule() left the CPU0 idle 98.19% of the time.
+   16.54% of total try_to_wake_up() was to wakeup local CPU. And, the total
+   waittime by tasks on CPU0 is 0.49% of the total runtime by tasks on the
+   same CPU.
+
+   ----------------------------------------------------------------------------------------------------
+   CPU 0
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                COUNT  PCT_CHANGE
+   ----------------------------------------------------------------------------------------------------
+   sched_yield() count                                         :           0
+   Legacy counter can be ignored                               :           0
+   schedule() called                                           :       17138
+   schedule() left the processor idle                          :       16827  (  98.19% )
+   try_to_wake_up() was called                                 :         508
+   try_to_wake_up() was called to wake up the local cpu        :          84  (  16.54% )
+   total runtime by tasks on this processor (in jiffies)       :  2408959243
+   total waittime by tasks on this processor (in jiffies)      :    11731825  (  0.49% )
+   total timeslices run on this cpu                            :         311
+   ----------------------------------------------------------------------------------------------------
+
+   Next is load balancing statistics. For each of the sched domains
+   (eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
+   the following three categories:
+
+   1) Idle Load Balance: Load balancing performed on behalf of a long
+                         idling CPU by some other CPU.
+   2) Busy Load Balance: Load balancing performed when the CPU was busy.
+   3) New Idle Balance : Load balancing performed when a CPU just became
+                        idle.
+
+   Under each of these three categories, sched stats report provides
+   different load balancing statistics. Along with direct stats, the
+   report also contains derived metrics prefixed with *. Example:
+
+   ----------------------------------------------------------------------------------------------------
+   CPU 0 DOMAIN SMT CPUS <0, 64>
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                     COUNT     AVG_JIFFIES
+   ----------------------------------------- <Category idle> ------------------------------------------
+   load_balance() count on cpu idle                                 :          50   $      490.74 $
+   load_balance() found balanced on cpu idle                        :          42   $      584.21 $
+   load_balance() move task failed on cpu idle                      :           8   $     3067.12 $
+   imbalance sum on cpu idle                                        :           8
+   pull_task() count on cpu idle                                    :           0
+   pull_task() when target task was cache-hot on cpu idle           :           0
+   load_balance() failed to find busier queue on cpu idle           :           0   $        0.00 $
+   load_balance() failed to find busier group on cpu idle           :          42   $      584.21 $
+   *load_balance() success count on cpu idle                        :           0
+   *avg task pulled per successful lb attempt (cpu idle)            :        0.00
+   ----------------------------------------- <Category busy> ------------------------------------------
+   load_balance() count on cpu busy                                 :           2   $    12268.50 $
+   load_balance() found balanced on cpu busy                        :           2   $    12268.50 $
+   load_balance() move task failed on cpu busy                      :           0   $        0.00 $
+   imbalance sum on cpu busy                                        :           0
+   pull_task() count on cpu busy                                    :           0
+   pull_task() when target task was cache-hot on cpu busy           :           0
+   load_balance() failed to find busier queue on cpu busy           :           0   $        0.00 $
+   load_balance() failed to find busier group on cpu busy           :           1   $    24537.00 $
+   *load_balance() success count on cpu busy                        :           0
+   *avg task pulled per successful lb attempt (cpu busy)            :        0.00
+   ---------------------------------------- <Category newidle> ----------------------------------------
+   load_balance() count on cpu newly idle                           :         427   $       57.46 $
+   load_balance() found balanced on cpu newly idle                  :         382   $       64.23 $
+   load_balance() move task failed on cpu newly idle                :          45   $      545.27 $
+   imbalance sum on cpu newly idle                                  :          48
+   pull_task() count on cpu newly idle                              :           0
+   pull_task() when target task was cache-hot on cpu newly idle     :           0
+   load_balance() failed to find busier queue on cpu newly idle     :           0   $        0.00 $
+   load_balance() failed to find busier group on cpu newly idle     :         382   $       64.23 $
+   *load_balance() success count on cpu newly idle                  :           0
+   *avg task pulled per successful lb attempt (cpu newly idle)      :        0.00
+   ----------------------------------------------------------------------------------------------------
+
+   Consider following line:
+
+   load_balance() found balanced on cpu newly idle                  :         382    $      64.23 $
+
+   While profiling was active, the load-balancer found 382 times the load
+   needs to be balanced on a newly idle CPU 0. Following value encapsulated
+   inside $ is average jiffies between two events (24537 / 382 = 64.23).
+
+   Next are active_load_balance() stats. alb did not trigger while the
+   profiling was active, hence it's all 0s.
+
+   --------------------------------- <Category active_load_balance()> ---------------------------------
+   active_load_balance() count                                      :           0
+   active_load_balance() move task failed                           :           0
+   active_load_balance() successfully moved a task                  :           0
+   ----------------------------------------------------------------------------------------------------
+
+   Next are sched_balance_exec() and sched_balance_fork() stats. They are
+   not used but we kept it in RFC just for legacy purpose. Unless opposed,
+   we plan to remove them in next revision.
+
+   Next are wakeup statistics. For every domain, the report also shows
+   task-wakeup statistics. Example:
+
+   ------------------------------------------- <Wakeup Info> ------------------------------------------
+   try_to_wake_up() awoke a task that last ran on a diff cpu       :       12070
+   try_to_wake_up() moved task because cache-cold on own cpu       :        3324
+   try_to_wake_up() started passive balancing                      :           0
+   ----------------------------------------------------------------------------------------------------
+
+   Same set of stats are reported for each CPU and each domain level.
+
+   How to interpret the diff
+   ~~~~~~~~~~~~~~~~~~~~~~~~~
+
+   The `perf sched stats diff` will also start with explaining the columns
+   present in the diff. Then it will show the diff in time in terms of
+   jiffies. The order of the values depends on the order of input data
+   files. Example:
+
+   ----------------------------------------------------------------------------------------------------
+   Time elapsed (in jiffies)                                        :        2009,       2001
+   ----------------------------------------------------------------------------------------------------
+
+   Below is the sample representing the difference in cpu and domain stats of
+   two runs. Here third column or the values enclosed in `|...|` shows the
+   percent change between the two. Second and fourth columns shows the
+   side-by-side representions of the corresponding fields from `perf sched
+   stats report`.
+
+   ----------------------------------------------------------------------------------------------------
+   CPU <ALL CPUS SUMMARY>
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                    COUNT1      COUNT2  PCT_CHANGE  PCT_CHANGE1 PCT_CHANGE2
+   ----------------------------------------------------------------------------------------------------
+   sched_yield() count                                              :           0,          0  |    0.00% |
+   Legacy counter can be ignored                                    :           0,          0  |    0.00% |
+   schedule() called                                                :      442939,     447305  |    0.99% |
+   schedule() left the processor idle                               :      154012,     174657  |   13.40% |  (   34.77,      39.05 )
+   try_to_wake_up() was called                                      :      306810,     258076  |  -15.88% |
+   try_to_wake_up() was called to wake up the local cpu             :       21313,      14130  |  -33.70% |  (    6.95,       5.48 )
+   total runtime by tasks on this processor (in jiffies)            :  6235330010, 5463133934  |  -12.38% |
+   total waittime by tasks on this processor (in jiffies)           :  8349785693, 5755097654  |  -31.07% |  (  133.91,     105.34 )
+   total timeslices run on this cpu                                 :      288869,     272599  |   -5.63% |
+   ----------------------------------------------------------------------------------------------------
+
+   Below is the sample of domain stats diff:
+
+   ----------------------------------------------------------------------------------------------------
+   CPU <ALL CPUS SUMMARY>, DOMAIN SMT CPUS <0, 64>
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                    COUNT1      COUNT2  PCT_CHANGE     AVG_JIFFIES1  AVG_JIFFIES2
+   ----------------------------------------- <Category busy> ------------------------------------------
+   load_balance() count on cpu busy                                 :         154,         80  |  -48.05% |  $       13.05,       25.01 $
+   load_balance() found balanced on cpu busy                        :         120,         66  |  -45.00% |  $       16.74,       30.32 $
+   load_balance() move task failed on cpu busy                      :           0,          4  |    0.00% |  $        0.00,      500.25 $
+   imbalance sum on cpu busy                                        :        1640,        299  |  -81.77% |
+   pull_task() count on cpu busy                                    :          55,         18  |  -67.27% |
+   pull_task() when target task was cache-hot on cpu busy           :           0,          0  |    0.00% |
+   load_balance() failed to find busier queue on cpu busy           :           0,          0  |    0.00% |  $        0.00,        0.00 $
+   load_balance() failed to find busier group on cpu busy           :         120,         66  |  -45.00% |  $       16.74,       30.32 $
+   *load_balance() success count on cpu busy                        :          34,         10  |  -70.59% |
+   *avg task pulled per successful lb attempt (cpu busy)            :        1.62,       1.80  |   11.27% |
+   ----------------------------------------- <Category idle> ------------------------------------------
+   load_balance() count on cpu idle                                 :         299,        481  |   60.87% |  $        6.72,        4.16 $
+   load_balance() found balanced on cpu idle                        :         197,        331  |   68.02% |  $       10.20,        6.05 $
+   load_balance() move task failed on cpu idle                      :           1,          2  |  100.00% |  $     2009.00,     1000.50 $
+   imbalance sum on cpu idle                                        :         145,        222  |   53.10% |
+   pull_task() count on cpu idle                                    :         133,        199  |   49.62% |
+   pull_task() when target task was cache-hot on cpu idle           :           0,          0  |    0.00% |
+   load_balance() failed to find busier queue on cpu idle           :           0,          0  |    0.00% |  $        0.00,        0.00 $
+   load_balance() failed to find busier group on cpu idle           :         197,        331  |   68.02% |  $       10.20,        6.05 $
+   *load_balance() success count on cpu idle                        :         101,        148  |   46.53% |
+   *avg task pulled per successful lb attempt (cpu idle)            :        1.32,       1.34  |    2.11% |
+   ---------------------------------------- <Category newidle> ----------------------------------------
+   load_balance() count on cpu newly idle                           :       21791,      15976  |  -26.69% |  $        0.09,        0.13 $
+   load_balance() found balanced on cpu newly idle                  :       16226,      12125  |  -25.27% |  $        0.12,        0.17 $
+   load_balance() move task failed on cpu newly idle                :         236,         88  |  -62.71% |  $        8.51,       22.74 $
+   imbalance sum on cpu newly idle                                  :        6655,       4628  |  -30.46% |
+   pull_task() count on cpu newly idle                              :        5329,       3763  |  -29.39% |
+   pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |    0.00% |
+   load_balance() failed to find busier queue on cpu newly idle     :           0,          0  |    0.00% |  $        0.00,        0.00 $
+   load_balance() failed to find busier group on cpu newly idle     :       12649,       9914  |  -21.62% |  $        0.16,        0.20 $
+   *load_balance() success count on cpu newly idle                  :        5329,       3763  |  -29.39% |
+   *avg task pulled per successful lb attempt (cpu newly idle)      :        1.00,       1.00  |    0.00% |
+   --------------------------------- <Category active_load_balance()> ---------------------------------
+   active_load_balance() count                                      :           0,          0  |    0.00% |
+   active_load_balance() move task failed                           :           0,          0  |    0.00% |
+   active_load_balance() successfully moved a task                  :           0,          0  |    0.00% |
+   --------------------------------- <Category sched_balance_exec()> ----------------------------------
+   sbe_count is not used                                            :           0,          0  |    0.00% |
+   sbe_balanced is not used                                         :           0,          0  |    0.00% |
+   sbe_pushed is not used                                           :           0,          0  |    0.00% |
+   --------------------------------- <Category sched_balance_fork()> ----------------------------------
+   sbf_count is not used                                            :           0,          0  |    0.00% |
+   sbf_balanced is not used                                         :           0,          0  |    0.00% |
+   sbf_pushed is not used                                           :           0,          0  |    0.00% |
+   ------------------------------------------ <Wakeup Info> -------------------------------------------
+   try_to_wake_up() awoke a task that last ran on a diff cpu        :       16606,      10214  |  -38.49% |
+   try_to_wake_up() moved task because cache-cold on own cpu        :        3184,       2534  |  -20.41% |
+   try_to_wake_up() started passive balancing                       :           0,          0  |    0.00% |
+   ----------------------------------------------------------------------------------------------------
+
 OPTIONS
 -------
+Applicable to {record|latency|map|replay|script}
+
 -i::
 --input=<file>::
         Input file name. (default: perf.data unless stdin is a fifo)
-- 
2.43.0

