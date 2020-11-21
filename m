Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F54C64E7D
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113A62408E
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Nov 2020 03:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKhG4kp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgKUDL3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 22:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgKUDL2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Nov 2020 22:11:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49CC0613CF
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z29so14322463ybi.23
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2020 19:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hD5ejNfyuyCoS/ZIO0QMnxuYssX6WcYQssRc/NoOro8=;
        b=pKhG4kp2fu3Kf0Vg8dDYwOua9NYqWjFTTnSDXzN43ene1McqdpT6vnAlBwck7y2FwV
         LSQIdP6u+EhejIjUqqqYDczUtYt7ldDDRd/s7fBvA1MBgSCME7iZYDNcPcklQoaBFI25
         lz/QSXCHblPZROHJ44XFn2fovhxywozKh6H5cJtWfU0gMopZKqFzq3v5CsIBdCNYzcGP
         Pn79GREFkUHV8D6s+FYX5q9g4RZK6Z2ZLNGl7rdAX+EhNG8wRDn/speh2/NuN7+Uy6d6
         YNiwBpVExAwOxY9Q5/ryLWfdqlFEFMJTcQAf4e4ZIknTHG+npbol9hxdzASALPjptEYm
         U3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hD5ejNfyuyCoS/ZIO0QMnxuYssX6WcYQssRc/NoOro8=;
        b=mu6XO7aFyu3W0aNgQc8XfUgmRJXzCIH/+2sYsbOMJ0jjWrfeGvS072pTqNLuEjREx5
         TlQ1sfVPDLqTcHrIGyCOrnPTwD5ryDqHQNmBPpSoWUEl3it+0t7l0Y7Xv1j2v6kNcwVC
         zp8V9Xyw6NFwrsJ060dfU09jZC7rOeO/oNywM7/9yq9KcFY02oGe63Uf+KV6ysekiog1
         PeU//aYiZHnAmS8/QSK/g4gt8tg/EzLYXOhHdma6usO0KwFvaes4BR9FISi5PbtxY1oo
         7+BBYMxbsw21JVnr8s103u5PMYlzpJZealEqfuAUQlY4Bcoboq0htA2uMdFH1jb/vGJp
         oIUg==
X-Gm-Message-State: AOAM531VS3p0fCt+trQxYKOshZArE1BblXJZI5VxcC2LJTcLWOP2lZb0
        F9G+0GPYydKcV8yqSFXrcNV2SjL+/xL5
X-Google-Smtp-Source: ABdhPJwv0J+E4kWkivpM7VPp7V7tFtvwnQAvk8kmQi5P4KCeAaTpgfvGQ8Df30uUz/tFc52skYtOrUGabjX3
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:7355:: with SMTP id
 o82mr27433034ybc.122.1605928287009; Fri, 20 Nov 2020 19:11:27 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:11:16 -0800
In-Reply-To: <20201121031119.3554769-1-irogers@google.com>
Message-Id: <20201121031119.3554769-3-irogers@google.com>
Mime-Version: 1.0
References: <20201121031119.3554769-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 2/5] perf metric: Use NAN for missing event IDs.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If during computing a metric an event (id) is missing the parsing
aborts. A later patch will make it so that events that aren't used in
the output are deliberately omitted, in which case we don't want the
abort. Modify the missing ID case to report NAN for these cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index b2ada8f8309a..41c9cd4efadd 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,7 @@
 /* Simple expression parser */
 %{
 #define YYDEBUG 1
+#include <math.h>
 #include <stdio.h>
 #include "util.h"
 #include "util/debug.h"
@@ -88,12 +89,10 @@ expr:	  NUMBER
 	| ID			{
 					struct expr_id_data *data;
 
-					if (expr__resolve_id(ctx, $1, &data)) {
-						free($1);
-						YYABORT;
-					}
+					$$ = NAN;
+					if (expr__resolve_id(ctx, $1, &data) == 0)
+						$$ = expr_id_data__value(data);
 
-					$$ = expr_id_data__value(data);
 					free($1);
 				}
 	| expr '|' expr		{ $$ = (long)$1 | (long)$3; }
-- 
2.29.2.454.gaff20da3a2-goog

