Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E28AC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 004BE61458
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhKHNoY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240024AbhKHNoY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHjEzELT2r7KPnopvwCH5U1z3J6vgvVx5TL9TWZNlk4=;
        b=IkTltRoceUHJL9YpxJ9ZpMsghgrmoyk6/LWDw3gMRzXV+NSFpRY58QZ0e1fU2v0jrbt5I1
        69CBUoWgR5JyARjXEXad7hago7QrLUE4C8Sfp1eFQqUViLVallhw89t1sRaDY8XJfWQjuF
        w7F1+Kh5upyGR4AouOQIGuuDX6fa/OQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-iDLzQ7F2MFyui5DDNhxTDA-1; Mon, 08 Nov 2021 08:41:26 -0500
X-MC-Unique: iDLzQ7F2MFyui5DDNhxTDA-1
Received: by mail-wr1-f71.google.com with SMTP id r12-20020adfdc8c000000b0017d703c07c0so4066449wrj.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHjEzELT2r7KPnopvwCH5U1z3J6vgvVx5TL9TWZNlk4=;
        b=awykUfeBJrI3+29K9Nx7g1EEuaB13O5IG4dM/eYnlTaJSU1FI3DHcYxMqSVNgL6AbJ
         C2DndPhKxFSZ9+RV4CJJpIrMPritS4aOGi+n+z1BO962fSq49h91H9HWWxeXWQm77Trv
         t6Csihe2d1pa9WO4ZYeZXF73wNtzgFgwPRV4zA6JYTGxVCWXSzIvvHpdvNbkRhsyR81l
         YeWAnzQ4FeR1ijJJS2qZkDkOSf2jH2bQ4H2zP6waZg9yiRqPTckpE/9L49cv0CkjVc2a
         Ol1t7StHZS2TVSBuEpLG5Ty/mmxek8+0C3LbEot7HvP0trYY8g6fRnoCZRgylnEqvpSU
         9w0g==
X-Gm-Message-State: AOAM5334Jo89BHEQgIp4/XsvZ7iToZVsRwmDSNNY5jjcnOiU0lGaSYh8
        8eXNkWwMLi1JFJQ0zx1vMwCqib2CNBxpLhxVS1fFeQMJ/26QGPDi6maxKegraJ8tXBDqi9FE/Dk
        rqwUCEueRgS/YYqQFDDQkhLgI+zuG/A==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr55682798wrt.41.1636378884702;
        Mon, 08 Nov 2021 05:41:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMuex/Y/frXoAydBCX3dHumL3lRJ0fsMeW/0bGFlFkFK4zirf3HNoTSPNDmAPSIQhtytuVbg==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr55682774wrt.41.1636378884559;
        Mon, 08 Nov 2021 05:41:24 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k27sm18005924wms.41.2021.11.08.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:24 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 41/59] perf tools: Add perf_evsel__delete callback to struct parse_events_ops
Date:   Mon,  8 Nov 2021 14:36:52 +0100
Message-Id: <20211108133710.1352822-42-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Adding perf_evsel__delete callback to struct parse_events_ops,
to allow custom event free for event parsing.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../lib/perf/include/internal/parse-events.h  |  1 +
 tools/perf/util/parse-events.c                |  8 ++++++
 tools/perf/util/parse-events.y                | 27 ++++++++++---------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 13a7baf2f781..1d7ee03b8a80 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -88,6 +88,7 @@ struct parse_events_error {
 struct parse_events_ops {
 	struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx, bool init_attr);
 	struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
+	void (*perf_evsel__delete)(struct perf_evsel *evsel);
 };
 
 struct parse_events_state {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5d4ad2179a48..0f2bf2b48888 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -74,9 +74,17 @@ static struct perf_evsel *perf_evsel__newtp_idx(const char *sys, const char *nam
 	return IS_ERR(evsel) ? (void*) evsel : &evsel->core;
 }
 
+static void perf_evsel__delete_helper(struct perf_evsel *evsel)
+{
+	struct evsel *tmp = container_of(evsel, struct evsel, core);
+
+	free(tmp);
+}
+
 static struct parse_events_ops parse_state_ops = {
 	.perf_evsel__new    = perf_evsel__new_idx,
 	.perf_evsel__new_tp = perf_evsel__newtp_idx,
+	.perf_evsel__delete = perf_evsel__delete_helper,
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d5cd2827b8a0..0ac863e06352 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -38,13 +38,14 @@ static struct list_head* alloc_list(void)
 	return list;
 }
 
-static void free_list_evsel(struct list_head* list_evsel)
+static void free_list_evsel(struct parse_events_state *parse_state,
+			    struct list_head* list_evsel)
 {
-	struct evsel *evsel, *tmp;
+	struct perf_evsel *evsel, *tmp;
 
-	list_for_each_entry_safe(evsel, tmp, list_evsel, core.node) {
-		list_del_init(&evsel->core.node);
-		evsel__delete(evsel);
+	list_for_each_entry_safe(evsel, tmp, list_evsel, node) {
+		list_del_init(&evsel->node);
+		parse_state->ops->perf_evsel__delete(evsel);
 	}
 	free(list_evsel);
 }
@@ -140,7 +141,7 @@ static int loc_val(void *loc_val_)
 %type <list_evsel> group_def
 %type <list_evsel> group
 %type <list_evsel> groups
-%destructor { free_list_evsel ($$); } <list_evsel>
+%destructor { free_list_evsel (_parse_state, $$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
 %destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
 %type <array> array
@@ -215,7 +216,7 @@ group_def ':' PE_MODIFIER_EVENT
 
 		parse_events__handle_error(error, @3.first_column,
 					   strdup("Bad modifier"), NULL);
-		free_list_evsel(list);
+		free_list_evsel(parse_state, list);
 		YYABORT;
 	}
 	$$ = list;
@@ -277,7 +278,7 @@ event_name PE_MODIFIER_EVENT
 
 		parse_events__handle_error(error, @2.first_column,
 					   strdup("Bad modifier"), NULL);
-		free_list_evsel(list);
+		free_list_evsel(parse_state, list);
 		YYABORT;
 	}
 	$$ = list;
@@ -293,7 +294,7 @@ PE_EVENT_NAME event_def
 	err = parse_events_name($2, $1);
 	free($1);
 	if (err) {
-		free_list_evsel($2);
+		free_list_evsel(_parse_state, $2);
 		YYABORT;
 	}
 	$$ = $2;
@@ -467,7 +468,7 @@ value_sym '/' event_config '/'
 	err = parse_events_add_numeric(_parse_state, list, type, config, $3);
 	parse_events_terms__delete($3);
 	if (err) {
-		free_list_evsel(list);
+		free_list_evsel(_parse_state, list);
 		YYABORT;
 	}
 	$$ = list;
@@ -511,7 +512,7 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_e
 	free($3);
 	free($5);
 	if (err) {
-		free_list_evsel(list);
+		free_list_evsel(parse_state, list);
 		YYABORT;
 	}
 	$$ = list;
@@ -531,7 +532,7 @@ PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
 	free($1);
 	free($3);
 	if (err) {
-		free_list_evsel(list);
+		free_list_evsel(parse_state, list);
 		YYABORT;
 	}
 	$$ = list;
@@ -550,7 +551,7 @@ PE_NAME_CACHE_TYPE opt_event_config
 	parse_events_terms__delete($2);
 	free($1);
 	if (err) {
-		free_list_evsel(list);
+		free_list_evsel(parse_state, list);
 		YYABORT;
 	}
 	$$ = list;
-- 
2.31.1

