Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F21AC001B3
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjF0SLW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjF0SLA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 14:11:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36ED1BE6
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56ff81be091so67559987b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889458; x=1690481458;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=zKLf44jyj+39w0a+bqNc2dgv2dREdGSzeZe+HP7YGWzKAptuBUBeZ3HLubfQN8ktPU
         J/hVxrzpmJEmMjxDDA9hWXUMzGcGE88LvOStfYcQ73rvV3KcYSj4TpSDt+CfNC3o/MDo
         K2iNVrUgK79UQZCfMhBpEczFI7xMJ2cAOvmILBvuaZruCBVWk5uTuRzPtbVK5ofATVTi
         q0Sr4j/plwsl+/pQMnChcyl8ujz1LD6ZCyUY6kBfmtDsM3zvtQaL7hGNpdcCriEo8EY5
         Gd0m4In8QsXo2VAV5mtg9f1sdi/vJeRaLPGQ2ndAFHfF5X0FFUit8aymAZ29aNcjUIjA
         asDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889458; x=1690481458;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhrU9btQvSNouRLprL5042Ez2uv0eRQsGm9r0lF36Cc=;
        b=buil1grzXyk2XMYR+f6WPEmSenVLfwH/4VZwmAQtPDO/ZjZAU/ffSwDy2Q5/sGXw+g
         3VX76qyKcO4IvXvJYDS+VucJ4kiEt6LGSsMifMDMOIH1UGsW4/niDmU9ciXgYjsxNb97
         DS6bz+TeJM0ES22HF3eOic6oolsfSX/OiE5R8FgaQkPyspUolIoqZNCyWf+LDjDm9d0i
         1jh1Ly/T3waRsD8m14cPffEjUbkuFwsQwhPgJsVblEd6d3+tOcIFt8GSSkDjKqaHCMRA
         arqhbz0PPwNFAp6rnw0xwuJela9R8ME/6DQ/vn4BBbuO678FjBh+aSmTvfhD1q6qD3ZL
         e31Q==
X-Gm-Message-State: AC+VfDzc7/e9WwrTLEPR7agEkIgIIsqOrtHPeekpC2A0hrnNaSRhkGOL
        lc1kba5PxuVQrzvb5cQlCyaCrRsLkrKm
X-Google-Smtp-Source: ACHHUZ4uaQfEAiZp9PqQDuN7pzOeygiYoEJNc87GGRVD0DwY9bbSmv0eS8WjGE+vlBe01swDXklrQzCsdz5u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a81:b710:0:b0:565:9f59:664f with SMTP id
 v16-20020a81b710000000b005659f59664fmr14322906ywh.6.1687889457830; Tue, 27
 Jun 2023 11:10:57 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:24 -0700
In-Reply-To: <20230627181030.95608-1-irogers@google.com>
Message-Id: <20230627181030.95608-8-irogers@google.com>
Mime-Version: 1.0
References: <20230627181030.95608-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 07/13] perf parse-events: Separate YYABORT and YYNOMEM cases
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

Split cases in event_pmu for greater accuracy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 45 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 3ee351768433..d22866b97b76 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -283,37 +283,42 @@ event_pmu:
 PE_NAME opt_pmu_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
 	struct list_head *list = NULL, *orig_terms = NULL, *terms= NULL;
+	struct parse_events_error *error = parse_state->error;
 	char *pattern = NULL;
 
-#define CLEANUP_YYABORT					\
+#define CLEANUP						\
 	do {						\
 		parse_events_terms__delete($2);		\
 		parse_events_terms__delete(orig_terms);	\
 		free(list);				\
 		free($1);				\
 		free(pattern);				\
-		YYABORT;				\
 	} while(0)
 
-	if (parse_events_copy_term_list($2, &orig_terms))
-		CLEANUP_YYABORT;
-
 	if (error)
 		error->idx = @1.first_column;
 
+	if (parse_events_copy_term_list($2, &orig_terms)) {
+		CLEANUP;
+		YYNOMEM;
+	}
+
 	list = alloc_list();
-	if (!list)
-		CLEANUP_YYABORT;
+	if (!list) {
+		CLEANUP;
+		YYNOMEM;
+	}
 	/* Attempt to add to list assuming $1 is a PMU name. */
 	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
 		/* Failure to add, try wildcard expansion of $1 as a PMU name. */
-		if (asprintf(&pattern, "%s*", $1) < 0)
-			CLEANUP_YYABORT;
+		if (asprintf(&pattern, "%s*", $1) < 0) {
+			CLEANUP;
+			YYNOMEM;
+		}
 
 		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
 			char *name = pmu->name;
@@ -328,8 +333,10 @@ PE_NAME opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				bool auto_merge_stats = perf_pmu__auto_merge_stats(pmu);
 
-				if (parse_events_copy_term_list(orig_terms, &terms))
-					CLEANUP_YYABORT;
+				if (parse_events_copy_term_list(orig_terms, &terms)) {
+					CLEANUP;
+					YYNOMEM;
+				}
 				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
 							  auto_merge_stats)) {
 					ok++;
@@ -345,15 +352,15 @@ PE_NAME opt_pmu_config
 			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list);
 			$2 = NULL;
 		}
-		if (!ok)
-			CLEANUP_YYABORT;
+		if (!ok) {
+			CLEANUP;
+			YYABORT;
+		}
 	}
-	parse_events_terms__delete($2);
-	parse_events_terms__delete(orig_terms);
-	free(pattern);
-	free($1);
 	$$ = list;
-#undef CLEANUP_YYABORT
+	list = NULL;
+	CLEANUP;
+#undef CLEANUP
 }
 |
 PE_NAME sep_dc
-- 
2.41.0.162.gfafddb0af9-goog

