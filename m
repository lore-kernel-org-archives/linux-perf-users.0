Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11703128BE;
	Mon, 19 Jan 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845793; cv=fail; b=F1paWwwgkXKoaT8LPmKnVezjcfIdk4ibWpABpCON/nxNxbahIGfvlsn6xfiWyl9k4OGB5sL9UAPdKXd48lNyCzCyYoVqK5HwT3GO8NLDWLRZ5cU5okGHXt5npwCNPqfPfb4iqqk2LXvnDPGcR2hjVzQF9/GndMH/UgoxYqHfoTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845793; c=relaxed/simple;
	bh=gqAZxoZKLiec3qn/670jAHkQUcHad5CAYPsvx7cZ5xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYQ6+mziXTHCy7AH3xeEaDfEnrQZ7v7DGtZ0T+HAkuTVR6M9aWVffUlMsj1IvGiVQS9i+t55SBDej4zmM20YO3WonyyHTme6GRsWRfNKoXs1bxbJyNTL4GeY152zrH7P3CYpm22qzHNHLbUAmK44Zt7djdXVttaz1KaBtHE9sdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1narVjxx; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1narVjxx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=br6nCUFWYV773PEQXLLXpx6+YOHd0VySXoiW1Q9pEPy6jdU0nKL1GTcJpbR9vNiGHRfoULJczoWu3mAnmco1x4jfw+jOfZRKx0BHMW4GQCKcvuG3FGpmkGrgjG39QPMvr2ZCu7P8WLDFFy3gjWhzgOe04SeVHPlNk8xsPbXkcuBjgwHqJkHoaqipdiJKT4m9fVhqIuXwXcnFPYWWbrUAUHKxVH08est0VV9mOi2JSUH/m7AlBa3U2VgxXaxZf8pszOkeMgfbpK27BgVdP38ZwfuexLfqmLc88Fru5c1HRyTx8D+WTaG4Rft112d3OTKEO2n5exg9SufJfX8maDHHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR5lwR7ocSYg9xggvlfqb4UMGVkz4dpo1j/gcmPJlg0=;
 b=lq9JuhL5KlmqY6R5IsDhX6C8LRBRpH/wmCH+B8+tQ3Qg5q0z9XI2p5flzZ9eHpDlBu/SAH+O7MKG+hPNMTQfKID+PykARXtTNyPQ7c2RhEgc5E2rTiP+1EkYNkVvZIfTdoFJgO1QUwjwQ6r9Jz7+n7q+XQfTSw6/oMLdZeDraAWf5vaoCT2MFqX6phF5prQL1f5XaWj+TvmhlrnFyQxAluf7h0GdroILVFOtoo2oAP3oxrGtQwf8oh7VaehF6Q7NTe8BhSk8e6O0eUs00jQbkeOPMroKfB41Cwir6khESvlilO8mFf14w8hPajTO5kgoi4Hbh0OTb9NreqBRkcyphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR5lwR7ocSYg9xggvlfqb4UMGVkz4dpo1j/gcmPJlg0=;
 b=1narVjxx68IIiXduoz03CO8WsLnRr88rCGwJthkE8H8fsk8agMz10soyBeecA2NeZhJ7GiIaSCuiXblmpxkM7GYUip5df5m4gKlFLHQcE4SeWJxR+MhH148NBslHqy9Nl3TI7y0FKMJCycgoGZhvXJPiv8J1jc2dN/FJ4q4ZF/0=
Received: from CH2PR12CA0024.namprd12.prod.outlook.com (2603:10b6:610:57::34)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 18:03:04 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::62) by CH2PR12CA0024.outlook.office365.com
 (2603:10b6:610:57::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:03:03 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:02:52 -0600
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
Subject: [PATCH v5 10/10] perf sched stats: Add details in man page
Date: Mon, 19 Jan 2026 17:58:32 +0000
Message-ID: <20260119175833.340369-11-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2503640c-7e8e-48e4-99bc-08de5784fd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U52Oub0+8a5gfbDYLFfsHBGx9TKaLjhDtCfnCcgyTQDMb6JhmA2I/VYj6lt0?=
 =?us-ascii?Q?Io1G2qxiz1+UrSBlKvN7L6H23JbB8H6Sh4eb/80vbfaNfMZIq0L1+s74aQS5?=
 =?us-ascii?Q?lhgUEMQKMAfh1IXkwdgg7w1BhA2/BzwF0c9nEGk4zM74k6GB//ilKZ2ZtXiH?=
 =?us-ascii?Q?mf+4SJfL86wYlMrslr4tLB70UfhK/36ng14iApQCUJ2/59Hn/2kqsXCzxOAC?=
 =?us-ascii?Q?2Qkcmm/VD7Waz37n+V9YiLO+TI968Mq1fu+uA4Mpc3ifwRc7p+uJc8ulX0fj?=
 =?us-ascii?Q?biv55aDlZt/s2LwvIie1mA9D5gLMBt53tgPc/TKpmLlCTFJEvduyuHGD5qQm?=
 =?us-ascii?Q?e4Wh0F6LPThrZZ0LsWZNNbgOdPrKCUIoAQWmBSXPQD7Sk3597SoSVyc6lCIT?=
 =?us-ascii?Q?gKZntqEbrlZptSxSzPg3rINnq2HmaG6lhEzRf7wwVc4drXbr/HcCfPbnTA8S?=
 =?us-ascii?Q?9b7rpWtH88YMqfq0AWXC8l9Ej7+sqjfDsTceknvdsiZhH4k9zvWWTlgPGYPT?=
 =?us-ascii?Q?tsT0uhvpu8HA0S92iv+1YxaUFzwH9voOeW0FbNPn+YTe404QuH/NrED8MHy2?=
 =?us-ascii?Q?z2YrWerdoNAs5DxEpM7szztIGxJyb1pdrzCvjD5juCYDJivO6oeDOhK/EQRH?=
 =?us-ascii?Q?Vf6IRMHaqiEkEdHoVAecZpg2WPHanqqAFTKDfHx+xb781JWpM9/Tc9Irvv+H?=
 =?us-ascii?Q?2Px3Bows6aIYml27tEW1fVRVLXdUdX7eLXyobnIDxnR7ywZ6NNzYsx1HdJ1y?=
 =?us-ascii?Q?DCqPyG522Pi2zdD+uKYNUfFvtGiY+OUGDwSLDa3QDsriAa5pDqxC6nL1Qxxb?=
 =?us-ascii?Q?j7++JiTwPYREJARZmKDdfU134RB94ODpV93L6akraeSnvTjyYS/wXGR8iX49?=
 =?us-ascii?Q?LgShlMwTRo9W9kTYpZEaq2l49F9ICvgCIBLfxhz3mtzJtdwNPAgF+nKQli33?=
 =?us-ascii?Q?qXjeSJh1tG4nJNI5BzdlLy7m/MV5v31JhaqoyZ+h8cusYu+mPQ2Lom0nnBA3?=
 =?us-ascii?Q?IA7oyKnRkUcvgGW3lnl0M78qav8jcHcSis174QO6b/4Pff2pVgx1z6Dvm5DC?=
 =?us-ascii?Q?0bImqU8h9WusWq/L5q/5eNBHAEVNO4MKMnWzZXyDhokFjwqeUXi9KaNe08Yu?=
 =?us-ascii?Q?9hDJo+8bYP9rk4SkEHrI/LF3HiRhyPPcNfB6x+lTV8sZpcTPN+Qu+ONHZ6c7?=
 =?us-ascii?Q?kqyB2wup7N3dG4PfZBlkY49SfuFB+uojkUdaL4fUSGEn4An5S/6AKv57iXfc?=
 =?us-ascii?Q?Lo2HMFl6D3azvY1jDHY5qdfQ/rogFFQ66ybHGtiUpFO8dHqzM1sJD3nvIOtj?=
 =?us-ascii?Q?iHnhJ5Rx72f3zJ9HJjQdiRnyeeDKRBtzq7ioHU/0UGQZc+I0s54K+C5gX4Gx?=
 =?us-ascii?Q?g6qGQAUp7dOHdD3Rv/5EJ6JOSx61tQvyfTXMigs1t9JyHwcAYkn7O/QVk7ZH?=
 =?us-ascii?Q?gBNors2uwb1pQOj6GSOi0SEOF373D8+ojC5G3KKWNKBuGjdUrvuevtUOB41V?=
 =?us-ascii?Q?LYct3ZUR6jRfa+ZkPRFMH/qncH/L8GGm5a0b2zX+/6Kke4Tv+vEnTv8Wwr53?=
 =?us-ascii?Q?ac+Z4CpUBeIDru1KN42wrXyS/GsCe7k8MtHuVlVIb7/KHerA9VbqC87LcDXQ?=
 =?us-ascii?Q?RCgC83reMkTX0NHhGZxFIk+dZu+HfRDs3JtFtM0lKbcbJMcxQ6tJ1cUy3erM?=
 =?us-ascii?Q?2Cd6IA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:03:03.0641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2503640c-7e8e-48e4-99bc-08de5784fd5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844

Document perf sched stats purpose, usage examples and guide on
how to interpret the report data in the perf-sched man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/Documentation/perf-sched.txt | 261 +++++++++++++++++++++++-
 1 file changed, 260 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 6dbbddb6464d..5bfb7bb6c633 100644
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
@@ -80,8 +80,267 @@ There are several variants of 'perf sched':
     
    Times are in msec.usec.
 
+   'perf sched stats {record | report | diff} <command>' to capture, report the diff
+   in schedstat counters and show the difference between perf sched stats report
+   respectively. schedstat counters which are present in the linux kernel and are
+   exposed through the file ``/proc/schedstat``. These counters are enabled or disabled
+   via the sysctl governed by the file ``/proc/sys/kernel/sched_schedstats``. These
+   counters accounts for many scheduler events such as ``schedule()`` calls, load-balancing
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
+   the report. These column names are given before cpu and domain stats to improve
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
+   Next is CPU scheduling statistics. These are simple diffs of /proc/schedstat CPU lines
+   along with description. The report also prints % relative to base stat.
+
+   In the example below, schedule() left the CPU0 idle 36.58% of the time. 0.45% of total
+   try_to_wake_up() was to wakeup local CPU. And, the total waittime by tasks on CPU0 is
+   48.70% of the total runtime by tasks on the same CPU.
+
+   ----------------------------------------------------------------------------------------------------
+   CPU 0
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                     COUNT   PCT_CHANGE
+   ----------------------------------------------------------------------------------------------------
+   yld_count                                                        :           0
+   array_exp                                                        :           0
+   sched_count                                                      :      402267
+   sched_goidle                                                     :      147161  (    36.58% )
+   ttwu_count                                                       :      236309
+   ttwu_local                                                       :        1062  (     0.45% )
+   rq_cpu_time                                                      :  7083791148
+   run_delay                                                        :  3449973971  (    48.70% )
+   pcount                                                           :      255035
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
+   CPU 0, DOMAIN SMT CPUS 0,64
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                     COUNT    AVG_JIFFIES
+   ----------------------------------------- <Category busy> ------------------------------------------
+   busy_lb_count                                                    :         136  $       17.08 $
+   busy_lb_balanced                                                 :         131  $       17.73 $
+   busy_lb_failed                                                   :           0  $        0.00 $
+   busy_lb_imbalance_load                                           :          58
+   busy_lb_imbalance_util                                           :           0
+   busy_lb_imbalance_task                                           :           0
+   busy_lb_imbalance_misfit                                         :           0
+   busy_lb_gained                                                   :           7
+   busy_lb_hot_gained                                               :           0
+   busy_lb_nobusyq                                                  :           2  $     1161.50 $
+   busy_lb_nobusyg                                                  :         129  $       18.01 $
+   *busy_lb_success_count                                           :           5
+   *busy_lb_avg_pulled                                              :        1.40
+   ----------------------------------------- <Category idle> ------------------------------------------
+   idle_lb_count                                                    :         449  $        5.17 $
+   idle_lb_balanced                                                 :         382  $        6.08 $
+   idle_lb_failed                                                   :           3  $      774.33 $
+   idle_lb_imbalance_load                                           :           0
+   idle_lb_imbalance_util                                           :           0
+   idle_lb_imbalance_task                                           :          71
+   idle_lb_imbalance_misfit                                         :           0
+   idle_lb_gained                                                   :          67
+   idle_lb_hot_gained                                               :           0
+   idle_lb_nobusyq                                                  :           0  $        0.00 $
+   idle_lb_nobusyg                                                  :         382  $        6.08 $
+   *idle_lb_success_count                                           :          64
+   *idle_lb_avg_pulled                                              :        1.05
+   ---------------------------------------- <Category newidle> ----------------------------------------
+   newidle_lb_count                                                 :       30471  $        0.08 $
+   newidle_lb_balanced                                              :       28490  $        0.08 $
+   newidle_lb_failed                                                :         633  $        3.67 $
+   newidle_lb_imbalance_load                                        :           0
+   newidle_lb_imbalance_util                                        :           0
+   newidle_lb_imbalance_task                                        :        2040
+   newidle_lb_imbalance_misfit                                      :           0
+   newidle_lb_gained                                                :        1348
+   newidle_lb_hot_gained                                            :           0
+   newidle_lb_nobusyq                                               :           6  $      387.17 $
+   newidle_lb_nobusyg                                               :       26634  $        0.09 $
+   *newidle_lb_success_count                                        :        1348
+   *newidle_lb_avg_pulled                                           :        1.00
+   ----------------------------------------------------------------------------------------------------
+
+   Consider following line:
+
+   newidle_lb_balanced                                              :       28490  $        0.08 $
+
+   While profiling was active, the load-balancer found 28490 times the load
+   needs to be balanced on a newly idle CPU 0. Following value encapsulated
+   inside $ is average jiffies between two events (28490 / 24537 = 0.08).
+
+   Next are active_load_balance() stats. alb did not trigger while the
+   profiling was active, hence it's all 0s.
+
+   --------------------------------- <Category active_load_balance()> ---------------------------------
+   alb_count                                                        :           0
+   alb_failed                                                       :           0
+   alb_pushed                                                       :           0
+   ----------------------------------------------------------------------------------------------------
+
+   Next are sched_balance_exec() and sched_balance_fork() stats. They are
+   not used but we kept it in RFC just for legacy purpose. Unless opposed,
+   we plan to remove them in next revision.
+
+   Next are wakeup statistics. For every domain, the report also shows
+   task-wakeup statistics. Example:
+
+   ------------------------------------------ <Wakeup Info> -------------------------------------------
+   ttwu_wake_remote                                                 :        1590
+   ttwu_move_affine                                                 :          84
+   ttwu_move_balance                                                :           0
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
+   files. It will take `perf.data.old` and `perf.data` respectively as the
+   defaults for comparison. Example:
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
+   DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
+   ----------------------------------------------------------------------------------------------------
+   yld_count                                                        :           0,          0  |     0.00>
+   array_exp                                                        :           0,          0  |     0.00>
+   sched_count                                                      :      528533,     412573  |   -21.94>
+   sched_goidle                                                     :      193426,     146082  |   -24.48>
+   ttwu_count                                                       :      313134,     385975  |    23.26>
+   ttwu_local                                                       :        1126,       1282  |    13.85>
+   rq_cpu_time                                                      :  8257200244, 8301250047  |     0.53>
+   run_delay                                                        :  4728347053, 3997100703  |   -15.47>
+   pcount                                                           :      335031,     266396  |   -20.49>
+   ----------------------------------------------------------------------------------------------------
+
+   Below is the sample of domain stats diff:
+
+   ----------------------------------------------------------------------------------------------------
+   CPU <ALL CPUS SUMMARY>, DOMAIN SMT
+   ----------------------------------------------------------------------------------------------------
+   DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
+   ----------------------------------------- <Category busy> ------------------------------------------
+   busy_lb_count                                                    :         122,         80  |   -34.43>
+   busy_lb_balanced                                                 :         115,         76  |   -33.91>
+   busy_lb_failed                                                   :           1,          3  |   200.00>
+   busy_lb_imbalance_load                                           :          35,         49  |    40.00>
+   busy_lb_imbalance_util                                           :           0,          0  |     0.00>
+   busy_lb_imbalance_task                                           :           0,          0  |     0.00>
+   busy_lb_imbalance_misfit                                         :           0,          0  |     0.00>
+   busy_lb_gained                                                   :           7,          2  |   -71.43>
+   busy_lb_hot_gained                                               :           0,          0  |     0.00>
+   busy_lb_nobusyq                                                  :           0,          0  |     0.00>
+   busy_lb_nobusyg                                                  :         115,         76  |   -33.91>
+   *busy_lb_success_count                                           :           6,          1  |   -83.33>
+   *busy_lb_avg_pulled                                              :        1.17,       2.00  |    71.43>
+   ----------------------------------------- <Category idle> ------------------------------------------
+   idle_lb_count                                                    :         568,        620  |     9.15>
+   idle_lb_balanced                                                 :         462,        449  |    -2.81>
+   idle_lb_failed                                                   :          11,         21  |    90.91>
+   idle_lb_imbalance_load                                           :           0,          0  |     0.00>
+   idle_lb_imbalance_util                                           :           0,          0  |     0.00>
+   idle_lb_imbalance_task                                           :         115,        189  |    64.35>
+   idle_lb_imbalance_misfit                                         :           0,          0  |     0.00>
+   idle_lb_gained                                                   :         103,        169  |    64.08>
+   idle_lb_hot_gained                                               :           0,          0  |     0.00>
+   idle_lb_nobusyq                                                  :           0,          0  |     0.00>
+   idle_lb_nobusyg                                                  :         462,        449  |    -2.81>
+   *idle_lb_success_count                                           :          95,        150  |    57.89>
+   *idle_lb_avg_pulled                                              :        1.08,       1.13  |     3.92>
+   ---------------------------------------- <Category newidle> ----------------------------------------
+   newidle_lb_count                                                 :       16961,       3155  |   -81.40>
+   newidle_lb_balanced                                              :       15646,       2556  |   -83.66>
+   newidle_lb_failed                                                :         397,        142  |   -64.23>
+   newidle_lb_imbalance_load                                        :           0,          0  |     0.00>
+   newidle_lb_imbalance_util                                        :           0,          0  |     0.00>
+   newidle_lb_imbalance_task                                        :        1376,        655  |   -52.40>
+   newidle_lb_imbalance_misfit                                      :           0,          0  |     0.00>
+   newidle_lb_gained                                                :         917,        457  |   -50.16>
+   newidle_lb_hot_gained                                            :           0,          0  |     0.00>
+   newidle_lb_nobusyq                                               :           3,          1  |   -66.67>
+   newidle_lb_nobusyg                                               :       14480,       2103  |   -85.48>
+   *newidle_lb_success_count                                        :         918,        457  |   -50.22>
+   *newidle_lb_avg_pulled                                           :        1.00,       1.00  |     0.11>
+   --------------------------------- <Category active_load_balance()> ---------------------------------
+   alb_count                                                        :           0,          1  |     0.00>
+   alb_failed                                                       :           0,          0  |     0.00>
+   alb_pushed                                                       :           0,          1  |     0.00>
+   --------------------------------- <Category sched_balance_exec()> ----------------------------------
+   sbe_count                                                        :           0,          0  |     0.00>
+   sbe_balanced                                                     :           0,          0  |     0.00>
+   sbe_pushed                                                       :           0,          0  |     0.00>
+   --------------------------------- <Category sched_balance_fork()> ----------------------------------
+   sbf_count                                                        :           0,          0  |     0.00>
+   sbf_balanced                                                     :           0,          0  |     0.00>
+   sbf_pushed                                                       :           0,          0  |     0.00>
+   ------------------------------------------ <Wakeup Info> -------------------------------------------
+   ttwu_wake_remote                                                 :        2031,       2914  |    43.48>
+   ttwu_move_affine                                                 :          73,        124  |    69.86>
+   ttwu_move_balance                                                :           0,          0  |     0.00>
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

