Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68332E721;
	Mon, 19 Jan 2026 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845721; cv=fail; b=CnIQZdyf4v11RKt26faKFJkeLp1wBY4O/pYtJX+Ug5EzfmTxhBN8pXf0t2qZdhq7DeBZjHmDLCfHV185EDDvNnxvPN2NzkwoN1u+rLvM8/vFPaSB3eeMyeC050BfZB43c7LWPD2+oEIesNCixRuTb1rovm4m1RcW8MqLMTfYOCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845721; c=relaxed/simple;
	bh=azpuIFGAPZuGe5bpPOSRoRSDdSNUs1pTGnW1tqErQso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzZWlwcdxvTvr7wuuE2SadsPxi9g7KnDfXp68RdtwU6Ln74WchMCgHo4JlnuoIeUgO+/GDUCm9hVBv0Uk8GC+EC7wjCEkrWbIyIgd49B34bLs+mFKXLUqQrw8atzToH95Cc61L+4UVzvVUPMO4TiMKcBMuXA0Uzkc3nlIa17C4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tB+APnG5; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tB+APnG5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeaxiX5l+neGPp/eKTJS+sYHHYuUyi8MKcw423A+/BHnbBeoMv7Xg/pP9+uqSrfPYaaljiDy3sP4z+2uGu0FxfqWouJfLIUoX2WkNwri3hGULv9L6deQ6y4C7hHOV7ASopwz+VTS0vwfwUnbUHiVPg1Kn6FlZ2ihr4h3Dnxa+dwwTVr9jUeYN952wE1x/6fy24PVBlEVAfIeOgW5QmyuwE5ZoLcqwNvXOQHDnZHxEHAULjcaUnwxhPvBFPl0rNEZzjLqasbW+os80HTiGXqUvjtw2Egpew5A2Voavj7S1CMZ4OK1+53uWJIA7SMhcU3DBDbeIlfgedIynruvtqCTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmJMd7fDjjUupdHqyktYY2gqSdeLdFwIMbYN3auFFQw=;
 b=c+OWeYmyFrRev50ny1ks9z1ffImfE9keD4++nNcvfEV44pyxftniOv4BxLsOMna2ZZX/w3BviOT0oiT1US9lhyXiZZZl2MoDLasINo0GliX6Ta+Pa8VXNzmSK56oEa3/zHZ5jXyEJO5uO+PaYUGDHh70shW2tmhv1MkCKSvLznIphUv+gIv+97tNRwYdQtVryDyUxOmq5qnlpmshmVaT2iFINUXR96VAH+yx/nA1g4nDTIdum8JCXJBHtLBUpB5oFN1nWyDlVTXAPhaAPMVYvyda1Tf3FL6gkgzPeqKUq3pziP1Lc8qwmQ1id5mQW923glc0dguG6kX2yQRVVK8Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmJMd7fDjjUupdHqyktYY2gqSdeLdFwIMbYN3auFFQw=;
 b=tB+APnG5vimJ3PybqcUB9QypGD+SPiODGB8pGLwNcepBaszkUiCKzGow9GDjb0oJrb1vepsO6rwGUEevwU04kfihXqQg0GbE+1viaxgDc+qlT+sCFrn1/90roVEtgyYJ3nflNRiyHR4r15nkWTZ2+Lhtk7ycG5PkMhuPppqnYSs=
Received: from CH2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:610:4f::13)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:01:54 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::8e) by CH2PR18CA0003.outlook.office365.com
 (2603:10b6:610:4f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 19 Jan 2026 18:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:01:53 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:01:43 -0600
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
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "James
 Clark" <james.clark@linaro.org>
Subject: [PATCH v5 07/10] perf sched stats: Add support for live mode
Date: Mon, 19 Jan 2026 17:58:29 +0000
Message-ID: <20260119175833.340369-8-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: c99ecc80-0dbf-4840-a284-08de5784d40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSVH0zv6ZZ3MkqXTD+uUOkOT6b9TSrdCwJRU2FFtXPRqVPF8ybQVEpwP3szo?=
 =?us-ascii?Q?QECf1SJfMevIpTGDls9u2LaTP1ShpWzi60tu11kOPKfnOBnB80p86IRWlYzI?=
 =?us-ascii?Q?2qG/yAss+5tVk8wOjhzm3tBDlkOpgZrxQ1XDRzDRyeTPPGOGGkZ9xCFnSZ+/?=
 =?us-ascii?Q?CQnW8xtnnWwsgbydawzbHniXuTiqB3vCR0BDZAiXfQx+p3zYYiRMUcsXU9UO?=
 =?us-ascii?Q?dpxAafxbYqecUVNPo0nskgJFIYDnNuquY6W2Qyb0NjTzQZ1K+UodhH1EJ1qr?=
 =?us-ascii?Q?SlOOb2Oo7eZPa5oi914waUn3rxTDvwE5YgYxonblvn3ZqG/78WHTtpYwAQbz?=
 =?us-ascii?Q?9JzRiiF7kw++NuHTkEA+eNR9eEh6aZg/Vfl00fZYTXmYtK/8mDLdSmaW+k7x?=
 =?us-ascii?Q?vw+HLwYjR+98BfHXQXQYOUGAWtKsD2+nxBWhcUesqmIfusrQAHaQoTIRqN2T?=
 =?us-ascii?Q?0k64QEO3CUi6xEaJQvZXkr9UYB4Rct4epzeKzrG8aHiXv47HvDJJN5IUHn6M?=
 =?us-ascii?Q?iliHNoRdwJiiBQGsz3irGCZpPllqFqh1yg4YyOVesJ07IaS5LK8B5NKoClqN?=
 =?us-ascii?Q?vdIYDXvm3oGstoKzdrkPYwUZa+CDGnwyf+QALdM/uOZPmHrwWcRgQ0Zmjfln?=
 =?us-ascii?Q?8Y6MFpknAMlYJS1YbHPNOt2Aw0hzrYmkc9R0Dbem7HxElwgYwTi6LfnT5FYK?=
 =?us-ascii?Q?J29CjzGiPxayyWBSntsi6apgh40JzrrJ2GNU8nk3TIpqB3Kw+I+GKkAH9P+V?=
 =?us-ascii?Q?z8J2wsPQfa8dtJvmnmH3/f65sUstSBPPJ4YbLG11KOj3SOr9TprLXgMVdc0G?=
 =?us-ascii?Q?ksW5xbdO6QE4/eBduryhuU5XWkp3i352LAgX3lDZ9UdIj5VKz4z6DjMDv9RR?=
 =?us-ascii?Q?HRH3pUgTqE1hbKKdZqCHKiVhuTo95i8ePvb1b/hrXjwbypf79myyHAiEgAEN?=
 =?us-ascii?Q?996oW+eCTkDmRXgVJo6gmEx4LL5sw4FeOK81P7aKzzrSRbMPdfSwLrqTa/QF?=
 =?us-ascii?Q?rDNHE5u2GoWJJ/OMAPfEdKAM1dRR4HVJvdi63k4Ohw6vaeDgUsQEpdDM12XZ?=
 =?us-ascii?Q?r+3HB05Vlm90u3ZafbINnGBDAUX+qwhMI6qrpLSiZNjzAmXUG/UNetTPUqYJ?=
 =?us-ascii?Q?TVI3T9Zb357NlODr1QkQXWoV9jsm8tXKaTO4Tdf6yt9kxz2FvA7h43/zG2eT?=
 =?us-ascii?Q?ot7ZPzTpgfSXWmWkdH6uTY+URjOofgV/UqtAykmK1CKbLC/cr2wwHoh6qNS0?=
 =?us-ascii?Q?b5CLl2M/oTANhmK3917vW5BChuqm2WqlkG+kNwlHt+SG6mDJl310F1fGbGjM?=
 =?us-ascii?Q?mULYbQ7eJa0pz+CROnszg17SogMj0tWXQsmy4Jsn4k2G7yJsjuTbvc/o8ffC?=
 =?us-ascii?Q?wq9HbMEhkBEeQaprh8hc/P0kn74WneMnn85+vUf5WTiK38ZgW8VlHwVu9S3E?=
 =?us-ascii?Q?PKAodHZri62PvdJmWR8FX4ddnAZBTUMJ5A4zCj6OzJOdcQLV2+/vnAwuVMSi?=
 =?us-ascii?Q?5ki05qnv70y7Rt1DlPlj2nE0/RW1jqVW7WuelJm9xOHmNzaNA3KsPFi0AWCR?=
 =?us-ascii?Q?2/nBtuXJp4jIPXxYAMNBpzEjZLUJKCFDoNLJrmZVfKgAx6g4cm2Jg3inPNy5?=
 =?us-ascii?Q?jr3Tcrx28KSCQgaAV7o66tiGPIUMWVQNSZpjBXmKCEkN8EHx8STuxLo1Oue3?=
 =?us-ascii?Q?5Sq8kA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:01:53.7265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99ecc80-0dbf-4840-a284-08de5784d40a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

The live mode works similar to simple `perf stat` command, by profiling
the target and printing results on the terminal as soon as the target
finishes.

Example usage:

  # perf sched stats -- true
  Description
  ----------------------------------------------------------------------------------------------------
  DESC                          -> Description of the field
  COUNT                         -> Value of the field
  PCT_CHANGE                    -> Percent change with corresponding base value
  AVG_JIFFIES                   -> Avg time in jiffies between two consecutive occurrence of event
  ----------------------------------------------------------------------------------------------------

  Time elapsed (in jiffies)                                        :           1
  ----------------------------------------------------------------------------------------------------
  CPU: <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT   PCT_CHANGE
  ----------------------------------------------------------------------------------------------------
  yld_count                                                        :           0
  array_exp                                                        :           0
  sched_count                                                      :           0
  sched_goidle                                                     :           0  (     0.00% )
  ttwu_count                                                       :           0
  ttwu_local                                                       :           0  (     0.00% )
  rq_cpu_time                                                      :       27875
  run_delay                                                        :           0  (     0.00% )
  pcount                                                           :           0
  ----------------------------------------------------------------------------------------------------
  CPU: <ALL CPUS SUMMARY> | DOMAIN: SMT
  ----------------------------------------------------------------------------------------------------
  DESC                                                                     COUNT    AVG_JIFFIES
  ----------------------------------------- <Category busy> ------------------------------------------
  busy_lb_count                                                    :           0  $        0.00 $
  busy_lb_balanced                                                 :           0  $        0.00 $
  busy_lb_failed                                                   :           0  $        0.00 $
  busy_lb_imbalance_load                                           :           0
  busy_lb_imbalance_util                                           :           0
  busy_lb_imbalance_task                                           :           0
  busy_lb_imbalance_misfit                                         :           0
  busy_lb_gained                                                   :           0
  busy_lb_hot_gained                                               :           0
  busy_lb_nobusyq                                                  :           0  $        0.00 $
  busy_lb_nobusyg                                                  :           0  $        0.00 $
  *busy_lb_success_count                                           :           0
  *busy_lb_avg_pulled                                              :        0.00

  ... and so on. Output will show similar data for all the cpus in the
system.

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 99 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.c   |  3 +-
 tools/perf/util/header.h   |  3 ++
 3 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index c6b054b9b12a..8993308439bc 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4426,6 +4426,103 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
+					  union perf_event *event,
+					  struct perf_sample *sample __maybe_unused,
+					  struct machine *machine __maybe_unused)
+{
+	return perf_sched__process_schedstat(tool, NULL, event);
+}
+
+static int perf_sched__schedstat_live(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct cpu_domain_map **cd_map = NULL;
+	struct target target = {};
+	u32 __maybe_unused md;
+	struct evlist *evlist;
+	u32 nr = 0, sv;
+	int reset = 0;
+	int err = 0;
+
+	signal(SIGINT, sighandler);
+	signal(SIGCHLD, sighandler);
+	signal(SIGTERM, sighandler);
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	/*
+	 * `perf sched schedstat` does not support workload profiling (-p pid)
+	 * since /proc/schedstat file contains cpu specific data only. Hence, a
+	 * profile target is either set of cpus or systemwide, never a process.
+	 * Note that, although `-- <workload>` is supported, profile data are
+	 * still cpu/systemwide.
+	 */
+	if (cpu_list)
+		target.cpu_list = cpu_list;
+	else
+		target.system_wide = true;
+
+	if (argc) {
+		err = evlist__prepare_workload(evlist, &target, argv, false, NULL);
+		if (err)
+			goto out;
+	}
+
+	err = evlist__create_maps(evlist, &target);
+	if (err < 0)
+		goto out;
+
+	user_requested_cpus = evlist->core.user_requested_cpus;
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out;
+
+	err = enable_sched_schedstats(&reset);
+	if (err < 0)
+		goto out;
+
+	if (argc)
+		evlist__start_workload(evlist);
+
+	/* wait for signal */
+	pause();
+
+	if (reset) {
+		err = disable_sched_schedstat();
+		if (err < 0)
+			goto out;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err)
+		goto out;
+
+	setup_pager();
+
+	if (list_empty(&cpu_head)) {
+		pr_err("Data is not available\n");
+		err = -1;
+		goto out;
+	}
+
+	nr = cpu__max_present_cpu().cpu;
+	cd_map = build_cpu_domain_map(&sv, &md, nr);
+	show_schedstat_data(&cpu_head, cd_map);
+out:
+	free_cpu_domain_info(cd_map, sv, nr);
+	free_schedstat(&cpu_head);
+	evlist__delete(evlist);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4751,7 +4848,7 @@ int cmd_sched(int argc, const char **argv)
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
 		}
-		usage_with_options(stats_usage, stats_options);
+		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 673d53bb2a2c..9a15dd4b7640 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1614,8 +1614,7 @@ static int write_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
-static struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
-						    u32 nr)
+struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains, u32 nr)
 {
 	struct domain_info *domain_info;
 	struct cpu_domain_map **cd_map;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index c62f3275a80f..36cc74e2d14d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -211,4 +211,7 @@ char *get_cpuid_str(struct perf_cpu cpu);
 char *get_cpuid_allow_env_override(struct perf_cpu cpu);
 
 int strcmp_cpuid_str(const char *s1, const char *s2);
+
+struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
+					     u32 nr);
 #endif /* __PERF_HEADER_H */
-- 
2.43.0

