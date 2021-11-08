Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2765C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F2061503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhKHNmg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhKHNmb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZ+DY7ML/3ZgmMqkEZhOxIpn3k0SxFW5JHmbGuYYxes=;
        b=DQ6APdnr6djCIfbAdSNxl61cE4u6DLByVVZid40QwcEASfvNDVHCHlfDSVyzcCnBsPzvD5
        5ti2CFGjyK4GvRQhiQwlxM1UH7Yzn1awdjVmkh5dPWLdkriz6aQ5zS2OAmhX2D7WmdXnbN
        LQV52lI6zn6F/tOTUFhTHkNbi5xS2VA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-GiuKsdAXNga7SiT8bZHaGw-1; Mon, 08 Nov 2021 08:39:45 -0500
X-MC-Unique: GiuKsdAXNga7SiT8bZHaGw-1
Received: by mail-wm1-f72.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so5314019wms.7
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZ+DY7ML/3ZgmMqkEZhOxIpn3k0SxFW5JHmbGuYYxes=;
        b=iSEsJ9YKrczDj8BQT2ZXNgrZCWaao7zN7S5kEXTPoYhViKwq/z4uyY8Fwg42oKJFfM
         BM9PUobKCUoYk80RsYKrhVlPqqOLzZ+0BtN06YgBshhmvvSVKCVrd8I2+XuyTDQSHK5k
         zyj7BUzhIgas7OX1je5AgUMMqZXaag7joBUl57B57w5toYU+3SxbqmnxJCi8NK0tqMGd
         XSX5bE87ZFn+fL5s6c/T9zMUiIv/odU/wfhn0fhMBBpMvDYUSToXdYtrkkOO3HqmCVq2
         GCwQevw1iO329FbuCQLACgp+J2QMN6qTdwqxUpK3f5aYVzdzXsk6heXNlVshBK/xNlve
         KtmA==
X-Gm-Message-State: AOAM530tiLHmKVRwxBpjaijvKFx3c6fqfAgAjoXMtRT5itcZIFaeU5sr
        TV4EBysOAKeer7UuG1qGxsCd0TdoXAwacwoJcOXEFVazvT7lXp2bBVUP/awLZkYepu4Ma14yRyv
        tabC4H7Rjj2xtqObJx2ebt3vQ0GFthw==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr25772508wrm.299.1636378784235;
        Mon, 08 Nov 2021 05:39:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1TPN5/K5gLykWuxh2ieJ3ry+ZRWc3oNTsD9wuezpkasRCY5J5pM6BvOuAQmOk6bW24AR6DQ==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr25772487wrm.299.1636378784084;
        Mon, 08 Nov 2021 05:39:44 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t11sm16678115wrz.97.2021.11.08.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:43 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 24/59] perf tools: Add loc_term and loc_val helpers to parse_events_term__str
Date:   Mon,  8 Nov 2021 14:36:35 +0100
Message-Id: <20211108133710.1352822-25-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move out bison specific code out of parse_events_term__str.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c |  9 +++------
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.y | 23 +++++++++++++++++++----
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 60f48d797853..cf46930750b5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -3210,17 +3210,14 @@ int parse_events_term__num(struct parse_events_term **term,
 
 int parse_events_term__str(struct parse_events_term **term,
 			   int type_term, char *config, char *str,
-			   void *loc_term_, void *loc_val_)
+			   int loc_term, int loc_val)
 {
-	YYLTYPE *loc_term = loc_term_;
-	YYLTYPE *loc_val = loc_val_;
-
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_STR,
 		.type_term = type_term,
 		.config    = config,
-		.err_term  = loc_term ? loc_term->first_column : 0,
-		.err_val   = loc_val  ? loc_val->first_column  : 0,
+		.err_term  = loc_term,
+		.err_val   = loc_val,
 	};
 
 	return new_term(term, &temp, str, 0);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 728074093c95..0590f613a38c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -158,7 +158,7 @@ int parse_events_term__num(struct parse_events_term **term,
 			   void *loc_term, void *loc_val);
 int parse_events_term__str(struct parse_events_term **term,
 			   int type_term, char *config, char *str,
-			   void *loc_term, void *loc_val);
+			   int loc_term, int loc_val);
 int parse_events_term__sym_hw(struct parse_events_term **term,
 			      char *config, unsigned idx);
 int parse_events_term__clone(struct parse_events_term **new,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7d7bffed0dd7..76b089c572af 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -57,6 +57,20 @@ static void inc_group_count(struct list_head *list,
 		parse_state->nr_groups++;
 }
 
+static int loc_term(void *loc_term_)
+{
+	YYLTYPE *loc_term = loc_term_;
+
+	return loc_term ? loc_term->first_column : 0;
+}
+
+static int loc_val(void *loc_val_)
+{
+	YYLTYPE *loc_val = loc_val_;
+
+	return loc_val ? loc_val->first_column  : 0;
+}
+
 %}
 
 %token PE_START_EVENTS PE_START_TERMS
@@ -782,7 +796,7 @@ PE_NAME '=' PE_NAME
 	struct parse_events_term *term;
 
 	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, &@1, &@3)) {
+					$1, $3, loc_term(&@1), loc_val(&@3))) {
 		free($1);
 		free($3);
 		YYABORT;
@@ -839,7 +853,8 @@ PE_TERM '=' PE_NAME
 {
 	struct parse_events_term *term;
 
-	if (parse_events_term__str(&term, (int)$1, NULL, $3, &@1, &@3)) {
+	if (parse_events_term__str(&term, (int)$1, NULL, $3,
+				   loc_term(&@1), loc_val(&@3))) {
 		free($3);
 		YYABORT;
 	}
@@ -867,7 +882,7 @@ PE_NAME array '=' PE_NAME
 	struct parse_events_term *term;
 
 	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, &@1, &@4)) {
+					$1, $4, loc_term(&@1), loc_val(&@4))) {
 		free($1);
 		free($4);
 		free($2.ranges);
@@ -898,7 +913,7 @@ PE_DRV_CFG_TERM
 
 	ABORT_ON(!config);
 	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-					config, $1, &@1, NULL)) {
+					config, $1, loc_term(&@1), 0)) {
 		free($1);
 		free(config);
 		YYABORT;
-- 
2.31.1

