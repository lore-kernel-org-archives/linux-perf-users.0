Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B5C07E96
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC52861C23
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jul 2021 15:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhGFPU2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232743AbhGFPUZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tOpmQlI5h4Fk2I5eFc58+NXtZElRb7F5uumjvKfZx3U=;
        b=Pt5Hw0mDm5YJ23pAnqbQHf9f3kcRYrii1Jf6DP12q/MRfS5CquYpAWiPjeV88rOwY/ei6V
        RLbdx55eyQW+3DwQNQs9PPS/EA5d5eKknfN7M0JGUIw+1zjGTRedRgW+qsRIfwpwRFJ5B+
        W/T65UlfhYsx1GbX9lUvhG56Nw4pNl8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-Dje7EEHrNx-hV3IBps4Gtg-1; Tue, 06 Jul 2021 11:17:45 -0400
X-MC-Unique: Dje7EEHrNx-hV3IBps4Gtg-1
Received: by mail-wr1-f69.google.com with SMTP id p4-20020a5d63840000b0290126f2836a61so7300173wru.6
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jul 2021 08:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOpmQlI5h4Fk2I5eFc58+NXtZElRb7F5uumjvKfZx3U=;
        b=QMFhwIXUD8l+c5biiMZiVCYjE080KxI/M/Pm3xLzT/DT5qB0ry1xt89is+QepKDQf1
         wMXDgtDtmL87ReregkrPtTpLoayw5kg1I5rcw5RysfmAKZT7p2UV/jfsZ5GDgoRVkIqD
         rXi0tYpeIJXes1Jmh/QFPNDKTlyDrkmERlrN9zmS5TYbDBZrrhAdxH0FO5e7RgE0X09H
         3RFNMD+kqsycwuXiVUql32yGRjufR58I5N8vN02LuQGPCTl7iR6316/fEK6ACrjZO/36
         2pqZv0An1qheyoO+tIo7KqV35y7benEyym0yVEoaopUI7sUykqaIhtD1/Q2pOpUtmm8m
         NUjQ==
X-Gm-Message-State: AOAM531rhYUD2utObSZRsgJoWp4NVT2D62/DVxuwGVSIsP7zzUjtXTlF
        1NvReGtg1bjcRhLGvHjxyIyrYZTcaOWEtXSFTCqfhS2XXZ7Mvu1JzLd6bCG/dGPW1cJtOcyQuuQ
        7ItxBUR2ViCGMlebGAPU9lLP6Z+PW1g==
X-Received: by 2002:adf:b605:: with SMTP id f5mr22556360wre.419.1625584663832;
        Tue, 06 Jul 2021 08:17:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym7QwnyWtDGr1euiYitV0KsusQCfpn9O/KHd8Nc1oxvOHqwOetCq9HmAYhF9E0dn4ELzf9cQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr22556334wre.419.1625584663684;
        Tue, 06 Jul 2021 08:17:43 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id d24sm3151612wmb.42.2021.07.06.08.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:43 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 5/7] libperf: Add perf_evlist__set_leader function
Date:   Tue,  6 Jul 2021 17:17:02 +0200
Message-Id: <20210706151704.73662-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving the implementation of evlist__set_leader under
the new libperf perf_evlist__set_leader function with
the same functionality and as exported API.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evlist.c                  | 21 +++++++++++++++++++++
 tools/lib/perf/include/internal/evlist.h |  1 +
 tools/lib/perf/include/perf/evlist.h     |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/perf/util/evlist.c                 | 19 +------------------
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/parse-events.c           |  2 +-
 7 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 68b90bbf0ffb..e37dfad31383 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -642,3 +642,24 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 
 	return overwrite ? evlist->mmap_ovw_first : evlist->mmap_first;
 }
+
+void __perf_evlist__set_leader(struct list_head *list)
+{
+	struct perf_evsel *evsel, *leader;
+
+	leader = list_entry(list->next, struct perf_evsel, node);
+	evsel = list_entry(list->prev, struct perf_evsel, node);
+
+	leader->nr_members = evsel->idx - leader->idx + 1;
+
+	__perf_evlist__for_each_entry(list, evsel)
+		evsel->leader = leader;
+}
+
+void perf_evlist__set_leader(struct perf_evlist *evlist)
+{
+	if (evlist->nr_entries) {
+		evlist->nr_groups = evlist->nr_entries > 1 ? 1 : 0;
+		__perf_evlist__set_leader(&evlist->entries);
+	}
+}
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index f16fa9877d27..f366dbad6a88 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -127,4 +127,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 
 void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
 
+void __perf_evlist__set_leader(struct list_head *list);
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index 0a7479dc13bf..9ca399d49bb4 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -46,4 +46,5 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 	     (pos) != NULL;						\
 	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
 
+LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index c0c7ceb11060..71468606e8a7 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -45,6 +45,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__munmap;
 		perf_evlist__filter_pollfd;
 		perf_evlist__next_mmap;
+		perf_evlist__set_leader;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 752f64afd622..47581a237c7a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -223,26 +223,9 @@ int __evlist__set_tracepoints_handlers(struct evlist *evlist,
 	return err;
 }
 
-void __evlist__set_leader(struct list_head *list)
-{
-	struct evsel *evsel, *leader;
-
-	leader = list_entry(list->next, struct evsel, core.node);
-	evsel = list_entry(list->prev, struct evsel, core.node);
-
-	leader->core.nr_members = evsel->core.idx - leader->core.idx + 1;
-
-	__evlist__for_each_entry(list, evsel) {
-		evsel->core.leader = &leader->core;
-	}
-}
-
 void evlist__set_leader(struct evlist *evlist)
 {
-	if (evlist->core.nr_entries) {
-		evlist->core.nr_groups = evlist->core.nr_entries > 1 ? 1 : 0;
-		__evlist__set_leader(&evlist->core.entries);
-	}
+	perf_evlist__set_leader(&evlist->core);
 }
 
 int __evlist__add_default(struct evlist *evlist, bool precise)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index cb2bf5f4866a..5c22383489ae 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -201,7 +201,6 @@ void evlist__set_selected(struct evlist *evlist, struct evsel *evsel);
 int evlist__create_maps(struct evlist *evlist, struct target *target);
 int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel);
 
-void __evlist__set_leader(struct list_head *list);
 void evlist__set_leader(struct evlist *evlist);
 
 u64 __evlist__combined_sample_type(struct evlist *evlist);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f6d77cb44007..e5eae23cfceb 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1833,7 +1833,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
 		return;
 
-	__evlist__set_leader(list);
+	__perf_evlist__set_leader(list);
 	leader = list_entry(list->next, struct evsel, core.node);
 	leader->group_name = name ? strdup(name) : NULL;
 }
-- 
2.31.1

