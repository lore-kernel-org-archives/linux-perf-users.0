Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1B1EB64D8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 05:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFVFLC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 01:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFVFKk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 01:10:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3F1BCA
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 22:10:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942442eb0so82425937b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 22:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687410632; x=1690002632;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Iwkvo3drwBmCh3irzLZqUQdw68f0F8NzA1rA0HnILRE=;
        b=DhKdtVPrmYHxiqjIKCbVGRxMjbXrvSQn+TCrG60I5aPx7c7YMFttQxbOAnjuiNvSKt
         ZBZ64IyZ6mpIB4RKj4p4a89tn8PJjxXPagqSybROjPUgGS0esLOwOEWVfi3U41BZrUKg
         Pr0ZYPWUaLrEeNgzVXC6UNOtI8+cFJKyDveKgVvWtzn4RxbD+CF1FbKnoaa58+ROWh5L
         InT4O4Bzo/yyWR3xkWxHPIoW/V3Jthf6X6MVMpCrFl8rTr/mtKpGB1bQvA7GIbYr1b8q
         B6eVEqekcxhU4dSVNyP3JbV8XRuhEhyfgwc6OEFURVr9h49gl+/Bh0Peos6QsbUGeJbs
         ov5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410632; x=1690002632;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iwkvo3drwBmCh3irzLZqUQdw68f0F8NzA1rA0HnILRE=;
        b=UqukwD5qsS+38dbZYL4fjJFE1Aq5exwRRCfCmqgItvL1yD6VMP5Kq4PDK+nxIZFBnZ
         uWRDMfC6mlGaPtvZMorcGPg/+OkMB5dAnC9uDvqbDhQxK+ok7k0rTeaFlpvd4mJ2agVG
         P2OvivIa/iqLZZ2OinSvEf3rHtktrPZtaXqnrEdk5JIyzzszfNeb8lEOPFaF6/6deZ3F
         uPsWUV4rlgTp2zdRtY7Tl0oaD9df0pRfGjy6V8ypcElj9Z5nV3E9CnxZ6GPDd9TRgsOW
         uqLjBON3fcQhlj0hLgsSjPBhRETvxxeB3LxXMMWjtizjWQte5nPcq37SzfbBUIlBn4mt
         6A/Q==
X-Gm-Message-State: AC+VfDxE+kqp4yUd6lH1lqf0rgSFqviMtITYPy4x39igB6l3FuLHVPz8
        OqrSmPjiOtO8kBFHrLX6ElO0bX3f9ZAO
X-Google-Smtp-Source: ACHHUZ5T7atXtGkQMSxCdZ4xuhdT4/Ifw+IX69REESlIEt/eN1LK8ciV7SNPoINgMMdPTtphocXQrxUgq6WM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91f3:1da5:6427:50d6])
 (user=irogers job=sendgmr) by 2002:a05:690c:70e:b0:573:4ed9:c69a with SMTP id
 bs14-20020a05690c070e00b005734ed9c69amr3818009ywb.10.1687410632774; Wed, 21
 Jun 2023 22:10:32 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:10:29 -0700
Message-Id: <20230622051029.3733815-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/1] perf unwind: Fix map reference counts
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
---
 tools/perf/util/unwind-libunwind-local.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 36bf5100bad2..9cb82d7c7dc7 100644
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
@@ -476,11 +477,11 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 
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
 
@@ -539,7 +540,7 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
 
 	size = dso__data_read_addr(dso, map, ui->machine,
 				   addr, (u8 *) data, sizeof(*data));
-
+	map__put(map);
 	return !(size == sizeof(*data));
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

