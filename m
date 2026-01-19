Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD75328B7B;
	Mon, 19 Jan 2026 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845557; cv=fail; b=XwKLaG4B+TnBFOwOVwHRl2OqjWT5JrGd7Y+0zzKy+4nhIDcwUwR486K43QSB7BmcynFNkH8G+whf3tr2dr0ecM2xt947VtDD1NNnfPZu08CCWYMn0NHhaAD02oqetapRmaajocavUt2ixCe56pVngIe06LjQtfpCIT39rfki6Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845557; c=relaxed/simple;
	bh=RbVDKE95RQjp7bNvSOqpLgiIn3ORMhYbNSKCExcPIjA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APdFrnOWhVATU5SnCSusw8XeRhmAv1dNb5KvU0ApBujELA2hixxElRxQr16TIISHxz+YdhhqhImRuQjmNkliGrGYAknzIy8kJ/S4BfuXKw5MX29HD41BcRHqTdFmOR1o1b6FVzCHjffVRJXxjOvs3Rq8/B5F2dUUhiZqK3tMMVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vtGe2Kaa; arc=fail smtp.client-ip=40.107.208.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vtGe2Kaa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BoBWaOnMB13+UoiRDl8rLIm70iy7MCQH54hxzoAkO19+4XgK+H+pQcd4VVMb/oBqoXOfKjJsKv1oO9sjB0KGNXhgoSt3I5Msx/bBSp4YshBZFpttaHGZRzUfbFQmz0ylUIXW/iGXoOaDim89KsCprSg9zIiOVartpgPxgv9ntMCFC1gX+/+14pOKHb28ql+Njv7R65eVbZePl+R+xYvkFD0vXk4+xeLPlCkWBHrUCOEr07ZGY8BlrBG+LEbvNFC+vjxRGbg6zaZe5YMy7buufZqhmTVWAZUl35wkiMy5ikzBU4Mz+L4nsX2m/nOMeJmo13kaEdvYpK0P9YVNwVvSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBYui7cgVMIiO84/RHBH6Nr3h4sGLScOifz7iy1v+p8=;
 b=o3Z2rGfnsGpWlZ1xRnj0ywZe/iWZBcuc/9Jy2ZiVXlHbkOx51WNDwimDpaRjqryLmTcAuBLrh1TcdRaUcof+i9/H0Z6T9cPjTXNaCr5AZooEWDLMBJrNXSxS57efMNKUgzpyWq4ig8NyXOXeqMHXIMG1Hx3c3apV74oUe3u+GYj+8yJx57JtMjQXC7qRTpAgxv4AxYVxnpLUwZ+ZBx65+DwuY+Lk2aM3WSG7L3ALeR9EdLZiMg9TJtVO2nTndael7OyPlfz1Ilz0ZI+qjyZArao6+4sojtkLvORCEmIGsP6iR/pxZaSBlDx3DjnaI6Fks/P+qa5vLnNxMK/5DsdT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBYui7cgVMIiO84/RHBH6Nr3h4sGLScOifz7iy1v+p8=;
 b=vtGe2KaaNLse27waBdmwyUiyiRdyChKwwbxCCbKSkA/BZ7t3fShnTqc7PHofyS/L46AuM0P2t5qmnIjYMGzWlKWExenMvUnf5F11lK/TwUz/JEGWPGXyM2Ua4DgCsEDehTMK6v008308Cl4/YUPrC2AsIkeH1HhG/T8x4DYW+uI=
Received: from IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::17)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 19 Jan
 2026 17:59:11 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:559:cafe::6e) by IA4P221CA0007.outlook.office365.com
 (2603:10b6:208:559::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 17:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 17:59:10 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 11:58:59 -0600
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
Subject: [PATCH v5 00/10] perf sched: Introduce stats tool
Date: Mon, 19 Jan 2026 17:58:22 +0000
Message-ID: <20260119175833.340369-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: b425b26a-818c-4371-0bef-08de57847297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RpQWyB5urq8kxiANpTGy1X9qWIir5nAkZVjMrgxpS8lETxTePAYRb9MUkbB?=
 =?us-ascii?Q?py/aPjp+gTsF9sOoPP8ea0KLf1PU8anuYE/MkpeZJo8vWkudREUVw7lRAom9?=
 =?us-ascii?Q?AxaUXnr3ItM0WiLu+4Q0vh80GdnulqUquAEiiHqzFfSUPX5KJAnYJv0YjbwY?=
 =?us-ascii?Q?MQtQel2PlgY9aErVnxs60WTgQ5As3l8Xs2e/5+CDZLvHMN/tOdkhMcemvbbG?=
 =?us-ascii?Q?VJiS2+yFJZh0Q54nm1aPtB6lotUhO5u+aWTlbvoBnjdcMEZyS6uzhPvlAJK6?=
 =?us-ascii?Q?IqHsHyr/NT2E5FyaoVzZmwsY1X6Pq8KUCkDyB0azqsbkOBJULNOvJdOw2yTa?=
 =?us-ascii?Q?PP1EIOvzQZnUaKikfFjji4Qz49fNpiw7G/JeuGowq2Q+iZ7wjMK9agLk/n2m?=
 =?us-ascii?Q?wr2RgjsEZUMj0CiBLRJtH7Y/YCUI59zT7oRstFD/byaVU/mB/adzbWasaOho?=
 =?us-ascii?Q?8aTErr9jCY5sI7Qml58Zs4tIUN3pbV9kgKcnc5ZhDajVEyIvKFVYoPYs3VgE?=
 =?us-ascii?Q?pzKePPcFXeFukFLq6OE72e2WJtwBUDovkk3L/QDeMElvxQuSPoa2JysBGHUP?=
 =?us-ascii?Q?FFqR7kaiJbdZT/y+MEmFDNVeHQMXsmrV7g4bbrU7PxUHsP2nb1CLi5Y9LmbT?=
 =?us-ascii?Q?B7l+l4EjEX+LFMsNSEDPPKxGwW4WvlmP+F4/fhXDIlHU50lWaBUbWy4Fr0r0?=
 =?us-ascii?Q?HQvlGcjsJPVYn9ZCyGtVkdjaRC3VS7ddzeqqgHsAWZDCtiwkbw6+NbzPD+rV?=
 =?us-ascii?Q?MCT+S9SrPy6PjimfjZQh72aB0QJ5h00gzzpNvzFSSfeeMUw+g3yb9Ia6wCyz?=
 =?us-ascii?Q?wT0P2AGvSV/0wXDX9xJV/HVh72uwt4+lPB3RDNj8ThdoYA2ID4wb7TEyKWED?=
 =?us-ascii?Q?FKY528YvTQxgCWAzYQ3Ix1fvp7mNo3ptnEnc9Kwvdlg2toHyu7zmlT8Dm5ln?=
 =?us-ascii?Q?AxmujzgzYs7ZKDw3iNRV9bNrBVNmeUQyVsaunKhypaZwNB/2XHHqqyWT40bM?=
 =?us-ascii?Q?0iLlUEfqMvyEH8mNEb7y6JIdBd7CpXobBu2gLAsb3mozj1ay/VI2fbiHjeC7?=
 =?us-ascii?Q?eO5605BWyugCutFEkzhDd17izW2RzajnxPggQ/U0acrAhfM/CLJpJFDVcdfm?=
 =?us-ascii?Q?4SXyTSb9pjHgE3kymrmz2xUq6L1UXHvE5DQvav6xYTJFkzI13de49u4i/dTV?=
 =?us-ascii?Q?742Iz9KZoly7Sz8jCfjBuDa047kkCDkEOAgG8B/NrjZvbC4lgr6rABQIpWkZ?=
 =?us-ascii?Q?Xail5RL+NRBZeSHKYIfqzvHOGxiKJN7VPqBMls+OCKwnJu/e98y+H9ZzPrFN?=
 =?us-ascii?Q?xLR6hvBEAlZdQ4EC4G3V9OujDXViaxdHgZsJNXX8dz67vGj39TYYWj1syI4L?=
 =?us-ascii?Q?CWjIETC3VUQXm1qesHhDgK2l/z3d5NDM/AMzkhaMgfpoTMBJ8/gp9BurCuIu?=
 =?us-ascii?Q?YKatCIf4VRPAw0embd+kbLKgnoOnqRWfdNlGXRcdFP/Or1NV9Lj/8JXx8xCw?=
 =?us-ascii?Q?CujqWFc2DMvUUoJM+QuElVrhSQOEmjZIVQqQm+0KT2Z/KVCbfrsf57nUUFgr?=
 =?us-ascii?Q?WAiQnpMGKYzv209SFCFgGQMO9deYafjIJH8EEGgc0vhbfokb5le0Gs5wCwcr?=
 =?us-ascii?Q?k7+HOkb1GBzFFLuiKpuGZG95gT/hBgkrfR51rXD8GQLO0lw8Mtrg0urWbYYc?=
 =?us-ascii?Q?6xT5IQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:59:10.2630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b425b26a-818c-4371-0bef-08de57847297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

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
present in the report. These column names are given before cpu and
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

In the example below, schedule() left the CPU0 idle 36.58% of the time.
0.45% of total try_to_wake_up() was to wakeup local CPU. And, the total
waittime by tasks on CPU0 is 48.70% of the total runtime by tasks on the
same CPU.

  ----------------------------------------------------------------------------------------------------
  CPU 0
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT   PCT_CHANGE
  ----------------------------------------------------------------------------------------------------
  yld_count                                                        :           0
  array_exp                                                        :           0
  sched_count                                                      :      402267
  sched_goidle                                                     :      147161  (    36.58% )
  ttwu_count                                                       :      236309
  ttwu_local                                                       :        1062  (     0.45% )
  rq_cpu_time                                                      :  7083791148
  run_delay                                                        :  3449973971  (    48.70% )
  pcount                                                           :      255035
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
  CPU: 0 | DOMAIN: SMT | DOMAIN_CPUS: 0,64
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT    AVG_JIFFIES
  ----------------------------------------- <Category busy> ------------------------------------------
  busy_lb_count                                                    :         136  $       17.08 $
  busy_lb_balanced                                                 :         131  $       17.73 $
  busy_lb_failed                                                   :           0  $        0.00 $
  busy_lb_imbalance_load                                           :          58
  busy_lb_imbalance_util                                           :           0
  busy_lb_imbalance_task                                           :           0
  busy_lb_imbalance_misfit                                         :           0
  busy_lb_gained                                                   :           7
  busy_lb_hot_gained                                               :           0
  busy_lb_nobusyq                                                  :           2  $     1161.50 $
  busy_lb_nobusyg                                                  :         129  $       18.01 $
  *busy_lb_success_count                                           :           5
  *busy_lb_avg_pulled                                              :        1.40
  ----------------------------------------- <Category idle> ------------------------------------------
  idle_lb_count                                                    :         449  $        5.17 $
  idle_lb_balanced                                                 :         382  $        6.08 $
  idle_lb_failed                                                   :           3  $      774.33 $
  idle_lb_imbalance_load                                           :           0
  idle_lb_imbalance_util                                           :           0
  idle_lb_imbalance_task                                           :          71
  idle_lb_imbalance_misfit                                         :           0
  idle_lb_gained                                                   :          67
  idle_lb_hot_gained                                               :           0
  idle_lb_nobusyq                                                  :           0  $        0.00 $
  idle_lb_nobusyg                                                  :         382  $        6.08 $
  *idle_lb_success_count                                           :          64
  *idle_lb_avg_pulled                                              :        1.05
  ---------------------------------------- <Category newidle> ----------------------------------------
  newidle_lb_count                                                 :       30471  $        0.08 $
  newidle_lb_balanced                                              :       28490  $        0.08 $
  newidle_lb_failed                                                :         633  $        3.67 $
  newidle_lb_imbalance_load                                        :           0
  newidle_lb_imbalance_util                                        :           0
  newidle_lb_imbalance_task                                        :        2040
  newidle_lb_imbalance_misfit                                      :           0
  newidle_lb_gained                                                :        1348
  newidle_lb_hot_gained                                            :           0
  newidle_lb_nobusyq                                               :           6  $      387.17 $
  newidle_lb_nobusyg                                               :       26634  $        0.09 $
  *newidle_lb_success_count                                        :        1348
  *newidle_lb_avg_pulled                                           :        1.00
  ----------------------------------------------------------------------------------------------------

Consider following line:

newidle_lb_balanced                                              :       28490  $        0.08 $

While profiling was active, the load-balancer found 28490 times the load
needs to be balanced on a newly idle CPU 0. Following value encapsulated
inside $ is average jiffies between two events (28490 / 24537 = 0.08).

Next are active_load_balance() stats. alb did not trigger while the
profiling was active, hence it's all 0s.


  --------------------------------- <Category active_load_balance()> ---------------------------------
  alb_count                                                        :           0
  alb_failed                                                       :           0
  alb_pushed                                                       :           0
  ----------------------------------------------------------------------------------------------------

Next are sched_balance_exec() and sched_balance_fork() stats. They are
not used but we kept it in RFC just for legacy purpose. Unless opposed,
we plan to remove them in next revision.

Next are wakeup statistics. For every domain, the report also shows
task-wakeup statistics. Example:

  ------------------------------------------ <Wakeup Info> -------------------------------------------
  ttwu_wake_remote                                                 :        1590
  ttwu_move_affine                                                 :          84
  ttwu_move_balance                                                :           0
  ----------------------------------------------------------------------------------------------------

Same set of stats are reported for each CPU and each domain level.

HOW TO INTERPRET THE DIFF
-------------------------

The `perf sched stats diff` will also start with explaining the columns
present in the diff. Then it will show the diff in time in terms of
jiffies. The order of the values depends on the order of input data
files. Example:

  ----------------------------------------------------------------------------------------------------
  Time elapsed (in jiffies)                                        :        2763,       2763
  ----------------------------------------------------------------------------------------------------

Below is the sample representing the difference in cpu and domain stats of
two runs. Here third column or the values enclosed in `|...|` shows the
percent change between the two. Second and fourth columns shows the
side-by-side representions of the corresponding fields from `perf sched
stats report`.

  ----------------------------------------------------------------------------------------------------
  CPU: <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
  ----------------------------------------------------------------------------------------------------
  yld_count                                                        :           0,          0  |     0.00>
  array_exp                                                        :           0,          0  |     0.00>
  sched_count                                                      :      528533,     412573  |   -21.94>
  sched_goidle                                                     :      193426,     146082  |   -24.48>
  ttwu_count                                                       :      313134,     385975  |    23.26>
  ttwu_local                                                       :        1126,       1282  |    13.85>
  rq_cpu_time                                                      :  8257200244, 8301250047  |     0.53>
  run_delay                                                        :  4728347053, 3997100703  |   -15.47>
  pcount                                                           :      335031,     266396  |   -20.49>
  ----------------------------------------------------------------------------------------------------

Below is the sample of domain stats diff:

  ----------------------------------------------------------------------------------------------------
  CPU: <ALL CPUS SUMMARY> | DOMAIN: SMT
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANG>
  ----------------------------------------- <Category busy> ------------------------------------------
  busy_lb_count                                                    :         122,         80  |   -34.43>
  busy_lb_balanced                                                 :         115,         76  |   -33.91>
  busy_lb_failed                                                   :           1,          3  |   200.00>
  busy_lb_imbalance_load                                           :          35,         49  |    40.00>
  busy_lb_imbalance_util                                           :           0,          0  |     0.00>
  busy_lb_imbalance_task                                           :           0,          0  |     0.00>
  busy_lb_imbalance_misfit                                         :           0,          0  |     0.00>
  busy_lb_gained                                                   :           7,          2  |   -71.43>
  busy_lb_hot_gained                                               :           0,          0  |     0.00>
  busy_lb_nobusyq                                                  :           0,          0  |     0.00>
  busy_lb_nobusyg                                                  :         115,         76  |   -33.91>
  *busy_lb_success_count                                           :           6,          1  |   -83.33>
  *busy_lb_avg_pulled                                              :        1.17,       2.00  |    71.43>
  ----------------------------------------- <Category idle> ------------------------------------------
  idle_lb_count                                                    :         568,        620  |     9.15>
  idle_lb_balanced                                                 :         462,        449  |    -2.81>
  idle_lb_failed                                                   :          11,         21  |    90.91>
  idle_lb_imbalance_load                                           :           0,          0  |     0.00>
  idle_lb_imbalance_util                                           :           0,          0  |     0.00>
  idle_lb_imbalance_task                                           :         115,        189  |    64.35>
  idle_lb_imbalance_misfit                                         :           0,          0  |     0.00>
  idle_lb_gained                                                   :         103,        169  |    64.08>
  idle_lb_hot_gained                                               :           0,          0  |     0.00>
  idle_lb_nobusyq                                                  :           0,          0  |     0.00>
  idle_lb_nobusyg                                                  :         462,        449  |    -2.81>
  *idle_lb_success_count                                           :          95,        150  |    57.89>
  *idle_lb_avg_pulled                                              :        1.08,       1.13  |     3.92>
  ---------------------------------------- <Category newidle> ----------------------------------------
  newidle_lb_count                                                 :       16961,       3155  |   -81.40>
  newidle_lb_balanced                                              :       15646,       2556  |   -83.66>
  newidle_lb_failed                                                :         397,        142  |   -64.23>
  newidle_lb_imbalance_load                                        :           0,          0  |     0.00>
  newidle_lb_imbalance_util                                        :           0,          0  |     0.00>
  newidle_lb_imbalance_task                                        :        1376,        655  |   -52.40>
  newidle_lb_imbalance_misfit                                      :           0,          0  |     0.00>
  newidle_lb_gained                                                :         917,        457  |   -50.16>
  newidle_lb_hot_gained                                            :           0,          0  |     0.00>
  newidle_lb_nobusyq                                               :           3,          1  |   -66.67>
  newidle_lb_nobusyg                                               :       14480,       2103  |   -85.48>
  *newidle_lb_success_count                                        :         918,        457  |   -50.22>
  *newidle_lb_avg_pulled                                           :        1.00,       1.00  |     0.11>
  --------------------------------- <Category active_load_balance()> ---------------------------------
  alb_count                                                        :           0,          1  |     0.00>
  alb_failed                                                       :           0,          0  |     0.00>
  alb_pushed                                                       :           0,          1  |     0.00>
  --------------------------------- <Category sched_balance_exec()> ----------------------------------
  sbe_count                                                        :           0,          0  |     0.00>
  sbe_balanced                                                     :           0,          0  |     0.00>
  sbe_pushed                                                       :           0,          0  |     0.00>
  --------------------------------- <Category sched_balance_fork()> ----------------------------------
  sbf_count                                                        :           0,          0  |     0.00>
  sbf_balanced                                                     :           0,          0  |     0.00>
  sbf_pushed                                                       :           0,          0  |     0.00>
  ------------------------------------------ <Wakeup Info> -------------------------------------------
  ttwu_wake_remote                                                 :        2031,       2914  |    43.48>
  ttwu_move_affine                                                 :          73,        124  |    69.86>
  ttwu_move_balance                                                :           0,          0  |     0.00>
  ----------------------------------------------------------------------------------------------------

v4: https://lore.kernel.org/lkml/20250909114227.58802-1-swapnil.sapkal@amd.com/
v4->v5:
 - Address review comments from v4 [Namhyung Kim]
 - Resolve the issue reported by kernel test rebot
 - Debug and resolve issue reported in the perf sched stats diff [Prateek]
 - Rebase on top of perf-tools-next(571d29baa07e)

v3: https://lore.kernel.org/all/20250311120230.61774-1-swapnil.sapkal@amd.com/
v3->v4:
 - All the review comments from v3 are addressed [Namhyung Kim].
 - Print short names instead of field descripion in the report [Peter Zijlstra]
 - Fix the double free issue [Cristian Prundeanu]
 - Documentation update related to `perf sched stats diff` [Chen yu]
 - Bail out `perf sched stats diff` if perf.data files have different schedstat
   versions [Peter Zijlstra]

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
 - This version supports diff for two perf.data files captured for same
   schedstats version but the target is to show diff for multiple
   perf.data files. Plan is to support diff if perf.data files provided
   has different schedstat versions.

Patches are prepared on top of perf-tools-next(571d29baa07e).

[1] https://youtu.be/lg-9aG2ajA0?t=283
[2] https://github.com/AMDESE/sched-scoreboard
[3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/
[5] https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
[6] https://lore.kernel.org/lkml/3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com/
[7] https://lore.kernel.org/lkml/feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com/

Swapnil Sapkal (10):
  tools/lib: Add list_is_first()
  perf header: Support CPU DOMAIN relation info
  perf sched stats: Add record and rawdump support
  perf sched stats: Add schedstat v16 support
  perf sched stats: Add schedstat v17 support
  perf sched stats: Add support for report subcommand
  perf sched stats: Add support for live mode
  perf sched stats: Add support for diff subcommand
  perf sched stats: Add basic perf sched stats test
  perf sched stats: Add details in man page

 tools/include/linux/list.h                    |   10 +
 tools/lib/perf/Documentation/libperf.txt      |    2 +
 tools/lib/perf/Makefile                       |    1 +
 tools/lib/perf/include/perf/event.h           |   69 ++
 tools/lib/perf/include/perf/schedstat-v15.h   |  146 +++
 tools/lib/perf/include/perf/schedstat-v16.h   |  146 +++
 tools/lib/perf/include/perf/schedstat-v17.h   |  164 +++
 tools/perf/Documentation/perf-sched.txt       |  261 ++++-
 .../Documentation/perf.data-file-format.txt   |   17 +
 tools/perf/builtin-inject.c                   |    3 +
 tools/perf/builtin-sched.c                    | 1028 ++++++++++++++++-
 tools/perf/tests/shell/perf_sched_stats.sh    |   64 +
 tools/perf/util/env.c                         |   29 +
 tools/perf/util/env.h                         |   17 +
 tools/perf/util/event.c                       |   52 +
 tools/perf/util/event.h                       |    2 +
 tools/perf/util/header.c                      |  285 +++++
 tools/perf/util/header.h                      |    4 +
 tools/perf/util/session.c                     |   22 +
 tools/perf/util/synthetic-events.c            |  196 ++++
 tools/perf/util/synthetic-events.h            |    3 +
 tools/perf/util/tool.c                        |   20 +
 tools/perf/util/tool.h                        |    4 +-
 tools/perf/util/util.c                        |   48 +
 tools/perf/util/util.h                        |    5 +
 25 files changed, 2595 insertions(+), 3 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh

-- 
2.43.0

