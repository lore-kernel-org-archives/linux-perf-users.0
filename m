Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022106.outbound.protection.outlook.com [52.101.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1B33F582;
	Sun,  2 Aug 2026 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704971; cv=fail; b=sDXnDFlhWHKwiruG+cXblBxEvM1rkuv8J+pJGMPzghjokKBikdey7Z1Zzzq8NPF2SsCh3xIkKgpU3uRUXcPnRWNCzcrRVQt1oVj3qadDu+zXTMUYmMgZj1Wz//ZWeyvOboP315R/JwBqe0SGzptrPTg4gtn2kNwwARq1n2McMhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704971; c=relaxed/simple;
	bh=ZPzZsOrDIVn7fm1Z0dF8KuuBojg/2we+j1r2fd8/9vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1KOUJ2Ean7g0tB3wlxFtcK4D3PqtbpIDlz1l+oa5Vr/vCCSxVy0haUm+KMslJaeKxtRcsoWZTydeYokuOv9lK2p4g4jGTjP1CwhZ2miyyV/VFwg5iQU+szBGLWtYUIQFndlDF2uFtDvXzdfgZMRGPX/0F2k9Pdj0mASDacw14w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+k3Yvw6KZ6undYdqAOpeRkwz/rNyUnp2npoypnlMd5NtPwY+f5DECbSjtLjmLdE4xcNsI6yh3ykhDRmnn1xlVGCbYj2K1SnzY0qHrziqbNYHmSjpXX8GuvBubxAGREfAGamD4o30A7E8QiV6oWL+IKeYS3QdmjIxSC5I5G+RdE5fDO4kNXZYcKWig6A2bhZeU35xESJhVoovVwemWxJqimafwen5pCe0Oinyn8P0Z/nuzIjRzPispQdCfFkFpCWjwX9ldQO8u+CeDOA94jhO0pY1Z08MXjyLhZUSNDcwQ2powM4mpndBPXj38WaSZKHzhW3AYoNkypqelJnbG2H9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=EkDt/CVfw8X++pr4rFYdxOC0fDjenH+pZjqbL/yiTT4=;
 b=icH55QtGcN5OW0PM0HDDd9b8fz9acpA/ntRm9YgaJ4TAtWAZBIA7FFpJn28+9jloMxAeIIXCVQpUuKGCvI3sQszViXKnS4tLXShrMv2s5PSfJHnaqJRyVKerMUW1GlA63KaskoGLCAT/VscxNFa2uMEj5zCB/Kk3e6biCHS6W9tT502dyaYWL/gF+F1N1pI2E4FTowC+TvZrERdrrhaP4tYPhF3d6oLwtQAYFzfroFVH5o3JOZh9JNTn5QFsqszPF2ZZgjGQmw7BWAbEBQRkUIu2H+yQAV5gdm+G3BMNJDOMIljL4OjN2a67+r6fT6Mt+4lxS6oPkrBCOPt+h/B0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5940.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 21:09:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 21:09:25 +0000
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
Subject: [PATCH v7 2/4] perf sched: Handle missing trace samples in pipe mode
Date: Sun,  2 Aug 2026 17:09:12 -0400
Message-ID: <20260802210914.199941-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802210914.199941-1-atomlin@atomlin.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed791b4-a60e-4f23-dbfd-08def0da54f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|56012099006|10067099003|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	fvKi0BBCtGEfuWfnMyNZ674V6XPZ8N6GaUqaZXkOASI/3JBLLIJ//567zM1E9eq2+m+RJ8jEtAJIe1rv331kYlWeTeQ1kIbLeftMMgd7RkB5ngIuFFj/pvFz3s6+i9zcLvvD7u5lEIHuV3Nt1Y0YYkKh+THwfOpT5CK1cNQEbHMPl5s54uwTsCH78CFI4FfZ9VyeQDlRDaLfnfaW7zulI8FsjnLi/cDYqzkiyVwhRn96sMrRMoW8+M/2AeJg2MgZ8ZWfwrlx5WpZoXjsNMQtPtl6HJQKDtBuS9Wqc084dp67UygADxq0H++5TcM6IHoEzRiaX+lJZuoCiz6ZhnH/tidfDbR3opcbbDBnrlitZDFRAaUuO2ycAeLdboJKpvXTiSFVARtmqG2gbuB0YsQ1FDI3pt4lJV5UezZKYIclBg0IQTGe9mozel/zbXbvpclH1/p2esGquz8EBxDtFbzWTw5MUgJRJf4L8FGLTbtPPoxlfs0ffzrsC76Qvfj/TicrjYBSICwMWp41fPDOmzOY6ltBut3tIk7S1BeW9UZpkd0nbFTzF+Lsk/SJuQ2yzcSTcqDXqnkopto/CGDlTFbyYrObzT0ojiCkfNu7aDnugVQ/FIHfCIbOyjNb4qUHbMJoo6GpradlSoP8W79bvJv1yHfIxI22II7MC1D4o84zals=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8nHHvmnggJQchtaU0h/AkVdNWAZud0QhdXL7EwiUmreDO3S/+dyWYLHEEnt?=
 =?us-ascii?Q?eh7C2s8Vcbsa7L9rpqIds2tEkD7jjo+nSYMUFLZfAfKnHmHJagJW1+bWNgW+?=
 =?us-ascii?Q?kgiFadAfcVHNtuvtNi53Gqx0k6D8tOV7fopyxOSe1ucU3RLcpo0SnTJz98jx?=
 =?us-ascii?Q?UJsLwm3ZQqA08kIz0dgaN+iQX2TgDPrRyPsVq87N1OfLM4GDdVh+PuXMvU3J?=
 =?us-ascii?Q?5wMNNeBFo+7HHplvsreMJGuZdVlSrSRjfwDo1REz2B3h5lhTw2ZK499KNBWk?=
 =?us-ascii?Q?Qt9txfA6iSTT68brQh9CribLScD2UQ3WYGxt9elspuvePOay4niJpTLR0lHD?=
 =?us-ascii?Q?SEscRerXdiuDPPQwymwf3njr/4enODoNmVStM7uFj+tz/Se25o9Q4vjmsUj4?=
 =?us-ascii?Q?6NCVMSNXuxZ1VBtx2x5YlTJoOBQc3C2ophSi1Vo2+titm5hHTFIQxkZ15Mbg?=
 =?us-ascii?Q?hKhwuS4ouU33dCFCWzKfMzxjyXIjDA7dvqA6XsozZY1G/UgYeXrEm6R/fJXR?=
 =?us-ascii?Q?6CiCxT0fEU7eHjNeQos84mo5GkXQUqvC/Fw5utDs28SG+XH4BeOQPSiYX5x+?=
 =?us-ascii?Q?7Ps9NTR89FoXbXQ0ri+x9mURLNvrqLUZ2tJsvuzexRsOwFaIH0SUl/DU7+eh?=
 =?us-ascii?Q?lwF44yLyWywncZiq/VwYWre/iGM6R6zuUmLb3aZAckmt8kOEmGJJI6qebBQN?=
 =?us-ascii?Q?yhDBYQYgV+4AaJfyL7NgrCNZaHdJyM94ugu5oOk//uRnBnkhwExRYJjKnPL9?=
 =?us-ascii?Q?xWO4KdoYq5vmCQqqJfc3KwIzgab4pLPRl+Rwi/+vuI5/a0YQTVfrX/3PgKsl?=
 =?us-ascii?Q?ACSapNN5kZOdzO6RwTgBKcPWOuOaz/Ift8UoqL+8C6z0wNVxgjNRAYmSCfhe?=
 =?us-ascii?Q?jufTVI8fsWYb5mb8AEmRovmPQ+xvWoPskjXwNxbMfIEi+4XuEOuZO8XxaRP8?=
 =?us-ascii?Q?o5HddTJRGrXPz1ZA7mJzw3gRSoXuij1pqH1J2TvEyo7dzhJ2Z0rl2GkW7l1X?=
 =?us-ascii?Q?0ixrGsGf8q0gyPbH2sRbKd6tq1qXb8CT8vOkAlSgoO8wMXXuz72lJfktzcWh?=
 =?us-ascii?Q?DMHTEPfPwDTd1GnGB9fTd/SYOf/UVFHr5E2dKMveqFJkW97JfEHzRL9dYClB?=
 =?us-ascii?Q?PJIel+iifu7sfmNKP0pFHIbVKPx32Y7cRHbQrgLmrlyWVjLm6cJRmmgbqTNv?=
 =?us-ascii?Q?AaEe42DTL2BMwLqLHELy+DtmWx7GT8a7zwcdzdiQuqYotBtF6X1Zr6VyyTa6?=
 =?us-ascii?Q?zfZwd0FuyyC3HfuYtC775tQ2yZhUMUpR9wH4BYCJ4iI3wvOuZ1uLPPqoZYBe?=
 =?us-ascii?Q?W4HBua4V5S9Wk46A9iJnzYuMMerZJuZS4EYKcj5/21L4gg4Ysj0GCxshK4X+?=
 =?us-ascii?Q?SLdD5Qq/zddFZ0AGoUn9qPBDxe8q6td+nXsvJiR4wwS1sC3zh3XgQhSM1dDr?=
 =?us-ascii?Q?6KAIy3cvJpb+Umf8is3JAI6YTKT/C8xBlArc90OQLWjYCuWjMuuDFDv5qtBG?=
 =?us-ascii?Q?btuU9xlVb8RAF7p3XlifDc/m2esouM92sJZ1r331yfmqUqH03ITn4RzUxdm7?=
 =?us-ascii?Q?YYf0gM66JJbny6m6ew3FG568KbPhCOtQKOjbxf8hjBkoIzW1BaubLo+ZKLKF?=
 =?us-ascii?Q?e9RCdf+KBFTkyiq1uETSv0sQVfVjy/SP3xJ4FI0TKYVj4iq6bier+Y3Su69W?=
 =?us-ascii?Q?dIX6tqvj7rTc8V+vIyh03Cf4w+WGTtqtZAFiTOLJTGbaT83mn74wHJqTisqZ?=
 =?us-ascii?Q?ZCWozUIEtA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed791b4-a60e-4f23-dbfd-08def0da54f3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 21:09:25.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZwTJwst1Ykdog2XnvQBupkyMrxfKp0KgR27kpp9CoRm9SVtUfv/RFB1Nl6+z8cWV0Q6Ze3akRN0btRgyDmANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5940

For pipe mode streams, event attributes are received dynamically during
event processing, meaning session->evlist is not populated prior to
perf_session__process_events(). To handle pipe input correctly:
  - Register the missing .attr, .tracing_data, .build_id, and .feature
    callbacks in cmd_sched()

  - Promote the handlers array to file-scope (latency_handlers[]) and
    dynamically assign matching tracepoint handlers (or a dummy ignore
    handler) inside perf_sched__process_tracepoint_sample() when
    evsel->handler is NULL

  - Perform the trace check post-processing when handling pipe data

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 65 +++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 94a323da0799..232e72537df3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1938,6 +1938,22 @@ typedef int (*tracepoint_handler)(const struct perf_tool *tool,
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
@@ -1946,7 +1962,22 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
 	struct evsel *evsel = sample->evsel;
 	int err = 0;
 
-	if (evsel->handler != NULL) {
+	if (evsel->handler == NULL) {
+		evsel->handler = process_sched_ignore;
+		for (size_t i = 0; i < ARRAY_SIZE(latency_handlers); i++) {
+			if (evsel__name_is(evsel, latency_handlers[i].name)) {
+				if (!strcmp(latency_handlers[i].name, "sched:sched_wakeup") &&
+				    sample->evsel->evlist &&
+				    evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sched_waking"))
+					evsel->handler = process_sched_wakeup_ignore;
+				else
+					evsel->handler = latency_handlers[i].handler;
+				break;
+			}
+		}
+	}
+
+	if (evsel->handler != process_sched_ignore) {
 		tracepoint_handler f = evsel->handler;
 		err = f(tool, sample, machine);
 	}
@@ -1987,14 +2018,6 @@ static int perf_sched__process_comm(const struct perf_tool *tool __maybe_unused,
 
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
@@ -2011,14 +2034,17 @@ static int perf_sched__read_events(struct perf_sched *sched)
 
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
@@ -2027,6 +2053,11 @@ static int perf_sched__read_events(struct perf_sched *sched)
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
@@ -5168,6 +5199,10 @@ int cmd_sched(int argc, const char **argv)
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

