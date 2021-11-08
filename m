Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7BC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB11A61177
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbhKHNp3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNp2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wkQA7Iy/lK7cN6hq1eLqMVhEk7vlykCR1xtvLFcno+A=;
        b=JKQCHcIKcggc1nseV2TJpU5djAv7KQOnMsZI8Qq9xklPVxpcnOX2Kxhr+IZO2EmdykFOiW
        hXsSWZ6mbc67wpbFtR9VMYLOrWOiKOFF18tgCkdU/0UKhRzsVjoFIeEALMRqkQrPF8FO+G
        bvxboLxAlLjyEl2xw7mNBwO8cYM+qU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-Zed1AmoxNrejOexDvoT3iQ-1; Mon, 08 Nov 2021 08:42:42 -0500
X-MC-Unique: Zed1AmoxNrejOexDvoT3iQ-1
Received: by mail-wm1-f70.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso5796791wms.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkQA7Iy/lK7cN6hq1eLqMVhEk7vlykCR1xtvLFcno+A=;
        b=gizHA+NGiOvlfHCGP2qFJQXF3KEiOCf2I8pmE35slL2mIcR24XJ1ZcEpjsnUjUNW38
         GtWj+I+ffXoPedQUnT6x8hcpzdDFyHf7g94jzDgZZ1TvnUAy+IWVJWkPv817R7Y/OSUx
         YSfW45+BgcDoiz2aEFNVvaKu9nAek0nODOWkwX9zVogR+ra3WP7tiUw+mGuCOaTNQohI
         f84s4w61sN3m+BT6dlPM0BleJXpbktv3Ghd8hpt3N6Ipqb+OwsEL+/hjWi3/Fl2zRXIT
         QJ5WlGYUPb7FyBODDgmcGAo3hIaD7w5d9nPe4fn+/7ZHTwCGbLXDEuHrTX5g15vJKeNn
         ymxQ==
X-Gm-Message-State: AOAM530KHr9FgmRKvGB9f2yi0+UYsTFmkJ5pjgVBv0G1A1Ezg8gNqqDG
        6qpymsegxY5R4K4lHg94UcVl6Xhd21vYYXFnBh/bA3CJ0QwM//yYCt8xVjKt/iufsszL6cRAHdm
        BWGa7yQH2TkJsW8xdqWPhq/MfoObj+A==
X-Received: by 2002:a1c:7f0a:: with SMTP id a10mr54435857wmd.60.1636378961655;
        Mon, 08 Nov 2021 05:42:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDCS+yM57NbFmOjqQemxMtg52L2Gyw7LDLJ0HvVEjtQ6RK5BtLPJpLaaYVAz2AxZgM2Sjzmg==
X-Received: by 2002:a1c:7f0a:: with SMTP id a10mr54435835wmd.60.1636378961510;
        Mon, 08 Nov 2021 05:42:41 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l2sm16307625wmq.42.2021.11.08.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:41 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 54/59] perf tools: Move PE_* enums in parse_events__scanner
Date:   Mon,  8 Nov 2021 14:37:05 +0100
Message-Id: <20211108133710.1352822-55-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving PE_* enums in parse_events__scanner. The function will
be moved to libperf in next commit.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index aa79ce2f2d44..7b171252083c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1914,12 +1914,18 @@ perf_pmu__parse_check(const char *name)
 }
 
 static int parse_events__scanner(const char *str,
-				 struct parse_events_state *parse_state)
+				 struct parse_events_state *parse_state,
+				 bool terms)
 {
 	YY_BUFFER_STATE buffer;
 	void *scanner;
 	int ret;
 
+	if (terms)
+		parse_state->stoken = PE_START_TERMS;
+	else
+		parse_state->stoken = PE_START_EVENTS;
+
 	ret = parse_events_lex_init_extra(parse_state, &scanner);
 	if (ret)
 		return ret;
@@ -1946,12 +1952,11 @@ int parse_events_terms(struct list_head *terms, const char *str)
 	struct parse_events_state parse_state = {
 		.ops     = &parse_state_ops,
 		.terms   = NULL,
-		.stoken  = PE_START_TERMS,
 		.guest   = perf_guest,
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, &parse_state);
+	ret = parse_events__scanner(str, &parse_state, true);
 	perf_pmu__parse_cleanup();
 
 	if (!ret) {
@@ -1970,7 +1975,6 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 {
 	struct parse_events_state ps = {
 		.list            = LIST_HEAD_INIT(ps.list),
-		.stoken          = PE_START_EVENTS,
 		.hybrid_pmu_name = pmu_name,
 		.idx             = parse_state->idx,
 		.ops             = &parse_state_ops,
@@ -1978,7 +1982,7 @@ static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, &ps);
+	ret = parse_events__scanner(str, &ps, false);
 	perf_pmu__parse_cleanup();
 
 	if (!ret) {
@@ -2001,14 +2005,13 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.idx	  = evlist->core.nr_entries,
 		.error	  = err,
 		.evlist	  = &evlist->core,
-		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
 		.ops	  = &parse_state_ops,
 		.guest    = perf_guest,
 	};
 	int ret;
 
-	ret = parse_events__scanner(str, &parse_state);
+	ret = parse_events__scanner(str, &parse_state, false);
 	perf_pmu__parse_cleanup();
 
 	if (!ret && list_empty(&parse_state.list)) {
-- 
2.31.1

