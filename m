Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BABC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6427F6115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhKHNpw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNpw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nQCmLZtPw0taZeN+1pGJy4+ujXR4QRpVZMokB4u8Do=;
        b=LT3Bam9KqLA7JpWoKaVCMvydEyvWPtp6Lvt6u8Wk5scljyi/hu9c/YQ6DDEqKWMk5r49Ld
        8dto+F6hR+89RiyVIRc4laO6BMdJY66pIy23wpko7V1OS38nZI0pQK58BHbaQEYqVo9bDY
        9qJOTN64ha0LRJOsG6HQRcZ5TZUygMI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-SfI3hfwHPJqycI50vK4MVw-1; Mon, 08 Nov 2021 08:43:07 -0500
X-MC-Unique: SfI3hfwHPJqycI50vK4MVw-1
Received: by mail-wm1-f69.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso10174948wmb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nQCmLZtPw0taZeN+1pGJy4+ujXR4QRpVZMokB4u8Do=;
        b=T/eNXUtkt8i0gnc8GU103shE4xYzxayg8vRwhAAPvY9IKT3HK8RTIac5wHhgD3bmIY
         sC2pjFBVptp/GQ5In1vP2BRChUL/aKnj7IQHkQ7JyHiMoixmnhvxWFZ8UV4rT7CusFco
         zu4Z+/3iZUcqvkECUlL53Db6+Zbk/R+PCqlOQJhshx7aCAflw0I4szOP9a4yXqtS3Whl
         omL5WwlciRT9Ty8cA9RiGqbZVS8nOtAa1bDI7AK/Iqwd2+a6dSBmxZs2b+k4jr5kxwIK
         i1Sc0qtKjsis82OWcDl9tXOzfUxbiGOqE2BPQLWIobPkaEMgZ+QdOzy3JxU91iui0a3h
         qO9g==
X-Gm-Message-State: AOAM5306VEaYwlAdzH3mTqVuASmBd84Nd6IIG/2D6LvNFVaOLqpidZTh
        xuWNYvtVCNEa7iWpQds7wFlu9fDQSvpz/5rS5Bsa1FNkZO7VJv6O+LND7Y1Oj8NML4TRzyQaYvc
        b3fd5XD9NAcKcqRa1ms9gXDiumBNNgQ==
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr34524850wmq.112.1636378985316;
        Mon, 08 Nov 2021 05:43:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLoUYfZwkcoLB29MiNHogQusqq+crCAjGoCl2OKfY0K9/tnoBJAwS+bGrjcEbdf02bAfYvXA==
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr34524824wmq.112.1636378985116;
        Mon, 08 Nov 2021 05:43:05 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t127sm20492881wma.9.2021.11.08.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:43:04 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 58/59] libperf: Add libperf_parse_events function
Date:   Mon,  8 Nov 2021 14:37:09 +0100
Message-Id: <20211108133710.1352822-59-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding libperf_parse_events function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/perf/evlist.h |   2 +
 tools/lib/perf/libperf.map           |   1 +
 tools/lib/perf/parse-events.c        | 171 +++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)

diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index 9ca399d49bb4..360443dd4135 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -47,4 +47,6 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
 
 LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
+
+LIBPERF_API int libperf_parse_events(struct perf_evlist *evlist, const char *str);
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 71468606e8a7..8971431071f2 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -50,6 +50,7 @@ LIBPERF_0.0.1 {
 		perf_mmap__read_init;
 		perf_mmap__read_done;
 		perf_mmap__read_event;
+		libperf_parse_events;
 	local:
 		*;
 };
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index 1c1fbbeb7182..d165c33fed83 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -10,6 +10,8 @@
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
+#include <perf/evsel.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <asm/bug.h>
@@ -702,3 +704,172 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				     /*pmu=*/NULL, /*config_terms=*/NULL,
 				     /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOENT;
 }
+
+static struct perf_evsel*
+perf_evsel__new_idx(struct perf_event_attr *attr, int idx, bool init_attr __maybe_unused)
+{
+	struct perf_evsel *evsel = perf_evsel__new(attr);
+
+	if (evsel)
+		perf_evsel__init(evsel, attr, idx);
+	return evsel;
+}
+
+static struct perf_evsel*
+perf_evsel__newtp_idx(const char *sys __maybe_unused, const char *name __maybe_unused,
+		      int idx __maybe_unused)
+{
+	return NULL;
+}
+
+static void perf_evsel__delete_helper(struct perf_evsel *evsel)
+{
+	perf_evsel__delete(evsel);
+}
+
+static
+int parse_events_add_pmu(struct parse_events_state *parse_state __maybe_unused,
+			 struct list_head *list __maybe_unused,
+			 char *pmu_name __maybe_unused,
+			 struct list_head *head_config __maybe_unused,
+			 struct list_head *orig_terms __maybe_unused,
+			 bool auto_merge_stats __maybe_unused,
+			 bool use_alias __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static int
+parse_events_multi_pmu_add(struct parse_events_state *parse_state __maybe_unused,
+			   char *str __maybe_unused,
+			   struct list_head *head __maybe_unused,
+			   struct list_head **listp __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static int
+parse_events_add_numeric(struct parse_events_state *parse_state __maybe_unused,
+			 struct list_head *list __maybe_unused,
+			 u32 type __maybe_unused, u64 config __maybe_unused,
+			 struct list_head *head_config __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static int
+parse_events_add_cache(struct parse_events_state *parse_state __maybe_unused,
+		       struct list_head *list __maybe_unused,
+		       char *type __maybe_unused, char *op_result1 __maybe_unused,
+		       char *op_result2 __maybe_unused,
+		       struct parse_events_error *err __maybe_unused,
+		       struct list_head *head_config __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static int
+parse_events_add_tracepoint(struct parse_events_state *parse_state __maybe_unused,
+			    struct list_head *list __maybe_unused,
+			    const char *sys __maybe_unused, const char *event __maybe_unused,
+			    struct parse_events_error *err __maybe_unused,
+			    struct list_head *head_config __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static int
+parse_events_load_bpf(struct parse_events_state *parse_state __maybe_unused,
+		      struct list_head *list __maybe_unused,
+		      char *bpf_file_name __maybe_unused,
+		      bool source __maybe_unused,
+		      struct list_head *head_config __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static void
+parse_events_set_leader(char *name, struct list_head *list,
+			struct parse_events_state *parse_state)
+{
+	struct perf_evsel *leader;
+
+	if (list_empty(list))
+                return;
+
+	__perf_evlist__set_leader(list);
+	leader = list_entry(list->next, struct perf_evsel, node);
+	leader->group_name = name ? strdup(name) : NULL;
+}
+
+static enum perf_pmu_event_symbol_type
+perf_pmu__parse_check(const char *name __maybe_unused)
+{
+	return PMU_EVENT_SYMBOL_ERR;
+}
+
+static struct parse_events_ops parse_state_ops = {
+	.perf_evsel__new    = perf_evsel__new_idx,
+	.perf_evsel__new_tp = perf_evsel__newtp_idx,
+	.perf_evsel__delete = perf_evsel__delete_helper,
+	.add_pmu            = parse_events_add_pmu,
+	.add_pmu_multi      = parse_events_multi_pmu_add,
+	.add_numeric        = parse_events_add_numeric,
+	.add_cache          = parse_events_add_cache,
+	.add_breakpoint     = parse_events_add_breakpoint,
+	.add_tracepoint     = parse_events_add_tracepoint,
+	.add_bpf            = parse_events_load_bpf,
+	.set_leader         = parse_events_set_leader,
+	.parse_check        = perf_pmu__parse_check,
+};
+
+static bool perf_evsel__has_leader(struct perf_evsel *evsel, struct perf_evsel *leader)
+{
+	return evsel->leader == leader;
+}
+
+static void perf_evlist__splice_list_tail(struct perf_evlist *evlist, struct list_head *list)
+{
+	while (!list_empty(list)) {
+		struct perf_evsel *evsel, *temp, *leader = NULL;
+
+		__perf_evlist__for_each_entry_safe(list, temp, evsel) {
+			list_del_init(&evsel->node);
+			perf_evlist__add(evlist, evsel);
+			leader = evsel;
+			break;
+		}
+
+		__perf_evlist__for_each_entry_safe(list, temp, evsel) {
+			if (perf_evsel__has_leader(evsel, leader)) {
+				list_del_init(&evsel->node);
+				perf_evlist__add(evlist, evsel);
+			}
+		}
+	}
+}
+
+int libperf_parse_events(struct perf_evlist *evlist, const char *str)
+{
+	struct parse_events_state parse_state = {
+		.list     = LIST_HEAD_INIT(parse_state.list),
+		.idx      = evlist->nr_entries,
+		.evlist   = evlist,
+		.ops      = &parse_state_ops,
+	};
+	int err;
+
+	err = parse_events__scanner(str, &parse_state, false);
+
+	if (!err && list_empty(&parse_state.list)) {
+		WARN_ONCE(true, "WARNING: event parser found nothing\n");
+		return -1;
+	}
+
+	perf_evlist__splice_list_tail(evlist, &parse_state.list);
+
+	if (!err)
+		evlist->nr_groups += parse_state.nr_groups;
+
+	return err;
+}
-- 
2.31.1

