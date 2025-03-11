Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487025A333;
	Tue, 11 Mar 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694606; cv=fail; b=IhXD3byM1H6jPzrmmU3WXyiI7M6ZdwuZwjFMcdEEgW20nwl6fNXS7aoibgoGHVxA3GsSH09WNZfVEfrdT8fd3ArkNEpGnNrnd6/mfIgq91a0ScRXUeG5IoV2y7dSOzBc4IGmXNl4jvJpzSd+Xvs/pM56FdFveAMc7r1OmdbGPCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694606; c=relaxed/simple;
	bh=jcUlfCa3zK8yVN3BPLApmme9GRJOfcumAhd1BhTmUDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z6hw6Xawl516oPac5H+lrphGSVRBHzTCq9yjFJ9F2e3M1zSDqXlx4sbSiH3rDY7Kq/L9OQ7kqxDPYHIa3xCgL9A8HrRLRwER38v5JXbi9XgDvOC0aciIPXCxz1yiyW8VprwfrptPk/tV7H843TCL3fyglTDFx+2jvXqEqGMqXdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VQrflpMX; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VQrflpMX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aySWTZQfu1QHd68GmAqrfJD4aZyVsFQluejLaCFzfeCRftvW7tQ/2fFHtDocWPSiP5TA/RXB47mNjG6Z2P+efHENbossrTyM2qSGgCcW3M+wbfNzkQCPDQwNJLtMLRkg/nN0FHqWDfAIhS+5lBQEsjtX+s9jzePX6dJ6c7nZ76zjZQM07wNrGNeDaTlqzcCEVvTxOozoV8xCTDrVE1CkFcYuWhciATTBBtKnTTtQ28qqlowjQZVtxh4zvELrAUL2gwrrMfrDjakpXe+STCYoRzTdCXxc5lULlgdYGYmRa8IXe+GWcb/3kWL8y3k1C2UO0782dwN2n2qE46sl0lvUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au8gNb3DWm4yuQcGGc7sxQxYRkIPzhgXVoOrVlEOcwg=;
 b=I5ywUfYpBUROtT2mlqpAV3bc2RYaZH19F2L/zZeEKPSIrwWygjfpFKLPn3Nf6eAwh86JQ/E7DjWmwQT1qGaaXbg9m11yIyLIWCVJOE9Bf60FTR0zToPMevnG3jOQGuhlbk7/BhA4MssEhVShG+5ljH0D7w4smzFBanOGMLyMnquKEDuBNgAFkNq+ZaNgOEMQ/OIb9UZj563PkuD/Aabn4yctNXc/7DpXogC2ruCN8svCn8sy8T6ugJxhTdY1yrrBzzTjbUVzgLaQJ2tiL8zWm8jHaR+++tCuW3mGtwN2O8HMzY/fYSX+WSoxHOup5YGP5FES8Ndj84V+IgN7FQ+ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au8gNb3DWm4yuQcGGc7sxQxYRkIPzhgXVoOrVlEOcwg=;
 b=VQrflpMXcFU8BpiRGF1pG124VUjHy5QyRW/gojEIIbUw/KhHLw/p5URNavIaBylWvw3fK+vnTqTYjRl9Si/ULlCNpY/2dtwQYX9BQdiGWShCCUe+iiYzCY88D32D5mqWt6ORTFzObW0wmlf6friw8PPnQYxV6c0BEhXPOv+yzhs=
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:03:16 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::39) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 12:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:03:16 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 07:03:08 -0500
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
Subject: [PATCH v3 0/8] perf sched: Introduce stats tool
Date: Tue, 11 Mar 2025 12:02:22 +0000
Message-ID: <20250311120230.61774-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bd8f8d-3c89-4afb-1a12-08dd6094b509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ht/VtCvITtx+S2rp0vGYVNaa+WcS86tvKZYHYVxZ7ebVyFClp6Dh+jmUN3RI?=
 =?us-ascii?Q?XccaKQpgHBfW63x/b2tOreXLyqxucYncs0sAHRiLmw1Jx6Km4XBzPmC68thR?=
 =?us-ascii?Q?d6QxENacLXm8lroXkMNLiee3w/+ABSDljVc/UHNhVNubSDCChVlhAUAFpOQq?=
 =?us-ascii?Q?yl4hPtDyD7OO43Ne4FNqieK6hOCv3umL6yjfps206km9htGbRr0u1Q+MKJ4G?=
 =?us-ascii?Q?qAYDHeeEXAStggckaMjL7Gwxr40S/LrzY7WZO5ctNpRaXKMAPykr573VKigi?=
 =?us-ascii?Q?5GQVPNoBmfVxmId2ruv2kobY6F/9VpPHRZOEzjeOZWpg/jgRChu1tkT4pfH/?=
 =?us-ascii?Q?YiYzuO4ERRwuKPAk55p83zu+6/Ty6Xfxy+vRI8iGLa4Goklk1TrlVcNnBvY9?=
 =?us-ascii?Q?zH0OmFr1GO5yY08h21lg5UN6AUqf9E/e5bj5T1eLc/iqDvFMsfs/AQhEiVam?=
 =?us-ascii?Q?U+UDvbr+ZsEACaJhrXKg97ybaY2NG+uvup1/9cHTkjfQIa4kCdCz1wjw6I4w?=
 =?us-ascii?Q?t+5tm2QEBMHwHbPLUvzteWVUHKyrvOlTDIBfC1FQhuPe6eNinWTGYLEqIwsW?=
 =?us-ascii?Q?2AkJEomSwfgoOnRWQySR5+8dqQgiWx7tWad69PbEqpvIidBbTOe3W3Ml+Rcl?=
 =?us-ascii?Q?PzPlWa1WvL0F60i+vOmkJjEGukutAbvyfVWCJaihIiHtJfpScTA/FvaOwByF?=
 =?us-ascii?Q?5sQTB1aSh9FnaulGKfYIkqKN0AmviPjFTIOVSfLYqLO0Djqf+B9xphxDwy7K?=
 =?us-ascii?Q?yHLliQyvhU30sUci8qH0+1rOjtINx4TAsR/o0N38ZVT3KDmYp1b9gLoyCBkq?=
 =?us-ascii?Q?J66EthXC4W2/fYAciYEGt8yAW4PBGUVC+PaxOvmNfMiqbUMLxajGuv9Ro+Z9?=
 =?us-ascii?Q?wWPogWENQTFj3rxKWdaYyu+1Q/QSm2hbyPcmfRB70250ABxpIXudM8L/GETk?=
 =?us-ascii?Q?40d5zcxXWRKATV343oEbcj/xNwWDO+z0peOcoI7uwOjL8SH20zawiZYSUREU?=
 =?us-ascii?Q?si++SgT3yOx60tQk/erhoBdKU6PK9tS52A4KtmoD/i6ATMIxtV+HSaa9Yl7K?=
 =?us-ascii?Q?Fbtq7LdXl1dVGGHJgYeKlKdLfZbdI0OU1Y0W5GmMeV3RpjWlIVH/s8mwue2Y?=
 =?us-ascii?Q?uSgEiUZ/wX+KOR5l36uSHolzOxf5zKIju/sJwtHhLek1WTcrAOAtBm/O7iWF?=
 =?us-ascii?Q?nZGhbIpJSOSLUcI2O4DrRs23npFPRekQbgGXfHVfQOL6wjMRZf+UgpmtnKzN?=
 =?us-ascii?Q?tEyvDzmrpHm2gdXdYP22wAeT8ZbEvJXy8Y6QZNaAOKRfO5sqglktJAfQLDmX?=
 =?us-ascii?Q?KsFhf0gPshpcyEXiHs2NbBvkE0Sgnm7UWs02Gy+OssSMpPQa397/+glzY6UI?=
 =?us-ascii?Q?Qq63PbrUgR8epgyVvTAYxEIgRZoIEFrRKnzQ28T6w9U+qEHhM+TffXPWfA6o?=
 =?us-ascii?Q?yCRE5xVQ4ZWIORNuPDgEdxkQoF0k8GKf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:03:16.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bd8f8d-3c89-4afb-1a12-08dd6094b509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517

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
of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
series to report the analysis[6][7].

Please note that, this is not a replacement of perf sched record/report.
The intended users of the new tool are scheduler developers, not regular
users.

USAGE
-----

  # perf sched stats record
  # perf sched stats report
  # perf sched stats diff

Note: Although `perf sched stats` tool supports workload profiling syntax
(i.e. -- <workload> ), the recorded profile is still systemwide since the
/proc/schedstat is a systemwide file.

HOW TO INTERPRET THE REPORT
---------------------------

The `perf sched stats report` starts with description of the columns
present in the report. These column names are gievn before cpu and
domain stats to improve the readability of the report.

  ----------------------------------------------------------------------------------------------------
  DESC                    -> Description of the field
  COUNT                   -> Value of the field
  PCT_CHANGE              -> Percent change with corresponding base value
  AVG_JIFFIES             -> Avg time in jiffies between two consecutive occurrence of event
  ----------------------------------------------------------------------------------------------------

Next is the total profiling time in terms of jiffies:

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
  DESC                                                                COUNT  PCT_CHANGE
  ----------------------------------------------------------------------------------------------------
  sched_yield() count                                         :           0
  Legacy counter can be ignored                               :           0
  schedule() called                                           :       17138
  schedule() left the processor idle                          :       16827  (  98.19% )
  try_to_wake_up() was called                                 :         508
  try_to_wake_up() was called to wake up the local cpu        :          84  (  16.54% )
  total runtime by tasks on this processor (in jiffies)       :  2408959243
  total waittime by tasks on this processor (in jiffies)      :    11731825  (  0.49% )
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
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT     AVG_JIFFIES
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

HOW TO INTERPRET THE DIFF
-------------------------

The `perf sched stats diff` will also start with explaining the columns
present in the diff. Then it will show the diff in time in terms of
jiffies. The order of the values depends on the order of input data
files. Example:

  ----------------------------------------------------------------------------------------------------
  Time elapsed (in jiffies)                                        :        2009,       2001
  ----------------------------------------------------------------------------------------------------

Below is the sample representing the difference in cpu and domain stats of
two runs. Here third column or the values enclosed in `|...|` shows the
percent change between the two. Second and fourth columns shows the
side-by-side representions of the corresponding fields from `perf sched
stats report`.

  ----------------------------------------------------------------------------------------------------
  CPU <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2  PCT_CHANGE  PCT_CHANGE1 PCT_CHANGE2
  ----------------------------------------------------------------------------------------------------
  sched_yield() count                                              :           0,          0  |    0.00% |
  Legacy counter can be ignored                                    :           0,          0  |    0.00% |
  schedule() called                                                :      442939,     447305  |    0.99% |
  schedule() left the processor idle                               :      154012,     174657  |   13.40% |  (   34.77,      39.05 )
  try_to_wake_up() was called                                      :      306810,     258076  |  -15.88% |
  try_to_wake_up() was called to wake up the local cpu             :       21313,      14130  |  -33.70% |  (    6.95,       5.48 )
  total runtime by tasks on this processor (in jiffies)            :  6235330010, 5463133934  |  -12.38% |
  total waittime by tasks on this processor (in jiffies)           :  8349785693, 5755097654  |  -31.07% |  (  133.91,     105.34 )
  total timeslices run on this cpu                                 :      288869,     272599  |   -5.63% |
  ----------------------------------------------------------------------------------------------------

Below is the sample of domain stats diff:

  ----------------------------------------------------------------------------------------------------
  CPU <ALL CPUS SUMMARY>, DOMAIN SMT CPUS <0, 64>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2  PCT_CHANGE     AVG_JIFFIES1  AVG_JIFFIES2
  ----------------------------------------- <Category busy> ------------------------------------------
  load_balance() count on cpu busy                                 :         154,         80  |  -48.05% |  $       13.05,       25.01 $
  load_balance() found balanced on cpu busy                        :         120,         66  |  -45.00% |  $       16.74,       30.32 $
  load_balance() move task failed on cpu busy                      :           0,          4  |    0.00% |  $        0.00,      500.25 $
  imbalance sum on cpu busy                                        :        1640,        299  |  -81.77% |
  pull_task() count on cpu busy                                    :          55,         18  |  -67.27% |
  pull_task() when target task was cache-hot on cpu busy           :           0,          0  |    0.00% |
  load_balance() failed to find busier queue on cpu busy           :           0,          0  |    0.00% |  $        0.00,        0.00 $
  load_balance() failed to find busier group on cpu busy           :         120,         66  |  -45.00% |  $       16.74,       30.32 $
  *load_balance() success count on cpu busy                        :          34,         10  |  -70.59% |
  *avg task pulled per successful lb attempt (cpu busy)            :        1.62,       1.80  |   11.27% |
  ----------------------------------------- <Category idle> ------------------------------------------
  load_balance() count on cpu idle                                 :         299,        481  |   60.87% |  $        6.72,        4.16 $
  load_balance() found balanced on cpu idle                        :         197,        331  |   68.02% |  $       10.20,        6.05 $
  load_balance() move task failed on cpu idle                      :           1,          2  |  100.00% |  $     2009.00,     1000.50 $
  imbalance sum on cpu idle                                        :         145,        222  |   53.10% |
  pull_task() count on cpu idle                                    :         133,        199  |   49.62% |
  pull_task() when target task was cache-hot on cpu idle           :           0,          0  |    0.00% |
  load_balance() failed to find busier queue on cpu idle           :           0,          0  |    0.00% |  $        0.00,        0.00 $
  load_balance() failed to find busier group on cpu idle           :         197,        331  |   68.02% |  $       10.20,        6.05 $
  *load_balance() success count on cpu idle                        :         101,        148  |   46.53% |
  *avg task pulled per successful lb attempt (cpu idle)            :        1.32,       1.34  |    2.11% |
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :       21791,      15976  |  -26.69% |  $        0.09,        0.13 $
  load_balance() found balanced on cpu newly idle                  :       16226,      12125  |  -25.27% |  $        0.12,        0.17 $
  load_balance() move task failed on cpu newly idle                :         236,         88  |  -62.71% |  $        8.51,       22.74 $
  imbalance sum on cpu newly idle                                  :        6655,       4628  |  -30.46% |
  pull_task() count on cpu newly idle                              :        5329,       3763  |  -29.39% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |    0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,          0  |    0.00% |  $        0.00,        0.00 $
  load_balance() failed to find busier group on cpu newly idle     :       12649,       9914  |  -21.62% |  $        0.16,        0.20 $
  *load_balance() success count on cpu newly idle                  :        5329,       3763  |  -29.39% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        1.00,       1.00  |    0.00% |
  --------------------------------- <Category active_load_balance()> ---------------------------------
  active_load_balance() count                                      :           0,          0  |    0.00% |
  active_load_balance() move task failed                           :           0,          0  |    0.00% |
  active_load_balance() successfully moved a task                  :           0,          0  |    0.00% |
  --------------------------------- <Category sched_balance_exec()> ----------------------------------
  sbe_count is not used                                            :           0,          0  |    0.00% |
  sbe_balanced is not used                                         :           0,          0  |    0.00% |
  sbe_pushed is not used                                           :           0,          0  |    0.00% |
  --------------------------------- <Category sched_balance_fork()> ----------------------------------
  sbf_count is not used                                            :           0,          0  |    0.00% |
  sbf_balanced is not used                                         :           0,          0  |    0.00% |
  sbf_pushed is not used                                           :           0,          0  |    0.00% |
  ------------------------------------------ <Wakeup Info> -------------------------------------------
  try_to_wake_up() awoke a task that last ran on a diff cpu        :       16606,      10214  |  -38.49% |
  try_to_wake_up() moved task because cache-cold on own cpu        :        3184,       2534  |  -20.41% |
  try_to_wake_up() started passive balancing                       :           0,          0  |    0.00% |
  ----------------------------------------------------------------------------------------------------

v2: https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
v2->v3:
 - Add perf unit test for basic sched stats functionalities
 - Describe new tool, it's usage and interpretation of report data in the
   perf-sched man page.
 - Add /proc/schedstat version 17 support.

v1: https://lore.kernel.org/lkml/20240916164722.1838-1-ravi.bangoria@amd.com
v1->v2
 - Add the support for `perf sched stats diff`
 - Add column header in report for better readability. Use
   procfs__mountpoint for consistency. Add hint for enabling
   CONFIG_SCHEDSTAT if disabled. [James Clark]
 - Use a single header file for both cpu and domain fileds. Change
   the layout of structs to minimise the padding. I tried changing
   `v15` to `15` in the header files but it was not giving any
   benefits so drop the idea. [Namhyung Kim]
 - Add tested-by.

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
 - perf sched stats records /proc/schedstat which is a CPU and domain
   level scheduler statistic. We are planning to add taskstat tool which
   reads task stats from procfs and generate scheduler statistic report
   at task granularity. this will probably a standalone tool, something
   like `perf sched taskstat record/report`.
 - Except pre-processor related checkpatch warnings, we have addressed
   most of the other possible warnings.

Patches are prepared on v6.14-rc6 (80e54e84911a).

[1] https://youtu.be/lg-9aG2ajA0?t=283
[2] https://github.com/AMDESE/sched-scoreboard
[3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/
[5] https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
[6] https://lore.kernel.org/lkml/3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com/
[7] https://lore.kernel.org/lkml/feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com/

Swapnil Sapkal (8):
  perf sched stats: Add record and rawdump support
  perf sched stats: Add schedstat v16 support
  perf sched stats: Add schedstat v17 support
  perf sched stats: Add support for report subcommand
  perf sched stats: Add support for live mode
  perf sched stats: Add support for diff subcommand
  perf sched stats: Add basic perf sched stats test
  perf sched stats: Add details in man page

 tools/lib/perf/Documentation/libperf.txt    |   2 +
 tools/lib/perf/Makefile                     |   2 +-
 tools/lib/perf/include/perf/event.h         |  70 ++
 tools/lib/perf/include/perf/schedstat-v15.h | 142 +++
 tools/lib/perf/include/perf/schedstat-v16.h | 142 +++
 tools/lib/perf/include/perf/schedstat-v17.h | 160 ++++
 tools/perf/Documentation/perf-sched.txt     | 243 ++++-
 tools/perf/builtin-inject.c                 |   2 +
 tools/perf/builtin-sched.c                  | 978 +++++++++++++++++++-
 tools/perf/tests/shell/perf_sched_stats.sh  |  64 ++
 tools/perf/util/event.c                     | 110 +++
 tools/perf/util/event.h                     |   2 +
 tools/perf/util/session.c                   |  20 +
 tools/perf/util/synthetic-events.c          | 260 ++++++
 tools/perf/util/synthetic-events.h          |   3 +
 tools/perf/util/tool.c                      |  20 +
 tools/perf/util/tool.h                      |   4 +-
 17 files changed, 2220 insertions(+), 4 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh

-- 
2.43.0

