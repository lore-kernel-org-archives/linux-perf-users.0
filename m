Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6D1BDA85;
	Fri, 22 Nov 2024 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265276; cv=fail; b=YjVlKZkQDJ6XdYNZ3ynDeLqIo1PxrIHck1RSpVq2l+SvMFfFhOTETdF5BnRkgPMSPYAlpPWpjEtJ8Kml1JntJ588RaWE1SiyWeG4mlfApGjJL9SLKfuZ0IpXls0RiScoANPSBdByagTCX8hK7M/A8npTnkoMtUjRejkK8gqTcic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265276; c=relaxed/simple;
	bh=7baihDCyBQbXRIeRthnprVt5wVWlOHDrZGyqxeITuPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZNHZFpKPgdUvj/1kTSpBLvg1qQ+oAkFAcy9tinzPeELi5ctogQCyFlERESoXiA0fJErR/Uqux7JMYYArbjiHZ4gEgguVCR1LfgUL2/A78WbhUDeg8MF5y1EySlMmZP66QsQNnZR9uhNna+/5LsLbbVG+us77ANU92COnfUTTx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cWsbBI5D; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cWsbBI5D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wxbzk8W5WI9mxsCYpEc2OEZwPlW3IY1IbalS4NcWUCYL426IcGep3OQO/1JoIosEJmux1seJXbtbY9dbhWlH1AfbqV/LLh0ndkJT4NheMrzV9DeTBm9HZx6yO669rX3y4sPQiWCptjCc+I0Zh7OFcxot3xIq9Yo/gBD8Y9wfya23/06Djr3JpwAfob4v8mg6qz9JA8RETqPeuBIFQJtaeTUxcTKnv/M6MWecIRUZPnkeR8p6kX7JO6gmrf5bRAtprBa98YMbVNPOv2E3EQuLhcPEP7T1eH/wZ+rX84YUco1OixexxnsulThLdgwwNP4fMV1UL1dnRM9IONy2oG5XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJZfJEpzd8aPiTVBViqYn/Zazms5j+ky/DTLPq+gobs=;
 b=vQ9mT6i7OgoEKxd5prdxbiN86ToQOiMV0ZpWrQUKvcyeqS+TXoCsw1OxzO+Ju3CZcPmDSwijVwa+c6SF1F9Cwa825JdHroumgbFKqZnR9KjV8OqvMSlZvIuWEukZw4FwlV5As1YDOO8K4TxNneDm84825w+Jw5Nr15Q6RhRGSt2X+R1DW5JXUViEEbeR48gsVWajoSHpY0gLnOU2iLgMe0eqrF4xCqCi/iXeUSykYuh7GWrdBbQmVpnO9y0pEn4Mii7XdDZaoSaj9EdkyPJwCLzOgl+pNhgLrTyiplY8+OdlEovctu4YZ7wO8d9UXKbMByToKqjxkpERCyA24DZALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJZfJEpzd8aPiTVBViqYn/Zazms5j+ky/DTLPq+gobs=;
 b=cWsbBI5DWsC3GGwr7x1skOCWmybiJ4uZuLA3BtMR3YATYAWJzMqdGypFN1F5WWC9HSzb/1A22eJS9ExYIJ0AscyOYwlgYtAYQRJP377L2b/Eh7hTlHcxN2lNPtQrwuGxw4iUoiBqvvB4jfR+mnNM+D26UvJlqhxOWAfzABlnV5U=
Received: from BL1PR13CA0345.namprd13.prod.outlook.com (2603:10b6:208:2c6::20)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Fri, 22 Nov
 2024 08:47:50 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::4) by BL1PR13CA0345.outlook.office365.com
 (2603:10b6:208:2c6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 08:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 08:47:50 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 02:47:42 -0600
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
	<swapnil.sapkal@amd.com>, James Clark <james.clark@linaro.org>
Subject: [PATCH v2 5/6] perf sched stats: Add support for live mode
Date: Fri, 22 Nov 2024 08:44:51 +0000
Message-ID: <20241122084452.1064968-6-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd72160-10e8-4bde-8df3-08dd0ad258a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pxXjFpyermBSmwjpTugKllqxXO8Xun4RGthKbQCocgCIuwDM5mH4yn9PIhrm?=
 =?us-ascii?Q?AoKAUJh+ttkheM4paHvaKg4c3BJurR++ik8AHGuFp0kgJO0Wu2V38hh6aSYN?=
 =?us-ascii?Q?s/mq5zpk3H3W21IC8f585LbwuKTonanKKZ3vt9sRcq81OqVpO/Kl7NQMzlO3?=
 =?us-ascii?Q?drdWAnljDkZUXbXZ7FRuwI6g9xEna93mIMiCHDnh7TiZ6Py5ZXAhKp2FDN+V?=
 =?us-ascii?Q?304bBUdgQIaXAJ8fcx1o5Jl2V5kF89IbvgtrOGcKuwypf61RnQlB4/jhbdU7?=
 =?us-ascii?Q?cQC7CRmQcPNtT0FUujDG2MYLHitLY271Uz2eZ1SF58Z6oCGxVy6VXIohTcA2?=
 =?us-ascii?Q?B45S+cH/0DlZoxcyZlsmv4nCdicpyk319E4tCjeWz2QJ+o6PkdUAdT+lX3JF?=
 =?us-ascii?Q?BvA0Dvje24IRJBWHeB8SiW46fIs2gYLXfHNw66M5Eq286QhGTjQvNuCaJPP2?=
 =?us-ascii?Q?CWn9tt7KRHKQUgmTKzhTSF2Jwy87ohqykJCLEX1yyZZJ45Um+IAP8ZEXmFZ2?=
 =?us-ascii?Q?MoDWCob+3LGgIdwEgAE3bgnbgFLiZf+IWY1UvRi6OfxTcA8guQFOpo7NNWFH?=
 =?us-ascii?Q?RY+Y/L7T2S7L9YNYsCsrCuX0kB1HHdYhDN9By/DwbkjXEPF/hZvXUyIym2LJ?=
 =?us-ascii?Q?cM3EpZ5K/D2u0BT5qSolranYNRh/uuQF7UCtlcuLh/kmSdHIep8/yG8KKx2x?=
 =?us-ascii?Q?ejwu7dAkWqAq3S1xPBTNa5tGS9AVzfjRghcRrzAVebt6cH1O9hNfLD44NIhj?=
 =?us-ascii?Q?nezFWVMkVwdsnP5nMvGjogZgDNJ8nUDIrU7R/7xNlUjtk6SZU99AyRB2139C?=
 =?us-ascii?Q?P/57tLK0vZoEyqjrZ03XH0UpQpCUEXF1TK5RhI7m3VNxpcYgLENfRG6FWAah?=
 =?us-ascii?Q?UkFQCS4CMhVKykLv39d+sMKJGLGfu35hQX81UGtIWsbk6JNaw+Qn+hR4DlBn?=
 =?us-ascii?Q?hbiHNRPyb/pQjKpJVtWpr6bIu1LmWhERGEEecFCyBbEVf4jH2ylgxGDH6UGc?=
 =?us-ascii?Q?5tUfup1rcPin8LKGsgxw8d9HazkZ+x96LXnmsq8Ar4VKk8lhIagztWlkhpA7?=
 =?us-ascii?Q?DpSNM/01G5DtvLvarqYOXqCejfs8mlU9ltzSetNa1tAGKnmTGK3w6aDZ/86R?=
 =?us-ascii?Q?ibSRa8XTXkJE3vS40l5Izyjz5mr+kD9Fd/161YL5BPJZS0HaA+NFUXWgQteS?=
 =?us-ascii?Q?lPmntwSxfamNNvsU+1CApUForGxrXWNiPELqy2U7ACG8CVagvNHbx2BJQYca?=
 =?us-ascii?Q?GiJrqZMKDrJnsTy+lSW5zDoJtF64UFOFm/LouRoDt9n7LY+cpH4q9t/5BuO2?=
 =?us-ascii?Q?kJ9QWoWOknjVNDe5bu2MTiFt6YnlHGcCUFDgBx4pZTChK4M5y+WZrm05NuzF?=
 =?us-ascii?Q?VVwfdXlC5MD71nrgpnpzZcqYOBhjq4g7kEdByC8PDsCblx3Dcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:47:50.2417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd72160-10e8-4bde-8df3-08dd0ad258a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

The live mode works similar to simple `perf stat` command, by profiling
the target and printing results on the terminal as soon as the target
finishes.

Example usage:

  # perf sched stats -- sleep 10

Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 87 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 58a4f6ce0448..004ad0952338 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4342,6 +4342,91 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
+					  union perf_event *event,
+					  struct perf_sample *sample __maybe_unused,
+					  struct machine *machine __maybe_unused)
+{
+	return perf_sched__process_schedstat(NULL, event);
+}
+
+static int perf_sched__schedstat_live(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct evlist *evlist;
+	struct target *target;
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
+	target = zalloc(sizeof(struct target));
+	if (cpu_list)
+		target->cpu_list = cpu_list;
+	else
+		target->system_wide = true;
+
+	if (argc) {
+		err = evlist__prepare_workload(evlist, target, argv, false, NULL);
+		if (err)
+			goto out_target;
+	}
+
+	if (cpu_list) {
+		user_requested_cpus = perf_cpu_map__new(cpu_list);
+		if (!user_requested_cpus)
+			goto out_target;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out_target;
+
+	err = enable_sched_schedstats(&reset);
+	if (err < 0)
+		goto out_target;
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
+			goto out_target;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err)
+		goto out_target;
+
+	setup_pager();
+	show_schedstat_data(cpu_head);
+	free_schedstat(cpu_head);
+out_target:
+	free(target);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4663,7 +4748,7 @@ int cmd_sched(int argc, const char **argv)
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
 		}
-		usage_with_options(stats_usage, stats_options);
+		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
-- 
2.43.0

