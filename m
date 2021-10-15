Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE26C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764FB611C1
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbhJORZB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbhJORYh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:24:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D047FC06177A
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:14 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id l27-20020a05620a211b00b0045fbe374e2dso5937338qkl.10
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jB5i04mXIrt5IWBLbRZrZOzlwvD40hhkm6eSih9HOlU=;
        b=DsoqFLKXS9zdB/bK/7EtQHxCHieD73ZgcXfQDnkOL6jRQU2eIeZfa1O43Q956AwZQC
         F54bDDECrTZLWlZnAVKtyUDlUPkjE1XkH3tTqeOU12eP1Uj+INaby0glO3l0n2FAA2lE
         1HlapEOWIhfsi/YpWMUbw3RdBkIrDcWzUsTaLeQImsrYBL4+R+WY58lEluf9O0N7LFoF
         R05DXKFznh2PHYV7hPwiUnP/wqOV7FJDnArNQPG47u/OgUNVIL2uBGrHUO0/SkRVnHq3
         AOEqVYx9l2XJW8dqEDxs4AZfnV+QweXfMgOmjbTM801C19SmaBasagqtQdPhhI0aqgDG
         MnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jB5i04mXIrt5IWBLbRZrZOzlwvD40hhkm6eSih9HOlU=;
        b=J+GKSyEJzdT3pmANNRJPdMlM1zqlFm6HeZ/2QAwyuTYygL96LU9fSdtijRSCBB7LN2
         f7diOaUpS2pIJilWKmACeYjRTA9up/umyl5iR61ITpmXL/6UD6gE54vVmPDTZ0b4IDA2
         heMCy52tqQxRXpORveBL4WjdvUOqyTYzOHW4xhcdGb5dNa408jMzNNokSC/Y5rY1A5ze
         V7PSSQU5aGf7Z9nIK0+fl3X2EgToXEPvTBfmDvEkqPV7OmcPsa7H64Bm3GDj30D8GXIh
         YCFHyE4JTeA2+idvvanh6nEH8RvJUmpCQYKk4MYdMbA4xsNueIUU/L9IBIs5OxcYzNXe
         I/vQ==
X-Gm-Message-State: AOAM532flSL8OQ34hnmtUR4tn0VfXk2MM84g9EqaHROn5oBS3OOdt1FA
        7F++Nv/+yHTy+LHOU+s1N/pjEWIVZKAH
X-Google-Smtp-Source: ABdhPJz9T8LpkqyMIRizYCHj9ixCDsCSOb5+1QiDqO3OV3p1KYgzoPC5QfFSLe/Um5mPMMzT8VP9QJ+JsgwW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:ac8:1e0e:: with SMTP id
 n14mr14701906qtl.95.1634318533830; Fri, 15 Oct 2021 10:22:13 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:26 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-16-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 15/21] perf parse-events: Allow config on kernel PMU events
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

An event like inst_retired.any on an Intel skylake is found in the
pmu-events code created from the pipeline event json. The event is an
alias for cpu/event=0xc0,period=2000003/ and parse-events recognizes the
event with the token PE_KERNEL_PMU_EVENT. The parser doesn't currently
allow extra configuration on such events, except for modifiers, so:

$ perf stat -e inst_retired.any// /bin/true
event syntax error: 'inst_retired.any//'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

This patch adds configuration to these events which can be useful for
a number of parameters like name and call-graph:

$ sudo perf record -e inst_retired.any/call-graph=lbr/ -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.856 MB perf.data (44 samples) ]

It is necessary for the metric code so that we may add metric-id values
to these events before they are parsed.

Acked-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 66 ++++++++++++++++++----------------
 tools/perf/util/parse-events.h |  1 +
 tools/perf/util/parse-events.y | 17 +++++++--
 3 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 89494b6213a6..006a7f721549 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1673,44 +1673,50 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-			       char *str, struct list_head **listp)
+			       char *str, struct list_head *head,
+			       struct list_head **listp)
 {
 	struct parse_events_term *term;
-	struct list_head *list;
+	struct list_head *list = NULL;
 	struct perf_pmu *pmu = NULL;
 	int ok = 0;
+	char *config;
 
 	*listp = NULL;
+
+	if (!head) {
+		head = malloc(sizeof(struct list_head));
+		if (!head)
+			goto out_err;
+
+		INIT_LIST_HEAD(head);
+	}
+	config = strdup(str);
+	if (!config)
+		goto out_err;
+
+	if (parse_events_term__num(&term,
+				   PARSE_EVENTS__TERM_TYPE_USER,
+				   config, 1, false, &config,
+					NULL) < 0) {
+		free(config);
+		goto out_err;
+	}
+	list_add_tail(&term->list, head);
+
+
 	/* Add it for all PMUs that support the alias */
 	list = malloc(sizeof(struct list_head));
 	if (!list)
-		return -1;
+		goto out_err;
+
 	INIT_LIST_HEAD(list);
+
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 		struct perf_pmu_alias *alias;
 
 		list_for_each_entry(alias, &pmu->aliases, list) {
 			if (!strcasecmp(alias->name, str)) {
-				struct list_head *head;
-				char *config;
-
-				head = malloc(sizeof(struct list_head));
-				if (!head)
-					return -1;
-				INIT_LIST_HEAD(head);
-				config = strdup(str);
-				if (!config)
-					return -1;
-				if (parse_events_term__num(&term,
-						   PARSE_EVENTS__TERM_TYPE_USER,
-						   config, 1, false, &config,
-						   NULL) < 0) {
-					free(list);
-					free(config);
-					return -1;
-				}
-				list_add_tail(&term->list, head);
-
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, head,
 							  true, true)) {
@@ -1718,17 +1724,17 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 						 pmu->name, alias->str);
 					ok++;
 				}
-
-				parse_events_terms__delete(head);
 			}
 		}
 	}
-	if (!ok) {
+out_err:
+	if (ok)
+		*listp = list;
+	else
 		free(list);
-		return -1;
-	}
-	*listp = list;
-	return 0;
+
+	parse_events_terms__delete(head);
+	return ok ? 0 : -1;
 }
 
 int parse_events__modifier_group(struct list_head *list,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c6c8343d311b..07f879e525fe 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -205,6 +205,7 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
+			       struct list_head *head_config,
 			       struct list_head **listp);
 
 int parse_events_copy_term_list(struct list_head *old,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d94e48e1ff9b..17c8c66f3f51 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -342,7 +342,20 @@ PE_KERNEL_PMU_EVENT sep_dc
 	struct list_head *list;
 	int err;
 
-	err = parse_events_multi_pmu_add(_parse_state, $1, &list);
+	err = parse_events_multi_pmu_add(_parse_state, $1, NULL, &list);
+	free($1);
+	if (err < 0)
+		YYABORT;
+	$$ = list;
+}
+|
+PE_KERNEL_PMU_EVENT opt_pmu_config
+{
+	struct list_head *list;
+	int err;
+
+	/* frees $2 */
+	err = parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
 	free($1);
 	if (err < 0)
 		YYABORT;
@@ -357,7 +370,7 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
 	snprintf(pmu_name, sizeof(pmu_name), "%s-%s", $1, $3);
 	free($1);
 	free($3);
-	if (parse_events_multi_pmu_add(_parse_state, pmu_name, &list) < 0)
+	if (parse_events_multi_pmu_add(_parse_state, pmu_name, NULL, &list) < 0)
 		YYABORT;
 	$$ = list;
 }
-- 
2.33.0.1079.g6e70778dc9-goog

