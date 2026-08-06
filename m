Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260A47DD71;
	Thu,  6 Aug 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030782; cv=fail; b=No6rea4zCy0MJBYjq+Sd3kgYS9FmWtOVcRYp8FSqIbiFbMAwaJUTjhKJHFLGhZA8FeKXjO589T5Ozf8UdKUdtY2dsMfvs31GiGaAOtGGm5jRBZ82sdvtdokyqdIdmvTT5Aap7DWsWb8kOKj3/rVS2V84p6b+/nrDHxtKsvW30FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030782; c=relaxed/simple;
	bh=ddY2lVPjAAqI9o6jQlRScKmcjEWsZoP73lkEZGsmKTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUnKVDD83vX/ORMLaqpvgo6RSUQSOyIJKxe/pAqLmaPIFX36typGvZyfcKBiZMzHxvgnK58AnelN9k3cctIZY+GJ12SNBff72B5UowTVZkKiqzw5ruOwA7qUnqZ6MZKGFXcMALcMturLs6BWbcR+GwrC1XraYTwy1InQyHCddUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZTjZ8z8SfNncmhnnBRF7A1NkEXHOOzf5uRFEp1xzwK7rGRmhgeVdoPqQKz0GpRfMVmHXAsz9TV+Mq2enJW2Yggul7EITRvfcdK1kN97xwl9lKqaGsTHZs1TExNtpXk9Z4JKSRsV1wB2EH6RJ19g+Nir97snB8kt83w7z+mxJecwL1OfA5Jha0iUxG0MEIc2fwWJyVI563opavWW6hJIcPJLY3TJXP7wpSvL8Y9IfHNaFoMNDwZKbT3NkSeFvnjNCy/iQRW67LiEnPrnwd/GXPuud7DJP8oiX0QlfEp7uBIuCYxVtmv8heqnZeEL/17cmP5dKYPJcwfEFQki8+Lsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=gkyhWj4pj8TK3YpwLUmKx/nXEH5ViNeXsLu+iWVhZUY=;
 b=apr6nNDZ3mdrfF7T9OTARN8eRh+EX854HwXLQAPIkUmfhVV12h7cWzr0+tZ4TXsqmz2x6efK+z3yM58OJI5hCaF9iGs85hA53k4KiupPphE9aT8D4Cm0WGH1DYij/HaPMAM6IDBjNCooWkOZEqGI7fEFsibURA7qO4DHv/dgzsRHfRvZyRsCLptzzttL3VWZT9TTSSUKaWzA6TnJ74qKZFOPJNciHUwWRtm+DhuNvXR7hwy5sOcswSEE1OyMplSFrl1oY0T8C6HGvBr/rdO+fQ9ExuPX9MkJxKc6TTvGBuM/MBd46MvowXYS6EM7qxjRQFuTUaRd/wRuCgUvYEZ52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6694.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 15:39:36 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 15:39:36 +0000
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
Subject: [PATCH v9 2/4] perf sched: Handle missing trace samples in pipe mode
Date: Thu,  6 Aug 2026 11:39:24 -0400
Message-ID: <20260806153926.300499-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806153926.300499-1-atomlin@atomlin.com>
References: <20260806153926.300499-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0388.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6a9940-3d67-4d3c-5e82-08def3d0ebb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TQDyc3aRx67hgBuGh2h7D+zsfJp7NJZC3kVLh3ssjuO9dPHE/QlBgyx+/CjicR2wNH0fnVWewyHkHZhlujaoLYirs189YnT14EF+PXXrakzrFm9tbKNBNKzWZSYFBdf5KZ55HX2xUygEzWBFgxY0BFF8q/Mbl97UMYnyXn1wTI5CycUKqs4z4a6MBjE2W3/6ZXCXUcOGSjBqVZr19uxudLSyjC11ObYJZUkDLzZxM5ZBibHaf9xnXigmEVJe8d/rltjJSyqfRDP3Z/aSW8oTclOvzDLNFZoFzmg69dswAE30n/iO7eS/E/u779Kr2rHUJyVLOLzOFhbe8KDWbzmA8h6MQZeVMLkyTvEzlGtkHc2lhJD6B4ZhCroSoexR9IIcCTY+L9MHiU+sFjLcruH6miHIotYkQ9+J7IpfknPfwNnu0AuvqMJ/oE5OEcKN2xd3fH08JeVbg+dF2NMWihfTVzMk6WuR42nuSnJuipkMXH8IyrAe46+rK2D7kfT627/iR4X9ipjWg+gFwueMRJnLZA/JZqYymUpWrKPifRfvPCyJgEYYolH6cAEM2AlgLuuWIMYDAxT9W5A1A/OZRemn45WhWUdxrO0TZ47Im77hzO546muRwF4mGhJKBBl0sA3Kj0xRQloF/X/1lvvSGyJR56wF2Ee3HmRcBZ0AqGBhocw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akaF8GCteezs+rbeWAGqKNaDiN7mAmSIHpoY8gubqSm++8uW1V8aQc9XKk6u?=
 =?us-ascii?Q?GTC1jEnKKh6pP/okekRo/2jGnzLWZDaluvnqkm0lhm1aVJ1+AHidbEWikMYB?=
 =?us-ascii?Q?qlJsMS/olNhkUPHDehbzjbi6twnLQPPm94GeHg4110JJ+xRfcdInNuxi5hvi?=
 =?us-ascii?Q?ePVQ9L4mS8pK64pfgucn+3ER0oMuhDRfvToxfbMbUPKLFtn/gM34TGYEDHoV?=
 =?us-ascii?Q?x29VneNz28zGzT/l0/ATE18321GPuFBM+BW2ZSzz4bb0XAwrkJHSeY6U6g8K?=
 =?us-ascii?Q?2j5LbsWCKignCs0xUrwZcD/EJrMRNP/4SrXCcjr0iapzgaChLNJnGXDFZOmI?=
 =?us-ascii?Q?QQOxHxtBjoarsM8l7j7QF+rE555wQ36Nuc/6/yP2w2CJcfC0VQGLef0Y6igA?=
 =?us-ascii?Q?a3HO5uXUAXov5pPktCFJnDKfq+mUWVRUYoVFymDg5w/doLcOKJ8BPkA4QK+4?=
 =?us-ascii?Q?Uz1Nm6EaV4iugHHIhyLt/Q/Mykf0BwPJPXyjzHKjkEgoD/XxmGmQVzLJ8BXV?=
 =?us-ascii?Q?fLy9NpGY7PDzNwsTaPieQaQgh+wsgAN86jwv2ltgs39Ww1bzGpQb4FcGUyzj?=
 =?us-ascii?Q?JyEuQLMa7NWV8cfv6mD72VP7kWRB5Ru4VSoQSFhuV7XFa+YZg4tE9ARmBgTq?=
 =?us-ascii?Q?H4rpNe+rFQ8+CciDSUA/caT2nFJ1NThTlqyZvtGAg4xT29SAYPflRA2sUgEF?=
 =?us-ascii?Q?Sd9Q46NTTsMjVJLghrksmnE9TKDxm/j0Folcrz1uZG9pEIMuSijI7PqfUauY?=
 =?us-ascii?Q?nFa3vGKfGP+Eu2PC8WJn2NTocxNj8tnHp8LToJH/XDPbDZWNbb58UKK5vDgH?=
 =?us-ascii?Q?ve9J+GDatqspiy5SiYNxXzU84EYfYvT8e73AzkPKbs9h9b0rncb8Ug2K8UNh?=
 =?us-ascii?Q?858lmCAsBA8N3rOnPQ0JWZW0NmBftd/lgkTfRfoRf9csWwzKjx6mUmf+NLPG?=
 =?us-ascii?Q?JTB9mTbdg7IHgIW/P/kITnTbYWndWu92/MTrl5XXQl9GCztqbyAfFDbLs7pD?=
 =?us-ascii?Q?yC94N+MKFPyt3qilnLKt/VLVG8OxNZ3IYpbekMxoRjEBwUlJJC9O3cog4CgC?=
 =?us-ascii?Q?S0/1HPpdiiQeSWNmfS9bzdimP9bgwyq+OxhhG9XtlC448xkmpklCW52lN0zT?=
 =?us-ascii?Q?HBN+LUUMRO+Z9CCJjTo6IFdCg461SRj1snmtAAhu8EWE+Areoxr7uZ94Huyx?=
 =?us-ascii?Q?6XsyRuTp/svYe/u+6KwR4JfRK81WsUUN1Hm4+Q7Le5aadI4Plv9TTpUkvKRK?=
 =?us-ascii?Q?IPI7J8P61UpC4XBqmnw+l0UGmT4yXJW1kJQ7BxudIreofT6nC6QIER0X1k0p?=
 =?us-ascii?Q?PztmkjB5CtLAJAJ8fHszw3uTTPl2qPbLvlnkOmWdDEwhVmAnyAs+INWjTYpR?=
 =?us-ascii?Q?gSshVh0Gvt0RORbIDMZs+x27GiS7q5HIdu2haDjEPFQ3Zcjv+AfzCWZRdERt?=
 =?us-ascii?Q?R+ViEQfT2uq0ecped2042AWmQNTAcb5L0XHZ8qcaHyzQha8TxIeu9SMMlw/N?=
 =?us-ascii?Q?57Z/Y14bJA5TLNytVnq7dh3K4/TrG2xxscjRszIVuus5mlvnfBzG2DDWEwT7?=
 =?us-ascii?Q?x0x1gcEzgOkRxz/KA2yxiv6kVBRNxVPJY8anrz8dNySmzgmV7Nu4hq/dHcUY?=
 =?us-ascii?Q?tMV2MVmhoLMexMcLX4p8wjQvPPKKu45I6w0se4nErWOdhxctT45xGuy4ONCg?=
 =?us-ascii?Q?Uxrela2TiFjeC1IS6zNjn9NAylHJs1iQal0x7V2c+PDtyEij+Phf53NLZ0My?=
 =?us-ascii?Q?4aXD7zWr8w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6a9940-3d67-4d3c-5e82-08def3d0ebb6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:39:36.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLXvCOZqjrIAx/vApDsCxzKsQN1Uem59ZFogqTSo1POFMtcQ05STFyLfjWTmjglFMUUkMUXxaXWEKiiwBkgjqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6694

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
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 72 +++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 39a375ef209a..7d4c6d6f308e 100644
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
 	sched->nr_events      = evlist__stats(session->evlist)->nr_events[0];
 	sched->nr_lost_events = evlist__stats(session->evlist)->total_lost;
 	sched->nr_lost_chunks = evlist__stats(session->evlist)->nr_events[PERF_RECORD_LOST];
@@ -5176,6 +5202,10 @@ int cmd_sched(int argc, const char **argv)
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

