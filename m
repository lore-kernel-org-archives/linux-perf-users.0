Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30178F6C;
	Wed,  8 May 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148317; cv=fail; b=gjRg9xo96yUsiHmFZisPG/kTC5snZ1XAz2U2oXoWGzSmd0OjUz7wqUew7J5moesGAxKbaEhGhw+2SGzHxbwYQEeVZzuUZiv1KLu3WljPZNLasA+aeTTWFZMAbs/zKrFqRcz1L6Mxp2RCvpOvyYqw2frDmP+NXC51zEIciZDoHQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148317; c=relaxed/simple;
	bh=wPhXF7skefc8X9vDixMFyySGivvf3my21MmPPtUDjXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDEsYaAxPpc9cn/NHmXCE336l40xamDZ/Yw8o9wNgVu8aQLoEhv/qWp7dQWY0Sbw7cjOgYnRDSLDPRJHewc4dVeJ/ycdqNLGrxIDFYpTJwXHWObGJcGder++YH8UzA5x9bYLdx3KO88OSKvzzdUS1b/ymuEf/9UR2Ap7GPMn66o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f3dahVhZ; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f3dahVhZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONw99BYBzEdM9T5WkEC+KYuHT3G+eY9zZGJ2CqIxNZcaKNfF27JwCuouF3sPkfmqmzeD1J5ibB99/jsjtsbbbwOXAJnqFcJfp+ayy7FPLCf0GnjbCCX4Pav4OoaLqhh9XhZDbDyeDa4tO0bsdtk7WBOplPkOR8xyf2m/rcUDExgaFSz5QeYuJ0P1/B3kBjUZtDoWPDFtXWtFgNZAorjtHAFjC+nhbXn6dB6ChJe2NBag0qOGCzJ3VR6gAI9l1Gn+onIYuC3L9kWMKDiPRaoAt05lGmGwx36hL1quk1EIbe2Y7hzy0AOrUMrAY63HQbIbDSNJKgQ5zL4wnKJBnDBOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8f5X8FtvfVxZDXv9Rh+iJnMydg0QLg2mZO6LudGjCo=;
 b=gcwtIfL1SfUsirt+RlCeQ2ax5lXurJHm3aphC0nXNmozzCewc0QnK4jJH9EjkNbPAOPBzxgFbKtqm/U9fRE+HRB5oeETCPGXhtfjn+VXksHV9WxjPyEDufZYaipVHQEuo1HM9H8ntPp2BCOtJurDEfxHkVE1L0wrMhz+QX87Wr//8whFXbZfi+AXotH6Nvc/GOF+ijUpmP4PPIZZiLIHgcXI2eyaNSpnlYBSQ02gPDzbC2b/FKCaEgvKvu1MsYKeZgtFnRoTxvYr0TBjx3UA2B/6Q0ITe19I5RXfqX3mQeUpOf10sQSMLayETzG88591hDhomintZm1Fva2iWQjOuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8f5X8FtvfVxZDXv9Rh+iJnMydg0QLg2mZO6LudGjCo=;
 b=f3dahVhZKUD6FcBIix7GF4sz0FjzJHLMuIz7h479yp/Oi6Mm3o8MLPggBYY2SxzRScdI0YbJUfEuvqpxrIQjpNLU60akpfVJiyNOoxsqo9gn31rQW/2Gg3JXFjknH/zlC9kM3PdqgUXhOoLPWwzPZM2Q6qZihTrtLhN1qZlP0GI=
Received: from DS7PR05CA0075.namprd05.prod.outlook.com (2603:10b6:8:57::16) by
 PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Wed, 8 May
 2024 06:05:10 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::5d) by DS7PR05CA0075.outlook.office365.com
 (2603:10b6:8:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 06:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 06:05:09 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 01:04:58 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>, <bristot@redhat.com>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [RFC 0/4] perf sched: Introduce schedstat tool
Date: Wed, 8 May 2024 11:34:23 +0530
Message-ID: <20240508060427.417-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 0595ab1e-d484-4f9c-9962-08dc6f24d140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8LNWuTEUcoIou7/CtjeptHCTeBiCTOG0r7qBvH+eWVOwSaOXPGOPBvxl55bn?=
 =?us-ascii?Q?ZofuMVVihe06wrvMVdGa+yAjCY7zjMOf1QggpeUUzA07sW/gp+H9WEbVtxLz?=
 =?us-ascii?Q?0fMarcUPuJRaof9oKiUaUuCZNsRsdYoLkWPs10kZ40VKJ4yiKZ1vHr5Xun2h?=
 =?us-ascii?Q?IumuJW5FtUQxAh7E4xuvigF/j5oCMKjwvj8lgYlJmH35SSSiDAMApbY3rVvg?=
 =?us-ascii?Q?hWO8DMN2UKbl34BcFUZDdo5KPL6XwNgn7MFJVPzUFHnT2Q1eOlsAzEwAzXAF?=
 =?us-ascii?Q?xwCj0XMBGZzb2mUUP3FwZ0qAIv2fse+ErXIgs6JeCu24j6SoQls7P8c25SRv?=
 =?us-ascii?Q?Vi6Vt0shjh9Cg7ObjLv+o+hQ87lEr1bEDeIqM3A4/AsLXnqBq8GWowBtVMzp?=
 =?us-ascii?Q?zXDVMPIUJ8VOSqlPaWrBUSRIgEg9CM3DKOzhWfxeV/m/WP0nl15CMZHlOHGJ?=
 =?us-ascii?Q?2zvG2++11aZsCp3ITzmUH4rDS6x/dYsNAYoPMHIKbJI2YR3eb5dTbeW4dny6?=
 =?us-ascii?Q?d2Aaj2wGz2u6F/kHsv3UgjHXh7Vbw00gqURfhZHFAEPoXiHvetJJMe1iE0WD?=
 =?us-ascii?Q?khiLhtFCExI1iuFGA2Eih2HKASh++LBAN7BuFO6ppfP2wnpaETv468yzS40N?=
 =?us-ascii?Q?hhuIss+kyNq0epbp3yIKWQOhGCAAspR2d1+a1cpTcQXWqelJNsqKVeNQTsc0?=
 =?us-ascii?Q?dhZ+9k4niT0sJrvd15xf9RllXgdnlW7lX+ixt1dzBmb34d4L4dt5AjjZgLMe?=
 =?us-ascii?Q?SNsKo44HcjmDfGsE86oHU9bgI/mfNdGRX1EBNZjTJCfMgI+Ghys3hYROW5dc?=
 =?us-ascii?Q?/76pQL1TvxixgwvicoRJTt5FBqsHlbe+J1fu+uIfJnblZQi8kvw5+FIdJMO2?=
 =?us-ascii?Q?eS6SGPp0ZNunukB1gRFDXv3jS7w7fQi2KVmowqqN4xYcCPQ8v/Z7CpCPdQvB?=
 =?us-ascii?Q?Oqojw1QAiY2f6x3XTT24RwNP4SFV/n/EeMhYY438QVDtZP5JWlbVWlr4nOQ1?=
 =?us-ascii?Q?MEczNP1f2NOkfnnUIGdtRUkC6ZRCTrsVfsJWkUeJT7EwsagHNgETnTgaTGc2?=
 =?us-ascii?Q?fsZSqojeEoHAx0m5tPJ9iWNcqaFdrOgQxwDSw4VcoXr9uqcqrDLKQ8h6FC4C?=
 =?us-ascii?Q?kzecdkgu0LTszj+xjImpVec/ClDZh2CECqHY5S7a+IkxRfeKKqQvuauAmGVE?=
 =?us-ascii?Q?DymMFKuq6hzYJ9Un530cq0vVgeby5SaUxOW7X+JdB5uRI6NZGHKGj8owFwsq?=
 =?us-ascii?Q?bSMNz2yVyM5ffmkQsOMVNFoNE0eI8OTHg8OpZyXAd3h2l+HUdtV7BZRVHtE4?=
 =?us-ascii?Q?bfbMrFYTZ5KMX49ThckEcrip/4PYC2WnyGu/8SCi+lavFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 06:05:09.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0595ab1e-d484-4f9c-9962-08dc6f24d140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

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
and generates samples on a tracepoint hit, `perf sched schedstat record`
takes snapshot of the /proc/schedstat file before and after the workload,
i.e. there is zero interference on workload run. Also, it takes very
minimal time to parse /proc/schedstat, convert it into perf samples and
save those samples into perf.data file. Result perf.data file is much
smaller. So, overall `perf sched schedstat record` is much more light-
weight compare to `perf sched record`.

We, internally at AMD, have been using this (a variant of this, known as
"sched-scoreboard"[2]) and found it to be very useful to analyse impact
of any scheduler code changes[3][4].

Please note that, this is not a replacement of perf sched record/report.
The intended users of the new tool are scheduler developers, not regular
users.

USAGE
-----

  # perf sched schedstat record
  # perf sched schedstat report

Note: Although perf schedstat tool supports workload profiling syntax
(i.e. -- <workload> ), the recorded profile is still systemwide since
the /proc/schedstat is a systemwide file.

HOW TO INTERPRET THE REPORT
---------------------------

The schedstat report starts with total time profiling was active in
terms of jiffies:

  ----------------------------------------------------------------------------------------------------
  Time elapsed (in jiffies)                                  :       24537
  ----------------------------------------------------------------------------------------------------

Next is cpu scheduling statistics. These are simple diffs of
/proc/schedstat cpu lines along with description. The report also
prints % relative to base stat.

In the example below, schedule() left the cpu0 idle 98.19% of the time.
16.54% of total try_to_wake_up() was to wakeup local cpu. And, the total
waittime by tasks on cpu0 is 0.49% of the total runtime by tasks on the
same cpu.

  ----------------------------------------------------------------------------------------------------
  cpu:  cpu0
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
                        idling cpu by some other cpu.
  2) Busy Load Balance: Load balancing performed when the cpu was busy.
  3) New Idle Balance : Load balancing performed when a cpu just became
                        idle.

Under each of these three categories, schedstat report provides
different load balancing statistics. Along with direct stats, the
report also contains derived metrics prefixed with *. Example:

  ----------------------------------------------------------------------------------------------------
  CPU 0 DOMAIN 0
  ----------------------------------------------------------------------------------------------------
  ------------------------------------------<Category idle>-------------------------------------------
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
  ------------------------------------------<Category busy>-------------------------------------------
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
  -----------------------------------------<Category newidle>-----------------------------------------
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

Next is active_load_balance() stats. alb did not trigger while I ran
a workload so it's all 0s.

  ----------------------------------<Category active_load_balance()>----------------------------------
  active_load_balance() count                                      :           0
  active_load_balance() move task failed                           :           0
  active_load_balance() successfully moved a task                  :           0
  ----------------------------------------------------------------------------------------------------

Next are sched_balance_exec() and sched_balance_fork() stats. They are
not used but we kept it in RFC just for legacy purpose. Unless opposed,
we plan to remove them in next revision.

Next is wakeup statistics. For every domain, the report also shows
task-wakeup statistics. Example:

  --------------------------------------------<Wakeup Info>-------------------------------------------
  try_to_wake_up() awoke a task that last ran on a diff cpu       :       12070
  try_to_wake_up() moved task because cache-cold on own cpu       :        3324
  try_to_wake_up() started passive balancing                      :           0
  ----------------------------------------------------------------------------------------------------

Same set of stats are reported for each cpu and each domain level.


TODO:
 - This RFC series supports v15 layout of /proc/schedstat but v16 layout
   is already being pushed upstream. We are planning to include v16 as
   well in the next revision.
 - Currently schedstat tool provides statistics of only one run but we
   are planning to add `perf sched schedstat diff` which can compare
   the data of two different runs (possibly good and bad) and highlight
   where scheduler decisions are impacting workload performance.
 - perf sched schedstat records /proc/schedstat which is a cpu and domain
   level scheduler statistic. We are planning to add taskstat tool which
   reads task stats from procfs and generate scheduler statistic report
   at task granularity. this will probably a standalone tool, something
   like `perf sched taskstat record/report`.
 - /proc/schedstat shows cpumask in domain line to indicate a group of
   cpus that belong to the domain. Since we are not using domain<->cpumask
   data anywhere, we are not capturing it as part of perf sample. But we
   are planning to include it in the next revision.
 - We have tested the patch only on AMD machines, not on other platforms.
 - Some of the perf related features can be added to the schedstat sub-
   command as well: for ex, pipemode, -p <pid> option to profile running
   process etc. We are not planning to add TUI support however.
 - Code changes are for RFC and thus not optimal. Some of the places
   where code changes are not required for RFC are marked as /* FIXME */.
 - Documenting details about schedstat tool in perf-sched man page will
   also be done in next revision.
 - Checkpatch warnings are ignored for now.

Patches are prepared on perf-tools-next/perf-tools-next (37862d6fdced).
Although all changes are in tools/perf/, kernel is important since it's
using v15 of /proc/schedstat.

[1] https://youtu.be/lg-9aG2ajA0?t=283
[2] https://github.com/AMDESE/sched-scoreboard
[3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/

Ravi Bangoria (2):
  perf sched: Make `struct perf_sched sched` a global variable
  perf sched: Add template code for schedstat subcommand

Swapnil Sapkal (2):
  perf sched schedstat: Add record and rawdump support
  perf sched schedstat: Add support for report subcommand

 tools/lib/perf/Documentation/libperf.txt      |   2 +
 tools/lib/perf/Makefile                       |   2 +-
 tools/lib/perf/include/perf/event.h           |  37 ++
 .../lib/perf/include/perf/schedstat-cpu-v15.h |  22 +
 .../perf/include/perf/schedstat-domain-v15.h  | 121 ++++
 tools/perf/builtin-inject.c                   |   2 +
 tools/perf/builtin-sched.c                    | 558 ++++++++++++++++--
 tools/perf/util/event.c                       |  54 ++
 tools/perf/util/event.h                       |   2 +
 tools/perf/util/session.c                     |  44 ++
 tools/perf/util/synthetic-events.c            | 170 ++++++
 tools/perf/util/synthetic-events.h            |   4 +
 tools/perf/util/tool.h                        |   4 +-
 13 files changed, 965 insertions(+), 57 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v15.h

-- 
2.44.0

