Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C848C43217
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 07:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiKNHxI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 02:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiKNHwt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:49 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C919C26
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Nov 2022 23:52:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b142-20020a253494000000b006ca86d5f40fso9819415yba.19
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Nov 2022 23:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIf5Y9gptGCDfzfHbnNjnA19mp6qRpBDngBttcXhem0=;
        b=lZg8XR9rikMPVUaFqH/pduhN9NiqpmRBLJZPpTe2SkaCZZo9Qs/Hp/RFLCAp+mFkx9
         lGuvUrwFTHlGZVfm2+G3HqL9/POx1pN3vv90zCejS2/nyihHFSaGyNfTMFnDKGQScODi
         IXWwCxxlDC6sVqn5lXwCYbIoBKwiLJbZt4FgxUpXjfo4ez5sZG/uI919jUZBoYP6tlTh
         1QJm1kAw8xF8wg4+9qQE29f1a6EemftrmcfUv8v0xwGRUsijsRo8XcCXX8IhYuqTsp+f
         rNKtmYdkvUc/zYmSkJenNFWeVbykk/cWU5DjSmGtkoH2ECbul3q+2Ojn5X4f8P3Bl7Fz
         kcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIf5Y9gptGCDfzfHbnNjnA19mp6qRpBDngBttcXhem0=;
        b=6oXq+zCQBcWFr/inLAASRbnRE+lcTVxLJk4UBPYTl1PhR1FpOPIZiq+IKS21d0A6J+
         inS1u+63EzOHesC/iTmaFs05ejoNSvBB9xSGX45nKl5GV1gdpksj1orHfgzPvToZ3Kmy
         BRqpNyUwX0k7M7yhPELJmZZ5gaCPjlaUerxu08+dtazRnvsTuDJMA79RK4YBSGYtVR4K
         rJLSIMO8V9dfFsnVkbojIQaweScnZAnz6Ta7EE9/j9tvOXi8NlM+rJWWGxPD/SARocJ2
         TSO9AzRtx+O0476C/P1ICreuPbZ78PisI32tYeOQukLAsCRJXaF8myBtKsfxmr8a8mTT
         Kytg==
X-Gm-Message-State: ANoB5plJ6IsScWPnd6UEo2x9WavZeCWE5zW/ZZB0sjMvhZJBwGx0QcWK
        gFIf0Wa2OHSLMlLVpt5mQ0e0KKcaS1lS
X-Google-Smtp-Source: AA0mqf57AZUJUVhHtCp40peKGAKFZ94n72xGc6XyQ0CA4X0cDyG4nIWE8vcK24czX4WgLAV/MywlhtRc8aMe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a25:320e:0:b0:6d1:a39d:637 with SMTP id
 y14-20020a25320e000000b006d1a39d0637mr11858110yby.335.1668412364529; Sun, 13
 Nov 2022 23:52:44 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:24 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-7-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 6/9] perf list: Simplify symbol event printing
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The current code computes an array of symbol names then sorts and
prints them. Use a strlist to create a list of names that is
sorted and then print it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 79 +++++++++-------------------------
 1 file changed, 21 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index ff7793944246..d53dba033597 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -52,14 +52,6 @@ static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
 	},
 };
 
-static int cmp_string(const void *a, const void *b)
-{
-	const char * const *as = a;
-	const char * const *bs = b;
-
-	return strcmp(*as, *bs);
-}
-
 /*
  * Print the events from <debugfs_mount_point>/tracing/events
  */
@@ -298,77 +290,48 @@ void print_symbol_events(const char *event_glob, unsigned int type,
 			 struct event_symbol *syms, unsigned int max,
 			 bool name_only)
 {
-	unsigned int i, evt_i = 0, evt_num = 0;
-	char name[MAX_NAME_LEN];
-	char **evt_list = NULL;
-	bool evt_num_known = false;
-
-restart:
-	if (evt_num_known) {
-		evt_list = zalloc(sizeof(char *) * evt_num);
-		if (!evt_list)
-			goto out_enomem;
-		syms -= max;
-	}
+	struct strlist *evt_name_list = strlist__new(NULL, NULL);
+	struct str_node *nd;
 
-	for (i = 0; i < max; i++, syms++) {
+	if (!evt_name_list) {
+		pr_debug("Failed to allocate new strlist for symbol events\n");
+		return;
+	}
+	for (unsigned int i = 0; i < max; i++) {
 		/*
 		 * New attr.config still not supported here, the latest
 		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
 		 */
-		if (syms->symbol == NULL)
+		if (syms[i].symbol == NULL)
 			continue;
 
-		if (event_glob != NULL && !(strglobmatch(syms->symbol, event_glob) ||
-		      (syms->alias && strglobmatch(syms->alias, event_glob))))
+		if (event_glob != NULL && !(strglobmatch(syms[i].symbol, event_glob) ||
+		      (syms[i].alias && strglobmatch(syms[i].alias, event_glob))))
 			continue;
 
 		if (!is_event_supported(type, i))
 			continue;
 
-		if (!evt_num_known) {
-			evt_num++;
-			continue;
-		}
-
-		if (!name_only && strlen(syms->alias))
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
-		else
-			strlcpy(name, syms->symbol, MAX_NAME_LEN);
+		if (strlen(syms[i].alias)) {
+			char name[MAX_NAME_LEN];
 
-		evt_list[evt_i] = strdup(name);
-		if (evt_list[evt_i] == NULL)
-			goto out_enomem;
-		evt_i++;
+			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms[i].symbol, syms[i].alias);
+			strlist__add(evt_name_list, name);
+		} else
+			strlist__add(evt_name_list, syms[i].symbol);
 	}
 
-	if (!evt_num_known) {
-		evt_num_known = true;
-		goto restart;
-	}
-	qsort(evt_list, evt_num, sizeof(char *), cmp_string);
-	evt_i = 0;
-	while (evt_i < evt_num) {
+	strlist__for_each_entry(nd, evt_name_list) {
 		if (name_only) {
-			printf("%s ", evt_list[evt_i++]);
+			printf("%s ", nd->s);
 			continue;
 		}
-		printf("  %-50s [%s]\n", evt_list[evt_i++], event_type_descriptors[type]);
+		printf("  %-50s [%s]\n", nd->s, event_type_descriptors[type]);
 	}
-	if (evt_num && pager_in_use())
+	if (!strlist__empty(evt_name_list) && pager_in_use())
 		printf("\n");
 
-out_free:
-	evt_num = evt_i;
-	for (evt_i = 0; evt_i < evt_num; evt_i++)
-		zfree(&evt_list[evt_i]);
-	zfree(&evt_list);
-	return;
-
-out_enomem:
-	printf("FATAL: not enough memory to print %s\n", event_type_descriptors[type]);
-	if (evt_list)
-		goto out_free;
+	strlist__delete(evt_name_list);
 }
 
 /*
-- 
2.38.1.431.g37b22c650d-goog

