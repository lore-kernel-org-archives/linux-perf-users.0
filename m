Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD0AC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B902A61245
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbhJGQ7f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242968AbhJGQ7b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 12:59:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F472C061755
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Oct 2021 09:57:37 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s20-20020a05620a0bd400b0045e893f2ed8so5708229qki.11
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Oct 2021 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L8gc2SLKtmcexIbSNAHtPbSk87uyMW/7ei0oQf2fgvA=;
        b=kZMFRqzoXRXcnaHOHs7IDVHk1z1OzvZWQVrdXx9t+Q7iArnHtSHZCJidncvz5f97tN
         g53bWclhEJUpg1cD42wbUC4nw2NsAizREU1gEuJWf7h1+3Vrq6vM+CC6HJCdABDye3WL
         TAcvp8KsYzK3OX3CN/p+zqklK1aMwgNyEiuclNknfhB6bJT21yLO7bmqvq9jc8l2a+Mo
         21qTukbGxrb9RIxmQrrJjHgAlFqo7Dxa5md17FQHpRjHBYXxgcStrQhXSJXbGnrX1iEx
         Rp8H8Jziei9XW59StqF5q1RZMwcguDziKIAsI8Abzb8oLu4PG4CPlHC66Hoabfgf+yrh
         X/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L8gc2SLKtmcexIbSNAHtPbSk87uyMW/7ei0oQf2fgvA=;
        b=6YKBcO8B/oKOix6S6qxwDvSJevFuJzzywKV3613rhyBBXf0zQI6DKS6/c5LXF2c4se
         MSpRunDq9ycgy6bZgFGaNeNJh61skN0Nh7dvHnFMIoHg574OE84yCZDCs0hZLs+nJIbB
         RS8bubTLi7DDKyg/2OJ7hHkW6bi/ayuTty46wCkCxISEgSvwc/MW+Eaac9m2mbaEmrB5
         NM44CAyLE00b15L9lry/+3xqHB8eQqccEDGH/8viqe1Ik7DerUmbUCfxi0VQzuuPZ1Az
         l7vmFYwkOYezFYkb7mTi0GR92d8LyXlgZR/x94ZiyCkdfQDWw5/1JhmMaMr3YPxLPyn8
         04uQ==
X-Gm-Message-State: AOAM5306DJn3ygp/z9B2EdY/VISWq6m2hg7scFHE8EwbdofV349GOSDZ
        Bh6irksuOUtH1vIbm6j/U01Xq33Wkkoy
X-Google-Smtp-Source: ABdhPJwIoQoUvl1evBM8gLJF/4wvNn7OaFmVW/kb08zNUBcNFgUxZJnqKALHmRhiWeo+SXL5JyTFjBOs5b90
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:fe85:5e36:cb6f:76bc])
 (user=irogers job=sendgmr) by 2002:ac8:431e:: with SMTP id
 z30mr6236542qtm.192.1633625856493; Thu, 07 Oct 2021 09:57:36 -0700 (PDT)
Date:   Thu,  7 Oct 2021 09:56:29 -0700
In-Reply-To: <20211007165647.3514803-1-irogers@google.com>
Message-Id: <20211007165647.3514803-4-irogers@google.com>
Mime-Version: 1.0
References: <20211007165647.3514803-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 03/21] perf pmu: Make pmu_sys_event_tables const.
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Make lookup nature of data structures clearer through their type.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c    | 2 +-
 tools/perf/pmu-events/pmu-events.h | 2 +-
 tools/perf/tests/pmu-events.c      | 2 +-
 tools/perf/util/pmu.c              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 5624a37d6f93..a31de0f77097 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -832,7 +832,7 @@ static void print_mapping_test_table(FILE *outfp)
 
 static void print_system_event_mapping_table_prefix(FILE *outfp)
 {
-	fprintf(outfp, "\nstruct pmu_sys_events pmu_sys_event_tables[] = {");
+	fprintf(outfp, "\nconst struct pmu_sys_events pmu_sys_event_tables[] = {");
 }
 
 static void print_system_event_mapping_table_suffix(FILE *outfp)
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 42c6db6bedec..f6c9c9fc4ab2 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -54,6 +54,6 @@ struct pmu_sys_events {
  * table of PMU events.
  */
 extern const struct pmu_events_map pmu_events_map[];
-extern struct pmu_sys_events pmu_sys_event_tables[];
+extern const struct pmu_sys_events pmu_sys_event_tables[];
 
 #endif
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 8a1fdcd072f5..c0f8b61871c8 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -258,7 +258,7 @@ static const struct pmu_events_map *__test_pmu_get_events_map(void)
 
 static struct pmu_event *__test_pmu_get_sys_events_table(void)
 {
-	struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
+	const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 
 	for ( ; tables->name; tables++) {
 		if (!strcmp("pme_test_soc_sys", tables->name))
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4bcdc595ce5e..c04a89cc7cef 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -873,7 +873,7 @@ void pmu_for_each_sys_event(pmu_sys_event_iter_fn fn, void *data)
 	int i = 0;
 
 	while (1) {
-		struct pmu_sys_events *event_table;
+		const struct pmu_sys_events *event_table;
 		int j = 0;
 
 		event_table = &pmu_sys_event_tables[i++];
-- 
2.33.0.882.g93a45727a2-goog

