Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBEDC07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD83E61960
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 16:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGEQcF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 12:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGEQcE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 12:32:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55872C061574;
        Mon,  5 Jul 2021 09:29:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t6so12822332wrm.9;
        Mon, 05 Jul 2021 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eplp7/n3jsj+3IbVU25mDy3/i+Dcp/355oC41kui6M=;
        b=Hhb5EHqqhMhhbKeFBinPr6lxVH6eRLwTeLYSCs08+aQbyS4RtVA/JJnUoZsMA6Ap9L
         cmc+env0b+QkutlUDk7Nylmbou+0V55ycYL+vq3B6gAdVBv8IIzBgy6SF9XhJcCYGctT
         zfHzOG37yqjJeTmf1+Bg2fUUj43Zi/NrtWuhNkZaOJeLPmU8fEALKXAdWaDu/e1UAo4x
         vg/NFDVb7cbJtwyqPepF0ojcjXIFDlKQ/ax26noherWB9dN2JdKqDF94bsjq4pboPs6I
         LAl18AeU1K9oYfA4eICpFzWLBHComkWopSo5Z9P4Wi/fguADbe60IHLfRj3KmapexAvr
         xVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eplp7/n3jsj+3IbVU25mDy3/i+Dcp/355oC41kui6M=;
        b=oOS9f1CgmNnadUBwrH6jCjocjQTpEZl9qypRJ+20eM5eegIdHZ/auve/qAqwpjG86n
         fc0n5d1viwImIAbcksGItrM0eTo2k9AETEbHANMU09Tmtoj+5ZDESmZM7EvqSngIeFpa
         tU2nKwm0JK/9ZU6VcoTsKl2WITT8pTkCMHzFZCVUIK7Du9m5hCsabMi6W9f4hJPuoA9T
         DQ1yGemmTprK8Ujo0uZSIbZYXXJg0WcIxbIfM/vjJM60ZTYthlRbb7c4FWYVa1mFmVF4
         NeqHFJrM+51YkMCzpdQjrvE/g2PmpKCyTVbzjordVhGC9ZrKtHbOwsOSj6AHlpewVAx4
         VD4A==
X-Gm-Message-State: AOAM532vLNT7iOxgYSQHO+x/k3cpxqgR4NlkeTj/7vzgJ1OAlaZEsBfM
        IF6hfenjTrCJs3adiAKubu0=
X-Google-Smtp-Source: ABdhPJwxBFvJnke95VCaYNovpVg8KTJH3nVecE8kyrE9fVtEHCdN8Z0jxUkFd8H8Mt6gUqKInL9kGg==
X-Received: by 2002:adf:d1cc:: with SMTP id b12mr9533901wrd.410.1625502565801;
        Mon, 05 Jul 2021 09:29:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id j10sm2411457wrt.35.2021.07.05.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 09:29:25 -0700 (PDT)
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
Subject: [PATCH] perf annotate: fix 's' on source line when disasm is empty
Date:   Mon,  5 Jul 2021 18:15:25 +0200
Message-Id: <20210705161524.72953-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the disasm is empty, 's' should fail. Instead it seemingly works,
hiding the empty lines and causing an assertion error on the next
time annotate is called (from within perf report).
The problem is caused by a buffer overflow, caused by a wrong
exit condition in annotate_browser__find_next_asm_line, which checks
browser->b.top instead of browser->b.entries.

This patch fixes the issue, making annotate_browser__toggle_source
fail if the disasm is empty (nothing happens to the user).

Fixes: 6de249d66d2e
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/ui/browsers/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index f5509a958e38..5812a2214cc1 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -350,14 +350,14 @@ static struct annotation_line *annotate_browser__find_next_asm_line(
 	struct annotation_line *it = al;
 
 	/* find next asm line */
-	list_for_each_entry_continue(it, browser->b.top, node) {
+	list_for_each_entry_continue(it, browser->b.entries, node) {
 		if (it->idx_asm >= 0)
 			return it;
 	}
 
 	/* no asm line found forwards, try backwards */
 	it = al;
-	list_for_each_entry_continue_reverse(it, browser->b.top, node) {
+	list_for_each_entry_continue_reverse(it, browser->b.entries, node) {
 		if (it->idx_asm >= 0)
 			return it;
 	}
-- 
2.23.0

