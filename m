Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B077C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 18:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiKNSO4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 13:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238306AbiKNSOR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 13:14:17 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057A2CE1D
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:14:03 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id r10-20020a17090a1bca00b002137a500398so6187707pjr.5
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 10:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIf5Y9gptGCDfzfHbnNjnA19mp6qRpBDngBttcXhem0=;
        b=ms3hkkK95AjV+ioKEVEzkclXhnmqtE13D4LhndsjTMdIUDHQQXNB8UOSp2+OFTFRFK
         ViC7tHBGKBTJNv7KryjTbINFQI5fSv39fXjaAD5iZypgA1bxtBjBkHjH2M85yh6ALa2h
         1r1lslPr4brLR45T0lMkmoq02U6kvVZouc8YCevM+z0aijHfPQjqgUTaoPOiWwSwRN9c
         89CwAlZ0BJ7onnoeLlDSwM5RNnDzvUBjgPlZTeANeCa6chbAE3MnVd+zdOGqb3wd27t1
         N9EDnlvusDE3+Mge/bfb7XJjnpg5n905IcTGtJ2BUzKJFtPCYmXEhsLg0SgWUwtRxGB7
         /p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIf5Y9gptGCDfzfHbnNjnA19mp6qRpBDngBttcXhem0=;
        b=GMwvkrTFSNXxHk1qAWRnd8JaMotWwiH9W1m3U6SQXrq+IQsj3VP3Z6VgCI4/AjH+kp
         rlWBlTyY4Q23Lq18rFiQztneq1WdeyW0l4p06yMvw6TChEWRl4tNMYaLK+Bq1lUgpHsN
         OVYj9yKjb4NYhFcU7VMGFI8d/tKSaEp/Hc3aHPNJ3+E0QLHQ2Fskg4p2bnTeNQ23evJl
         OzgA1U8I8RVhxFh5Y/1F3NEZfYckuA3X99T8ieu0ZAy3ISD7wDmSe+0B0Qza6Sz3gB3L
         Lm6IPsmYPdzldEM9ki/6igVLgynVwp/DFWU4rK8QnLvQzkYQ8GsxBDLExWL2QuRgQGGz
         Sk/w==
X-Gm-Message-State: ANoB5pmmdJm4HYZldH90NwaQCsc3g6PeaEfP2KeExgcdPbxlAE4kr19g
        /ulFj6hi39XU2fp6QozBsHnY4BvrIR/B
X-Google-Smtp-Source: AA0mqf7fo8BRpt9UyNarIFwRiFpN3L3+Rg+07DS6Qqp0WgP/FT8AsgvT1iH5tLFIF2XStyDqjYS6g+TWGWsG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a62:b402:0:b0:56e:8f96:6b2e with SMTP id
 h2-20020a62b402000000b0056e8f966b2emr14862845pfn.18.1668449643208; Mon, 14
 Nov 2022 10:14:03 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:48 -0800
In-Reply-To: <20221114181251.2683871-1-irogers@google.com>
Message-Id: <20221114181251.2683871-7-irogers@google.com>
Mime-Version: 1.0
References: <20221114181251.2683871-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 6/9] perf list: Simplify symbol event printing
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

