Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CE1C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8160F9B
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbhKHNpO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNpK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jyz7yDsjltEJeJ8+06pFC9Pct3mUD5+4joy0NskZqNA=;
        b=NAVnvHZhYIQb237dqmMD/uv6v/xmbGLh/hNbaaNBbZmt+iRpn1mi1B396hQknJr6ZXYZS3
        bNJd+sgOGrRZjUZZKbcuM2Nd9FYZ8dh2nCCIrrgW6QiwYCEkU7iGkIMOa5K/tFEAsJxdP2
        M1Ir1TiAwEnQbz70LRJ/Es+LmHw6UbQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-miR7K0_KPuex2ZZZiXrehw-1; Mon, 08 Nov 2021 08:42:25 -0500
X-MC-Unique: miR7K0_KPuex2ZZZiXrehw-1
Received: by mail-wr1-f71.google.com with SMTP id z5-20020a5d6405000000b00182083d7d2aso4049070wru.13
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jyz7yDsjltEJeJ8+06pFC9Pct3mUD5+4joy0NskZqNA=;
        b=k/hI43yJLmYaAztATfLPZVIopKzoMurXHj/23s1/Gk/xd11PePzGZiJqcuGebzGdcM
         nUr8qtdDxrDO0whgB9tWSkN3kEiUUGXh/QjeY6kmH6uFYyuSJFEwIFRUaWF3jtN7Sp1G
         /lOGP08X7TSKaY7CUMiEtpsZshOEwgTF+aUGmmG5IfIX6E+hw6h10saHUWTmYHFdKYom
         rPFnoAsit6Xw2Zkm/9Om7wT+ZUd4IWTDPg9LKNQuon5RPX2m6TpIAvOfrycQPVzijEbz
         pqzsQPUY/2EqZfb/pW62LXLfpeYKIf4XWaCIGJmxqWTwgNm+g8GdxFyzL1+apNLKBEi6
         8Nug==
X-Gm-Message-State: AOAM531ELeLtLUW0TEAKaKNCAiUgs3ihBvbWCob4+eKiS9VVsH9/b9FH
        FDwo8vD6rMFFgBznabm7gngHkafrXlWS8/NR+m0YPtCJBosa7HzhSdEFRorzDDEsA+03/frZlsN
        QN6GCXz5nUPsvfD5H549ZV2hO3sZ77A==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr51786417wml.100.1636378943700;
        Mon, 08 Nov 2021 05:42:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz78mh8KFhPjwLNL6C7hO36WgWTt8gEhmtOtqw2p1KOPeKft+q6AYJOHMH90Qm3R0ajbwENbg==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr51786401wml.100.1636378943575;
        Mon, 08 Nov 2021 05:42:23 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id w15sm16995107wrk.77.2021.11.08.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:23 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 51/59] perf tools: Add add_tool callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:37:02 +0100
Message-Id: <20211108133710.1352822-52-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_tool callback to struct parse_events_ops,
to allow custom tool parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 4 ++++
 tools/perf/util/parse-events.c                 | 2 ++
 tools/perf/util/parse-events.h                 | 3 ---
 tools/perf/util/parse-events.y                 | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 3f57cd8a935a..8a5e3f7d5719 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -129,6 +129,10 @@ struct parse_events_ops {
 		       char *bpf_file_name,
 		       bool source,
 		       struct list_head *head_config);
+
+	int (*add_tool)(struct parse_events_state *parse_state,
+			struct list_head *list,
+			int tool_event);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 21eb101d24af..c1ebb114dd41 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1356,6 +1356,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 	return ret;
 }
 
+static
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event)
@@ -2920,4 +2921,5 @@ static struct parse_events_ops parse_state_ops = {
 	.add_breakpoint     = parse_events_add_breakpoint,
 	.add_tracepoint     = parse_events_add_tracepoint,
 	.add_bpf            = parse_events_load_bpf,
+	.add_tool           = parse_events_add_tool,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index ec94c8541698..95fc6f4cd187 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -69,9 +69,6 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 			      struct list_head *list,
 			      struct bpf_object *obj,
 			      struct list_head *head_config);
-int parse_events_add_tool(struct parse_events_state *parse_state,
-			  struct list_head *list,
-			  int tool_event);
 
 struct evsel *parse_events__add_event(struct parse_events_state *parse_state,
 				      struct perf_event_attr *attr,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 1c55b9fdc79e..1d9410605c9f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -468,11 +468,12 @@ value_sym sep_slash_slash_dc
 |
 PE_VALUE_SYM_TOOL sep_slash_slash_dc
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	ABORT_ON(parse_events_add_tool(_parse_state, list, $1));
+	ABORT_ON(parse_state->ops->add_tool(_parse_state, list, $1));
 	$$ = list;
 }
 
-- 
2.31.1

