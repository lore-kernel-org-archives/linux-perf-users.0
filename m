Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F1C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 21:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiKNVJT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiKNVIz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 16:08:55 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C44B488
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:08:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36810cfa61fso115079557b3.6
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIf5Y9gptGCDfzfHbnNjnA19mp6qRpBDngBttcXhem0=;
        b=GZZvStXHmV1H/jsQ47y9n//yaqltl/vwRLrf6lcIZ4n2MbmDx8/ILodhf/TEK75Z8h
         vXUnxC0uMPqpB2vpMCDlnHSYpQa3dRDuEOq5vKovpKq+6HygbUCE6CxFPDJH2gM7E1Qi
         FLLrolhCv9gq604BrlQkqDDkLA0ofnmSvLMWXDxOFhh1tp3dzVRpVhvk+6L+WKvrsVor
         lZZe4gUEvOzHpoof7kQuiiR3Iu6mUFZeHXN9XKZ/SHkRgkMgQxrKpvFCK5p45B5IA+sK
         mZuaxZ2n64tLPPGQlcOe5C8WIbk7k11MRMslThYNuZJYNMKQH3QxYYmA0Xhgz2/jqeDP
         fDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIf5Y9gptGCDfzfHbnNjnA19mp6qRpBDngBttcXhem0=;
        b=oUA5Y9xvwvnfFn5N4tczjBkl/Ix42knKZxZ2pV122N7UjplgijKTBZoZz4TzsTRex9
         iXSZ5jjZ723WAmyYb94tn2ICt962og5ZPUqRRpRMH+jv9hWeBNssESu6YEPNRn78gYKZ
         TFbVoUI876YWgOc1nWYwrN+z8sEI9+5iovDppRKtUSNO/inKsUD3TsyuUQH2ifiaFSj7
         W5zz6v9OO0Ha1Jx6/1UfSJ4DwVptQLLypMCFDD2T6kAFtnTM+m1jXVyNutVMto18ikJ7
         YrsMPAw+vMGZoruK/gx9RwpLnR8kVcWmmLbdCRdNkwBXKgdLnMCJ6FcD+JhvrdU2l2Dc
         35UA==
X-Gm-Message-State: ANoB5pnMsWxKsh8BpGLuNlU16gyWR7ySWkGnoiX44kb0IHR4OD5qWPif
        1tKhVfkZwWJJGa0BDSPDAmmGO3jTnbj1
X-Google-Smtp-Source: AA0mqf4iUCGjqHHy6le8WzwURkFlzhXoc/qhYuUsB8WjG8LnurJrKZI5KTY7Z/hdnQqtsNRqBFQconWgEbKj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a0d:d596:0:b0:36a:bc93:587c with SMTP id
 x144-20020a0dd596000000b0036abc93587cmr15112789ywd.59.1668460132140; Mon, 14
 Nov 2022 13:08:52 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:20 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-8-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 07/10] perf list: Simplify symbol event printing
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

