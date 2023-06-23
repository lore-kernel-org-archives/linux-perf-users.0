Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D137EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 04:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFWEbP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 00:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFWEbN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 00:31:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16132128
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:31:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb2a7308f21so364813276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687494672; x=1690086672;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cu9nI31LEpqxG6RFF3bTH+0H9TeY5MTdZFgwWUSRFwU=;
        b=HDdKa5vorjtsTOrpdZyZbORmZaBWBLRNFyZz+mquVo87kCprIyIN8sJdGBbNPkAExV
         lZsOFohZIZYXcx+EOi3cnPYVBgXSwuRwX+NN2SyjBHY+dZhlbeFPbvDTcrUYvX4iDgND
         B/3N4GkPcRdJSTv8PAv+Ayi/kJFAETG/ktcG0BK1ipSkvvzQwQdd9b4hO+HNvdy4HHj0
         QLMcbKt6YfIiTauaZuaOdy+BOR0vdfzOvUEXZzzZahsNRBWHTIK9DqfXmbpg8xvTmNEC
         ggmowdUOKFgOlKsPkUOx4gckl6EE1Qrlwe5LqX69IpEeV9d2LTWQE8ayD2XjjG87s6cJ
         dCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687494672; x=1690086672;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cu9nI31LEpqxG6RFF3bTH+0H9TeY5MTdZFgwWUSRFwU=;
        b=cYhRcuzRMpOvE5woWMEVRBYzWGEzTTOakM0/bXyf0iTax6vrPy77GeEOHuDM2ldoI2
         K0N/NU8JTm8bCFJ2gv8gcQN2BLLPj+brU/ZYv8b6RFgPTGWY91ylfNOzpCuTeUzVzLve
         PFs7a0l6xvXENfy/X6OOezHW3cSXjMthVCDNimM7EP7ZZvIslZ+/1c+Za9glV4pj7GEl
         /XZ+uQnJYGYLkmw3tVhz/PfkLiHwfMe8ZkKWnH0HrMplyHykKe/slSVBpLKaa7ZF+L3B
         X1YQDxOFkLMaxhk/GDbR7rnaJLnr+CZn36Z28wL3c0T6x5GOc5u2Vo5/Ff0Q6X4cFEVe
         JMtQ==
X-Gm-Message-State: AC+VfDwMBI3dFOs2eEzZA8nCxBg3plQYH6axvlHrvAKRELmfvMQnde1h
        8b15LE03IfNM18QIG90pLuDN7knR9BBB
X-Google-Smtp-Source: ACHHUZ6Y8LjAHTkZi3zCabhg5Vde/FZX17mb7veqsintqlySiJ99zT4N14uiAb3OID4t2IMOa5kNVv3SNJgR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:ab28:0:b0:bc5:2869:d735 with SMTP id
 u37-20020a25ab28000000b00bc52869d735mr8255983ybi.13.1687494671922; Thu, 22
 Jun 2023 21:31:11 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:31:07 -0700
Message-Id: <20230623043107.4077510-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2] perf unwind: Fix map reference counts
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
        Ivan Babrou <ivan@cloudflare.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The result of thread__find_map is the map in the passed in
addr_location. Calling addr_location__exit puts that map and so copies
need to do a map__get. Add in the corresponding map__puts.

Signed-off-by: Ian Rogers <irogers@google.com>

v2. Add missing map__put when dso is missing.
---
 tools/perf/util/unwind-libunwind-local.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 36bf5100bad2..ebfde537b99b 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -419,7 +419,8 @@ static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
 	struct map *ret;
 
 	addr_location__init(&al);
-	ret = thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	ret = map__get(al.map);
 	addr_location__exit(&al);
 	return ret;
 }
@@ -440,8 +441,10 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 		return -EINVAL;
 
 	dso = map__dso(map);
-	if (!dso)
+	if (!dso) {
+		map__put(map);
 		return -EINVAL;
+	}
 
 	pr_debug("unwind: find_proc_info dso %s\n", dso->name);
 
@@ -476,11 +479,11 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 
 		memset(&di, 0, sizeof(di));
 		if (dwarf_find_debug_frame(0, &di, ip, base, symfile, start, map__end(map)))
-			return dwarf_search_unwind_table(as, ip, &di, pi,
-							 need_unwind_info, arg);
+			ret = dwarf_search_unwind_table(as, ip, &di, pi,
+							need_unwind_info, arg);
 	}
 #endif
-
+	map__put(map);
 	return ret;
 }
 
@@ -534,12 +537,14 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
 
 	dso = map__dso(map);
 
-	if (!dso)
+	if (!dso) {
+		map__put(map);
 		return -1;
+	}
 
 	size = dso__data_read_addr(dso, map, ui->machine,
 				   addr, (u8 *) data, sizeof(*data));
-
+	map__put(map);
 	return !(size == sizeof(*data));
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

