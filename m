Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6638718C023;
	Fri, 22 Nov 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265139; cv=fail; b=bE5ZvDvo27tlCYA6kpRxF/BOIiPVKyF84ZzZEwH52lb+S7998wGmOVlFlkD3sGp5uPPxLXbSD49dNjvEnYE5IF2OJ/iQLLX5fvxTA63BNN7IF7oVM6jyQzBAc6L5a2js51UDpRkPSIDovnJhJ8Enn92gjMHEpO82d+HP1VBNGrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265139; c=relaxed/simple;
	bh=eSTb0C9ZlcqJ6HBv8P+MIDz0hNgrSZqBAv+zVQITsHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWBRpSJLQ/h5lTJg2xvspgGVl1BE6HnJTYqx1qq7iGYGqEyq9dd09qi942qkVBL70PdSYMJuheQhbcE3PMPTVeg8eAWs1Jlk7GEG+NuZsK0p+2K9w6jIXgtNqFkHeER7tT70vpZKUnHIeO+KZOjWO6uGFojiNcWk8O/tPzPRgng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LrGUt69L; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LrGUt69L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGRyMeaDnP2qZDFzAHXGF/USs0OYs8Y7Qyf8cYskfE3RkPXfsBaYV9DlPeINzQbjb5C2F3MEqUeIGpBr/opcmG86wGxY5/c4ZPJ7ed+IzChkqsLGqhhUpCLVtUHrTOd5V9HopIuTjfneTIGssoXicvCycjhEdn/PyPdl4IQ+ymnYFr71PRAnLFK/JcEutxMUc6c2JYInave1P6tVNMsOaT2cqlIVX8ZfP4RD5dyDlvryepofIcDeQUmBqqTI/UC3grhhp7E4q0uxRuAJ4GPmH8vuY9rAL+PE8bp+updx19U3ESh/84wTq8cHR8rnKEDTQkgii8lmL+FMiNgfzFLRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gVdS3aKNaUOSU0Pnfksx2ESQI5SfeDcqiJMBzYuTrs=;
 b=adS7/aO/jKgKmIudYy2cL7f8UpVKI9JwSA09WhvUb9R74yShqx6ul0ny4Qe+ruqSE07LSHOcAIm6NNX1LS8JhzsmqtbNWfFhvvXSLTTarpNbOD9HC/chmwgbPXbcSUZ4USPMQKT4YSLGQM2XiNfwaGfCBjaKIlPWJqCT6oz3NkW7yqHFOoIO4xDR9WfHfqMMDZOYileYXr9tTnjwBM4xrgC/ldEowWLLRaKfwjjeYs3WM1YESUHfJbfecGD76LuNZ0Gdr5WKF66bC6KvmtBjb2k5uJM3b9h6c5Vrn36mGttlxGMl0+l/cDvZm+LASLlVDR72GtOb7iJzm/DqZYQ2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gVdS3aKNaUOSU0Pnfksx2ESQI5SfeDcqiJMBzYuTrs=;
 b=LrGUt69LnHRkxopMNsKR/ipaFs8Ei4RsSN3RhtcWjApAbidwWWVuxvI3NuxGNUSZyPCn+RiSbcPVZUMsvN9NrzdBNMGj1NBSdHsVt38V417u4Id35RsD/cOFiEuXS8WQsVBTKiSQxMKIr/Ik0ve2BXwZ2uS/vj1bnVpxSJS+re8=
Received: from BN8PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:94::48)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 08:45:31 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::d5) by BN8PR03CA0035.outlook.office365.com
 (2603:10b6:408:94::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Fri,
 22 Nov 2024 08:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Fri, 22 Nov 2024 08:45:31 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 02:45:23 -0600
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
	<swapnil.sapkal@amd.com>
Subject: [PATCH v2 0/6] perf sched: Introduce stats tool
Date: Fri, 22 Nov 2024 08:44:46 +0000
Message-ID: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: dcef6b80-a3ce-424f-2aca-08dd0ad205e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hm+TmkrlawDA88kczysnXlgou+GmN0kyhGrbXdmS2X2TCcO2Qg9tnxyrv+5r?=
 =?us-ascii?Q?xQ+iR9AVeQHMSq/hJPSkM4Y1LyyGkULunJF93ul9FegQ612G3vkjChMolSJj?=
 =?us-ascii?Q?H/eNPNxCcPaSLvfNAUmekS/yi8fJD4a/pqy2V2Novv6ZCKcpERmbLeeIukgH?=
 =?us-ascii?Q?GHqX75X7pRconwmiZnoJVjww23Cgr8v5OEZDqkDLrqTRH4aeD8aCMMA03q1o?=
 =?us-ascii?Q?FM7sw+5Oe2LHCQX/ioO3x/+iXckiNl3R3joNsf6pnSWJWFsAe58Iy6ywwP9A?=
 =?us-ascii?Q?bp6eUJsqb7F04aG7qD0+NyOB3frf6hjAKuIrBbsOgm7e4u6Zn4SbfSN+hptM?=
 =?us-ascii?Q?ErtPEp/AOKIemkdlBZieeOw4iGIjHTbOzm6yBJID4OD9Iz+j3o9j+PuhvsZz?=
 =?us-ascii?Q?5r+0lbo3d5d5vrXHsUCCyBgkPyvtCwJACcAk9dEv7uEzmlthrK9sGg/7sxVZ?=
 =?us-ascii?Q?F0MEKtnCcp/wWFyw1k02FmxgZ2k+Yk1VZx5HyupGtEBlCKjJZP4uRIVCLnH8?=
 =?us-ascii?Q?1rDVuWPxrKCf48xn/0FTCSc+HaCWJ9PweZJKNWPinJykOGvIlOy0uHRKzucp?=
 =?us-ascii?Q?PFAMam0KpYtcUokyHKP/6BODFU31nO6QLiFd3QohvaCvGHQg3MkppeOsQlH3?=
 =?us-ascii?Q?aoLDqWFNye3EWArGeCRgmykjXp7270CL6zluwBuxsNJ6M63qZ/Ns4VGiXGDY?=
 =?us-ascii?Q?qDuuElK4Itp6Mq8EmsC+vQiglB9kJwslZ3WofAGcqaUrT9nGd43bGshR14WL?=
 =?us-ascii?Q?/9VBkZy2D9Lm/RHyfaSe6giZtw4VJ3IRqc3DKDLDZs3tDzI9lKZoTFstFUsj?=
 =?us-ascii?Q?W740ekm8gEjyS990FH3kiGvBHjo1nzX9VHFBm34hN5qvmMYMUGIvaHUj7PRV?=
 =?us-ascii?Q?eApay0yrfLjlUouook/WyoMycBQV7pF0U9LwjUUWhQrH/z/KTMZcGb+dXaj/?=
 =?us-ascii?Q?m/FwASbBTXsc9NLLQHzBHGbo6xu5wlv/KmllsxWVjT+FNLUI6kZzNrRWR7XI?=
 =?us-ascii?Q?OFjiNIMIUzujgQG2ChT/WXmTttnpr5h9/FNQc2JJPKbeX4S+qE2HGSnYK6VJ?=
 =?us-ascii?Q?jgTGZz9g+bGY8ajrrkeZYwe42s8IJ6KKfoWseMZycXa97wukmU8JFlVzOJN0?=
 =?us-ascii?Q?QgfftJLZOj+nFzjzcVa7GPoSx3qvlcQx3htlLpEuRlCF8gS+JHCo7pfhvOFQ?=
 =?us-ascii?Q?tmtC2WKvikadRk9gLFhBBg7nMJ5ZUSfi48KUUOOsf0RqlHzbouSyUPvP8Td0?=
 =?us-ascii?Q?sQQyTb5bwNX59g45SI7AoQjt8nb9uIncu26bLCTy/ibVc8wC8w6blR7NWTzp?=
 =?us-ascii?Q?gTZNktsyuZmlPi8k2fz0YoRCU75Yo8jlYIB4KU0gck9gucZjDaMOs2V3ahH1?=
 =?us-ascii?Q?Rqg4sGw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:45:31.3840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcef6b80-a3ce-424f-2aca-08dd0ad205e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

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
  CPU 0
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
  CPU 0, DOMAIN SMT CPUS <0, 64>
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
 - Add perf unit tests to test basic sched stats functionalities
 - Describe new tool, it's usage and interpretation of report data in the
   perf-sched man page.
 - perf sched stats records /proc/schedstat which is a CPU and domain
   level scheduler statistic. We are planning to add taskstat tool which
   reads task stats from procfs and generate scheduler statistic report
   at task granularity. this will probably a standalone tool, something
   like `perf sched taskstat record/report`.
 - Except pre-processor related checkpatch warnings, we have addressed
   most of the other possible warnings.

Patches are prepared on v6.12 (adc218676eef).

[1] https://youtu.be/lg-9aG2ajA0?t=283
[2] https://github.com/AMDESE/sched-scoreboard
[3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/


K Prateek Nayak (1):
  sched/stats: Print domain name in /proc/schedstat

Swapnil Sapkal (5):
  perf sched stats: Add record and rawdump support
  perf sched stats: Add schedstat v16 support
  perf sched stats: Add support for report subcommand
  perf sched stats: Add support for live mode
  perf sched stats: Add support for diff subcommand

 Documentation/scheduler/sched-stats.rst     |   8 +-
 kernel/sched/stats.c                        |   6 +-
 tools/lib/perf/Documentation/libperf.txt    |   2 +
 tools/lib/perf/Makefile                     |   2 +-
 tools/lib/perf/include/perf/event.h         |  56 ++
 tools/lib/perf/include/perf/schedstat-v15.h | 142 +++
 tools/lib/perf/include/perf/schedstat-v16.h | 143 +++
 tools/perf/builtin-inject.c                 |   2 +
 tools/perf/builtin-sched.c                  | 965 +++++++++++++++++++-
 tools/perf/util/event.c                     | 104 +++
 tools/perf/util/event.h                     |   2 +
 tools/perf/util/session.c                   |  20 +
 tools/perf/util/synthetic-events.c          | 256 ++++++
 tools/perf/util/synthetic-events.h          |   3 +
 tools/perf/util/tool.c                      |  20 +
 tools/perf/util/tool.h                      |   4 +-
 16 files changed, 1729 insertions(+), 6 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h

-- 
2.43.0

