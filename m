Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DEAC4743C
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6C460FE6
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 23:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFUXFO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhFUXFN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 19:05:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFFBC061574;
        Mon, 21 Jun 2021 16:02:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d11so19035632wrm.0;
        Mon, 21 Jun 2021 16:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCG6H7GuL0YCs68rOtAhGiPNk+jNUbnfrlm8YFS4cH0=;
        b=B2895UjxZZOVMW3o6YZas7ftFhr5xzWNp34dcyqq3kFi6XVfz61XS/hs2m45T1Nnos
         NlCAqZfyn5u0ARpo7iVa6O6JsdkI1ZFDqsvNITqT+z9G8cBq8OTCfI5mi1wXMIM+hU/u
         H4UMNzUJv12ZUKw/b4b1XXEQHaI2zUDt4cxwub/oNts22FEbAH/XxwniwMmZAg0nl13v
         VVScN17r5Axdl8w8afP0DV6bG0URQlUOQMtScN4E61aAkhfPWuQoHZ4IrFYGCzhmf1+s
         ZaR9UWBH5tsr7To85gJMzno3CZiR6sNf/78DgKSg5vzYHdbQns8mDXyJyMZvu4sCtWfR
         IDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gCG6H7GuL0YCs68rOtAhGiPNk+jNUbnfrlm8YFS4cH0=;
        b=NMzpSV5S4DqKbOy6JRsoGrnjEZRdK9qKEwaB2UAPdIorfZrpdnHGGx/H039cJcBnbw
         BGWfuN4lIhglHtusf/8OMGpMy4IYqclS5ghcX68YoqIMhl64CHBZOx73r0dAmB8u8nBl
         lX5Swk/vI+YApiGOqWT+b1Z4IAOvXHlm5xREIdEjatbk/HrJpDznsWej6vPsRI0ItZP3
         iBoCEBzd+dzNcT1LXjvW7MwzyXzfRqCHIJWZ1DZEJ6ljEsUu2xI2L+Kh74n0TJc0azAI
         grlt4c6mLysFE5KOgdQh2UIaTFMT/FXdrjiuxwzwtnWxmjkHsbnL12uI+cKObq/aUeAd
         Xl8Q==
X-Gm-Message-State: AOAM532V8V7C9AER4cwEPCQsa+2+RUfUMEu3H8PGieaI6mERReoootM6
        7uljA/siPDiFYP6ZM9ug6VM=
X-Google-Smtp-Source: ABdhPJwmcYtNHdapPFg+UvGZ7Q8yBaYQidWv2LToZq0EwmH4Kpl/+Wt+Ds/u4E2q7MBpCkRQ3eX+2g==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr903268wri.293.1624316576571;
        Mon, 21 Jun 2021 16:02:56 -0700 (PDT)
Received: from honeypot.. ([151.29.45.200])
        by smtp.googlemail.com with ESMTPSA id r4sm20179517wre.84.2021.06.21.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:02:56 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Martin Liska <mliska@suse.cz>,
        Jason Yan <yanaijie@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf annotate: allow 's' on source code lines
Date:   Tue, 22 Jun 2021 01:00:47 +0200
Message-Id: <20210621230047.211430-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In perf annotate, when 's' is pressed on a line containing
source code, it shows the message "Only available for assembly
lines".
This patch gets rid of the error, moving the cursr to the next
available asm line (or the closest previous one if no asm line
is found moving forwards), before hiding source code lines.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/ui/browsers/annotate.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ad0a70f0edaf..eb94d20d0d13 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -343,6 +343,29 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 	browser->curr_hot = rb_last(&browser->entries);
 }
 
+static struct annotation_line *annotate_browser__find_next_asm_line(
+					struct annotate_browser *browser,
+					struct annotation_line *al)
+{
+	struct annotation_line *it = al;
+
+	/* find next asm line */
+	list_for_each_entry_continue(it, browser->b.top, node) {
+		if (it->idx_asm >= 0)
+			return it;
+	}
+
+	/* no asm line found forwards, try backwards */
+	it = al;
+	list_for_each_entry_continue_reverse(it, browser->b.top, node) {
+		if (it->idx_asm >= 0)
+			return it;
+	}
+
+	/* There are no asm lines */
+	return al;
+}
+
 static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
 	struct annotation *notes = browser__annotation(&browser->b);
@@ -363,9 +386,8 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 		browser->b.index = al->idx;
 	} else {
 		if (al->idx_asm < 0) {
-			ui_helpline__puts("Only available for assembly lines.");
-			browser->b.seek(&browser->b, -offset, SEEK_CUR);
-			return false;
+			/* move cursor to next asm line */
+			al = annotate_browser__find_next_asm_line(browser, al);
 		}
 
 		if (al->idx_asm < offset)
-- 
2.31.1

