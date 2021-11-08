Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA20C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7475E6109E
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbhKHNpT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNpQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhKHPTvltkaEZLSPuifVV1UW/U00a6SjzCphRdXjLZM=;
        b=AOZufAS0A6Bi9VE+jQctY1veczA1dkT5yxvgwk0JU/sKvUIkvTXBzaBlpf+8iU5E+GJb07
        cnjSuUYnrA783xS4XcfQtii6m8GGMk5hlxVEnIJOeRW4+dkFcZp28SAvPhwBulIB+NHG1K
        g7WhTzcilUqGkztazaNCY7lH6stRX9w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-atR5vcs5M9meSFSYm4VcvA-1; Mon, 08 Nov 2021 08:42:31 -0500
X-MC-Unique: atR5vcs5M9meSFSYm4VcvA-1
Received: by mail-wm1-f72.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso5796609wms.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhKHPTvltkaEZLSPuifVV1UW/U00a6SjzCphRdXjLZM=;
        b=ec410cTrD8bzdhMLlVmksAWnJBlxn3jgkG/aZQHZB634p/OkZV+TcpY3Z1fbgXm6lq
         8yOP0zwZFbE0xGhzKwTYmhS1onFfuJppIzJW9kvWuYBKAl1XmV8eyqyup3bGAfQHA98j
         E8cmhgo8WRIGvuFOsTl4fLRfygM/ZHrfYY3ax+6ataZjQm8h7PGab1N9LLAxyyllR69v
         ngIxVih/+Z2D1GseuLJSr0OMylqu89Q6LXBXhWsLdfE6p0uJ/uvIWB1j/RB0G1yMbLJ1
         V1MZ0yt0o8PR22cFXVvDTIkqqs92IVtdGDPeD+qvJj6+SLQ7kLD71wbot3+SoCokkouC
         MISA==
X-Gm-Message-State: AOAM533gBglmh0W0q8Q6/8TJ5wmDt90x10xR6bacAcGolPPO/9EaC+cY
        pi1LsVfNtTu5IC8NqBHX5ozEs25fk8Fjl8KRAGzwmzx9nZ5sYTxlt1qE8dks/HBR9eKmZAgC3fI
        XNL6uOrsAbl8DU9Rm7G+Pdc1CK4C10Q==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr50680007wmj.77.1636378949798;
        Mon, 08 Nov 2021 05:42:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ8G96STCfWvyJ60/5R09xFSqGmVbaeRPFqOJpoKc1bTt5i+aKY8bAUM9INVDYlcXMfbBPHg==
X-Received: by 2002:a7b:cb56:: with SMTP id v22mr50679992wmj.77.1636378949662;
        Mon, 08 Nov 2021 05:42:29 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o10sm7182436wri.15.2021.11.08.05.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:29 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 52/59] perf tools: Add set_leader callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:37:03 +0100
Message-Id: <20211108133710.1352822-53-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_numeric callback to struct parse_events_ops,
to allow custom leader setting in parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 3 +++
 tools/perf/util/parse-events.c                 | 6 ++++--
 tools/perf/util/parse-events.h                 | 2 --
 tools/perf/util/parse-events.y                 | 6 ++++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 8a5e3f7d5719..8eb9487a2519 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -133,6 +133,9 @@ struct parse_events_ops {
 	int (*add_tool)(struct parse_events_state *parse_state,
 			struct list_head *list,
 			int tool_event);
+
+	void (*set_leader)(char *name, struct list_head *list,
+			   struct parse_events_state *parse_state);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c1ebb114dd41..2c1bc9644c42 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1756,8 +1756,9 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	return ret;
 }
 
-void parse_events__set_leader(char *name, struct list_head *list,
-			      struct parse_events_state *parse_state)
+static
+void parse_events_set_leader(char *name, struct list_head *list,
+			     struct parse_events_state *parse_state)
 {
 	struct evsel *leader;
 
@@ -2922,4 +2923,5 @@ static struct parse_events_ops parse_state_ops = {
 	.add_tracepoint     = parse_events_add_tracepoint,
 	.add_bpf            = parse_events_load_bpf,
 	.add_tool           = parse_events_add_tool,
+	.set_leader         = parse_events_set_leader,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 95fc6f4cd187..c62a2e3a1f34 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -77,8 +77,6 @@ struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
 
 enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name);
-void parse_events__set_leader(char *name, struct list_head *list,
-			      struct parse_events_state *parse_state);
 
 void print_events(const char *event_glob, bool name_only, bool quiet,
 		  bool long_desc, bool details_flag, bool deprecated,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 1d9410605c9f..38d29946fa07 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -227,20 +227,22 @@ group_def
 group_def:
 PE_NAME '{' events '}'
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list = $3;
 
 	inc_group_count(list, _parse_state);
-	parse_events__set_leader($1, list, _parse_state);
+	parse_state->ops->set_leader($1, list, parse_state);
 	free($1);
 	$$ = list;
 }
 |
 '{' events '}'
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list = $2;
 
 	inc_group_count(list, _parse_state);
-	parse_events__set_leader(NULL, list, _parse_state);
+	parse_state->ops->set_leader(NULL, list, parse_state);
 	$$ = list;
 }
 
-- 
2.31.1

