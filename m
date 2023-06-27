Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED1FC001DF
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjF0SLY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjF0SLH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 14:11:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BE12976
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:11:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0d62f4487cso5741766276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889465; x=1690481465;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=aei3beb4q3x++WPIPe0QnHzZckcCFW4R3vf2GZueNTS8EH1ej5AXfNxSKeKke4OnW4
         pA1YiiyKDg4RiHfInlERXtFstvo8F+W0YaAE+KQJjwrFblA/gDRz1CNUUrPC2w2JQil3
         /Wra5Ojjv9MsDQI5HT4WZil3DOlquS7Yg0g4ytIrnu96YIlrFydfvyZzAezPCh/AEdFB
         rRhqPAkPurZjCa/Bls2FsuQpCBCe+AU4YlqrMa6qVUXBaNjbpW5dfNvPrvt+gulyeI6z
         hZY6zNeqiTqUAdNOa6piRZ3r0WzZRF4/9Mff9lv3m+nnFLcYoEpQVXsLvBCl3X/F32rh
         wojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889465; x=1690481465;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmcwCCrzohBexPPxiwkNS29383WCu9lx0QPsW2KVyZ4=;
        b=A06Y0d9cWcWzp7bXgNSUjVJbB+TKrqcqVcAK44rUYB026XmU68qm7dSgItI36hcCMN
         84D/sqznJjcNXYmW/rlv4So+gxH4CsiV9TmXumFXrEAamGyQPum7LDn17RrSazNyjUbV
         AhN+7WhZrUyBHCa6JM0obaqbXUz6dDqbXfZPmc+tsBMbLd+UZr8HPovtvqWMdvubrb/w
         MIh3P2q9HmNu6tW2syHbCLsGbkUTQQrGTb/URa1+vdtwASDbEBlnGV+7YcruZt2cyXsT
         rMIljQ/40cRumBIqBaDlWtahMgtweHzppBebhvWExTU85TePJcIHNVFnPTD6gb6wCdGT
         dTow==
X-Gm-Message-State: AC+VfDxwwlGeYs+SqWCbApAJ9lJngF8CRZnYl8ZxULWCXVfb0p3ET0wd
        TKBc2+GrC280e/spW7YTZziNz1cd4Hml
X-Google-Smtp-Source: ACHHUZ4/a+LchMST3LH5uXgoZ0tXTL1BebqlP5Oj8R+ArkMhvomyHOWsaMi0FEXWPrdUw3IQVWMEMjhABDIT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a25:ad9f:0:b0:bce:5d6f:87a with SMTP id
 z31-20020a25ad9f000000b00bce5d6f087amr7873345ybi.1.1687889465014; Tue, 27 Jun
 2023 11:11:05 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:27 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-11-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 10/13] perf parse-events: Additional error reporting
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When no events or PMUs match report an error for event_pmu:

Before:
```
$ perf stat -e 'asdfasdf' -a sleep 1
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

After:
```
$ perf stat -e 'asdfasdf' -a sleep 1
event syntax error: 'asdfasdf'
                     \___ Bad event name

Unabled to find PMU or event on a PMU of 'asdfasdf'
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
```

Fixes the inadvertent removal when hybrid parsing was modified.

Fixes: ("70c90e4a6b2f perf parse-events: Avoid scanning PMUs before parsing")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index f090a85c4518..a636a7db6e6f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -291,7 +291,6 @@ PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
-	struct parse_events_error *error = parse_state->error;
 	char *pattern = NULL;
 
 #define CLEANUP						\
@@ -303,9 +302,6 @@ PE_NAME opt_pmu_config
 		free(pattern);				\
 	} while(0)
 
-	if (error)
-		error->idx = @1.first_column;
-
 	if (parse_events_copy_term_list($2, &orig_terms)) {
 		CLEANUP;
 		YYNOMEM;
@@ -360,6 +356,14 @@ PE_NAME opt_pmu_config
 			$2 = NULL;
 		}
 		if (!ok) {
+			struct parse_events_error *error = parse_state->error;
+			char *help;
+
+			if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+				help = NULL;
+			parse_events_error__handle(error, @1.first_column,
+						   strdup("Bad event or PMU"),
+						   help);
 			CLEANUP;
 			YYABORT;
 		}
@@ -376,9 +380,18 @@ PE_NAME sep_dc
 	int err;
 
 	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
+	if (err < 0) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+		char *help;
+
+		if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
+			help = NULL;
+		parse_events_error__handle(error, @1.first_column, strdup("Bad event name"), help);
+		free($1);
 		PE_ABORT(err);
+	}
+	free($1);
 	$$ = list;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

