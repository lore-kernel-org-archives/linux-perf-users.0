Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022120.outbound.protection.outlook.com [52.101.96.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7534107D;
	Sun,  2 Aug 2026 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704965; cv=fail; b=ZvVAHGOJDunrx869L/L6AzcGyidGRqzEQPxoFB8sYH6FtDT5o0DuNEw40GOajvzciYiQBbEaixt+jEXxr1+j3YOCWsI/RHsFKHIQ3Ps9IduAict6XEPXIsyYmiq8oT2Rska44tRJp3Lf+FJZbibWrBkazNJAb8E8/TKg4B0BmcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704965; c=relaxed/simple;
	bh=jWS1rvOOmED8Kkbh6qPS0gFYwujmZrVL2GTKppTPAx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gjpvTvr/ap1fcfQVB6urk/kwe7qPyGr1zdM8MmXDoemZ98prUKTYWtEj614Cm0BooQZM1PMCXn0IcPbifo7aajImPVAW+0MAnSYE0IS2s8WX3V1CDnwxpCx7kpGx0yPVmYTowUli7/rc9ksTAchAHZVrvfJJP1ZLUX1V8TOlbbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awd+5zzHPf3vUnxnktPCNs8NiKH3DUT88Hi7hzVhgeZmb+IsrIYSAirGl8FqAEvjRkomaKK7Le7gUjSMwi7pB89aJOerpvgqUVaRvmigeyPJBfMth1M3FMA9ZfyoxmGpcmsAAEq/hl0z3U0229GgnISZ+pXQuuPpDpaDaaB4hGzjVeygVJPNAogY72JUzK5iz4YeylYG0bKbdcIHfFLdAaatWdrGKJllLEpe/ma3Ks1BNIVpOOTQWRN3iPOdkEJlodVAXYhYQ+0q99fpeQA1/QZuGWpxkIoupgGyddBZ69rtz2KUKDbNWW0dU3eoT5TCVlOXHcVnN1suigVK7xo4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Djxij0QPX/LW/PbeRhCP31Au7MuCtAOAHsIkgDHtErk=;
 b=nrAfA9A7ypZU0ZML0EGx4Jvu91EWSapLio+n2BXenfqbHwTioYNcmmwBLSwL4YKqQAD/AwHFqP6ys8W66AxGIVpVBDXJFvRtaBBI8DgigU+9om4GxmtCCaT89in2lyxgVmZvRQfpnPouTVQqjllOPJqo5PfPl3Zca0zIoevKhwoBLoGxsz654m6Dp97paEIl3pbm4t4eXkOcmi4g2NJISSyStF19jV3uNfKf3Ib3j4Bzd51ru2GGjoZ/Ez8lfjAq8zxDHm4XkIq4tvSt4pIKe6fllTCNcVlMOiR6/J/N3ULJBD4uK20FEOY7ojt/idjuYo2dXf1awlM82vHkAs5nOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5940.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 21:09:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 21:09:21 +0000
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
Subject: [PATCH v7 1/4] perf sched: Suppress latency table output when trace samples are missing
Date: Sun,  2 Aug 2026 17:09:11 -0400
Message-ID: <20260802210914.199941-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802210914.199941-1-atomlin@atomlin.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:408:ee::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 3727ab78-b166-4ac9-6cc4-08def0da5261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|5023799004|56012099006|10067099003|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	EtkOg5cZNzN7HTXaDH8zMbyKDrT4qCJH3w+G37+133L85lb1ngYk5TPN1ZqwQAoaKRUubsvHmrIgbWE83CB8jGjTIT1+L3Xv+44A+AWTemFj16cXvPLu2E3p2tJ8gbvV4BrdDvCw0PCawaBHVQKQyQ6CXMaB9XRSKpH/Vtz3WRWdKK04a0fQoVbiI5GlUN462nHMt4VDsLW6b7YWWtL8giocwFKMcLX1GmDFsuV0b0rakejeaykuLZ9/7YPLhgvCS5RJSS80IBp/TKNPTtLUvUyaIKIgWBxK3c3QcEvqkG7J+TJdfpKDBif8ttSMPLQAjB3WH6xOZ6xvjWwLkUHqA1+IVouaSMYrhiWNiiYtipCO6sq6p5djAntf8KhF9mwtONInWu7FFdfl78NrjFJ+BN9m5KNzncJg6jx3w2PH3UetW/TxO67f3UG+lAaiwJvg3cHbLx6Nh6oNrnVz3CnUCOVAAHdf3RiT+91hNaj4w9zjHUot/RqN2vK7U55BoQTvTTiyj1/rrbbN/lkBHNfC9DupWX48DOulGlw49MsX9Sg+iw3dESVWacLC5J6+vC/Kjvr3WoE+fbucVabuMwnYqfPC7rqmi6Hwzlfgol78KEan+7nqiX4XlTJ3PIntO2+naqrr0HdxzbTHbHS2Fe4lxp8vTOaXacaRZ3IbwTavcc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lqknZ5nvk2AqqsUfHsd2iUM8A4oSnazve5lVI5ybwiPHWwOdmOQfP6csrH5W?=
 =?us-ascii?Q?a4PE2uEbbQcKd7ruMp1hZzCW99end2bdVydK5dvuwyt+Px1janQRH3jP8maA?=
 =?us-ascii?Q?A9cjK5teEyCovYi024q5+Tt3LG6TzICD/QWRKysmW8xDvSRsPO1vHBvMxJBr?=
 =?us-ascii?Q?cLiPqsCVYjFIyhwjQl6F7r/LbkVtVcbT2KKqPMJ980DS6tWrhTYKPVORg82y?=
 =?us-ascii?Q?Jl7IdI46Dct8MZiAmP1rgjhfdfazcK3KW1Pk9dKaDv8WlAKPd36M41wgncVw?=
 =?us-ascii?Q?rXeB7bJG85FJqjfoCDdRrEDGEzwo8UKTDNcl2OlmiwQ2PHTXnWw/0bO6CJr5?=
 =?us-ascii?Q?ltK5TLhpRac5BJwCktqv44//9g/QQ+espaGZvzkGJ/q0NghNlHaOvqxN+VUR?=
 =?us-ascii?Q?30QsCxeRBNssO7rpi78Rhb+JWoFGZjA37veeDkxoK/US3F1CDSJ1PEQpJH4q?=
 =?us-ascii?Q?qjGgh4oUjXENox3Zc34phImsDoJXxOvh2hSQS4idxHpMtUi9c5lsgZ+p1yeI?=
 =?us-ascii?Q?HIDoxTCqCxa+ixQwUHtMdiqoxXZCCZ+n7wGKOqExAP/5lLiUUtcx7u7SgENd?=
 =?us-ascii?Q?w2qy9KXgrXM5hxZl+cpI365UipJFVsuAwvIrqHF3TNXsIjDTAij5bhw7XnKD?=
 =?us-ascii?Q?wN4LwHMOpNysT1QpRlLNcRtbsgNyksbHCLOQX2lNKCzXdk76pEyFJJEoDZkz?=
 =?us-ascii?Q?1LgU550rNsbXDKjhdbmVzhvhkE9NK1998Z1woPFVMzW0U+a0QvvTDfLoOOhR?=
 =?us-ascii?Q?0xX40nYd1Q/YlVSCx7pMwFYw3fWqYLOv586x2k50lIBhC0KihlfVUtzstfxP?=
 =?us-ascii?Q?efXb/8t6E57dw5m+eTd27/yp7P9I4lWEmQ9TRytMqxNeedPqgHc+lv/ZzUgv?=
 =?us-ascii?Q?KrdEoFMaEuxVuCOQdk05q8Dm33g+kCBDz5UNH89vRvweIjd31E/5YacIwpwC?=
 =?us-ascii?Q?0iO3q9cJvKpxMP2jixDavnHBiTcrqsUJs+4tU6012FYdmt4zPh1d2Sh2TlAf?=
 =?us-ascii?Q?P3oonAUHuEFj9xyeZrKynS1EeK9eXzWLJcrtH0IkZxYenoZsYIGg6QrpVxAs?=
 =?us-ascii?Q?0pMWsaUf5chstHT6W04lUBxCLF8iLSNSwnWsZLnt1Yf9yHdNn4/fWJKFszlu?=
 =?us-ascii?Q?bhHyIifwg6mlJpn9geqK5ajN8mhhcW4DY5kMfrCbLhZpHPzYfRMgWIundCNP?=
 =?us-ascii?Q?UEOPkSO6d6OpysTi3M3/5M6/FJbszUJ2/f/HBJP4mmEDxsrVy/mEWxzC/MC6?=
 =?us-ascii?Q?L1FgCSGzQ/gatMBWACFGPUvkU55V0hQW1aZy3yDmWDOr03umsLAFlZzUWGzv?=
 =?us-ascii?Q?tHfVwZybw4TmXYvQzqJm/XGUJy9j9WAA8MnKINqZWR07h3CjbK7aR2pjf+Vz?=
 =?us-ascii?Q?rNqpAg8EWbJ6ylUGaHjZ1tBp701mvi8F3V332Zkyzj3jn4tZG65NpxaldccZ?=
 =?us-ascii?Q?4EfN3FgTzyWHuSWBwkhiC8fy1KI5QZRt+k7KYOkiuItGmbi8nuOZxDbU1+r6?=
 =?us-ascii?Q?EBsf2tN2LNhvLbAZYr6S1JPyzljsSF1qCPTpbHKOZxQOzULIIycCC8PzV6nv?=
 =?us-ascii?Q?IAxUrFCCg7vOO5IhJmx40nPc38a/2/P11Tf9UGnhsc1osOvtLF49+6noArOB?=
 =?us-ascii?Q?459ImWROzYj3ePpQY9nZ0cX8djg6pARogJvjyFRVdm4y6OyqlXeys/T1WLnL?=
 =?us-ascii?Q?lu+nFFqpDo3K4zl18HSezAYO+1H9F9byRegfACLNtpaTT2/ofzB/fFTeYr5l?=
 =?us-ascii?Q?W5lXVunezg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3727ab78-b166-4ac9-6cc4-08def0da5261
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 21:09:21.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb+MvctXKCy9TEdCqfbi9kQkDXdvH+kZWU6VbpXzs6nyl8tRy5YBxapMKdCtzmaQUmC3MLj1jTTPP60vt45OrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5940

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

Additionally, validate thread__get_runtime() against NULL in
map_switch_event() to prevent potential null-pointer dereferences.

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7fd63a9db457..94a323da0799 100644
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
@@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = sched->force,
 	};
-	int rc = -1;
+	int rc = -1, err;
 
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
@@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	if (perf_session__set_tracepoints_handlers(session, handlers))
 		goto out_delete;
 
-	if (perf_session__has_traces(session, "record -R")) {
-		int err = perf_session__process_events(session);
-		if (err) {
-			pr_err("Failed to process events, error %d", err);
-			goto out_delete;
-		}
+	if (!perf_session__has_traces(session, "record -R"))
+		goto out_delete;
 
-		sched->nr_events      = session->evlist->stats.nr_events[0];
-		sched->nr_lost_events = session->evlist->stats.total_lost;
-		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+	err = perf_session__process_events(session);
+	if (err) {
+		pr_err("Failed to process events, error %d", err);
+		goto out_delete;
 	}
 
+	sched->nr_events      = session->evlist->stats.nr_events[0];
+	sched->nr_lost_events = session->evlist->stats.total_lost;
+	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+
 	rc = 0;
 out_delete:
 	perf_session__delete(session);
-- 
2.55.0

