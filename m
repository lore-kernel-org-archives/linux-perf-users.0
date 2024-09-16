Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EF15B984;
	Mon, 16 Sep 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505347; cv=fail; b=iEYyvq1vqOgxU1ZPPWamnkobXk7pA+7QZmT/o88DqpKODERfIST2Co3ua9NU2UUqobCAM433g8tz9aiBji61bmqi6lGPh+pJuoTpnCpkphtljx8YslMBpJ5/xZRc3L5mg9wUYoZh1J493P86chyK2rT2loCGPPcjD26Zx2kflBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505347; c=relaxed/simple;
	bh=qsiYyigcFRl92gy3GRi5I9YUUrX+3IDv+ouBjOQ2ntg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fE0J5npTXxOFLr+GymLPpDIBeA0Jxb+Rlg0Qw3qf7Ufeii6HydnBnZ6DajzrD8i1DC+egr6HYLfztIt0QjH/LvREpmXeC7yF87vQmgMza1iV1TtyuDpFDJt0lyQMWK7Emxik2AYa27GEl7KHoQx01kZUOmOkQb4Y6aUl8tzaTIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qY299KsI; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qY299KsI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImlRIaJMeT96c+BURALZaFT35so7qCoDFqWs4dBQQdg9YqiTGt2nnicSuG67J9VRJYIr/pRg1Mq9+3V968FadrEGXoogX7PMzf2ucFA6C44iF92fcd1Knn2e1RZX5GyfK0sB2BPeF0DBJYk65+1e4OgTOEGyCDNdDTNRf9jNv5O3Pguck5+PJd3Mvl8x/srLaGXcLuQqzCXsR5p92gpW9iSYkbvRAelBNQ5wjrFr/uppH4xL6U/nW4oDyUDVqhZsu3GDA/lmJHJ46wMrZVJOV57Meb1eFMuwybTv2vd7t4RJUl+jR1xZhkt5KJub3/vePG7hF+XayMBbkQcX+uLhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptna+Fw00BndPfA60LOKKfjp8ZCOawWqhlukSzVX0sM=;
 b=pXKM+TKcCdwCZMW2KRleRH2cYgt0CVBtqlhoWp6D25xgQeY+3x6v2OA8FInwSulpbOG4zq/axgke9p84Cpbuv4TDpjJ2822NJS1Sux+nAB0DuhWd/SOjMdKoyoX2vHxUWUUu/W+KlJM1XFZEj44362v+EAb26qsz4K+fu054PA5E1QbcOkSdtWv5/+QE4KcbNyuAyhkjpRfACqXSWB+8DKenEGJ3pYWlBfhchW+nc1Ar2DLPncBmz7ymGv/Bm3nWd68Nb8uK31gd/KTUiVgVBNsHKrPqrKcHhMJB38Ea7+mp2wG/+uXAPDsnj5OZeWMx100RoE5CArIEJVjYtmw8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptna+Fw00BndPfA60LOKKfjp8ZCOawWqhlukSzVX0sM=;
 b=qY299KsIi6kXh1s2R1z17nmPg1pccCYGbDTKxqR3QyqaVZt4v18mjBJ4TSaSarOyWoHL5r4Yymy19BdmqaiF7rYHiFgEwMXqYhrYimefxn1F7Lgx4Fg9K6g/QUMkV6egSlMmbZl9TYVir7EtsJRP6VjXwmJbzOPtI5jAVybqDA0=
Received: from SJ0PR13CA0129.namprd13.prod.outlook.com (2603:10b6:a03:2c6::14)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:49:00 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b1) by SJ0PR13CA0129.outlook.office365.com
 (2603:10b6:a03:2c6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 16:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:49:00 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:48:50 -0500
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
Subject: [PATCH 0/5] perf sched: Introduce stats tool
Date: Mon, 16 Sep 2024 16:47:17 +0000
Message-ID: <20240916164722.1838-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9efdef-241c-4078-a533-08dcd66f76f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3la2f6/VcjslLeKs+8c86SxCwPRINerXVEd3bMKmh+yaVSLiljXzEiBfRIp3?=
 =?us-ascii?Q?XlO5IxQaN8Al9zCXV0rw5GNOcfvtuMxt7BWeNzA1/OT6dyQyzKeWQc9QM4DS?=
 =?us-ascii?Q?pHbJEWDEeeJbsM/8qoRw3yqcG6rxgJtO9oj/M17nsxWcByihxUiUiokOoQTg?=
 =?us-ascii?Q?JewBXFF79lu7GwO73RuEMh13Ac/zTNY/3QVUvfcS5AoA0J1rr/YEgz6c0Op4?=
 =?us-ascii?Q?UXi2HCdT62dYq5El4xv0iDGucdljk/H16+eC3Fx9slTZk0auUcoXa5EURH5d?=
 =?us-ascii?Q?lxeFw7vmsmsd+g1IvvGH/Qtvn954mEcV7IORlcN4vNrEIAbEJyE0FImDjzL2?=
 =?us-ascii?Q?Cx/0AaYI1ganzBbEtpyaB+Lm/zkf7/7U8WlttmYXpWMiT2S5E+x2HZTJG9mM?=
 =?us-ascii?Q?8sr2TqpfstV4EcM9qZvBYeoplfgRqYVuMnRGuHh3JfH7CaoJADj/meprt8Nj?=
 =?us-ascii?Q?IBF0jnM7IxHHkRteEasJefXzrZamGIuCvOTby0YIXT3CjNZOLYVBUjk45Yhn?=
 =?us-ascii?Q?VfCmBZTeCuoH2NQT06xuswqsQaghvWj2qg9/OTxk4j6s/YJ6oTVdF97pPPTZ?=
 =?us-ascii?Q?xE/YngC1dIWCyFZYoteskK7pvMr1r767fe3t5t9KA2fK5n4/jhfNHh6DaJiJ?=
 =?us-ascii?Q?uBlUKJR6goaP1xIZ8H+yEqo03brkdSbFEGaWneREPvGED6maQUsVYrkEQCuj?=
 =?us-ascii?Q?k8g+sUYURTDWKr957+0Z9qG5z8RK1/RLVrpsTrsl+j6K1aR7ET5MNue4RsIX?=
 =?us-ascii?Q?oUyMJfY3faEh6lbtMBGrCDIl8ibCaKrolZ2eQZ4z3HIXRpDjb7Vfj2rPID4w?=
 =?us-ascii?Q?2hbTYzdeaR5LgeklfWppjUu900yxh7qfdITJJAwl8elYniORX8CPS1gXEHIo?=
 =?us-ascii?Q?/TynjqjMYTRSNPE5EClbaVTCw/QyakIuWOHgUyMBNGdtdH2/RkRiqXpUIrc5?=
 =?us-ascii?Q?Un5A7+JB5qmzA0/mFDBbg3143o0HRNPjxRgrrQhax2/qy0NtRo/rkiT1yQux?=
 =?us-ascii?Q?e0pX2azGbarsP1GWeDc2T4Wg7jo5VkOg/bEjTJULUlJffjGcbNCxDa1qq3mL?=
 =?us-ascii?Q?FmTlkE2t0sv1U/4Q5NKAPoRQZ52m6vZskbmYhyxXjkJdDoR9uSHeAAyfKq1A?=
 =?us-ascii?Q?w1mdoYatabZWZpxsOkEpp2suM7X0HKAg2ns05BV8dNyrDQxlmOMNnx5LjDU2?=
 =?us-ascii?Q?J/EHMykJ1UftkRAK0q2dRgfTvnVtHOtEud1wWa0CliBtgz0c63Cv4OyuMXdY?=
 =?us-ascii?Q?3++YuVOo8YZBjUZ2VkW0bVk8//aFAIGJDps94noNO76AyzYuBS8JIrWnc9Lx?=
 =?us-ascii?Q?bL358FuAIJWUdAcbIJ99tqzNMU8dUB8I1w30SurXZW3Z3EMOBAzQtKzJq7k7?=
 =?us-ascii?Q?Geso3xXVNm7TKRx8iiWzy32VDNxnM4FSF9U2URZayOcYD10+IaXUJu6SEvP0?=
 =?us-ascii?Q?YtbY6j76A2PAFZncXEL20VmcrhzxWczZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:49:00.4016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9efdef-241c-4078-a533-08dcd66f76f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

MOTIVATION
----------

Existing `perf sched` is quite exhaustive and provides lot of insights
into scheduler behavior but it quickly becomes impractical to use for
long running or scheduler intensive workload. For ex, `perf sched record`
has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
generates huge 56G perf.data for which perf takes ~137 mins to prepare
and write it to disk [1].

Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
and generates samples on a tracepoint hit, `perf sched stats record` takes
snapshot of the /proc/schedstat file before and after the workload, i.e.
there is almost zero interference on workload run. Also, it takes very
minimal time to parse /proc/schedstat, convert it into perf samples and
save those samples into perf.data file. Result perf.data file is much
smaller. So, overall `perf sched stats record` is much more light weight
compare to `perf sched record`.

We, internally at AMD, have been using this (a variant of this, known as
"sched-scoreboard"[2]) and found it to be very useful to analyse impact
of any scheduler code changes[3][4].

Please note that, this is not a replacement of perf sched record/report.
The intended users of the new tool are scheduler developers, not regular
users.

USAGE
-----

  # perf sched stats record
  # perf sched stats report

Note: Although `perf sched stats` tool supports workload profiling syntax
(i.e. -- <workload> ), the recorded profile is still systemwide since the
/proc/schedstat is a systemwide file.

HOW TO INTERPRET THE REPORT
---------------------------

The `perf sched stats report` starts with total time profiling was active
in terms of jiffies:

  ----------------------------------------------------------------------------------------------------
  Time elapsed (in jiffies)                                   :       24537
  ----------------------------------------------------------------------------------------------------

Next is CPU scheduling statistics. These are simple diffs of
/proc/schedstat CPU lines along with description. The report also
prints % relative to base stat.

In the example below, schedule() left the CPU0 idle 98.19% of the time.
16.54% of total try_to_wake_up() was to wakeup local CPU. And, the total
waittime by tasks on CPU0 is 0.49% of the total runtime by tasks on the
same CPU.

  ----------------------------------------------------------------------------------------------------
  CPU 0
  ----------------------------------------------------------------------------------------------------
  sched_yield() count                                         :           0
  Legacy counter can be ignored                               :           0
  schedule() called                                           :       17138
  schedule() left the processor idle                          :       16827 ( 98.19% )
  try_to_wake_up() was called                                 :         508
  try_to_wake_up() was called to wake up the local cpu        :          84 ( 16.54% )
  total runtime by tasks on this processor (in jiffies)       :  2408959243
  total waittime by tasks on this processor (in jiffies)      :    11731825 ( 0.49% )
  total timeslices run on this cpu                            :         311
  ----------------------------------------------------------------------------------------------------

Next is load balancing statistics. For each of the sched domains
(eg: `SMT`, `MC`, `DIE`...), the scheduler computes statistics under
the following three categories:

  1) Idle Load Balance: Load balancing performed on behalf of a long
                        idling CPU by some other CPU.
  2) Busy Load Balance: Load balancing performed when the CPU was busy.
  3) New Idle Balance : Load balancing performed when a CPU just became
                        idle.

Under each of these three categories, sched stats report provides
different load balancing statistics. Along with direct stats, the
report also contains derived metrics prefixed with *. Example:

  ----------------------------------------------------------------------------------------------------
  CPU 0 DOMAIN SMT CPUS <0, 64>
  ----------------------------------------- <Category idle> ------------------------------------------
  load_balance() count on cpu idle                                 :          50   $      490.74 $
  load_balance() found balanced on cpu idle                        :          42   $      584.21 $
  load_balance() move task failed on cpu idle                      :           8   $     3067.12 $
  imbalance sum on cpu idle                                        :           8
  pull_task() count on cpu idle                                    :           0
  pull_task() when target task was cache-hot on cpu idle           :           0
  load_balance() failed to find busier queue on cpu idle           :           0   $        0.00 $
  load_balance() failed to find busier group on cpu idle           :          42   $      584.21 $
  *load_balance() success count on cpu idle                        :           0
  *avg task pulled per successful lb attempt (cpu idle)            :        0.00
  ----------------------------------------- <Category busy> ------------------------------------------
  load_balance() count on cpu busy                                 :           2   $    12268.50 $
  load_balance() found balanced on cpu busy                        :           2   $    12268.50 $
  load_balance() move task failed on cpu busy                      :           0   $        0.00 $
  imbalance sum on cpu busy                                        :           0
  pull_task() count on cpu busy                                    :           0
  pull_task() when target task was cache-hot on cpu busy           :           0
  load_balance() failed to find busier queue on cpu busy           :           0   $        0.00 $
  load_balance() failed to find busier group on cpu busy           :           1   $    24537.00 $
  *load_balance() success count on cpu busy                        :           0
  *avg task pulled per successful lb attempt (cpu busy)            :        0.00
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :         427   $       57.46 $
  load_balance() found balanced on cpu newly idle                  :         382   $       64.23 $
  load_balance() move task failed on cpu newly idle                :          45   $      545.27 $
  imbalance sum on cpu newly idle                                  :          48
  pull_task() count on cpu newly idle                              :           0
  pull_task() when target task was cache-hot on cpu newly idle     :           0
  load_balance() failed to find busier queue on cpu newly idle     :           0   $        0.00 $
  load_balance() failed to find busier group on cpu newly idle     :         382   $       64.23 $
  *load_balance() success count on cpu newly idle                  :           0
  *avg task pulled per successful lb attempt (cpu newly idle)      :        0.00
  ----------------------------------------------------------------------------------------------------

Consider following line:

  load_balance() found balanced on cpu newly idle                  :         382    $      64.23 $

While profiling was active, the load-balancer found 382 times the load
needs to be balanced on a newly idle CPU 0. Following value encapsulated
inside $ is average jiffies between two events (24537 / 382 = 64.23).

Next are active_load_balance() stats. alb did not trigger while the 
profiling was active, hence it's all 0s.

  --------------------------------- <Category active_load_balance()> ---------------------------------
  active_load_balance() count                                      :           0
  active_load_balance() move task failed                           :           0
  active_load_balance() successfully moved a task                  :           0
  ----------------------------------------------------------------------------------------------------

Next are sched_balance_exec() and sched_balance_fork() stats. They are
not used but we kept it in RFC just for legacy purpose. Unless opposed,
we plan to remove them in next revision.

Next are wakeup statistics. For every domain, the report also shows
task-wakeup statistics. Example:

  ------------------------------------------- <Wakeup Info> ------------------------------------------
  try_to_wake_up() awoke a task that last ran on a diff cpu       :       12070
  try_to_wake_up() moved task because cache-cold on own cpu       :        3324
  try_to_wake_up() started passive balancing                      :           0
  ----------------------------------------------------------------------------------------------------

Same set of stats are reported for each CPU and each domain level.

RFC: https://lore.kernel.org/r/20240508060427.417-1-ravi.bangoria@amd.com
RFC->v1:
 - [Kernel] Print domain name along with domain number in /proc/schedstat
   file.
 - s/schedstat/stats/ for the subcommand.
 - Record domain name and cpumask details, also show them in report.
 - Add CPU filtering capability at record and report time.
 - Add /proc/schedstat v16 support.
 - Live mode support. Similar to perf stat command, live mode prints the
   sched stats on the stdout.
 - Add pager support in `perf sched stats report` for better scrolling.
 - Some minor cosmetic changes in report output to improve readability.
 - Rebase to latest perf-tools-next/perf-tools-next (1de5b5dcb835).

TODO:
 - Add perf unit tests to test basic sched stats functionalities
 - Describe new tool, it's usage and interpretation of report data in the
   perf-sched man page.
 - Currently sched stats tool provides statistics of only one run but we
   are planning to add `perf sched stats diff` which can compare the data
   of two different runs (possibly good and bad) and highlight where
   scheduler decisions are impacting workload performance.
 - perf sched stats records /proc/schedstat which is a CPU and domain
   level scheduler statistic. We are planning to add taskstat tool which
   reads task stats from procfs and generate scheduler statistic report
   at task granularity. this will probably a standalone tool, something
   like `perf sched taskstat record/report`.
 - Except pre-processor related checkpatch warnings, we have addressed
   most of the other possible warnings.

Patches are prepared on perf-tools-next/perf-tools-next (1de5b5dcb835).

Apologies for the long delay in respin. sched-ext was proposed while we
were working on next revision. So, we held on for a moment to settle down
dusts and get a clear idea of whether the new tool will be useful or not.

[1] https://youtu.be/lg-9aG2ajA0?t=283
[2] https://github.com/AMDESE/sched-scoreboard
[3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/


K Prateek Nayak (1):
  sched/stats: Print domain name in /proc/schedstat

Swapnil Sapkal (4):
  perf sched stats: Add record and rawdump support
  perf sched stats: Add schedstat v16 support
  perf sched stats: Add support for report subcommand
  perf sched stats: Add support for live mode

 Documentation/scheduler/sched-stats.rst       |   8 +-
 kernel/sched/stats.c                          |   6 +-
 tools/lib/perf/Documentation/libperf.txt      |   2 +
 tools/lib/perf/Makefile                       |   2 +-
 tools/lib/perf/include/perf/event.h           |  56 ++
 .../lib/perf/include/perf/schedstat-cpu-v15.h |  22 +
 .../lib/perf/include/perf/schedstat-cpu-v16.h |  22 +
 .../perf/include/perf/schedstat-domain-v15.h  | 121 +++
 .../perf/include/perf/schedstat-domain-v16.h  | 121 +++
 tools/perf/builtin-inject.c                   |   2 +
 tools/perf/builtin-sched.c                    | 778 +++++++++++++++++-
 tools/perf/util/event.c                       | 104 +++
 tools/perf/util/event.h                       |   2 +
 tools/perf/util/session.c                     |  20 +
 tools/perf/util/synthetic-events.c            | 255 ++++++
 tools/perf/util/synthetic-events.h            |   3 +
 tools/perf/util/tool.c                        |  20 +
 tools/perf/util/tool.h                        |   4 +-
 18 files changed, 1542 insertions(+), 6 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v16.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v16.h

-- 
2.46.0

