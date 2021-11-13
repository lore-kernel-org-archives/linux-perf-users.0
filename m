Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB8C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 07:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF7960FE3
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Nov 2021 07:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhKMHSq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 02:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhKMHSp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 02:18:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AD4C061767
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 23:15:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso18145332ybj.18
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Nov 2021 23:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VdnfAA7CUmCEI8U4fjFQFwNxnsq/Nxa4FP/+oD/MraA=;
        b=CRbx9W44DN6vvYx50LcoXajUy62kmT3n5F+7mEbV8b247GgToXb0Y7xQYciZESPEOc
         NGTbC+IhZ+4JoqsiXuF7VUScB/ot1S4CA8HpO87tTP6zAS5Fe/MhXSLE16qfiNS0RZHg
         pIxrig77hLjJ39pXIrAjobvi5TvItwezr/xZSoaXyaJXaGTf0Us8xf4uPBPTh9aEiKmf
         lpACyRK7bqn/jEM68gfgHvKNuMp4j0RiOTCnr/oQUyALe+z4lWykr9qIXm0w00CUbhT/
         q1o0v8mNaiZKA5C0CHw74Y5YfUcHWo/3ovEtTpSbtussbAT6YSh5UREu5p7Q2DcVMITE
         KUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VdnfAA7CUmCEI8U4fjFQFwNxnsq/Nxa4FP/+oD/MraA=;
        b=mArqng+snIcM/ImIeyet3D4sRKi6t7Xo8XY0F6gRSnR3vumNinuDo9KE3l4YOk6OFU
         jT0PahtTymroxv9gE2EAhCqOUelgkrxpycdJjQPdeQCouPeyTalbQBCr3mn1ARG1+Wx8
         YapB1HyLT8I6MartreDDjqyjfyxRJegKsoxlNvhkL+6k2pkZlHOZmgPGSnkLqNEFMtUp
         Ma+jCxt1DBQzkUUZ5Fse8+SwyoXrfzZaL8r+EFfya78VsbXd87gXAmK32csCTuIjdMHq
         z/HmN365BQ12wWJlYxnQFInh+g2KsspivIDYVn1jx5Na1Gdzc8ZnCWY41iM89cAZR53b
         2JsA==
X-Gm-Message-State: AOAM530rMphCSry+0oFnhfUIWP7XtORiIMYvR3CZXUUZqh1pJtk+QBLo
        BBZihErmPXcgQq9hmdpBhF24nFr2rYeW
X-Google-Smtp-Source: ABdhPJzchJra2nBK1aFykE4SPEUOhNHoubxkz1EaRlErGPrQLRK/U2rg7y6JGmeI+QLCBA1EeJkJjDjP0eqw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7363:ca3f:1032:5f2d])
 (user=irogers job=sendgmr) by 2002:a5b:145:: with SMTP id c5mr22782502ybp.60.1636787752705;
 Fri, 12 Nov 2021 23:15:52 -0800 (PST)
Date:   Fri, 12 Nov 2021 23:15:47 -0800
Message-Id: <20211113071548.372572-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 1/2] perf evlist: Allow setting arbitrary leader
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The leader of a group is the first, but allow it to be an arbitrary
list member so that for Intel topdown events slots may always be the
group leader.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                  | 15 +++++++++------
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/util/parse-events.c           |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index e37dfad31383..974da341b8b0 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -643,14 +643,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
 }
 
-void __perf_evlist__set_leader(struct list_head *list)
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *evsel, *leader;
+	struct perf_evsel *first, *last, *evsel;
 
-	leader = list_entry(list->next, struct perf_evsel, node);
-	evsel = list_entry(list->prev, struct perf_evsel, node);
+	first = list_entry(list->next, struct perf_evsel, node);
+	last = list_entry(list->prev, struct perf_evsel, node);
 
-	leader->nr_members = evsel->idx - leader->idx + 1;
+	leader->nr_members = last->idx - first->idx + 1;
 
 	__perf_evlist__for_each_entry(list, evsel)
 		evsel->leader = leader;
@@ -659,7 +659,10 @@ void __perf_evlist__set_leader(struct list_head *list)
 void perf_evlist__set_leader(struct perf_evlist *evlist)
 {
 	if (evlist->nr_entries) {
+		struct perf_evsel *first = list_entry(evlist->entries.next,
+						struct perf_evsel, node);
+
 		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
-		__perf_evlist__set_leader(&evlist->entries);
+		__perf_evlist__set_leader(&evlist->entries, first);
 	}
 }
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index f366dbad6a88..6f74269a3ad4 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -127,5 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
-void __perf_evlist__set_leader(struct list_head *list);
+void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader);
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5bfb6f892489..6308ba739d19 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1834,8 +1834,8 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	__perf_evlist__set_leader(list);
 	leader = list_entry(list->next, struct evsel, core.node);
+	__perf_evlist__set_leader(list, &leader->core);
 	leader->group_name = name ? strdup(name) : NULL;
 }
 
-- 
2.34.0.rc1.387.gb447b232ab-goog

