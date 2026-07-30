Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020107.outbound.protection.outlook.com [52.101.196.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2445FFAF;
	Thu, 30 Jul 2026 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437669; cv=fail; b=bx0LiBpIjMyS29CRGJL47eCJgkeOTqjuQMUdZHc603h7tof7BOzD8rt2iN4jEalA6Q6cswSNiNrZKx5tM5uDveYXx6zoJuYdP6Jd0VKHCW13p14tJwnBnTDps2B8XxXSvCS80QckxSQIOSenXO0veTrWB5TeKHwWQIfA7S08f6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437669; c=relaxed/simple;
	bh=Sa75FXvDuFaPgS68ayTTj4tOC3YpRADIODaQgqDuBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2iFBZOoTZcyV7U4cFixqD8wv1Y2p4Qu/3Vtr2J8VTpUopCs/zZbY987rH5T6QhIO8dCiAoqfv81kEY+228bA1RKHAjevMZT3pn/FOA3FLD1QyKNZ6m0ydxw/Ud6XbktE4qzzfSZLmU5NhyYlloYOnlgBYkp1DNvUaFiND/IcTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/+uhX8JoKhsQOo0kkqTapjD9brYMo1/qX46F/6QaaER9KqFPZAce8iwc4+B3c3mdJlj+G4nUcQqQUniErddPihP09ERMUQzJom5Idy41t9pvgVdSRBxMHdfb/8STVn0BGmUpBEsOg1eHNqnzH0aoyIiqhsjFXnDcMnp02RklGblVE6jZ/GIc0csoBuiARXSU4Uvjcg0bSMYCtODmuGhaFNZsAbQkdvzjuCkwGt44Gighl0p76GaBgduDAY1nM0m82mLDa0dYhJQONuVtEyJuF8/S6TO9AoeBzseuMUlB93TvOur1I13ieMjGvSpFNS1M+lb1tKkf6FX+8M3Iq8NMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AzPL4l1Jvwyiv1nWyKinS3vpe82qpgbjMTmKj6a1XPs=;
 b=B46T3xOp2oS89I++7adr7zk8MZ3mEkBubYJbP608zwMUdG5SYHe0rpBv3VsPXyI5XOoLdQquBKi0L1RVVPh210iQcdUP/4P086cmkyqgJdsxQGr3l8N/lh4OQZOP5Z4+Lx2ejRafGCoHYgANQWaGbRjjlrvwOMS9ti1aXeuhvkzaxqhjajwVROb0ti9xPdJqgEu0PUlAiv3ZaL1XC3OZC5qychDSPKEsCtY6NcxiMFr2aXNxyyiVbKShxfttGiL3f/OhXheuef+qdc+TB4tMQCRjwT2C+eid73pG0ngWZd/I6ZISHkNFt4oGGo028IG0gFS6L4EMzZiWuFjlfN4Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3654.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:54:24 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 18:54:24 +0000
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
Subject: [PATCH v5 1/3] perf sched: Suppress latency table output when trace samples are missing
Date: Thu, 30 Jul 2026 14:54:14 -0400
Message-ID: <20260730185416.97166-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730185416.97166-1-atomlin@atomlin.com>
References: <20260730185416.97166-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f9c883-e492-4cfb-ee4e-08deee6bf952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|5023799004|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	afcF9lynuwQwkwW94qmsViWJwnbDgdgC3jFL8eVd1LqfOU65PchRkmd1iJpuNvdMViJMZfXZ72lcGMB7iw9EXSoIgEAL6IQk124Hl5jNki5V+HLcWde7KWDJbA/QUIT6iyfFXrFN+9mJTaiwRPhkrp0OU9js/FfoG3K3cXydwJGPIBnHdg1QGbMtspAHCqD8rP9rhJb+Xep1ErbzhEtzPzLpZFXoh13izDK/b1nQXmMLDXsEb+Uk/n3rRoRIhXv3mFATtGJYncdQRN4xSpdyPWm/kEAyxdG7kLWuKpFscN4nId+7FDuJRmZV0n3poEiXWBiWW6VgJhOvr2OxIsOEZzGw3Wwhxc7qOrhgP1HWF9LCLdi8+tgjdtwc+xHrzK0jRKrhYwftzqaLUY/aymdbs701hpGaIniGLR5fn2oyBcB3ARw1l2fanUN6im6zKQlyJKeEFJjWJmnMRjCv/YeNeUmp1b58ax5SCwXZhEuVq/DrMlmbV19XNsDqJr+1CI6Gn4IqhyOXhgQT5s2CToO1U4Y9hvcgd9s2eyfGOB3UAXowV2jEcXPSowsGvEhFIp7OwwR+obIAKKzPCqjzERrvGnR+igOsRxf5WSZjsmGU48nto25JQuVDkOtk95bEfIlCg9aOdhw1gYbE1Usf5Y3xvPC0w87noARU0msVpe0HlPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(5023799004)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6WY21n1ZGZe0WZA5GOSUImjBuZJL0BVHyujbltnCtVSuUUgTmkNV/L2kuDh?=
 =?us-ascii?Q?aR04gOYeG5HqpQND6orHOMk8t4rzpxkvxZ6/dihxrSBFrj85pjRidqJAJxvR?=
 =?us-ascii?Q?UaEukByBYl4GilTY+ajrNfZOVPinfFBkyaAcBqqUWCbrS6oO9nuFGLHoh4ls?=
 =?us-ascii?Q?uKkMx25AvDcMPcfvAXOyLHne3+weOV5sIXhDhpdZKv8StdOIjSdY4p9fhzLc?=
 =?us-ascii?Q?hNsNqTQQ0Tl+ncItdUKyOsy7MVQNI+PRzDUTLdPL7HOMtFIZBoRSkToO8B0m?=
 =?us-ascii?Q?4QuLqBw26tgc+g57gP4mhr7ksS11lPfRq3Ma0VhyAm2tRuakkV0/LAp2MJTq?=
 =?us-ascii?Q?kDe7lSkDHowf35hz1dxddAXHo6BSP7VuanFB7rJYydu5Veo6oTVAiMlqA2mo?=
 =?us-ascii?Q?sxvRVhczPzqHfMc3hV1sF2E5YWunZF5bCRnDtCl2joPRvydV0PaRj+1Gr+Y+?=
 =?us-ascii?Q?f/biTRc5ym8t7ut/+Zw+7v/305HhCYJqp3hKz33iZPhWrMKoqbAYkviQKaBe?=
 =?us-ascii?Q?MGOop/SqZXkJKsN1ZoHOUOqG/itSoH3TgeWdpngLeh8wmlMQ1uKud+h2wgBb?=
 =?us-ascii?Q?5xnmnEPOjO58ISAkY4ddad1CQujC24H31BcxnPabZaeXAt5+Hc/jszw7JgBm?=
 =?us-ascii?Q?PuUaUFsS3oaZ/qL4hGHco6vL/ePJ1MYorbaiSY7J7ifeoC/bYm5ehD8wRNG9?=
 =?us-ascii?Q?CPsgDEtj9iVqvsOsFfJy4WVZlVLNHWLXtHhOgOMcVOfQ9FpJbj5By94FglQF?=
 =?us-ascii?Q?s/uMtVwGrCDBngUwdpxI0GO8j7aVMPt1abQRJSlQp1N3r5k7gNq7xO8SMiFK?=
 =?us-ascii?Q?h6BdTwkOcub+eIOc6bV6WJY1yAGfAAk+EKSqOvXswmfd2HJC8EcspbghH+8m?=
 =?us-ascii?Q?dgpjZnGfiVPat45R8U+7JuM8t8OgPEY2ERKVqbT9asQra1xK0ijmD98k1aZo?=
 =?us-ascii?Q?jYj2d2sqTLIB+pO6FNV4/yssfaLBkF4SM6bLQ5mXqcjBe3ixBWSAPaGl7DBU?=
 =?us-ascii?Q?rJsX5yNN1pkm60mV9+MYjgxMytUeUj7NWJONgdPNtNWES6miy1VfgZ0haDOp?=
 =?us-ascii?Q?KLcWBp6jcsOnOsUuglQI9sP1xeXG6M3/T16rK375vo6hQDMTCXsXx4Yr0pkI?=
 =?us-ascii?Q?m7iU6Mi/UjlGOLYOSU25+h9H8w4QVfyH5sGoiNBoI4lcVBSYRJ8qM5Rmikqw?=
 =?us-ascii?Q?OWGjRuqgZnYSIMRiRRitzg2ZhDStAam/Z7Cgw6v1Bx92sRrlbll0ylCpU4Ct?=
 =?us-ascii?Q?b0+4hQgW5fFA/NLiJgvy34RwGbQODy0ETFDCAAnsxvGE+ea60C+Q6oR2Vs/l?=
 =?us-ascii?Q?qyEN+dCvFv/HomeW41wyWYwzdXF3Pefgkce46VM4r8DoTwLTJ8NOklW9DHJ+?=
 =?us-ascii?Q?K1FtibO7FowM82wk7x2NuxozF8fJZ7RVsC1t6fxxMXqZMqvsPK7bAz4cnONm?=
 =?us-ascii?Q?aT8YH93V61VE2NTKGxlDUhvWjjT4bA2TDpBvIJoOBxgfueBNoa+RkPPlnOYs?=
 =?us-ascii?Q?eBmjUXc71LKYEfeogslhyBxWqEOTLfEGoC5k/l//IkKt3/xzYWoUWYn44e3X?=
 =?us-ascii?Q?AxfiJ7pcET74ikXCU9E4xMpuyO8sYH5uZQ+xfOrJV7hXMR4BRdh6JW3qZvfY?=
 =?us-ascii?Q?rSNWgxFhyl42i/caVn+mje8l2k6mX0KG9jvPlHwDm+HFNCyHzLIu3OPRC0aH?=
 =?us-ascii?Q?JeqaRy1Mo2MoLeeQSu1VWkuLNALEJGEbTYvOIzg+B0VgBS7VrysXR6+jXIS4?=
 =?us-ascii?Q?B9m26JttpA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f9c883-e492-4cfb-ee4e-08deee6bf952
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:54:24.6493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXPOnnmsH49MaV7PNSdK5WCQ9WSDGt+/pvM+TEcMqQAK+XJkURFpika3B2g/XE2mir4s378wI0AECw08i9hurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3654

When 'perf sched latency' is executed on a perf.data file that lacks
tracepoint samples (i.e., a file recorded without the -R flag or
containing only non-tracepoint events), perf_session__has_traces()
correctly outputs an error message. However, perf_sched__read_events()
subsequently falls through and returns 0 (success).

Consequently, caller functions such as perf_sched__lat() assume event
processing succeeded and proceed to render empty latency header tables
and total summary statistics.

Fix this behaviour by ensuring perf_sched__read_events() aborts early and
returns a suitable error code when perf_session__has_traces() evaluates
to false.

For pipe mode streams, event attributes are received dynamically during
event processing, meaning session->evlist is not populated prior to
perf_session__process_events(). To handle pipe input correctly:
  - Register the missing .attr, .tracing_data, .build_id, and .feature
    callbacks in cmd_sched()

  - Promote the handlers array to file-scope (latency_handlers[]) and
    invoke evlist__set_tracepoints_handlers() dynamically inside
    perf_sched__process_tracepoint_sample() when evsel->handler is NULL

  - Perform the trace check post-processing when handling pipe data

Additionally, validate thread__get_runtime() against NULL in
map_switch_event() to prevent potential null-pointer dereferences.

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 68 +++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7fd63a9db457..0abf9f1f3c2e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1833,7 +1833,7 @@ static int map_switch_event(struct perf_sched *sched,  struct perf_sample *sampl
 sched_out:
 	if (sched->map.task_name) {
 		tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
-		if (strcmp(tr->shortname, "") == 0)
+		if (tr == NULL || strcmp(tr->shortname, "") == 0)
 			goto out;
 
 		if (proceed == 1)
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
@@ -1987,21 +2004,13 @@ static int perf_sched__process_comm(const struct perf_tool *tool __maybe_unused,
 
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
 		.mode  = PERF_DATA_MODE_READ,
 		.force = sched->force,
 	};
-	int rc = -1;
+	int rc = -1, err;
 
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
@@ -2011,25 +2020,34 @@ static int perf_sched__read_events(struct perf_sched *sched)
 
 	symbol__init(perf_session__env(session));
 
-	/* prefer sched_waking if it is captured */
-	if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
-		handlers[2].handler = process_sched_wakeup_ignore;
+	if (!perf_data__is_pipe(session->data)) {
+		/* prefer sched_waking if it is captured */
+		if (evlist__find_tracepoint_by_name(session->evlist, "sched:sched_waking"))
+			latency_handlers[2].handler = process_sched_wakeup_ignore;
 
-	if (perf_session__set_tracepoints_handlers(session, handlers))
+		if (perf_session__set_tracepoints_handlers(session, latency_handlers))
+			goto out_delete;
+	}
+
+	if (!perf_data__is_pipe(session->data) &&
+	    !perf_session__has_traces(session, "record -R"))
 		goto out_delete;
 
-	if (perf_session__has_traces(session, "record -R")) {
-		int err = perf_session__process_events(session);
-		if (err) {
-			pr_err("Failed to process events, error %d", err);
-			goto out_delete;
-		}
+	err = perf_session__process_events(session);
+	if (err) {
+		pr_err("Failed to process events, error %d", err);
+		goto out_delete;
+	}
 
-		sched->nr_events      = session->evlist->stats.nr_events[0];
-		sched->nr_lost_events = session->evlist->stats.total_lost;
-		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+	if (perf_data__is_pipe(session->data) &&
+	    !perf_session__has_traces(session, "record -R")) {
+		goto out_delete;
 	}
 
+	sched->nr_events      = session->evlist->stats.nr_events[0];
+	sched->nr_lost_events = session->evlist->stats.total_lost;
+	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+
 	rc = 0;
 out_delete:
 	perf_session__delete(session);
@@ -5167,6 +5185,10 @@ int cmd_sched(int argc, const char **argv)
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

