Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529CFC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DDE761503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhKHNmm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238667AbhKHNmh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dpxo/0qgAmz96sn3/jLospDBrtfn4ngTPbHqah3c5nM=;
        b=UQsKfIfOVApQLQk4p1wVtCCEIZjbrfh1VJ/SouhEQo5Pj3VgA+z3ie+ctP/x6RvDUkZSmz
        rcqUDT0Uc7apJ3z2LltcN6g6PQjSBThT/LZtRl/1zFN2LwZoqpIaYiQUgRC5VxnV8S2AkC
        3BF6jf1iQ0vefVs/d2i/EsvKajKXroM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-vAkUo3OQMsGKsiUUFz7hQA-1; Mon, 08 Nov 2021 08:39:51 -0500
X-MC-Unique: vAkUo3OQMsGKsiUUFz7hQA-1
Received: by mail-wm1-f70.google.com with SMTP id 128-20020a1c0486000000b0030dcd45476aso6252043wme.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dpxo/0qgAmz96sn3/jLospDBrtfn4ngTPbHqah3c5nM=;
        b=AmaYjlY/yL1SUhfeVoCwZ4jVxv9L2e5QjaV7rPiMlxgqZ4nwmmt5emvf7Jj0U4LVeb
         lwNiwmiyjCNzpYQeZNPayYhTJk5sZ42MY013K+gmCATv3DHwpIJmCkHmwJ8DypQ8UoOR
         AXgXLLCTMgb2ibLHLXHL0oFnZOhzqFfq2q9JvgDhFdUomJFTDjREn7D7hXzDGBSCKdwp
         3d5SP0bIV93hda734cI4814mxlSMlNfWeQecLcurJ9X9GGvKLRDAYoIYjU3vEFGZiUXb
         0vm1wD2Gdt2rD9MsXCxhjKX4D/Aw/myvyYzfeCbSNUwkiNFVBOvSbevM6dytPF/4Y/pk
         rI0A==
X-Gm-Message-State: AOAM531ZPa0i0wpsMK1y80cqGWDrCuPzcL+F0QjNgBEDJylYlguc8sOo
        0bRAiZMiPHwpJoKB+/zRl+d/npHTukSjAZB+CcUyKAAk8DHhEbyFN0DAin/SM/u8a47Gw55a2T3
        1AZZ4hcnVPQavoLnbsgLwxnmNwXSWHA==
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr41531975wmo.179.1636378790238;
        Mon, 08 Nov 2021 05:39:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzt5IWu0bqqGx32lQrRxQWKdV59zrpMwkJa9esTc/cWElxD41vasqrC9S7vrAFhyEUqN912lw==
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr41531957wmo.179.1636378790065;
        Mon, 08 Nov 2021 05:39:50 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f6sm16209986wmj.40.2021.11.08.05.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:49 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 25/59] perf tools: Add loc_term and loc_val helpers to parse_events_term__num
Date:   Mon,  8 Nov 2021 14:36:36 +0100
Message-Id: <20211108133710.1352822-26-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move out bison specific code out of parse_events_term__num.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 11 ++++-------
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.y | 13 +++++++------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cf46930750b5..c36657d906ce 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1714,7 +1714,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_events_term__num(&term,
 				   PARSE_EVENTS__TERM_TYPE_USER,
-				   config, 1, false, NULL, NULL) < 0) {
+				   config, 1, false, 0, 0) < 0) {
 		free(config);
 		goto out_err;
 	}
@@ -3191,18 +3191,15 @@ static int new_term(struct parse_events_term **_term,
 int parse_events_term__num(struct parse_events_term **term,
 			   int type_term, char *config, u64 num,
 			   bool no_value,
-			   void *loc_term_, void *loc_val_)
+			   int loc_term, int loc_val)
 {
-	YYLTYPE *loc_term = loc_term_;
-	YYLTYPE *loc_val = loc_val_;
-
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
 		.config    = config ? : strdup(config_term_names[type_term]),
 		.no_value  = no_value,
-		.err_term  = loc_term ? loc_term->first_column : 0,
-		.err_val   = loc_val  ? loc_val->first_column  : 0,
+		.err_term  = loc_term,
+		.err_val   = loc_val,
 	};
 
 	return new_term(term, &temp, NULL, num);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 0590f613a38c..29ea37808d32 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -155,7 +155,7 @@ int parse_events__is_hardcoded_term(struct parse_events_term *term);
 int parse_events_term__num(struct parse_events_term **term,
 			   int type_term, char *config, u64 num,
 			   bool novalue,
-			   void *loc_term, void *loc_val);
+			   int loc_term, int loc_val);
 int parse_events_term__str(struct parse_events_term **term,
 			   int type_term, char *config, char *str,
 			   int loc_term, int loc_val);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 76b089c572af..e62a7a3bf6b2 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -787,7 +787,7 @@ PE_RAW
 	struct parse_events_term *term;
 
 	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_CONFIG,
-					NULL, $1, false, &@1, NULL));
+					NULL, $1, false, loc_term(&@1), 0));
 	$$ = term;
 }
 |
@@ -809,7 +809,7 @@ PE_NAME '=' PE_VALUE
 	struct parse_events_term *term;
 
 	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, false, &@1, &@3)) {
+					$1, $3, false, loc_term(&@1), loc_val(&@3))) {
 		free($1);
 		YYABORT;
 	}
@@ -833,7 +833,7 @@ PE_NAME
 	struct parse_events_term *term;
 
 	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, 1, true, &@1, NULL)) {
+					$1, 1, true, loc_term(&@1), 0)) {
 		free($1);
 		YYABORT;
 	}
@@ -865,7 +865,8 @@ PE_TERM '=' PE_VALUE
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false, &@1, &@3));
+	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false,
+					loc_term(&@1), loc_val(&@3)));
 	$$ = term;
 }
 |
@@ -873,7 +874,7 @@ PE_TERM
 {
 	struct parse_events_term *term;
 
-	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, 1, true, &@1, NULL));
+	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, 1, true, loc_term(&@1), 0));
 	$$ = term;
 }
 |
@@ -897,7 +898,7 @@ PE_NAME array '=' PE_VALUE
 	struct parse_events_term *term;
 
 	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, false, &@1, &@4)) {
+					$1, $4, false, loc_term(&@1), loc_val(&@4))) {
 		free($1);
 		free($2.ranges);
 		YYABORT;
-- 
2.31.1

