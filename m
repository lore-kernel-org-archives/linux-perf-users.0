Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468523D7FC;
	Tue,  9 Sep 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418513; cv=fail; b=GXPEIjTavh3Z9l833rpJ6jw19GoHSxCgjcpdNUzeHF2h9lSSTSiFFC/2gVoM0aDmuoPw3UcF69IreOe43d5SKgQp+OKaJdpWGdNG9kX/rC21c/X6TJmSPpo58Be9y1ntzYU5687CkUjl+kNgqXAHa+lK1rFjWmrJXNKVhxXKEH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418513; c=relaxed/simple;
	bh=gqAZxoZKLiec3qn/670jAHkQUcHad5CAYPsvx7cZ5xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG0H6pZ8GnCNrfpX2Dx1vaT0OhKB9tnfuTLPDVuoxfimkH4rh7ayI0hrvyQWnbgAa9ulcP546KY8nzLjD87T/KY94QWMC2UVZ9PwmgqmmfebSTJ5wm978GGLQG6jJFCqgEGhqeCymdxj9rj2KfauF1OQYtUnkNzN1l+w5/izruc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aYJ1lDL2; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aYJ1lDL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMTFyD4U7QazT57szyPYsmAL7igdKPTGYGE4SSrF/WbaW5RaHXEV0Mz48/RzQYgOJG4ohANcxCMF4VqC3fuf9QrDvRSarIiN3V5TcKsD31YFJeiD1taicJutQaoEWKX9hHDgwILW0cz9aKRbmhJ4hd78IWQjSVquW33x+kfAtBzFD04eW6hOoJmZgN7FxyrvZNEGSFSR94BFs487GI8utheGKYFdcLpDYcMBb26bmGLmTv63DkIt8JYPp9NwouFvIRZNuOka28LkRSjksug4b+Oh7OFFunh6AUMBJWIJaDVNj+zkSZupY4Mv36KT1x9RimbkJEqRLlMdm3xw8aedbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR5lwR7ocSYg9xggvlfqb4UMGVkz4dpo1j/gcmPJlg0=;
 b=WSFbPKQatNewVH2pmhpTa15kuMzjXX4beSXOLy8+7RBgP319z6sHxltCic/ax5vbIMo+YYVnrd57tOBdUroyEWYQGD9N666q1rj+AA+dFZuVugyYL3l5oThYGYhAxqzA5/ortGLqHRqgFqg4t/BeDST0uhrOqv7amEExd4d1rsqWCfVFJE/O/LrJ+kx9c4WrCa7srB4Rf6jfKVDcb0eLZZQqJmdGG/93h089N3D2MIssb7HpQK/wWrJ3HmatVcLjCEXsGoGQC6hUYQUyUxBKE5e8ApyTAaKms1osb8W2Lj4+R63cvSSG5vEkrKbrTGG8TdVsb1YWDXdo7jaQpvSpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR5lwR7ocSYg9xggvlfqb4UMGVkz4dpo1j/gcmPJlg0=;
 b=aYJ1lDL2Sw2jOR35I+3NJnP8GJAtD5exV7k0AcPifTxtaRGLRiF7dv+Y08Xwz+HR52L3fm32PPVC3XrFakf2lDsqqmEa07IN53GNNtScT0ATSu3z7Px1CdmO+crPwY7nXC21clKe+lzh9FM1O2EtL2SjSIWFxOU9WvTOo9hl9k0=
Received: from MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 11:48:25 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::3f) by MW4PR04CA0215.outlook.office365.com
 (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 11:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 11:48:25 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 04:48:12 -0700
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
Subject: [PATCH RESEND v4 11/11] perf sched stats: Add details in man page
Date: Tue, 9 Sep 2025 11:42:27 +0000
Message-ID: <20250909114227.58802-12-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909114227.58802-1-swapnil.sapkal@amd.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2436f2a6-f032-4239-6388-08ddef96c8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WrJWsSLEu4Jb3JfxDKKshKrXBZ3PVNJ3nqIPeyZ/WjYHr0yEScBF3goO3u/c?=
 =?us-ascii?Q?7+LnDirLqCIr0184TM44p4PhJ0BNHKm2pPMTFSHSdu3tF0pfy9Vji8ahFeRW?=
 =?us-ascii?Q?6uCCPuWmtiCiEJdrKRCLaAxMh5wIIG16u5aHXOpx0gS4a4NGnYvHbUMj6VS3?=
 =?us-ascii?Q?FdjeDh/jf+4s5hqLzl/GsFYZlqSRc8avO1lxNdx6e1ULbC4Z6a3qikKbjUBN?=
 =?us-ascii?Q?bWr/T/quMawE032TTc6gm38pxPBrOu9W1oMLUkrbeB4TTfUb38Eyc5661dPg?=
 =?us-ascii?Q?Usel3bFIvLyyCJUBnJLlnaubboJ+LTNYfSKrXfPVufTvNPQODEeuAkbxT7XF?=
 =?us-ascii?Q?72K6dTIDz3HCZHatinaVAIr3cqqSL5RG9LBzISbKxMcCTQNDRsUSFWzrpV0z?=
 =?us-ascii?Q?KLC+8gcvh/kyBZOClpqud+cIEE4XPBt0CthIjwI/u8FzTETSbQnmL7Ja8bmd?=
 =?us-ascii?Q?e8JyLUZcAoKq6wk4zhn9ZAc0WA8h3EMXLySWeNgrsL7l9kgDaaqkXBfqPzDP?=
 =?us-ascii?Q?VcsFlJymT4eK7eEMHCWFZZqY+9WcJ6z47YqghVPBCISvKej/6+nXPJ+XOaBb?=
 =?us-ascii?Q?afKUvF0+5MK/g6g6K0N7KFZCWVR6vgkYNZ6kn6x2p4IEB0Lim/LWNNV1LFJd?=
 =?us-ascii?Q?qO8nmGdJtoQl0HbkLYJR90g5pCL/ktmmK/zznMMMznSJ4EXfqJuYqHR/ZeUt?=
 =?us-ascii?Q?0Utt4Fc9mBiOsgfKstO+0Yzd6YiJxKTmaONh9cgjnUbfcGR6mZB9dLb4ecuX?=
 =?us-ascii?Q?m3i9ovGw0S0tvVhrzDuc+6ffMpo20YAt3sJKVPViNVkE0hZl227x9GdgqHhm?=
 =?us-ascii?Q?XljBodrzPOzoQGuhlci91ge17xrINxEFCnEVEahn5R4MKeoX/4Pt5At9N+rN?=
 =?us-ascii?Q?l5LPv6KSpCil9rwse1w7e5gj7roTtyuoBDHjW7Zp4QktZXAcvojLIZ4IZZaN?=
 =?us-ascii?Q?3QMO0X+Fgu39p2WtsvDAAdRIka2s5BXT5UZjANy886SOsvSNsDHrfDXI8ve4?=
 =?us-ascii?Q?jIIBNQuZHz7jm/XM40Hu48FHNaKnIYN7mIDjt/ai5Lq8LvvEhSBvSzVp03Ev?=
 =?us-ascii?Q?5W5yaMR34G7mG0zCexHoMrcnEB6pQ6nQt+xZhYFRHybGWXzYslGixtFTqttm?=
 =?us-ascii?Q?o7BzJDZPH3cGQyApogLjG76l3Sn3f7NZeXGNqf+3tjQvD/N/8/1dx7csXFNU?=
 =?us-ascii?Q?UT4hksI46eKUXBWlM3aPPOtigSSn1i+QwOJS7a5Dv2LWWRg6udnLgyRM/9xR?=
 =?us-ascii?Q?UiRnVdm2Aweb56EHmT0btGQzwZt689imuQd/T0d5bU5ZWDbwB3R30X99dDDv?=
 =?us-ascii?Q?hTPZiELnVD6bNkE0J6KM7rm/IAThyuHpR2WQvKB0SS6vkVHegwln96i4psGa?=
 =?us-ascii?Q?ka2Mbsm0JZvyxY80ADN73NdiFzv/RB7XkDh5Uld1sj30g39HpKCZafk1FQ0J?=
 =?us-ascii?Q?mD3NEpiUtYWXxWTEWqbgADjnWSzcdWs0sdIXeCxqVUUCS6t5T9CevQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:48:25.0155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2436f2a6-f032-4239-6388-08ddef96c8eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

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

