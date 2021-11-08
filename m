Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEFCC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AAD61506
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbhKHNmE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhKHNmD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8JrJwi/d98AGDVluF/BHBqJRaN4sCF1ILhKhxFFLV8=;
        b=ittFcFopyr3ml1kZy7/vWV39B3NNoMbhnTrjz8r36XVTPhlh+aiA7w2AUwpT93JfO7VVlf
        fbTzDwwAzuDhaeiQM3y148vH25p40MYQM+ymwpwFWvMJk4bWGIOe3WdE5NqGKqqujfh+Ml
        X0Xflx5oUD+yz7824/lxDSo+ZButFSI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-pVM5nVjcNQW1Nwzt7BCESQ-1; Mon, 08 Nov 2021 08:39:15 -0500
X-MC-Unique: pVM5nVjcNQW1Nwzt7BCESQ-1
Received: by mail-wr1-f70.google.com with SMTP id u4-20020a5d4684000000b0017c8c1de97dso4045089wrq.16
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8JrJwi/d98AGDVluF/BHBqJRaN4sCF1ILhKhxFFLV8=;
        b=hOBIGnBcN3eVyEr2Kun0DdUj0XWDn2YVhVM1GB3xmG5ouKyKSieycDBPZ7FqxMgTpa
         OgxoC56ml+HIOKdKlZFjESQzpJPSttT0Y8d79gm9MwvcD6OVgo/APb6YtHlP2iS70Jfq
         AYjU450LQNQ+qSjcq0KZJBaVwC5lbjSTfjOAnjvCPgA2K69j0Nuj1vlUFijAHntocifp
         3M1DuDJF/S4AunmvV+iPh9mWGIqlSOltHunTrEbuZwR7yUhXY0QlSgW6Z87ujE39ERtt
         AZcLa3hqe3pzwUxyDE1UrgGrBsLxJwJjrwFXnFidcZ+jaVUp2djcTGOnKjHsg0NXrih3
         apxg==
X-Gm-Message-State: AOAM532hBiLvc5ATk80DlWnYhGaqm1vHNbvoQF2c+7U5LWoMgNbRT+QZ
        uW9uyuE1x0F4fCSczU0s3uaQxL6NUJh+XeqcGgGBIgRgWqVgGCSsBHSrFIRqu+eNJAqeAp9kBtF
        oc5lMrk3uSlqc2zhZGQyWFaPiZi4JOA==
X-Received: by 2002:a05:600c:4fcc:: with SMTP id o12mr35467567wmq.110.1636378754833;
        Mon, 08 Nov 2021 05:39:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjmCfJI5M2ZB3b6lqzgTA8/Lp7Ox0kSfbEr+MX0Ivd+zRLF5wxZ3XFJWcfbdzwvk+It4IFWA==
X-Received: by 2002:a05:600c:4fcc:: with SMTP id o12mr35467546wmq.110.1636378754697;
        Mon, 08 Nov 2021 05:39:14 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 10sm20593006wrb.75.2021.11.08.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:14 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 19/59] perf tools: Fix parse_events_term__num call
Date:   Mon,  8 Nov 2021 14:36:30 +0100
Message-Id: <20211108133710.1352822-20-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

We are wrongly passing &config to parse_events_term__num
as loc_term_ argument.

Fixes: fb0811535e92 ("perf parse-events: Allow config on kernel PMU events")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 05a96b0f7b41..2bacbab86b09 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1697,8 +1697,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_events_term__num(&term,
 				   PARSE_EVENTS__TERM_TYPE_USER,
-				   config, 1, false, &config,
-					NULL) < 0) {
+				   config, 1, false, NULL, NULL) < 0) {
 		free(config);
 		goto out_err;
 	}
-- 
2.31.1

