Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022107.outbound.protection.outlook.com [52.101.101.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FB3932D3;
	Sat,  1 Aug 2026 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627623; cv=fail; b=sMK1Ay+75zzynpVa/IqpyzJnmLuOiW423a+YhmJqGMW4F1APySvxp5Vmnlked6H4QP4oeYcZSVmcIkdWEJjDj1pVSq4Sd0W96+n5FcqMSuIe4pXZCZkjgv0eNuyrVBSbsR8R5vvF1Euc+NUEPu/VSoZ4AhA/cydFUb9hsxnMk6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627623; c=relaxed/simple;
	bh=NIW6BR6ZRmV06frbxjJ42hzDq0HDUFNMMfwxVOJs7/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oBNbV2Z6UOc6eTg7ISOO+KKxnOnKfs0utWZWaHZJdIn09TdvOMlc184AUNGl9K13NXVb16FYU9rnVdEaOBJfIaD7cAuTsGJM3bgsXK80rLx5XRLMeLozDIJ9TYOxE2HYAEgK6TIkzfTQQatvgupsX2oZcX6LdF/fULM52SfKjY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rK3TWW1rJ7ehsTldDG7p4Kx1DN/Ok8jzDoht2eD5muEqwSAvwI7bHktYQYPGQ2t19vA9Twxx0UDy26qRKqWLSlNE833vQdEOfKBMBOERymruZ0rflC6W7VpoDAKaxWDttoVQ7Cnom2xSkgtflJrqptFJChVpssGu2dZbK9Tq8p5+okQaoC2l3SRXZo6U/DnMwKGZo62uSgLmVjaWUEuyLvNfMV8R3yAoCEL+jAT+O07mnj6f8RK8lg1jn87SsqVrab6Ng+dtqCcMotMtxuBRjkGPRqnBAWcekkFAR0DHm3uURNSkJBBSXvlaIz3FNHsbIpm6jYc7O0HqUHuOEbbV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+Cer140HBasjB5wd71BGfoKpv5v4wr8TdNy2U3j0WqE=;
 b=Ilh1TWfmLwS/LCo0FhUuRESZTv2SxYnWAfGQ2XwG7iHOMoT3ieHSYfL900SSMrbXmQxHrRVbnVLwQmVSySFL4CY1g9KDTXkY0x4Go/+k/KgqjiHpo4LiKEhkLEQmqC96WuH2rUD3QdAdZZgbOGAgXlx8jD6pNWiZNO1HTFZr9eUiFAoz+kFN02fGmqA7Zrov0JF1b0EEkjP0EVRlY12dAsNMVqnlKqkuFafk0uNH8cl/gKXk1qdfBRjtSlpjLld5phFM7N3/BlU6iPn8vTNVGwfdAPQulSwEVbG+D3ENUP+Uo2XOf9kb5Mxd0TZsP4WcHPyw3FcpmJVB+HijUeIh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8812.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 23:40:19 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 23:40:19 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] perf sched: Handle missing trace samples in pipe mode
Date: Sat,  1 Aug 2026 19:40:06 -0400
Message-ID: <20260801234008.176724-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801234008.176724-1-atomlin@atomlin.com>
References: <20260801234008.176724-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: f6987c15-8d37-47ae-ff9e-08def0263f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	yzYnE4YS/GeJkdxw3eWkq12ROSD3+ZXL8cmuWBKc6R31bOgzOvGWeJfALAJ7ZDlLjWOVnkJS0xWyMEwpOnOJ2ndGG4SFQLLFnv/b+SixLwIdLhh7hPYKsr5vfeCmT5d7qr6mdBbscDzf6GGBVDlXjD+UUsI52X7mOl1AQOKlCZl28EmYDqBQEBdSz5KAmXLmit1fEes/E+8DCLVdJa004Dpc8jlc5flmj11mAIAr9m3k/wcBD21s9teHyZP1N8CHTWKgyeoHh+Gi6z0LEva5sb6EWWzYmKSmbCxz+yhO9OarXA3H3GvjjGc+zQtl+lCe5b37Bj03fNlwDwkUXscRb24jk0/1BGCWELPvq1amECnz7SuMi04yZZrK+p7lQRao6Q00fB8Im046iMYwmaHGhQeig+wvqVeqSmHYVTfGpiDnbSBvwrruAVPvgM60PXlb7af9mireAicEzXv7RQL4cMXaLAGmuh5xXeU9NbZOysUdVxdy/69RPxgkGKUFTVzUjb8BRCayheSoyXN6KWdee/+jwtVGJ1KPBJTBPkh7AlIjzD/0u2SZW/SjHOxim5FY57Al89LJrTQEbYEt1ECmx/4nxGf2cfhCd48GYB0PzTaotKMs1QS2X48kI54FBruErn/cLw38DaqrA0L9roW6Lx+e3X2TKwg8R66rvH7/KV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lMwYAa1yyq9cMLmw+D+NN9JFIy+BYsTyr4TYnJfdf9fxQICwa8o3gCyqCIUy?=
 =?us-ascii?Q?OAI85knBt9j3UAhC9GuTx5a3sd/01QNrmI6/cqhoyxAM/gS0mM+EYMxOEEpB?=
 =?us-ascii?Q?o/mHKJ2XiuN9rAAmQWqUL0FCLqBFPHsqG12xLqBFQwrLf7yxvlp4J48yIbyS?=
 =?us-ascii?Q?S89C20esJqJot3YcJwFHTurKN9IlnsPPjYJCMaVU9X8HZa874khcEOtT8xod?=
 =?us-ascii?Q?LDW8eiKlfERwv2NTl6RhHqgeU8tfFReRYa3pTCpCAUsgiwvJs9ngk9qYTsK4?=
 =?us-ascii?Q?lVs7xxj1ccTfbOtcGKITnMwM15zMXx3CThJlK68oOnvGVqfy+DEMtOSBiKSp?=
 =?us-ascii?Q?oy3xAwDVFHZhLaQP0enZoLnTmaXCB+0yhsX6n+KqsQBGuIxizE5mnyFmCKIH?=
 =?us-ascii?Q?7X98NSuJ7eCVsLTK4IFXpBOAUR1L5CB+bYhUIOX2b3IM8whlZDlXiE1H0EKz?=
 =?us-ascii?Q?CrF5YaqvLMH61RaNnfvTNptJprJrKqlVNJk33m9WU+qsbL55pGuSLvwG8GDi?=
 =?us-ascii?Q?EF/7f/irlEA91RQViU4cxf++XtfDQNos0qhiP4GVtzoelz2XwO2kiPqxPOp6?=
 =?us-ascii?Q?u2fzujScFWYT+me/1pbDtS5lAhrPPReD9C9UK7h290CUs+OfFaRG38PJP7uR?=
 =?us-ascii?Q?2NCP2ih9gEZL5AS/JpDMVeMhATkXRy3+1lhGSGLj1UMhebO53RjE+ua88AYZ?=
 =?us-ascii?Q?6YAc+xIPcEC1gpaujQbhbByAb7Di7Ym9LzRew5iUNJDKh0UsPf35fVYIHAIQ?=
 =?us-ascii?Q?usUY8W5n+75LDq0a+hLENDPNRJRv8vB48vyfb46MSluR3pfSMxnc8AKHWIXA?=
 =?us-ascii?Q?GhTMZxqq13mIeMucgeL4R1XNIao7PqkXhZgodnKy9CHOLERDHTKzkhhnQ4eZ?=
 =?us-ascii?Q?JSSWiPIhC8J5PMqmRYO+l+v28xKIqeizZeinINfTxWGb0ycFMYiyUtyc7KPN?=
 =?us-ascii?Q?Cw8MmXOTghk0UCo0sfqZaGMAm3ufvtAsWzA/WJd0Bvddg3aSzTWOygfyxqay?=
 =?us-ascii?Q?4PF+ZozMDGr/H9yxhperrGwaME7ulFM1Sh0W8dzX/v+WP2zbaM3UlZ/J1AX3?=
 =?us-ascii?Q?Tm1CziLRIVotoUJhvifjAVZ6+L9q+K+9OwyeZzu9nhpX9HL50MYLgvCTpaoa?=
 =?us-ascii?Q?ToVgG6wevHeooMaci74lurG92TDX5vKic5Pk9U5PaJSPO7TP9TI/gxk04ohZ?=
 =?us-ascii?Q?NxVnNVBKCH8Q6uAuahxGhHQhp60xWW2Gvaa2RE2ffOsHvD1dJbse5WxWcfGG?=
 =?us-ascii?Q?7yWMadnZDCIBcbdswClyFyYzKCmfa8cCAkN4F5FkxCpTtWLo4W49ybKJwG/e?=
 =?us-ascii?Q?XgfcSZBumHNhgeWceHBt4l2qzqDPoznbmIYZw/4B16xlPa0ieukHV9AkFmTU?=
 =?us-ascii?Q?T5Xw2Dh3iYLauTKBsWskLM8ZJkeIgve14S/bapIP21qbDYtU0727kmv6ygEy?=
 =?us-ascii?Q?8FgcqcQ2zqQMk30llPC+M980tKePro3xeF1SqJSdcqqOewLBmRJfo7znFXyb?=
 =?us-ascii?Q?vowPSsmf+L51C4CiSLxmft7KIxbow+f5751LmtoSOk54em6TdXiz2dJ5pBn6?=
 =?us-ascii?Q?BOfYp0tlPmjfjf+ntwtCLFbGxfBH1Hv8UzDxi29LhChsWlvrOq5owgz2hI/z?=
 =?us-ascii?Q?XW2GG2IbQ+y+JEAt1E2Uos8zB+rhfd+b5cAouFCxq5GJT1HG59ZzNcHnHb51?=
 =?us-ascii?Q?0lf3cXTvE3PRR/H2Hb9YTzRdcxk57/RGAjJcda0vXxq6thyhtc6tRv5LW5BJ?=
 =?us-ascii?Q?jnGCdBfXGg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6987c15-8d37-47ae-ff9e-08def0263f2e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 23:40:19.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efKhkwFIbn+WI4kHwU4ZNTcvNAtJrgIN2pg1qf+77/LnRuEC7XCPJ28e6YaPn8XoC1a1SeeZSvP/D0pmQPRxLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8812

For pipe mode streams, event attributes are received dynamically during
event processing, meaning session->evlist is not populated prior to
perf_session__process_events(). To handle pipe input correctly:
  - Register the missing .attr, .tracing_data, .build_id, and .feature
    callbacks in cmd_sched()

  - Promote the handlers array to file-scope (latency_handlers[]) and
    invoke evlist__set_tracepoints_handlers() dynamically inside
    perf_sched__process_tracepoint_sample() when evsel->handler is NULL

  - Perform the trace check post-processing when handling pipe data

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 49 +++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 94a323da0799..0abf9f1f3c2e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1938,6 +1938,15 @@ typedef int (*tracepoint_handler)(const struct perf_tool *tool,
 				  struct perf_sample *sample,
 				  struct machine *machine);
 
+static struct evsel_str_handler latency_handlers[] = {
+	{ "sched:sched_switch",       process_sched_switch_event, },
+	{ "sched:sched_stat_runtime", process_sched_runtime_event, },
+	{ "sched:sched_wakeup",       process_sched_wakeup_event, },
+	{ "sched:sched_waking",       process_sched_wakeup_event, },
+	{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
+	{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
+};
+
 static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __maybe_unused,
 						 union perf_event *event __maybe_unused,
 						 struct perf_sample *sample,
@@ -1946,6 +1955,14 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
 	struct evsel *evsel = sample->evsel;
 	int err = 0;
 
+	if (evsel->handler == NULL && sample->evsel->evlist) {
+		/* prefer sched_waking if it is captured */
+		if (evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sched_waking"))
+			latency_handlers[2].handler = process_sched_wakeup_ignore;
+
+		evlist__set_tracepoints_handlers(sample->evsel->evlist, latency_handlers);
+	}
+
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
 		err = f(tool, sample, machine);
@@ -1987,14 +2004,6 @@ static int perf_sched__process_comm(const struct perf_tool *tool __maybe_unused,
 
 static int perf_sched__read_events(struct perf_sched *sched)
 {
-	struct evsel_str_handler handlers[] = {
-		{ "sched:sched_switch",	      process_sched_switch_event, },
-		{ "sched:sched_stat_runtime", process_sched_runtime_event, },
-		{ "sched:sched_wakeup",	      process_sched_wakeup_event, },
-		{ "sched:sched_waking",	      process_sched_wakeup_event, },
-		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
-		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
-	};
 	struct perf_session *session;
 	struct perf_data data = {
 		.path  = input_name,
@@ -2011,14 +2020,17 @@ static int perf_sched__read_events(struct perf_sched *sched)
 
 	symbol__init(perf_session__env(session));
 
-	/* prefer sched_waking if it is captured */
-	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
-		handlers[2].handler = process_sched_wakeup_ignore;
+	if (!perf_data__is_pipe(session->data)) {
+		/* prefer sched_waking if it is captured */
+		if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
+			latency_handlers[2].handler = process_sched_wakeup_ignore;
 
-	if (perf_session__set_tracepoints_handlers(session, handlers))
-		goto out_delete;
+		if (perf_session__set_tracepoints_handlers(session, latency_handlers))
+			goto out_delete;
+	}
 
-	if (!perf_session__has_traces(session, "record -R"))
+	if (!perf_data__is_pipe(session->data) &&
+	    !perf_session__has_traces(session, "record -R"))
 		goto out_delete;
 
 	err = perf_session__process_events(session);
@@ -2027,6 +2039,11 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		goto out_delete;
 	}
 
+	if (perf_data__is_pipe(session->data) &&
+	    !perf_session__has_traces(session, "record -R")) {
+		goto out_delete;
+	}
+
 	sched->nr_events      = session->evlist->stats.nr_events[0];
 	sched->nr_lost_events = session->evlist->stats.total_lost;
 	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
@@ -5168,6 +5185,10 @@ int cmd_sched(int argc, const char **argv)
 	sched.tool.namespaces	 = perf_event__process_namespaces;
 	sched.tool.lost		 = perf_event__process_lost;
 	sched.tool.fork		 = perf_sched__process_fork_event;
+	sched.tool.attr		 = perf_event__process_attr;
+	sched.tool.tracing_data	 = perf_event__process_tracing_data;
+	sched.tool.build_id	 = perf_event__process_build_id;
+	sched.tool.feature       = perf_event__process_feature;
 
 	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
 					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.55.0

