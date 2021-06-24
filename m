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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D0C49EA5
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 22:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0F6137D
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 22:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhFXWjj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFXWji (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Jun 2021 18:39:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5FC061574;
        Thu, 24 Jun 2021 15:37:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o22so4072340wms.0;
        Thu, 24 Jun 2021 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2SRYuayMY0kZYP1oHuZ7/ySlD9VBDzAesA2LlWtDsw=;
        b=CnL7z1YVqs1rxBZzxUZrZQyBRdLpb/mkgCMVeVYlsnEK/12r65doQf8tD2HRvBlEvu
         7FelT75dcsVE4MRmZs2TSx1/PaVCQ/xBF38bQX2Q/zpMfOZeJU7qbmycRiwJ8CH57w3I
         fAeKJfj+x7nCd0Lj5u0Yq4cftKMO5q0OxGuEfn6dRinEIpfvWAJF9MZa5zny2gWCtwyT
         0KMGKCC/KXS/d7xjKwZDTe4n+Ml8ocqMji2zZtICzmlqWRcXe2b5YxPurd5jDVQIlglD
         EWCIixZivh47LplyJ9BxZv2Yf52irdW0CzqwKSnFbzFK+4gHQpTfBmZqtameWu33CxOr
         pFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2SRYuayMY0kZYP1oHuZ7/ySlD9VBDzAesA2LlWtDsw=;
        b=t4OFrwhuzbxtyeIGqM5dSrN4eyQxcvoKH1qR5oJjhKxa2nd8SjpjtafoeJ8zCaSfj7
         N7cAoTju26QMxXLAH3tRjEoVG6JLFtbALlXJT3rHSbqnHelC560pK7TepKA0WQfBNTpP
         /vFBKi3xILT1ClNEr6Oe0WsYkIXX7vNMTKsIaL8Cewpr8Xjbjg3oDvX91ipbF1Q4X4m5
         9utFXaqSI0OU1CgGaOmxRBk4MJ0GeS6aZeCYf8pMyxG/ZBZUYVxBpNLuuGa5NNPCmg1A
         LlH7YUNd27COhyFHMb48i7gckqnR/8l72uEKIGzUncPQ7kCogwp7GqvfZy/JB1eU5F0b
         xi2g==
X-Gm-Message-State: AOAM533yER96i2ZfHsHyEzyKJqf6xQk/MrYaigMiox8bBzcDaERyJBVl
        zqHfFNztloC1jycsABHq8VA=
X-Google-Smtp-Source: ABdhPJy1Z1zTaiPqFj/xo9ufOkLvUSPKIIFRoqFTH/JhPx3Jn0ymMdxSh/UxAtQGbLf8q+pZZ6f4Rw==
X-Received: by 2002:a05:600c:22cf:: with SMTP id 15mr6925140wmg.177.1624574237262;
        Thu, 24 Jun 2021 15:37:17 -0700 (PDT)
Received: from honeypot.epfl.ch ([151.29.44.148])
        by smtp.googlemail.com with ESMTPSA id e38sm9447999wmp.4.2021.06.24.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:37:16 -0700 (PDT)
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf annotate: allow 's' on source code lines
Date:   Fri, 25 Jun 2021 00:34:22 +0200
Message-Id: <20210624223423.189550-1-rickyman7@gmail.com>
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

Changes in v2:
 - handle case of no asm line found in
   annotate_browser__find_next_asm_line by returning NULL and
   handling error in caller.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/ui/browsers/annotate.c | 32 ++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ad0a70f0edaf..f5509a958e38 100644
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
+	return NULL;
+}
+
 static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
 	struct annotation *notes = browser__annotation(&browser->b);
@@ -363,9 +386,12 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 		browser->b.index = al->idx;
 	} else {
 		if (al->idx_asm < 0) {
-			ui_helpline__puts("Only available for assembly lines.");
-			browser->b.seek(&browser->b, -offset, SEEK_CUR);
-			return false;
+			/* move cursor to next asm line */
+			al = annotate_browser__find_next_asm_line(browser, al);
+			if (!al) {
+				browser->b.seek(&browser->b, -offset, SEEK_CUR);
+				return false;
+			}
 		}
 
 		if (al->idx_asm < offset)
-- 
2.31.1

