Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF61C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000006162E
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbhKHNns (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237467AbhKHNns (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAnD5R7KyMwk+WoAcI1rO4/nUh+tX34vEz0LN7mEcy0=;
        b=CgMLelUFhIi7nEfZXv6hBZYxbULc33IbTKfJe5I8IhI4qu7Pb0Rer4w7EX+8WlfjY/8KqC
        Elg+iVCQUk7CBUwGLNGWYYBCjclgZ/YOnaWpRqeO/FncNcrj1NOJ2kTbM0LMHlRgOPs3NN
        s8qdp3pcAUM5KFuKyv4sPjaC5N7oZTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-Cch0vqi0Mya49Dqouwavgg-1; Mon, 08 Nov 2021 08:41:02 -0500
X-MC-Unique: Cch0vqi0Mya49Dqouwavgg-1
Received: by mail-wm1-f72.google.com with SMTP id 128-20020a1c0486000000b0030dcd45476aso6253900wme.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAnD5R7KyMwk+WoAcI1rO4/nUh+tX34vEz0LN7mEcy0=;
        b=W9UB4aEI/BNSaXWDINUbIR/gtVUygHFi1WUPZQCYNh2kOdrDqBaTz97wfmsMwJw3tB
         RiLJPLJlx4p2XqCwEqXZLy1vYloddZmo34gxRqglJyX+5oZCYPMS2m7Bxp5zyKDtMPeX
         nqVUqP6yH5CNWfc05VF27HGfh1uAELK0crfRayvbskZ0ZIzp4844gcLJOwLl3nDWoTew
         4/ZBkvs4U7uAyGxMecWtjk8SGSuo95isP+jwKYEhFAvz/lRQ+rFidFAa1I3XcaLuW8eR
         u9I0spMmn/HYyWWIbAWih4TTSEpBR+j0MBiQ437xXh1za8raDyjmyDPrYwweiEpr/7sK
         0Ftg==
X-Gm-Message-State: AOAM533etwqD78jcyKdmGlCKTResY+WbpaOvNQYEHNPSxAdl3+jjd1O+
        BRL+4+IFjh1P/x+HFff2RHdNyYvL/Iykj+queBV1CKZKnJdDXwy+rqTWpjKHDkpup8QIMEGZK4D
        IFoVhkS7K7pfr8zln2Sf0Bv4o7KENrQ==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr77738447wrw.170.1636378861022;
        Mon, 08 Nov 2021 05:41:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5CB0VVjhf4nk4E53tXx4/hhJ41mp0X2I87WjS3/rP+KsLFp1RrdF/8/cMoXudiRqHT5fmLw==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr77738417wrw.170.1636378860818;
        Mon, 08 Nov 2021 05:41:00 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f15sm16412870wrt.26.2021.11.08.05.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:00 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 37/59] perf tool: Pass perf_guest in struct parse_events_state
Date:   Mon,  8 Nov 2021 14:36:48 +0100
Message-Id: <20211108133710.1352822-38-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Passing perf_guest in struct parse_events_state so the
parsing code does not depend on perf_guest variable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h |  1 +
 tools/perf/util/parse-events.c                 | 18 +++++++++++-------
 tools/perf/util/parse-events.h                 |  4 ++--
 tools/perf/util/parse-events.y                 |  8 ++++----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 7bf58f6fc53f..e4b136a58484 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -101,6 +101,7 @@ struct parse_events_state {
 	struct perf_pmu		  *fake_pmu;
 	char			  *hybrid_pmu_name;
 	struct parse_events_ops	  *ops;
+	bool			   guest;
 };
 
 int parse_events_term__num(struct parse_events_term **term,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 41615c6e9871..e10f6476854f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1618,9 +1618,9 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 }
 
 int parse_events__modifier_group(struct list_head *list,
-				 char *event_mod)
+				 char *event_mod, bool guest)
 {
-	return parse_events__modifier_event(list, event_mod, true);
+	return parse_events__modifier_event(list, event_mod, true, guest);
 }
 
 /*
@@ -1770,7 +1770,7 @@ struct event_modifier {
 };
 
 static int get_event_modifier(struct event_modifier *mod, char *str,
-			       struct perf_evsel *evsel)
+			       struct perf_evsel *evsel, bool guest)
 {
 	int eu = evsel ? evsel->attr.exclude_user : 0;
 	int ek = evsel ? evsel->attr.exclude_kernel : 0;
@@ -1795,7 +1795,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
 		if (*str == 'u') {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
-			if (!exclude_GH && !perf_guest)
+			if (!exclude_GH && !guest)
 				eG = 1;
 			eu = 0;
 		} else if (*str == 'k') {
@@ -1891,7 +1891,8 @@ static int check_modifier(char *str)
 	return 0;
 }
 
-int parse_events__modifier_event(struct list_head *list, char *str, bool add)
+int parse_events__modifier_event(struct list_head *list, char *str,
+				 bool add, bool guest)
 {
 	struct perf_evsel *evsel;
 	struct event_modifier mod;
@@ -1902,11 +1903,11 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
 	if (check_modifier(str))
 		return -EINVAL;
 
-	if (!add && get_event_modifier(&mod, str, NULL))
+	if (!add && get_event_modifier(&mod, str, NULL, guest))
 		return -EINVAL;
 
 	__perf_evlist__for_each_entry(list, evsel) {
-		if (add && get_event_modifier(&mod, str, evsel))
+		if (add && get_event_modifier(&mod, str, evsel, guest))
 			return -EINVAL;
 
 		evsel->attr.exclude_user   = mod.eu;
@@ -2115,6 +2116,7 @@ int parse_events_terms(struct list_head *terms, const char *str)
 		.ops     = &parse_state_ops,
 		.terms   = NULL,
 		.stoken  = PE_START_TERMS,
+		.guest   = perf_guest,
 	};
 	int ret;
 
@@ -2141,6 +2143,7 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 		.hybrid_pmu_name = pmu_name,
 		.idx             = parse_state->idx,
 		.ops             = &parse_state_ops,
+		.guest           = perf_guest,
 	};
 	int ret;
 
@@ -2170,6 +2173,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
 		.ops	  = &parse_state_ops,
+		.guest    = perf_guest,
 	};
 	int ret;
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e4ac9b546bc3..599ee3a760d7 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -65,8 +65,8 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
 				char *str, char *help);
 void parse_events__shrink_config_terms(void);
 void parse_events__clear_array(struct parse_events_array *a);
-int parse_events__modifier_event(struct list_head *list, char *str, bool add);
-int parse_events__modifier_group(struct list_head *list, char *event_mod);
+int parse_events__modifier_event(struct list_head *list, char *str, bool add, bool guest);
+int parse_events__modifier_group(struct list_head *list, char *event_mod, bool guest);
 int parse_events_name(struct list_head *list, const char *name);
 int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 				struct list_head *list,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 098e27ac718c..d5cd2827b8a0 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -204,13 +204,13 @@ event
 group:
 group_def ':' PE_MODIFIER_EVENT
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list = $1;
 	int err;
 
-	err = parse_events__modifier_group(list, $3);
+	err = parse_events__modifier_group(list, $3, parse_state->guest);
 	free($3);
 	if (err) {
-		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
 
 		parse_events__handle_error(error, @3.first_column,
@@ -261,6 +261,7 @@ event: event_mod
 event_mod:
 event_name PE_MODIFIER_EVENT
 {
+	struct parse_events_state *parse_state = _parse_state;
 	struct list_head *list = $1;
 	int err;
 
@@ -269,10 +270,9 @@ event_name PE_MODIFIER_EVENT
 	 * (there could be more events added for multiple tracepoint
 	 * definitions via '*?'.
 	 */
-	err = parse_events__modifier_event(list, $2, false);
+	err = parse_events__modifier_event(list, $2, false, parse_state->guest);
 	free($2);
 	if (err) {
-		struct parse_events_state *parse_state = _parse_state;
 		struct parse_events_error *error = parse_state->error;
 
 		parse_events__handle_error(error, @2.first_column,
-- 
2.31.1

