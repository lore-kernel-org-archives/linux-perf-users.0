Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDBCA0FF9
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Sep 2023 23:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349876AbjIAXkE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 1 Sep 2023 19:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjIAXkD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Sep 2023 19:40:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF07DE42
        for <linux-perf-users@vger.kernel.org>; Fri,  1 Sep 2023 16:40:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d745094c496so2186795276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Sep 2023 16:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693611600; x=1694216400; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPYkQ8Xw70h9DqHSSmMkj0hho7Qvwic0o4hOL1SmVO8=;
        b=VTP5HWYJ6lT0EWTf4vSFsDAr8J3aCbLE042P84hYsONrrq6C/HlA2UPPJcHDL8eJap
         zjtrvn78rFeQyEl5wLu9izsy7Vp/Y5fBCGfOps5V+iCMpg/Bpo5rXqKuUHYCnhxeQ48k
         WnZIjR0ECBPQjWlaU3pr2y1nREkM8sBzNP1OvZUQg6OljlgqlrAlKmdehVsKh4ioJW4k
         mb1kRPoCr2476T+IUMq96D8/ItN4+QUfx7hCZthWVBkScfg8McR45VBDYobb/yFzCa6c
         MbuxAeoeMv6GZB+B4Obsf6IJy2z6mM2GqcnsyOFQ6B74lXHj21ueID8HDGMrWWqCkrQO
         DDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611600; x=1694216400;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPYkQ8Xw70h9DqHSSmMkj0hho7Qvwic0o4hOL1SmVO8=;
        b=bBmrtfvg7p3BXXqqhJYXS5b6lpyerA913ZPdyD48JJuYNPXk+nt7+t2kyTK25QiNDX
         ugWt7fggmaTewiU9YHJSI+54cynoEFsJoTvJH/i0d/vIQcH2scpgqPlNLoABMOIoYvtZ
         h8HSjefIglopKlJqiBqaO0bvAdmPbSP6JPAde08BdlyJJWW6b8z2SC+kR371je+PWobI
         69LSVJgJxydCkkB6gML3Rq2D2jOzCC5XAVEPofRgoTBwu1PgRdPoFd148S1c9+aXaGiG
         Q+bfjZPH9P1UGjeEMFNitHUyL5r+AQ1otxoTKxuLH8LhXC/iLvAMMY/FHB72bs9uK6vn
         XsDg==
X-Gm-Message-State: AOJu0YyFK9NijqidteLCBJlM5Wd1DbrS2FgRAQRN1duonC3CG4VI4lL2
        xkc1+yrwHFfIxL1vRd+1fFuzbYMYs4E3
X-Google-Smtp-Source: AGHT+IGxloGRu70SiEhB2mwb4HGbhgX1oJ+wp7rpTws/IEeT5tolfsEc540yl+Geu2DFv9zeeUq8m3CZtyhn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51bc:d985:dbbd:10b])
 (user=irogers job=sendgmr) by 2002:a25:a56a:0:b0:d77:f7c3:37db with SMTP id
 h97-20020a25a56a000000b00d77f7c337dbmr113992ybi.8.1693611600107; Fri, 01 Sep
 2023 16:40:00 -0700 (PDT)
Date:   Fri,  1 Sep 2023 16:39:45 -0700
In-Reply-To: <20230901233949.2930562-1-irogers@google.com>
Message-Id: <20230901233949.2930562-2-irogers@google.com>
Mime-Version: 1.0
References: <20230901233949.2930562-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 2/6] perf parse-events: Remove unnecessary __maybe_unused
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The parameter head_terms is always used in get_config_terms.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 65608a3cba81..e9e3623f3fed 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -34,8 +34,7 @@
 #ifdef PARSER_DEBUG
 extern int parse_events_debug;
 #endif
-static int get_config_terms(struct list_head *head_config,
-			    struct list_head *head_terms __maybe_unused);
+static int get_config_terms(struct list_head *head_config, struct list_head *head_terms);
 
 struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -1079,8 +1078,7 @@ static int config_attr(struct perf_event_attr *attr,
 	return 0;
 }
 
-static int get_config_terms(struct list_head *head_config,
-			    struct list_head *head_terms __maybe_unused)
+static int get_config_terms(struct list_head *head_config, struct list_head *head_terms)
 {
 #define ADD_CONFIG_TERM(__type, __weak)				\
 	struct evsel_config_term *__t;			\
-- 
2.42.0.283.g2d96d420d3-goog

