Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C6C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10986115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbhKHNor (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240026AbhKHNor (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KNoUJbonxCWUF/nG8DbLKKrVFDkGQ/Tlo8C3/BsMnHg=;
        b=N/i1MI/5l9aorXntOfs+i3k99ZmzqdR5mjMgvxV76vpXHApyYwk/RsQRvzEl30X7WvgTty
        tZDmmXel0l+GhuKx6Z1dik6x4cCyhy+gXH2iV5K3tZHUUwzLxWJ51KaCP1RcEg06DEhmUt
        vd0TyELXukn/SoXNUu6nS6S0PmlKTQ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-BzkZRpWkO66cZBGCuAmkJA-1; Mon, 08 Nov 2021 08:42:01 -0500
X-MC-Unique: BzkZRpWkO66cZBGCuAmkJA-1
Received: by mail-wr1-f69.google.com with SMTP id q5-20020a5d5745000000b00178abb72486so4055260wrw.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNoUJbonxCWUF/nG8DbLKKrVFDkGQ/Tlo8C3/BsMnHg=;
        b=ELLWhO4MMCgYyr/kw8WQw94/ue4iGbwZstQjx4Ac/tO2g9iBzzq+D+/p8hoZ+6zP1l
         uWkYJABBytaDeFIO7AFAo5/33t3rCOTMb9AKY7XpEf0PaRvIMv3vLL5dMKzaNt1VDcHo
         IRCKbTZML17sBvF73wRpq2ZuMdLbVuUizEQX534RzfckMXll9J9VXmZp4uFG2lzOG1Ri
         RvyJ6wIh86/toDmv6bwDOwIzVxph8wQam/+n53aVjDLorIFSi5EApvpdTc0elf4PP9Ui
         WHTg6R+2NAWC4Xk7CQsBg9/TjWNlDAP2ixf60cjHil0ZHnKhID8WnIdM2x9C2MP+n5EK
         GfMg==
X-Gm-Message-State: AOAM532ETFGCDyGnO02udpVn73AOhNYXRLPi62Ov6tg0WQvI/1MalKS/
        EhFuSpO6iLBmBlqx6fn0OckqvpniIUw5HbEnzQJS5Le2i5jpxJaxRT/QJSle/Dlnvk2MPdgnW2h
        tlLUtdMxfOZEqTmGRHz87/XUkNV7zlw==
X-Received: by 2002:a1c:48e:: with SMTP id 136mr53493809wme.21.1636378920130;
        Mon, 08 Nov 2021 05:42:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKUIKrq7QxajTDpHUaMFIWuO+itX89NsZLuWoQ7JujEZrxTQOoVZEJkRo7ZKp3sVnkrPTx+A==
X-Received: by 2002:a1c:48e:: with SMTP id 136mr53493792wme.21.1636378919997;
        Mon, 08 Nov 2021 05:41:59 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id u5sm17735818wrg.57.2021.11.08.05.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:59 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 47/59] perf tools: Add add_cache callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:36:58 +0100
Message-Id: <20211108133710.1352822-48-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding add_cache callback to struct parse_events_ops,
to allow custom cache parsing code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 6 ++++++
 tools/perf/util/parse-events.c                 | 2 ++
 tools/perf/util/parse-events.h                 | 5 -----
 tools/perf/util/parse-events.y                 | 6 +++---
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index cbcf799f8969..bc938cddb3d7 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -107,6 +107,12 @@ struct parse_events_ops {
 			   struct list_head *list,
 			   u32 type, u64 config,
 			   struct list_head *head_config);
+
+	int (*add_cache)(struct parse_events_state *parse_state,
+			 struct list_head *list,
+			 char *type, char *op_result1, char *op_result2,
+			 struct parse_events_error *err,
+			 struct list_head *head_config);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a05e1bdb4e60..6bffb67f8c24 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -339,6 +339,7 @@ static int config_attr(struct perf_event_attr *attr,
 		       struct parse_events_error *err,
 		       config_term_func_t config_term);
 
+static
 int parse_events_add_cache(struct parse_events_state *parse_state,
 			   struct list_head *list,
 			   char *type, char *op_result1, char *op_result2,
@@ -2906,4 +2907,5 @@ static struct parse_events_ops parse_state_ops = {
 	.add_pmu            = parse_events_add_pmu,
 	.add_pmu_multi      = parse_events_multi_pmu_add,
 	.add_numeric        = parse_events_add_numeric,
+	.add_cache          = parse_events_add_cache,
 };
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 40d192cace03..91c3f5bdf434 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -82,11 +82,6 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 int parse_events_add_tool(struct parse_events_state *parse_state,
 			  struct list_head *list,
 			  int tool_event);
-int parse_events_add_cache(struct parse_events_state *parse_state,
-			   struct list_head *list,
-			   char *type, char *op_result1, char *op_result2,
-			   struct parse_events_error *error,
-			   struct list_head *head_config);
 int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 				struct list_head *list,
 				u64 addr, char *type, u64 len);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b23691397374..6dcd1e1677e9 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -486,7 +486,7 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_e
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(parse_state, list, $1, $3, $5, error, $6);
+	err = parse_state->ops->add_cache(parse_state, list, $1, $3, $5, error, $6);
 	parse_events_terms__delete($6);
 	free($1);
 	free($3);
@@ -507,7 +507,7 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(parse_state, list, $1, $3, NULL, error, $4);
+	err = parse_state->ops->add_cache(parse_state, list, $1, $3, NULL, error, $4);
 	parse_events_terms__delete($4);
 	free($1);
 	free($3);
@@ -527,7 +527,7 @@ PE_NAME_CACHE_TYPE opt_event_config
 
 	list = alloc_list();
 	ABORT_ON(!list);
-	err = parse_events_add_cache(parse_state, list, $1, NULL, NULL, error, $2);
+	err = parse_state->ops->add_cache(parse_state, list, $1, NULL, NULL, error, $2);
 	parse_events_terms__delete($2);
 	free($1);
 	if (err) {
-- 
2.31.1

