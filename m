Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E79C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDB96109D
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhKHNpF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237316AbhKHNpE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsI8BqJK+8ujPnGBIF+bBgzzhB7Y1IH5qe6bx3pDuvE=;
        b=g/IuNa0O8Xd+cunHmBa2igGANXBEsLd0wSdRbAgAzoYvooJ75FX9E9PAYoJ2NH2EMVdv2l
        b31HDKVuYgCm1PCQme0qFbh/mW2UubEzKqopvgUZsRmm+6D5nD4K/wnUke5iz25WirRR2U
        ALcviOU+G1k/mlI6IVUCr9Ko2S0Q4mE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-3wRbgKnDN0ery9hLt96vRA-1; Mon, 08 Nov 2021 08:42:19 -0500
X-MC-Unique: 3wRbgKnDN0ery9hLt96vRA-1
Received: by mail-wm1-f69.google.com with SMTP id r6-20020a1c4406000000b0033119c22fdbso6232001wma.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsI8BqJK+8ujPnGBIF+bBgzzhB7Y1IH5qe6bx3pDuvE=;
        b=FVMIv4rkb8r5pYow3TGdL/PMuCWQ1Mnu85Y1jiMV+Hp8z9EYf4C+5ONzlnpF0eZ0Oo
         EFrOGJrdaVaRIDKw9AFJtKzbwOpikb5kakP/ThVCsFZlOfyvpeuRhWRU+64Qkfdqhl2/
         v9o2TScuoW8tATPt+0LYOEo7nX/7gb4K92t7Hp0i15Vg3bkbqrGZqfLHQuYmKVlcfCOw
         8ZrgCqh4LluGJCY8kExPJNSOv4Z8DVTqtj/7iB3cnFk3RneuZpntaFqYVQ1sHZS6TZCH
         WvkGWIfzpVsmPV4T9+q3KDGEtxmzI4xYZPOy7zkWKIhWESFwxKnlS+LT7SHUyA5FVdAe
         pRLQ==
X-Gm-Message-State: AOAM532Lve1A+zqysx1KwVc4rOFXBiNfbukCw56iejrXTPlTRgO/VMXn
        vTAfg51Q4Tl5wrlSabGIGhcDlBfDg56R3CBvb7mQj6dWsQI7aOFmp6JmjJuZMAWlToz/cRvJJzc
        ibUIohAWi7svhjbPO5Wd3zbODztRgEQ==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr85162288wrt.28.1636378937872;
        Mon, 08 Nov 2021 05:42:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyE1nGcqE0tqmZq7NtOT9S1yOr2CoMKxmTB9LHVNt2+isgtxV4zLTPkM9nIgqibf+rL+7d8dg==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr85162272wrt.28.1636378937758;
        Mon, 08 Nov 2021 05:42:17 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l124sm19340307wml.8.2021.11.08.05.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:17 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 50/59] perf tools: Add add_bpf callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:37:01 +0100
Message-Id: <20211108133710.1352822-51-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_bpf callback to struct parse_events_ops,
to allow custom bpf parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 6 ++++++
 tools/perf/util/parse-events.c                 | 2 ++
 tools/perf/util/parse-events.h                 | 5 -----
 tools/perf/util/parse-events.y                 | 5 +++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index f06c86630fda..3f57cd8a935a 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -123,6 +123,12 @@ struct parse_events_ops {
 			      const char *sys, const char *event,
 			      struct parse_events_error *err,
 			      struct list_head *head_config);
+
+	int (*add_bpf)(struct parse_events_state *parse_state,
+		       struct list_head *list,
+		       char *bpf_file_name,
+		       bool source,
+		       struct list_head *head_config);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ad2bec6e6b37..21eb101d24af 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -779,6 +779,7 @@ split_bpf_config_terms(struct list_head *evt_head_config,
 			list_move_tail(&term->list, obj_head_config);
 }
 
+static
 int parse_events_load_bpf(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  char *bpf_file_name,
@@ -2918,4 +2919,5 @@ static struct parse_events_ops parse_state_ops = {
 	.add_cache          = parse_events_add_cache,
 	.add_breakpoint     = parse_events_add_breakpoint,
 	.add_tracepoint     = parse_events_add_tracepoint,
+	.add_bpf            = parse_events_load_bpf,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 328612945503..ec94c8541698 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -63,11 +63,6 @@ struct perf_pmu_event_symbol {
 
 void parse_events__shrink_config_terms(void);
 void parse_events__clear_array(struct parse_events_array *a);
-int parse_events_load_bpf(struct parse_events_state *parse_state,
-			  struct list_head *list,
-			  char *bpf_file_name,
-			  bool source,
-			  struct list_head *head_config);
 /* Provide this function for perf test */
 struct bpf_object;
 int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 34915b81a7f1..1c55b9fdc79e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -690,7 +690,7 @@ PE_BPF_OBJECT opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_load_bpf(parse_state, list, $1, false, $2);
+	err = parse_state->ops->add_bpf(parse_state, list, $1, false, $2);
 	parse_events_terms__delete($2);
 	free($1);
 	if (err) {
@@ -702,12 +702,13 @@ PE_BPF_OBJECT opt_event_config
 |
 PE_BPF_SOURCE opt_event_config
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list;
 	int err;
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_load_bpf(_parse_state, list, $1, true, $2);
+	err = parse_state->ops->add_bpf(parse_state, list, $1, true, $2);
 	parse_events_terms__delete($2);
 	if (err) {
 		free(list);
-- 
2.31.1

