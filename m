Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061623D5666;
	Wed,  5 Aug 2026 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964089; cv=fail; b=RS4230h+IQ0bBGw182Fv/HniAGWcfON3S6rUzQ3OewAHWqjOo4RVkOdvEmqlfE/A+Ct8O8c1IRncimZIcZsxY63Y1l6eENiUzS1wxy+s6Hhen2VKNUvFfh3j/ECUAHTIcTiSKWhmWWdiG7ukVozVFhecysJl6+JBSSeVQBoyg2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964089; c=relaxed/simple;
	bh=7EqPAmlImzvNcFQE1Da1ahwzIEsj/R+4GdOawdZnNyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBHN5qRs+421DlSRhhfgo+kShfXzrJqTPbEjBjeimCYJfop6vPnpRd4U1Cw0SnX5OvwcFYbSOUktJ5au/gPkJAb7c2Ce2FJ7LQNR0lvM7hMqHX2nY27vJi6kAkBUfDyGg5yMiJxLEwjRhuo8rXDbVO2yL9JeMEayzOISciiprag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKA7kNSTiUIfHT8Lw9NMXUijh3EIhB3Vo5Mxb1pdKECWqbnx1wDGxGDdomVkdOyZ/EIB2729ZlV42phJaucxini3LAYj8qxdXSLDPAV8z5vtdLDIPiZzuSzQFFOpwLElhoIjiOsubnjzYnIsEZwwR8iQniqMUKpfuYEcoBMveporOa0DvWdRML6gZKa1NIZIdI4lqJs9IegdsrjWK+TMEOzNEFJPsRtMEKAz6MnggHQOTy7zGFPaMbwsvHWrlHcyjiiHwwNmKQyJ3GHVGi/CBYg3Nv13bjGHBf1g+jVVYRWt3bE4v4dEBgvvg4IFUkC4RVCFVApr1PQQNI4M+HBzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vgWpiuorL1TaBUrNy4qZHGl3ScRAZbDX7w2R7UOEW0o=;
 b=gIJp5q+mmv5dZkcAxTMzZKA7lS07E/2H/uXMu9VV2rNd6AT5+az3ETBzGtJU1/D28n+//doie08oF4tUcJk1nfc2cq+b6vMNTFHqgkgdSHAx+5Fnlq8aC7N+Uv+X8Cw/f1QSBVKW/05boA0XWyni5CdJeIfzIGhUqNCXhTS26Zpi1xa72aNHo7874WIbDN0yTKr8ya4A4NUyxcPUWMgRcrmufBVl/8UvcJtRyKRbVgvDmjTyEjuqaAPDppNIHmepShRJpKLH6LsPK10yJk+aVPnwb+oaG8kyx3xDXST6/mrjS4prGn2xtk5zLAVVbouiHcINu6sSS/JG3OuKpqLCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8157.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 21:08:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 21:08:03 +0000
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
Subject: [PATCH v8 2/4] perf sched: Handle missing trace samples in pipe mode
Date: Wed,  5 Aug 2026 17:07:49 -0400
Message-ID: <20260805210751.287746-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805210751.287746-1-atomlin@atomlin.com>
References: <20260805210751.287746-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:32b::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d7abcb-2f02-40d1-ad58-08def335a393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oIqoKVwX+R2QdoEY50Lve814vAu5eYP0jihm/B4ttczIA9fY+/njQ+3lmQ3sMzQkVjqWRNqzdRDKM2GJiTWxYoLwFGEKcLxeEcU9JY9KwB67W8hTaJgFc7tjmFTCeSwU0HVPvW01fkK2gk3mkpxnId5Y0NRaR5iDiWUU2yRglB+2hFlAHgBTDd8Pqv1+6jx/2R55GzfcHH5lwJw6z/7Ead52lSawKg6PPTCcP4EbDJLelD1ayBP1Noj+OP6zw8OL0/x8APTfc1DqgYAbIizy2kQMJWIShGEeqLfbj1w3aA3Df7XmM5wQirOHQHOXtHCHMvuhQZiMDy69gvYgb+RftXloj5MDSVpxU7xCSBtoL9HzzNroyNh5fUo7zUuDdPWK5ClsdnFVWtLuF5g28kOsgyCilcMMTynTLgB3MjZIgpardkwkQk4rebGwwyvq5/uLE+Qs3+UKDjJQbT2gzdYuxa8K/+6ZnwvJ1meXfjND6vOfP6nawB4k5Qp8SWl6ne88jwWfqHf/zQhoGdq1iTJ6zktFXfTkyMidRjba3Tyeijrih36SxTmMhe39eFkGoE6Vi+zFq5zm+bY3IEY+8HexbzSZY0vFQDqbQcNpZW/KkU91bn+ignVHkNBwavxCP/szJFGKFMeSsQfxcF7brsH8/g7djgAXXHhHmOWxaYmTbkk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/aN8oLwVTle9iDa6utHnWgKoTgtqJAhYe1FfnkGkQQiZhGydxIkRbSWNsjJh?=
 =?us-ascii?Q?OAzFth6MMyn9KbiQz6etKPRYdZkDKNR1rvnu8MXecQ+DXSUp3C1z1nenxNnu?=
 =?us-ascii?Q?NmrU6tZG8orvSuhzVRFlRK4kxRrEii6NnYlFi3hIDt9xH765fBZHahEMZXjs?=
 =?us-ascii?Q?Sj6TPGt7SnBerDmJj5bt+8D/bbZmCzhJ9pyRmbbKs7xl+qrtVWVuJvWyKrBe?=
 =?us-ascii?Q?2nawpMcTKzRuMW6AP4O4JF3rY2STUY9DulQbRltAvqzWoUa0m9EDmGPC75KK?=
 =?us-ascii?Q?q1iQEI6tmtfSUyd2e4qrJGLoBu3wTWfXRBtq2PaAplj7zsPne5RagWzNdwa1?=
 =?us-ascii?Q?zVN+xXS1CkeF/Xs71uDJGb4Q3bv4Q1IDP/f6ScBTf12uzjVxaUNkSfBCtlI2?=
 =?us-ascii?Q?FAVmqfooLWhbMD4Wu7ZN7UdJY5xEQQbqw6ANEhlaq5/nN/xWpgEFTwZ7gtMv?=
 =?us-ascii?Q?HKPwz9ZPxTCatUocznaYPWBk9qi4xNN5XQ3kK0iGgpUxA5rCFCZlQ7uGRDUA?=
 =?us-ascii?Q?EZ3RKCBaeMqwcrCF+i6y5PU9z5cutodYTzXiO/5KXMGOgwxpSOJZiAokbRfi?=
 =?us-ascii?Q?ku5KdweuHqNGV/vVB+QR0+i8JJDQeC/fsjgjXee8TDYnYDBz2xoLH6Py8H11?=
 =?us-ascii?Q?pFlLwcjRe10nQ2HBV6iQ+2Zg6fe8L40hxcsB1goaexjJ2s7lNQt5qE7RftZe?=
 =?us-ascii?Q?oVAboEW5VxmbCrbc8WhJ+1OnSbF7O5WXuNz+3feL9dpb0crEpijButQnUK8U?=
 =?us-ascii?Q?llCkXAjGXGJnB1fIWHxZIZ9CcMv0qxIgeh+RWzxdaxBLxNLTDTT8Zx027yfs?=
 =?us-ascii?Q?iPXL6PeuZrdZaIC+1bi+8J/zSaGSSz5FxMwtPVHptlxHp+fztsu+JRPu67vJ?=
 =?us-ascii?Q?ksGfIQQitc2wRMuNmXphf03Ao78kEyFbM2mEVaMlsUiBsIsc8sttA2oSzmZb?=
 =?us-ascii?Q?zfXi6HtgaqAXslof52ISn1aSGWMMMUsVVBY0x5+39vdy8WkfOtkagAh/FfVv?=
 =?us-ascii?Q?ir7nUGdP8uA9qgRDFbRXXu4ukdII2YsJYT/TvRURDEbYutxKQq+8pyyioTnx?=
 =?us-ascii?Q?tJ3dKIqc0mcE02dh0CHhr3J5hIFIkT+6yu7Nb5GPsi0qzokNDUWjORyO0Cqn?=
 =?us-ascii?Q?sYAfv8ABViR0Cv6bvHHFNp5i5mDdZA2EoNi2mYY9XkfsYUFvvizuEzCBhOaN?=
 =?us-ascii?Q?VXwpkx4+XKzEm+QJ2owMit/Byys9tfii0uZGEx/h5DZ7nbSM41ZiJeHuENt6?=
 =?us-ascii?Q?IROq2vZ6XQualZeLzPIJaVAGS/2xV0JTCqeMcz/6ueau/FrIWjZEN6PCfCAs?=
 =?us-ascii?Q?r0MAJAXT8/rMQ33qvO4uYrYjwYfQyKA7O3LaCwTNY1P7KNhcQ0du81ZOklD8?=
 =?us-ascii?Q?gy8Ut6CwOgFXRd8VWmGXhUfHMS6a5fFjqM3/kqXHbpZvMqAy0LyJkoXJ0gFR?=
 =?us-ascii?Q?2ym3j+3K5LUTBMjtS6JusJpNrTyr+OsZl4Mt1yVGtGUmptvRUB+7N6fzW6F8?=
 =?us-ascii?Q?r/8xiEJ5O59U7YNEAIAozGazOuW5WO0qLEKcYawQ4O1vNr0O4dw/ZjnH+6Fu?=
 =?us-ascii?Q?qfOsOLYcBmyBNxh5DPwvAqQvwHjoqCO/wUs318CgiJlPVaKQhaURNJzfdq1Y?=
 =?us-ascii?Q?iSUE815RUdJB7+JzHJtiuTO4P2UVcGzz5MnfLfyogzW/2S6QVFccRrO/AZHd?=
 =?us-ascii?Q?z4NHx2wnVi+HaVQmQ232mrYbfLV8jzD+LOJHiNeTsTz8TPQnQ31aq/wuxNLq?=
 =?us-ascii?Q?7yRfhF1pSA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d7abcb-2f02-40d1-ad58-08def335a393
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 21:08:03.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJFEeLT+U+aa8gypbjce23+7S3W/7mHS8FsVUunFRbyrnvc9eM+30TA0RyKRiVCOh98cIwqS7/phU80glC+KPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8157

For pipe mode streams, event attributes are received dynamically during
event processing, meaning session->evlist is not populated prior to
perf_session__process_events(). To handle pipe input correctly:
  - Register the missing .attr, .tracing_data, .build_id, and .feature
    callbacks in cmd_sched()

  - Promote the handlers array to file-scope (latency_handlers[]) and
    dynamically assign matching tracepoint handlers
    (or process_sched_ignore) inside
    perf_sched__process_tracepoint_sample() when evsel->handler is NULL;
    replace process_sched_wakeup_ignore() with process_sched_ignore()

  - Perform the trace check post-processing when handling pipe data

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 72 +++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 94a323da0799..d6b4412045e2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1581,12 +1581,6 @@ static int process_sched_wakeup_event(const struct perf_tool *tool,
 	return 0;
 }
 
-static int process_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
-				      struct perf_sample *sample __maybe_unused,
-				      struct machine *machine __maybe_unused)
-{
-	return 0;
-}
 
 static bool thread__has_color(struct thread *thread)
 {
@@ -1938,6 +1932,22 @@ typedef int (*tracepoint_handler)(const struct perf_tool *tool,
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
+static int process_sched_ignore(const struct perf_tool *tool __maybe_unused,
+				struct perf_sample *sample __maybe_unused,
+				struct machine *machine __maybe_unused)
+{
+	return 0;
+}
+
 static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __maybe_unused,
 						 union perf_event *event __maybe_unused,
 						 struct perf_sample *sample,
@@ -1946,7 +1956,23 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
 	struct evsel *evsel = sample->evsel;
 	int err = 0;
 
-	if (evsel->handler != NULL) {
+	if (evsel->handler == NULL) {
+		evsel->handler = process_sched_ignore;
+		for (size_t i = 0; i < ARRAY_SIZE(latency_handlers); i++) {
+			if (!evsel__name_is(evsel, latency_handlers[i].name))
+				continue;
+
+			if (!strcmp(latency_handlers[i].name, "sched:sched_wakeup") &&
+			    sample->evsel->evlist &&
+			    evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sched_waking"))
+				break;
+
+			evsel->handler = latency_handlers[i].handler;
+			break;
+		}
+	}
+
+	if (evsel->handler != process_sched_ignore) {
 		tracepoint_handler f = evsel->handler;
 		err = f(tool, sample, machine);
 	}
@@ -1987,14 +2013,6 @@ static int perf_sched__process_comm(const struct perf_tool *tool __maybe_unused,
 
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
@@ -2011,14 +2029,17 @@ static int perf_sched__read_events(struct perf_sched *sched)
 
 	symbol__init(perf_session__env(session));
 
-	/* prefer sched_waking if it is captured */
-	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
-		handlers[2].handler = process_sched_wakeup_ignore;
+	if (!perf_data__is_pipe(session->data)) {
+		/* prefer sched_waking if it is captured */
+		if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
+			latency_handlers[2].handler = process_sched_ignore;
 
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
@@ -2027,6 +2048,11 @@ static int perf_sched__read_events(struct perf_sched *sched)
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
@@ -5168,6 +5194,10 @@ int cmd_sched(int argc, const char **argv)
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

