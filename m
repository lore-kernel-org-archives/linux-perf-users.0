Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEFC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF626115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbhKHNna (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50650 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237467AbhKHNna (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiDiz6WXLiR6ZTzJpFWzTDgLEgDLgDTgaA4Q7ualtyM=;
        b=VDQG9n+VK040QhxzWz56CuteLaBpJvpJ/0CuXxaVuel+YqBsbO/D6fxDOwdo0F8UsnK4CK
        CYnfKqmKV6+RuODDUhxRp2OAJl5O+D7iq4+rSuvsb/UMtwCj71BGv6TCES5lo+zJvxKP9k
        TVQla8i8WpxzbQlJd+XlSgpmDyPi7sA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-hHkMAetwPJ-quFhYV2bEgw-1; Mon, 08 Nov 2021 08:40:44 -0500
X-MC-Unique: hHkMAetwPJ-quFhYV2bEgw-1
Received: by mail-wm1-f69.google.com with SMTP id o10-20020a05600c4fca00b0033312e1ed8bso3102202wmq.2
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZiDiz6WXLiR6ZTzJpFWzTDgLEgDLgDTgaA4Q7ualtyM=;
        b=xh3IWlviVnNPwVByf0OAgSJFx2ZHeq387vxMUfJ6OK8OgP4QfQmV4bEIvZdjMhqoNe
         +jeye9flPO/xPt+/H0KmGUi7J/A9LQK21cYYUKvmqctj+Rig/Oycn0H/lk1tNsq54F+/
         FRqlDs6p4djMnSgvWVB9xuMhrLCYaBy8nH11uBNaqjaCGikh/QQoSWG2Kl4Mvzc4ZjJx
         Ox0p8G4JhosBZT3edy0nveORn2Jum8WFN8S8CgLlCHJFFaL7BJN2vnlW/g8AqRraQnUl
         P4wJtWBqVuRUW0mOeda2VUxddXARBh5d4ZKN0jJoI6owxr61nhwru2zClvnqKtQwExLI
         ImFA==
X-Gm-Message-State: AOAM532HqqDV6HTa1lC6jraXFEghgQ0BUgAkSa0EIyRI18NOz+wnbShx
        Jn3JVe9Ls/MDIS5sHCvOqWR+Bq7w3yrMXYRhjyfC9q3RmufvkLQc0cyDdSzCPJnpPmIqLShojaW
        oByPewHZFrVNbxNo33TZvcjB8ZfrNSQ==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr44411069wri.382.1636378843256;
        Mon, 08 Nov 2021 05:40:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymYMHV7pmbmtE/g87+Eq2u+vRJgvYSDHikHgxzMDz2Onc0rSknScFaxgG8CK8bgFBt1uAD4A==
X-Received: by 2002:a5d:64cd:: with SMTP id f13mr44411042wri.382.1636378843059;
        Mon, 08 Nov 2021 05:40:43 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n8sm16665087wrp.95.2021.11.08.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:42 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 34/59] perf tools: Move parse_events_update_lists to parser unit
Date:   Mon,  8 Nov 2021 14:36:45 +0100
Message-Id: <20211108133710.1352822-35-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse_events_update_lists to parser unit,
so we can easily move it to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 13 -------------
 tools/perf/util/parse-events.h |  2 --
 tools/perf/util/parse-events.y | 21 +++++++++++++++++----
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 77e122eb5601..1e3ec927545e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1752,19 +1752,6 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	leader->core.group_name = name ? strdup(name) : NULL;
 }
 
-/* list_event is assumed to point to malloc'ed memory */
-void parse_events_update_lists(struct list_head *list_event,
-			       struct list_head *list_all)
-{
-	/*
-	 * Called for single event definition. Update the
-	 * 'all event' list, and reinit the 'single event'
-	 * list, for next event definition.
-	 */
-	list_splice_tail(list_event, list_all);
-	free(list_event);
-}
-
 struct event_modifier {
 	int eu;
 	int ek;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 057b92778d17..e4ac9b546bc3 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -120,8 +120,6 @@ enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name);
 void parse_events__set_leader(char *name, struct list_head *list,
 			      struct parse_events_state *parse_state);
-void parse_events_update_lists(struct list_head *list_event,
-			       struct list_head *list_all);
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e62a7a3bf6b2..098e27ac718c 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -49,6 +49,19 @@ static void free_list_evsel(struct list_head* list_evsel)
 	free(list_evsel);
 }
 
+/* list_event is assumed to point to malloc'ed memory */
+static void update_lists(struct list_head *list_event,
+			 struct list_head *list_all)
+{
+	/*
+	 * Called for single event definition. Update the
+	 * 'all event' list, and reinit the 'single event'
+	 * list, for next event definition.
+	 */
+	list_splice_tail(list_event, list_all);
+	free(list_event);
+}
+
 static void inc_group_count(struct list_head *list,
 		       struct parse_events_state *parse_state)
 {
@@ -160,7 +173,7 @@ start_events: groups
 	struct parse_events_state *parse_state = _parse_state;
 
 	/* frees $1 */
-	parse_events_update_lists($1, &parse_state->list);
+	update_lists($1, &parse_state->list);
 }
 
 groups:
@@ -170,7 +183,7 @@ groups ',' group
 	struct list_head *group = $3;
 
 	/* frees $3 */
-	parse_events_update_lists(group, list);
+	update_lists(group, list);
 	$$ = list;
 }
 |
@@ -180,7 +193,7 @@ groups ',' event
 	struct list_head *event = $3;
 
 	/* frees $3 */
-	parse_events_update_lists(event, list);
+	update_lists(event, list);
 	$$ = list;
 }
 |
@@ -237,7 +250,7 @@ events ',' event
 	struct list_head *list  = $1;
 
 	/* frees $3 */
-	parse_events_update_lists(event, list);
+	update_lists(event, list);
 	$$ = list;
 }
 |
-- 
2.31.1

