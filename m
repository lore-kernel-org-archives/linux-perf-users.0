Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA81FC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B9361505
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhKHNoG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240015AbhKHNoF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvpi237D7XrYW4knnoizxq4/JkeMQjKywyqw5+RIJCU=;
        b=DRsef6gNz5G8hn4Gwp4rAvD36+qrXKHyo9jW7Ebmcq5deDfG4EKafwa7G7iMzqpq2Eb4Xd
        07H0/jaAZMWoRvpxuON+cl/l/y4m0pTmd7nNj6baLLzD/Mgggs49g6Wq9u/U66RJs8YuYR
        S3R3XkZezkFsbiNjwlrnWIiteXb03aw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-r_kB61S0MD6t42_Zx8nUfw-1; Mon, 08 Nov 2021 08:41:20 -0500
X-MC-Unique: r_kB61S0MD6t42_Zx8nUfw-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adff791000000b00183e734ba48so4053512wrp.8
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvpi237D7XrYW4knnoizxq4/JkeMQjKywyqw5+RIJCU=;
        b=V0SW/J2DibvBv5NQNRVdJuErQgia2/eSumLZc7TQ5btN53ONx/qd6RZ/v6bl78v3I/
         Xwg96fLon1199pEBaNlelvsnciceOk6Ogd/FsFw0Ek2wmZeEyLmNLkWGdsbuwdVq03F4
         rqV7ZrvIBDLI0YLxa82jsdHWiCg5Fy3qd9iuucBII8Lb5k0CwXHCsMSgwgj7vW9lMS8x
         niodY9BLmS9cLB9ekkH23x8E8Kph7fDMilsmGSvZtIEsm+PtT1Gka4DCzX3iTQD+bYG+
         I9ZqGmtsYtS7YSJdRN5H7PtAH7ccAcJRYTvFnQLSMd2lMG3wA/qJFGEjmXaWHbNPp8UC
         sKeQ==
X-Gm-Message-State: AOAM531R7KsgSJPZzPMqS0WztVwrPVTYfvz3nYlHtVZBmfeSxiyaqtvy
        8Jbp6rL9apcvoPv+c26RoruqB9dJX+dJM2oK6SlL7iMkybdUuuPZNTH5yPWEvHw+D/kI3ExXeuF
        zYna4525n1osmw7s4J+gwWLDJFrmzeg==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr52009001wmq.148.1636378878746;
        Mon, 08 Nov 2021 05:41:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/WP/z3CGYbBkR33YiPVi/jYTO4X4oe+SB74Zt8xapO+f+pJO0C1xU3jodT46qnevdJLJsNQ==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr52008990wmq.148.1636378878601;
        Mon, 08 Nov 2021 05:41:18 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d11sm16474212wrs.38.2021.11.08.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:18 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 40/59] libperf: Move in parse_events_evlist_error function
Date:   Mon,  8 Nov 2021 14:36:51 +0100
Message-Id: <20211108133710.1352822-41-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse_events_evlist_error function to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h | 2 ++
 tools/lib/perf/parse-events.c                  | 9 +++++++++
 tools/perf/util/parse-events.c                 | 9 ---------
 tools/perf/util/parse-events.h                 | 2 --
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 9706ce11e2fd..13a7baf2f781 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -134,4 +134,6 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add, bo
 int parse_events__modifier_group(struct list_head *list, char *event_mod, bool guest);
 void parse_events__handle_error(struct parse_events_error *err, int idx,
 				char *str, char *help);
+void parse_events_evlist_error(struct parse_events_state *parse_state,
+			       int idx, const char *str);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index d2d538f89ff9..07c89a3601b1 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -571,3 +571,12 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
 	}
 	err->num_errors++;
 }
+
+void parse_events_evlist_error(struct parse_events_state *parse_state,
+			       int idx, const char *str)
+{
+	if (!parse_state->error)
+		return;
+
+	parse_events__handle_error(parse_state->error, idx, strdup(str), NULL);
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 8cc29dd8743a..5d4ad2179a48 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2794,15 +2794,6 @@ void parse_events__clear_array(struct parse_events_array *a)
 	zfree(&a->ranges);
 }
 
-void parse_events_evlist_error(struct parse_events_state *parse_state,
-			       int idx, const char *str)
-{
-	if (!parse_state->error)
-		return;
-
-	parse_events__handle_error(parse_state->error, idx, strdup(str), NULL);
-}
-
 static void config_terms_list(char *buf, size_t buf_sz)
 {
 	int i;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c058488ef8e2..cc7c6449d423 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -116,8 +116,6 @@ enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name);
 void parse_events__set_leader(char *name, struct list_head *list,
 			      struct parse_events_state *parse_state);
-void parse_events_evlist_error(struct parse_events_state *parse_state,
-			       int idx, const char *str);
 
 void print_events(const char *event_glob, bool name_only, bool quiet,
 		  bool long_desc, bool details_flag, bool deprecated,
-- 
2.31.1

