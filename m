Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA56C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7D8610E8
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbhJORX7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242199AbhJORXw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:23:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0376CC061765
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso11968130ybc.6
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Oct 2021 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XW2mCrDf1DUphwbsZwW9UQbbVujr91pVtxEQxiDp1EI=;
        b=NIPGrv9BA/LZYfiUo7NPjx8EdPL1MouxnBhCEzjFTW27A3qVWCmbH3hVxMbYCaY8gz
         XrtutPqUji9pJtmI5wWSjcx4Pz9UxpTorp+vLGEOPSmpa3550/iJbee6b0lB/Ff+iN0W
         /hjRngvvu62glxs6KqMVqLBcn1juprlgRgpt69qBE+X1+u+YRF2LApZB53yx5NTdGXog
         RODcv0FdV/1GEK9QpLbZJ3G0IBPlY3/bS1Zoqi5lSe6YFnva4+J7WJdLdPMkxT6EyfHF
         LrqMdjXjpHQixdesuUINS6xlXZo4h0O//7xtg+iTy9HjBZ9Fl5Ez+0ZDvrxhXLL5eyA1
         gjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XW2mCrDf1DUphwbsZwW9UQbbVujr91pVtxEQxiDp1EI=;
        b=SN4X577IapPxHF5u+/xDolvLfoWD4s6/vuIFsFPUP+yh6vs1ayp1kit8vprCD7ev7n
         oza903wdw8K3w+LycWxwF2NMH73avmOJ8gRQHZnCELDNZcjEFyfJX/R4sHjI93ucrihI
         5lrYo17WiZSQn6DoXEbVGdKRUI0ARnTWNSclveY100id0F1wTmOaMGeSAT0tOlF50vzA
         +V/t6Gsj1F4wyu3nfKZHG0jwSICSSUD3ZTcrFTxYTJzw8jMP3JFGiwQ0LN31RfuLaQFT
         Qza8i23afOMxO29gVeToKtWFexmnDgcU0aJp4jTTKvYJTkyuXUPnvMmweONvenV8pslg
         Y76g==
X-Gm-Message-State: AOAM532Hy/s57E7cIOcZQvYKzdjbGm9iE/XVI7GwepSZIDNSUgGtvKSW
        +4DAinjssUuQv64Iud9vkT3Jsbr65iUV
X-Google-Smtp-Source: ABdhPJzql8UID52sHiRlvZQ979qtJqoOFqn8yZz6fXTYBFx1XPDbTQpVNwNVzHQv5qJfnQryYoW1RqO1B5Z8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:69bc:7451:58ad:6585])
 (user=irogers job=sendgmr) by 2002:a25:afcf:: with SMTP id
 d15mr13161012ybj.433.1634318505185; Fri, 15 Oct 2021 10:21:45 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:21:14 -0700
In-Reply-To: <20211015172132.1162559-1-irogers@google.com>
Message-Id: <20211015172132.1162559-4-irogers@google.com>
Mime-Version: 1.0
References: <20211015172132.1162559-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 03/21] perf pmu: Make pmu_sys_event_tables const.
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

Make lookup nature of data structures clearer through their type.

Acked-by: Andi Kleen <ak@linux.intel.com>
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
2.33.0.1079.g6e70778dc9-goog

