Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62817260A3D;
	Tue, 11 Mar 2025 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694705; cv=fail; b=NBTJX8fH6KIIXyLLnOGkhyhawIB66HQhUh6Q2Q1Zq2UdgMUQyW4nQUxRCMvh2oicRH35MDFdrk03yVoOIEdn3HwXbKRxS/K3vMqrZRMK3wMfF9sr2FyJ40hhrLA64WHQ0GRjDjND4XaG6w2LnYV0sPszcMtl1EFAPxuBpZ8wnQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694705; c=relaxed/simple;
	bh=g/bVDvWwNVYsYhi9+7PQPfUUzN4VNt31kxtG6UZaeFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0WO22m+EFVU4Wuk/2KmTq9YZUhQk53cY7zeZLkDIhM1med4as/c9+5dmtzUsIIDJyxzLuOsZJWDsUnRfQ+jT7nIiYTRomFUXaZlgnDbEucFT+F2XBCr7cHdCYBSgsIh8BeRmUSZueYVvE54JnFOsiXf8WLYu03fFo+VDmmMkYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aD1K9l3W; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aD1K9l3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnXYivvpWYQQ4V40D06Ew+QhzM9QdK9YZTQQVyjC0fsE/6S8IoKUtNnPqevm6/Y7O1Q6HUgkMjaKao4zZ9sdqfqwEY4x4v7+uQZbPPwtijuyAqIsPc8l5pzfl2VaJEoeb7xvvCOOQRKiQAZQe9WHAYfgj/GZdrTMNyuPOnp3JBTEOQBj+6SmwBu6wmEBKbkHfYzQeU6NdOAZt9Bq6Crm/wfQC0VTS5DpH1J00+pFrJubuKHs/WGY6Wo2tyGlYvO2pucsS4c74bLmQ3CGk8DxaE9WQtZdzEbR5W1BgVUECkejeY5umpkmm32LNwtvfrxRyMDudgI/Syb6BpJcEmuXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv4z9nJ0ctGC0n4lqHvu7EefkDs3OUJbfGih7LTHaPs=;
 b=fnqDzfHchiMRScciTOQD8r1uZwV2PowA1Hu5Jf3Qi6okkCLOPjDXVIYIGwP/fcEoWlO897Z4pE7wkeWZdhvnJRYafLoomte4C/sx8wyBQSM5Ie1yJSyeLRAl2YFVHGGj+HJ15RYccs4OZWvzxRkRVB3mg2ES7DtARoS/CbkRX6vpcvfuTN9ECOGkfbeRxs47ha0RhtgpJUJXVo94arxAOgzafkqp6pVGBGgIz8Ban9qAEOGHMN+lY48fhd6g5D6/pbFzsE5SUKWX6ZNrOo+oPdsUY0db9n/Emjy+Swm+l3dwg3S/KXh1AN0Vftsedg/xZ9eDKwrX3/Vz0EoPsldGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv4z9nJ0ctGC0n4lqHvu7EefkDs3OUJbfGih7LTHaPs=;
 b=aD1K9l3WsWc1I3rN7k+PNd/Q+cgi0iS9rNLTvMkReliZb1ssejoN6UNYCBc/DNN4vIHzL0OsUO6/TpEynpTmjFBJpY3Oz5qJE35wJhIN6Lxurt1y+cbLafkXjApArRN/6BEWWW9YoN4hUAIvkDE7O3r2yPv/N2X9tFk4TeJtE7g=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:04:58 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::a6) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 12:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 12:04:58 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 07:04:50 -0500
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
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
Subject: [PATCH v3 5/8] perf sched stats: Add support for live mode
Date: Tue, 11 Mar 2025 12:02:27 +0000
Message-ID: <20250311120230.61774-6-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311120230.61774-1-swapnil.sapkal@amd.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e06f7b0-1b0c-4a86-b000-08dd6094f1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Io6tVsceVZjkK9sT3Z8vZYVuyARyQLSzzZbMyEFYoswHqhpDBmU+xj72ri8u?=
 =?us-ascii?Q?t4qlbf5JXr3oVBhV/O+XhFjPbhlaMQ/DtDHQKkJFiMttRhtGgAtiYEGbXI/b?=
 =?us-ascii?Q?LYVlo9PglobqOyrAKRc+LGs5vLfZP2xGlCcL3nh0s935g2zz1yq8+FF3Q+YE?=
 =?us-ascii?Q?eGT47ORixLM1B9CeDRV4CVesJYQVenAsJTP4GHRwVfxV1aWngOPmaVxuDOED?=
 =?us-ascii?Q?3RU9yxKi7k48wBjyxymqz1eLi+66h7NqIjLva0GHo3ThOxG1eluHMi0tG5om?=
 =?us-ascii?Q?ij/YDKjTKK+g567TFVOqLuqrlqO3S+S1aEsYT993L6GSg1g1PBOkr54QRQjm?=
 =?us-ascii?Q?jAx2lJDLWW1wjdtf4xbeIy9aszGdY2A5nx04FMAonJlLrhcIIlT4wtHYSagM?=
 =?us-ascii?Q?bbWcgua+lZ6M9NdE9JrB11eRZAGPpPeAvzdHz4Nmqx7IgFcPsebWEIM+F4dW?=
 =?us-ascii?Q?N7BJ7wHDoJIUi9akxsPFdIrqNj69qk0ZkJesA8PC8GK7lKJNYR1MM9lBbukP?=
 =?us-ascii?Q?RucoAaoR5jDY0Gi0ymOseOU1YppJyWze6+05XKq7rJnfA9xA1cxaZQ84QC88?=
 =?us-ascii?Q?oNnbFU8yH2FaVwpL0v+GWjSNYRgf6rqDEjX1GDNH0raIA0jb0L2x1rlAr4Ro?=
 =?us-ascii?Q?suRl+1++C7L8H9UrwZxYTKdRUCZxMLRSXmjwAxPFa7P0QtAnEQ1LsuG/4a+Y?=
 =?us-ascii?Q?m3tgnVXZufL/yDhrz5vUjV6iORnwI2XoihmlANCLhCFb59kddbeqDzcxP5Ba?=
 =?us-ascii?Q?6u907JvroqudDFQ7avzpOsKAKVAMqfXoC0qUV0MN1DYnMN//0OKyXuqoaG2Z?=
 =?us-ascii?Q?VnXt1B2vgD1UCg7ByXg97TPozfhl0k/3xleLsNLeGMQQQrtWXfSi72PFbODL?=
 =?us-ascii?Q?6tZQ+Td75pYo49VkLaLgbKl3xeLMfeUjLoprnvWgvfDdoso6VwD/Vi3kZrbd?=
 =?us-ascii?Q?v+HIy1ZLjjzwICVB0jQqafz6imwR0AW0mdvRB+SXhuQ5AyGYWInGJ2KYOeJO?=
 =?us-ascii?Q?V8wFefV38mMRKyxUJr5UOtI3OLrz24Sff8mrWOfQDwKOgawY7eUcDyGrklUn?=
 =?us-ascii?Q?3pCHE8muwJH1GbYCbaIUMmR0UHnUIw/KpRIeoTjPWUwj7mfeZALWR2XQfHF1?=
 =?us-ascii?Q?Sr7Y7x0c8zg8LkG2KtC/Kn1NMZaiaqP6HDKcwLOaEUhWk6JNiAneBCk3YOum?=
 =?us-ascii?Q?eoX76jNn2kNHKweHnXVTJFHDDMnI+/6tdfnxcPAWeqMLPJmkxm0/pYQ/1MJZ?=
 =?us-ascii?Q?qCCPFjmhApmqBe2mA2yH0Y0zlc8d1M0r9rjE/C0uJkS9+kj3ojd9P+YGP1aZ?=
 =?us-ascii?Q?6sljdlqAxR9oCcxkJUJ+xNsjDAILocfWToqpyloHU6/GZOvk4LxubIW0qFCP?=
 =?us-ascii?Q?YBbODoxoi39b7nx9T/U+1Dc6RHzyJcfugP8f35W7syqp+oT+mKElJ8Z4mXmc?=
 =?us-ascii?Q?dUb5HrhL63q1ofRIItfQbirGRM21Eh8XeFIf+DUlt9r1Ohi7YZK35s+zhzGK?=
 =?us-ascii?Q?sDxYEN4BzC/Q8SA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:04:58.4310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e06f7b0-1b0c-4a86-b000-08dd6094f1df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

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
index e2e7dbc4f0aa..9813e25b54b8 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4364,6 +4364,91 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
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
@@ -4686,7 +4771,7 @@ int cmd_sched(int argc, const char **argv)
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

