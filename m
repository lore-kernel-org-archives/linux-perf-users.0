Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E497C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 03:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723E660F41
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 03:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhKLDye (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 22:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhKLDyd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 22:54:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C482C061766
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 19:51:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so12726247ybj.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Nov 2021 19:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HqqMV268AXgL1rVcGsniXEAH/wkIQoU3POJ40rKEUPc=;
        b=NEIWIeXqBf8lPIVFFpIPKTVDLKOdFW7L2BnoSw6Ryn19k3x1i+CfrxGWUatEfVT4k4
         At15y6LSB5Om3/HS/ecUgZ8+pXDuhUvkc0eJCIvJ4OT0b9XOINsQ6jNAd2eGmfiO/OqE
         wNQJkBTZrZIW7n7Hx97Y29BeJqTgdDrr53DO5SmxS62kqP2nghkbWJkRVapmXhWJD0zJ
         5cizopKqu0/pMkhZKNnRNf1nqWiICGcDSht8EYAcQKVfOeg5muBVnzAq8r2ZFU77jzuN
         N9vyxbxLSLkxPNiJ+pBwRAg/y4HO4ZhNCbMV2+oKNAhmH5kTlbY5uiej9BhBp9mEGBJa
         TJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HqqMV268AXgL1rVcGsniXEAH/wkIQoU3POJ40rKEUPc=;
        b=kkqwVldDha88wi++owDmHGGmXQPFqOOUqdDGwcPMmxALRzRppz7poKXisNQUvqXraG
         u2aNGUIvrjRdE1WHRHHp6I1gI0T1t+oZ+Q/5mknrG8AUdGdrafkAyzomYVo0zbrTYCss
         tIxj5praCnt+UFljTWK4J9GOUGUYzXF26qLjbtkryZLNc9VlZCjzEskbnYOazRsdxqnP
         eWSh5SP+q4gPJYBNwVDOfSaAJIsd+p7XMUx9S+ubhwpRcyA1d1XFGj2MaxW1sLQ3yt3P
         pnU/Z2DZ5cZu1Rjt/UYlc9gcXPusT/3P79q2EFiA+ywJN8T24UlLNJTJ/ZXekmznJKOH
         Sbcg==
X-Gm-Message-State: AOAM530I7iofn7RJ3Ws4WXWoZXiKoDDAPBykU8taLwu/C1sckiSEn1bu
        2n77CT9VWodtQEfFcNfV2KDAtjcQ92rB
X-Google-Smtp-Source: ABdhPJwoMeiSlF2KwM8I7iD9tp9PXpkFePSIlADswSv/USkurc160W1Dul+x7g1pjUAHGTmeg1GX/yA/+DwO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5ce9:74ca:7ed9:75f2])
 (user=irogers job=sendgmr) by 2002:a25:944:: with SMTP id u4mr13771731ybm.31.1636689102376;
 Thu, 11 Nov 2021 19:51:42 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:51:23 -0800
In-Reply-To: <20211112035124.94327-1-irogers@google.com>
Message-Id: <20211112035124.94327-2-irogers@google.com>
Mime-Version: 1.0
References: <20211112035124.94327-1-irogers@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH 2/3] perf symbols: Bit pack to save a byte
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use a bit field alongside the earlier bit fields.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 2 +-
 tools/perf/util/symbol.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8511af55fc3a..5d982933b3a2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3132,7 +3132,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	notes->nr_events = nr_pcnt;
 
 	annotation__update_column_widths(notes);
-	sym->annotate2 = true;
+	sym->annotate2 = 1;
 
 	return 0;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3586fa549f44..fbf866d82dcc 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -62,10 +62,10 @@ struct symbol {
 	u8		ignore:1;
 	/** Symbol for an inlined function. */
 	u8		inlined:1;
+	/** Has symbol__annotate2 been performed. */
+	u8		annotate2:1;
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
-	/** Has symbol__annotate2 been performed. */
-	bool		annotate2;
 	/** The name of length namelen associated with the symbol. */
 	char		name[];
 };
-- 
2.34.0.rc1.387.gb447b232ab-goog

