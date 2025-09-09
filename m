Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588C3277A4;
	Tue,  9 Sep 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418214; cv=fail; b=PKUJQM91rEoi4obNd5htotlZY7VAhm3CERVpte0yAZYLQQj4hMt5xUiFVj9nyDmaFSWzc3KygdaFoQxIvSINEL/6PxO55kk92XWGjK8loBaT6KwOZXRaSPdfflrwgqa8tkH8zuYbtJ0uEWSBvZn2o7z10jMCrqKyxlaSuE+e04k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418214; c=relaxed/simple;
	bh=XFRQQWDTsFaYbRQxRr45TzEnlR+Z+0RgBS9kW1p9H/8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPPYiD3uJYn2xqC1nbQY8U5FAyT/tzjNnDmTM5Rq3fauYr+3kOov/OfN3dgRKci5oV6u5YATNEfbFRu43lxvhN3Blqizi8NDzzuskziXNdDcMyFdhguMXCcBp6aprQCH9nuNgV4EX5w6bWoBiUDwxBJSwKsOiD3mUzKZFsawtXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N5d0GWwX; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5d0GWwX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MY43edL0hAyFyN3CLn2RFL1Am2MB5fgUFotasGMObkuYVmg4srf35ICh9TDEg9c3wPCSDiyh3Z7hXApu1+6/5wLvLRsO4NM9ohsOeGvouCLT5a01A+VzHSVSqxK5G7vknld6aH7/Qxk+UzE+bsghpuRcK/tuvVLuHp8uB95kv68znrbePqkdPRneP5800XMuWNL+3+DSB8OVP5SiqfzfVJhYrl4AIgeC1IuyYcnGcpP9x7ew7IPGxrZXIvDpiaeA+EvQIoXSo/waf6EHhRBmHxuTmMTOIIxqwc79Ns1TmaKDYoSit9xmHPO5t7ue1V0/7etzZ/W9ewcrsHA5/dG82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UasofqCgPPeteAQV0h1YXQfF+aC70Ren+nRA+EbFtA=;
 b=vR/0sx7ZUKnoLdy2Qg9AWiMdvDIvnzJiY6DCWCjM2GeFrNNVPLMM4uLDZYhlHPbaQwOEzMBQiwPQq0x9XPIv0YGnPdh2LKsBF0xOr7KyH2+YFIkEH8IIROZHiufbfZEq3h2bk+JXx2Yy7lR+SZdVj9PHOfeK5PtP02xotgC1KBbUBIcuNVO+VWg82pg3CAMnJrPzlN8odDp+VefnzSxwNghE7JzHNyz8kay4ehaOnoQrSaQhfG4G2UIY6F0X3m9SSJQy0N5FeHFmO0Rpo4Nj7BMQTz0GFof7lsXFdbVrsEC55oSom/HIgHmKtJGh4ekj1DjCs0dInCKnyt7K9tdftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UasofqCgPPeteAQV0h1YXQfF+aC70Ren+nRA+EbFtA=;
 b=N5d0GWwXUxXPPZ7N94KzKe1vVHcnfVT+9eFSKWhwUA68dQtZ9knI6hr5C/qylHwLVqjEOdhwLGfgodM8XawZwmyWwvc3YxISGQ7wCvQZyh1WNs1x4UE1cVaBeV9e40h0ryzPhHfoEIJwdeeo4x9xO4rf0qWpKpZTCP/a6GvpsJc=
Received: from CH0PR03CA0428.namprd03.prod.outlook.com (2603:10b6:610:10e::23)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:43:27 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::7) by CH0PR03CA0428.outlook.office365.com
 (2603:10b6:610:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 11:43:26 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:43:14 -0700
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
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH RESEND v4 00/11] perf sched: Introduce stats tool
Date: Tue, 9 Sep 2025 11:42:16 +0000
Message-ID: <20250909114227.58802-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c3d6da-76d3-40d3-4f09-08ddef961737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzt4S0IbDs7HBJgEfREh0tixvvTjXYk/78hpHSPC1xE4MAlkj2xY21H/uZog?=
 =?us-ascii?Q?ZaugpSiVtgSBNd2zaGRkmrx6k3yRQgPK189CxkVp7tlhnCQSvlZ5/MflUw3X?=
 =?us-ascii?Q?hXc/W458aKxn1ms1udM2qyDvwqi9PeyF6HA9jdZAmU0W9tKulgl8U88NPbB+?=
 =?us-ascii?Q?z/PoYI5qYdAOoNnMr1aQBhbE4Sq/7CTAMP+tJzZEZ4ZtA30QuN6Qf30YoycP?=
 =?us-ascii?Q?xNuaOQtuO0puL0+s133Ddqiwc+oMWsxibE81GeVaTg6kgc02/m5RGEvKrdNM?=
 =?us-ascii?Q?r3ZD0Svn/WcjWSlXXMTPhvtsNCXDOSai70oms+1Oq9q8YQM9g3LKv+NpGlqr?=
 =?us-ascii?Q?aJy5OsDrVQkAdTRWimoJVbc4rXNgQu16TLEyCD3jREM4jl7H0AlACdjJ6qfL?=
 =?us-ascii?Q?1+yACTveswYInLbXaATsraAFmavsvFQxFrhJcLIRBC1znVmQdQMPem2zarkx?=
 =?us-ascii?Q?kzIyOpe0OsnYuhWOwzufc5F6Z2pBNkPfA5A0Jtq71eE+sIQVYFHskMpTNu46?=
 =?us-ascii?Q?JlhTGk9RZ2y6nbQPvJ21OlI0U2VpQM0urnQSlxCF5iLobU0KiAkDQMlizFMi?=
 =?us-ascii?Q?sQx6lOaxX8PAhyZWB5DxjtqKFAGqv1zOqXSjxIKcW26wv8ePJkzQb1eKwDC9?=
 =?us-ascii?Q?P0mePnKWkC4Jjuq03hl27NV2kKyhhfxUdno/Eu3uBYBvcrGdqmHf2ULj1BNz?=
 =?us-ascii?Q?GASjeOJrZb0oUKq+cMuFnfqMWP+DlIRy3MdOzin0Hu7mHOKZdJYz0rUHH5zW?=
 =?us-ascii?Q?t0NQyNN4fyRZxXh7fFVbid8QK391IEUubNv8UOwHtsgjzkmlaZYAxllwMsde?=
 =?us-ascii?Q?Dc5bbIz5aCPg+kFhCnUjPV0CxjgmkiBfXvmj1yIEV2F/QM+5amBG+wKy5UCX?=
 =?us-ascii?Q?8vovrF2snL47Q8KGmMWRwB55dhZZd4psHW8ivlUyZwOP1oMmnMhJbZNP8nxO?=
 =?us-ascii?Q?/qMXP1pexGdyb/8nTASN5naZyMxiWqBzzZU87U08eEk+gdp4gDgWmjogappd?=
 =?us-ascii?Q?h8yXM7hRTKZMEQIV11ke1vDWCQJJom/nEio0GLYxaXg8BxSPM5WUiKKatNaY?=
 =?us-ascii?Q?w2Z7VfsElk4Ds4SHQBArneTTfBzjGGFpqrtXo9XZE5czTYBEV/1tearN9dbF?=
 =?us-ascii?Q?LAD8vKyW9yEq93erU34TXkXtk3+NZS8YpkhVCDRIZzGLjqazEaUa3rrwO/9K?=
 =?us-ascii?Q?tf50Zv698N/Jcr366vmX3JYBimKUZ+xX1Wn8Y3xuFUKLJSOpuJiGzIGC3TOS?=
 =?us-ascii?Q?eVAsQF7GIWppxiU/DhAG8wSxFwlD4rZbe/NWdkZXZBHOIgPSH90ntyELLa/R?=
 =?us-ascii?Q?YPh8+4ZXWATFfC73BNtGlLthkMqCydRKooeqgZi4g34VxK1XTgh1D1m2/Zkw?=
 =?us-ascii?Q?Hhr/ZVeJFYjvbmBf7dy5J6PpsV6oVwSIq52YxsqEw1EkT/vjLzjj27E3un0+?=
 =?us-ascii?Q?QUasIbrl2j+veaRkmDni/uIHy51rJfa9qZYbhBztuFk2owzkwWZT+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:43:26.9576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c3d6da-76d3-40d3-4f09-08ddef961737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

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
  CPU 0, DOMAIN SMT CPUS 0,64
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
  CPU <ALL CPUS SUMMARY>
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
  CPU <ALL CPUS SUMMARY>, DOMAIN SMT
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

Patches are prepared on v6.17-rc5 (76eeb9b8de98).

[1] https://youtu.be/lg-9aG2ajA0?t=283
[2] https://github.com/AMDESE/sched-scoreboard
[3] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[4] https://lore.kernel.org/lkml/3e32bec6-5e59-c66a-7676-7d15df2c961c@amd.com/
[5] https://lore.kernel.org/all/20241122084452.1064968-1-swapnil.sapkal@amd.com/
[6] https://lore.kernel.org/lkml/3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com/
[7] https://lore.kernel.org/lkml/feb31b6e-6457-454c-a4f3-ce8ad96bf8de@amd.com/

Swapnil Sapkal (11):
  perf: Add print_separator to util
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
 tools/perf/builtin-kwork.c                    |   13 +-
 tools/perf/builtin-sched.c                    | 1027 ++++++++++++++++-
 tools/perf/tests/shell/perf_sched_stats.sh    |   64 +
 tools/perf/util/env.h                         |   16 +
 tools/perf/util/event.c                       |   52 +
 tools/perf/util/event.h                       |    2 +
 tools/perf/util/header.c                      |  304 +++++
 tools/perf/util/header.h                      |    6 +
 tools/perf/util/session.c                     |   22 +
 tools/perf/util/synthetic-events.c            |  196 ++++
 tools/perf/util/synthetic-events.h            |    3 +
 tools/perf/util/tool.c                        |   18 +
 tools/perf/util/tool.h                        |    4 +-
 tools/perf/util/util.c                        |   48 +
 tools/perf/util/util.h                        |    5 +
 25 files changed, 2587 insertions(+), 12 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh

-- 
2.43.0

