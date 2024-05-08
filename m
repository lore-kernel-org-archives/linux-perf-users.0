Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5511863C;
	Wed,  8 May 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148322; cv=fail; b=NUOuXKnEv5DjufkoZFAvzBZpGlOK2xyFRSfpvFuzPckOZ3ALpCmQtB6ag11zJOo4XKjrtuLzYk6fIYWZgA7E07tmV77t7MmBeDUil8E8gghB1PxokVP8LNJre1nUsIEvaU172apFU3ouf4ePti4LLMiA3Lui6bGgaqq3ReZBC4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148322; c=relaxed/simple;
	bh=z5VWE23tCeumW2tbUwJCHz6uR1PbUOPADnkOKAdPIvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AufVfoKe4cXrh4BfmWl+s2VhOeDVxX/Zp0jZr0xMNk7GRxxJEQrz59sdKVwMLdM5JV7Lud+oLZkFD3Q/TOuEal3igp3TZL0YDECFxSB85LGuKokZjP28p8nghZLKGnFZlh/Qjj3cFmhUkh/JWwtuc6wz1kFRQOObKeUcPbPvoqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yI42BjBc; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yI42BjBc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YojH39HXs2mf0jEECa/ASd8y/b7d3MHiGpSDgRU7ZHlVAUCUPFkOXrnjtKWD4i9EP5+UPA8xMejt6rwUPkQjIAsTmvzYcm1eu9xMo1nQ1nX2/eUBdhqKZGsvsmYYlTLQm64cojfnZ7MoWjI/41e2sJvrYYyZL2sVR0ifvEwOy4dy1Pq6jrXyGsSMIDcy8OibV+tsBbWSwSS1D4K97mfdPgMkHUafZpP/H6XODXqcNu9Y0OyGCqjlQRAJyJktrEK2HYRiYz4PxxgS+U+/an7BC7bYYbPGntqMEyN1I4EFL1IpdR5W6DINYq0OGqR4MuLaGQ0nE2PlUsZmD/ucLh8f4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS1ORoWQExkx6rktbhPzqAKYoaQi8LXjO9GrTzVQv+U=;
 b=HG5C2xiEXSmaz/WCklSIhv36dDadU7mhiY5G00bjeylod0YvS+umoiOQA1pAqrwpspxbmdz2oKJ5SuQzqFoluaDESe6B3RA/maclajQOQ8HqdD9RkUdhTdWyEabBrvA2S9FuWJjNNPuaGwsVCERTh05nxHLRFIj0oUuPCTRqUepDEyVGUqtC3dGuangRVzE7MZOFnWBV4XASBacFb5OveqqvUXdKfyvkEY+tlkFVSB4Ve29TFiOrAA8/FaUp5/8906vg0qaR3s7C/cN+Q64wbOw3MYhwFj4vkW1grS9bQ4Vnc5kmfA5KsXwVmLBKSDCwnXEQdLQfgX5pEhQ9mfm0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS1ORoWQExkx6rktbhPzqAKYoaQi8LXjO9GrTzVQv+U=;
 b=yI42BjBcqwOE/bdlHRS/qH8qVSfTYdnovwbXNlA6gOfe94vzDOWIEsvDospOcqbp2czlZd9sWW0ODP0GnDgWU07PZRu/GsyyRjYj1s8nucfTACQUB3OS25cZIjd917YYqBcCCPsTEaHCXxdQShdqJmAlGbQ4pox1NndhQTwTI/w=
Received: from PH7PR17CA0060.namprd17.prod.outlook.com (2603:10b6:510:325::24)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 06:05:17 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::bd) by PH7PR17CA0060.outlook.office365.com
 (2603:10b6:510:325::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 06:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 06:05:16 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 01:05:07 -0500
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
Subject: [RFC 1/4] perf sched: Make `struct perf_sched sched` a global variable
Date: Wed, 8 May 2024 11:34:24 +0530
Message-ID: <20240508060427.417-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508060427.417-1-ravi.bangoria@amd.com>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b72310-a59f-43ff-4c81-08dc6f24d55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1QHCSFQ9BDSJUlYuCqVUQZDaxfNgLkVJfNv2Az6Ep4pZ6tpMcqBy4gP43TNP?=
 =?us-ascii?Q?62aslwNIm7nxwyfqWCo/1EgkdO3njpXG+Dtmaq7AmzWI/4IPHrzn72rv+2ed?=
 =?us-ascii?Q?b7xRnqkke70RpuNNPP7ZH41xU26ikR1kRCRlwAvAWRE711W1hhPaAKBe+C2m?=
 =?us-ascii?Q?y79tCtC9UhwTxlyhfnwtgjQHcOarA1YIh8OUEA5Vw1njF14whq/i9+a5k8qf?=
 =?us-ascii?Q?1J2SBCX4OUWUpb4FIYaltlRzKMveZx7usemYy0G0nrNERq/MDFr5E4SkXQPx?=
 =?us-ascii?Q?vc/k5rIFihWY9D5yootmWQbPLcjd7StfAqyLz+q/Qb1SDr/O1Xt+dKUuamOz?=
 =?us-ascii?Q?e/1kJmgWjUeynboWq7M111pGB/v/LWWbZliFAG0Stuv9Qf5FhDjXWTa7lXBE?=
 =?us-ascii?Q?dZUQXEHHJCLfiWQPlGiDce+2qx8biwiVlBSbWg4WwrefVMV4qJ+3NQe9dTdi?=
 =?us-ascii?Q?jhyAe16nCoZsDwjinJoUxGFB9ji6p8amaTyp59QWjFGGt/R3EkNFaeJim8JU?=
 =?us-ascii?Q?n5dngt9+DoQCwaUm2SjwQ0EZGTrZbigqMdDSZeYlB0O8TJDPwF/pltk27Erg?=
 =?us-ascii?Q?2EFur7YYamVgMvHutrbQD1M5cL7E8/Aw6n5OtGnRyvApxsHWTXCicQKvjjJ0?=
 =?us-ascii?Q?FB5PBwKyx/qbLIc6tB3m91o5C76VcMq0yiFLMSd1cjEZ9DkcZyCfmK8kmwBb?=
 =?us-ascii?Q?bNCXpk4bUCO/rKraEVKYWPnJKYYMUb0McYvLgVuMspuJgnEEFlMFnnJwcl+l?=
 =?us-ascii?Q?EGco67sTE8j9vWeyPIy8d86gE1ZJk0QD0UpKRSN0AebtDHDSSwWXhTxqtLzj?=
 =?us-ascii?Q?lqMsgI/BEhvPF+llVvXlu99xvRB/UW2+tkDeRipzydpmYfQ9acYufJZVJWsV?=
 =?us-ascii?Q?fJbTqbmFJf/P6JZWEbMkUtJmTIzfghFMTygq1oCjIuD9NHzUB41+OkdYubJp?=
 =?us-ascii?Q?CHq+LOIauyoDwgViXhw/QdVEoWc3BBDU4ued0m/XFnVjKONcCW3+6adRS34C?=
 =?us-ascii?Q?RaGBmssfA29bqQbEiu8pf/0ysWLpmTqUSxXm3SfGriyJnckHBkOmXalmm9kc?=
 =?us-ascii?Q?tvKz5M/A/m5j62LEHMU/AurZuMQg/LfEKGTCfd8AWw5+8lSFnRSddEXKFf+G?=
 =?us-ascii?Q?Kjt4EDs76ha7pZwFoQKkD1K1Jr5UMr8TsAbgPQpbG6oiOC5VgDmbSbLXOOW7?=
 =?us-ascii?Q?lUQllViFwjWy4ECZPdL+5/B4VlPwMr6KNE0eJFZB7rIXeZnbUUQbosdhh+0O?=
 =?us-ascii?Q?bjncsnZuMQ73OuI7/DhqmY4U5VWJzbT0bpAh85OyjVEvLAL5LJLZdwiq4ZsT?=
 =?us-ascii?Q?zCaZahiec33xOVQ1UPHMLQEGSWNy/3UUQqIdGeBWs9auMsqFScCxIy6ibB2p?=
 =?us-ascii?Q?8nlGLVo+4R5OsCAW76PPEbUFTgdJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 06:05:16.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b72310-a59f-43ff-4c81-08dc6f24d55f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000

Currently it is function local. Followup changes will add new fields to
this structure, and those new fields will be used by callback functions
to which there is no way to pass a pointer of `sched` variable. So make
it a global variable. Also, rename it to `perf_sched` to be consistent
with other builtin-*.c subtools nomenclature.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/builtin-sched.c | 109 +++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0fce7d8986c0..bc1317d7e106 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3504,29 +3504,30 @@ static int __cmd_record(int argc, const char **argv)
 	return ret;
 }
 
+static const char default_sort_order[] = "avg, max, switch, runtime";
+static struct perf_sched perf_sched = {
+	.tool = {
+		.sample		 = perf_sched__process_tracepoint_sample,
+		.comm		 = perf_sched__process_comm,
+		.namespaces	 = perf_event__process_namespaces,
+		.lost		 = perf_event__process_lost,
+		.fork		 = perf_sched__process_fork_event,
+		.ordered_events = true,
+	},
+	.cmp_pid	      = LIST_HEAD_INIT(perf_sched.cmp_pid),
+	.sort_list	      = LIST_HEAD_INIT(perf_sched.sort_list),
+	.sort_order	      = default_sort_order,
+	.replay_repeat	      = 10,
+	.profile_cpu	      = -1,
+	.next_shortname1      = 'A',
+	.next_shortname2      = '0',
+	.skip_merge           = 0,
+	.show_callchain	      = 1,
+	.max_stack            = 5,
+};
+
 int cmd_sched(int argc, const char **argv)
 {
-	static const char default_sort_order[] = "avg, max, switch, runtime";
-	struct perf_sched sched = {
-		.tool = {
-			.sample		 = perf_sched__process_tracepoint_sample,
-			.comm		 = perf_sched__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.lost		 = perf_event__process_lost,
-			.fork		 = perf_sched__process_fork_event,
-			.ordered_events = true,
-		},
-		.cmp_pid	      = LIST_HEAD_INIT(sched.cmp_pid),
-		.sort_list	      = LIST_HEAD_INIT(sched.sort_list),
-		.sort_order	      = default_sort_order,
-		.replay_repeat	      = 10,
-		.profile_cpu	      = -1,
-		.next_shortname1      = 'A',
-		.next_shortname2      = '0',
-		.skip_merge           = 0,
-		.show_callchain	      = 1,
-		.max_stack            = 5,
-	};
 	const struct option sched_options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -3534,31 +3535,31 @@ int cmd_sched(int argc, const char **argv)
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
-	OPT_BOOLEAN('f', "force", &sched.force, "don't complain, do it"),
+	OPT_BOOLEAN('f', "force", &perf_sched.force, "don't complain, do it"),
 	OPT_END()
 	};
 	const struct option latency_options[] = {
-	OPT_STRING('s', "sort", &sched.sort_order, "key[,key2...]",
+	OPT_STRING('s', "sort", &perf_sched.sort_order, "key[,key2...]",
 		   "sort by key(s): runtime, switch, avg, max"),
-	OPT_INTEGER('C', "CPU", &sched.profile_cpu,
+	OPT_INTEGER('C', "CPU", &perf_sched.profile_cpu,
 		    "CPU to profile on"),
-	OPT_BOOLEAN('p', "pids", &sched.skip_merge,
+	OPT_BOOLEAN('p', "pids", &perf_sched.skip_merge,
 		    "latency stats per pid instead of per comm"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option replay_options[] = {
-	OPT_UINTEGER('r', "repeat", &sched.replay_repeat,
+	OPT_UINTEGER('r', "repeat", &perf_sched.replay_repeat,
 		     "repeat the workload replay N times (-1: infinite)"),
 	OPT_PARENT(sched_options)
 	};
 	const struct option map_options[] = {
-	OPT_BOOLEAN(0, "compact", &sched.map.comp,
+	OPT_BOOLEAN(0, "compact", &perf_sched.map.comp,
 		    "map output in compact mode"),
-	OPT_STRING(0, "color-pids", &sched.map.color_pids_str, "pids",
+	OPT_STRING(0, "color-pids", &perf_sched.map.color_pids_str, "pids",
 		   "highlight given pids in map"),
-	OPT_STRING(0, "color-cpus", &sched.map.color_cpus_str, "cpus",
+	OPT_STRING(0, "color-cpus", &perf_sched.map.color_cpus_str, "cpus",
                     "highlight given CPUs in map"),
-	OPT_STRING(0, "cpus", &sched.map.cpus_str, "cpus",
+	OPT_STRING(0, "cpus", &perf_sched.map.cpus_str, "cpus",
                     "display given CPUs in map"),
 	OPT_PARENT(sched_options)
 	};
@@ -3567,24 +3568,24 @@ int cmd_sched(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
-	OPT_BOOLEAN('g', "call-graph", &sched.show_callchain,
+	OPT_BOOLEAN('g', "call-graph", &perf_sched.show_callchain,
 		    "Display call chains if present (default on)"),
-	OPT_UINTEGER(0, "max-stack", &sched.max_stack,
+	OPT_UINTEGER(0, "max-stack", &perf_sched.max_stack,
 		   "Maximum number of functions to display backtrace."),
 	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
 		    "Look for files with symbols relative to this directory"),
-	OPT_BOOLEAN('s', "summary", &sched.summary_only,
+	OPT_BOOLEAN('s', "summary", &perf_sched.summary_only,
 		    "Show only syscall summary with statistics"),
-	OPT_BOOLEAN('S', "with-summary", &sched.summary,
+	OPT_BOOLEAN('S', "with-summary", &perf_sched.summary,
 		    "Show all syscalls and summary with statistics"),
-	OPT_BOOLEAN('w', "wakeups", &sched.show_wakeups, "Show wakeup events"),
-	OPT_BOOLEAN('n', "next", &sched.show_next, "Show next task"),
-	OPT_BOOLEAN('M', "migrations", &sched.show_migrations, "Show migration events"),
-	OPT_BOOLEAN('V', "cpu-visual", &sched.show_cpu_visual, "Add CPU visual"),
-	OPT_BOOLEAN('I', "idle-hist", &sched.idle_hist, "Show idle events only"),
-	OPT_STRING(0, "time", &sched.time_str, "str",
+	OPT_BOOLEAN('w', "wakeups", &perf_sched.show_wakeups, "Show wakeup events"),
+	OPT_BOOLEAN('n', "next", &perf_sched.show_next, "Show next task"),
+	OPT_BOOLEAN('M', "migrations", &perf_sched.show_migrations, "Show migration events"),
+	OPT_BOOLEAN('V', "cpu-visual", &perf_sched.show_cpu_visual, "Add CPU visual"),
+	OPT_BOOLEAN('I', "idle-hist", &perf_sched.idle_hist, "Show idle events only"),
+	OPT_STRING(0, "time", &perf_sched.time_str, "str",
 		   "Time span for analysis (start,stop)"),
-	OPT_BOOLEAN(0, "state", &sched.show_state, "Show task state when sched-out"),
+	OPT_BOOLEAN(0, "state", &perf_sched.show_state, "Show task state when sched-out"),
 	OPT_STRING('p', "pid", &symbol_conf.pid_list_str, "pid[,pid...]",
 		   "analyze events only for given process id(s)"),
 	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
@@ -3645,31 +3646,31 @@ int cmd_sched(int argc, const char **argv)
 	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
 		return __cmd_record(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
-		sched.tp_handler = &lat_ops;
+		perf_sched.tp_handler = &lat_ops;
 		if (argc > 1) {
 			argc = parse_options(argc, argv, latency_options, latency_usage, 0);
 			if (argc)
 				usage_with_options(latency_usage, latency_options);
 		}
-		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__lat(&sched);
+		setup_sorting(&perf_sched, latency_options, latency_usage);
+		return perf_sched__lat(&perf_sched);
 	} else if (!strcmp(argv[0], "map")) {
 		if (argc) {
 			argc = parse_options(argc, argv, map_options, map_usage, 0);
 			if (argc)
 				usage_with_options(map_usage, map_options);
 		}
-		sched.tp_handler = &map_ops;
-		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__map(&sched);
+		perf_sched.tp_handler = &map_ops;
+		setup_sorting(&perf_sched, latency_options, latency_usage);
+		return perf_sched__map(&perf_sched);
 	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
-		sched.tp_handler = &replay_ops;
+		perf_sched.tp_handler = &replay_ops;
 		if (argc) {
 			argc = parse_options(argc, argv, replay_options, replay_usage, 0);
 			if (argc)
 				usage_with_options(replay_usage, replay_options);
 		}
-		return perf_sched__replay(&sched);
+		return perf_sched__replay(&perf_sched);
 	} else if (!strcmp(argv[0], "timehist")) {
 		if (argc) {
 			argc = parse_options(argc, argv, timehist_options,
@@ -3677,13 +3678,13 @@ int cmd_sched(int argc, const char **argv)
 			if (argc)
 				usage_with_options(timehist_usage, timehist_options);
 		}
-		if ((sched.show_wakeups || sched.show_next) &&
-		    sched.summary_only) {
+		if ((perf_sched.show_wakeups || perf_sched.show_next) &&
+		    perf_sched.summary_only) {
 			pr_err(" Error: -s and -[n|w] are mutually exclusive.\n");
 			parse_options_usage(timehist_usage, timehist_options, "s", true);
-			if (sched.show_wakeups)
+			if (perf_sched.show_wakeups)
 				parse_options_usage(NULL, timehist_options, "w", true);
-			if (sched.show_next)
+			if (perf_sched.show_next)
 				parse_options_usage(NULL, timehist_options, "n", true);
 			return -EINVAL;
 		}
@@ -3691,7 +3692,7 @@ int cmd_sched(int argc, const char **argv)
 		if (ret)
 			return ret;
 
-		return perf_sched__timehist(&sched);
+		return perf_sched__timehist(&perf_sched);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
-- 
2.44.0

