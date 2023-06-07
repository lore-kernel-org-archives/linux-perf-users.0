Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B4C7EE29
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jun 2023 05:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjFGFCF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jun 2023 01:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjFGFCC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jun 2023 01:02:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D110D5
        for <linux-perf-users@vger.kernel.org>; Tue,  6 Jun 2023 22:02:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb397723627so2633013276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Jun 2023 22:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686114120; x=1688706120;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRAyICdxSGyrBKbLP2q4JA92wKF4IQsTca6ujv0oJ70=;
        b=SHF6+czYmJSPg6CZsTHIGpB42/zXg7RQ6fEyMR23JmXNKA+j4cxDeul7zicrPLVN/H
         i2vHXmUndfahQN11iLH6nXBf1jh9zmTG//HYu3RrNYt32jQxLZywPxVux8KXrcC6ciTf
         oWY3N5KP4h5DEF9Hn0fGWBdkgpaSPHbF1hIkbb1BGgIZLIkGFNHGs1TW3bV82U9e1mOE
         +55e7vyctEknl0nWgCsPTyRguZ1I7OH/yLB7DUVKDkoiJE27UBOMqZWRjDg/Wx7sdKQN
         AfA7DelBpgGUriA0BUDNTTgOHElZoZrXx4NVv0iswaSUkKTu9PxD8/zX9UPiS3Nn0EhC
         OJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114120; x=1688706120;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRAyICdxSGyrBKbLP2q4JA92wKF4IQsTca6ujv0oJ70=;
        b=iSNZLvrBcZDnCW0AZRElI8YG/D4PPiQTCrDHcX4eivRAbvqrSlRVU30XeCJWbKc11A
         wbrX6uS9n07vqt0tiAuXDtFjYOZ4X0RkOMBrVMQPrfosMqI9sn1jCc3j/abe4VULoU9U
         4yulE3BG+sXL+J/CFUgrQM8Dfxa4SDL5YNv1DcbyDMaNEWyB+WaUNOVJANuAxOd1NPa/
         F8IXgm8Cl0M9MXRXNq+w7mzcZw7RIWO+LQd/HKxf2QCEVb3Fu6JzzCQhYWDAYcOqE/BW
         1x7Ee2+QhH5RXoC863Vx17bPExD7lEOW2giMyrg0RBZrtWjquCysVnZV2rQii8QbNf+r
         WptA==
X-Gm-Message-State: AC+VfDzxoKiLuQca+sjnzqjWtB1EP5IzTmzfu9xa/3GjABwEhI1b7vFo
        elluDuXl2A73FbSKwpE5CjLziJMmMddh
X-Google-Smtp-Source: ACHHUZ7swUdFlK8MwbVV27uiqLr02j263EZVgmxsJeTDgCt7riuy9Ee8MBI/tBz8zvJMekA2PK7yM+17+T8g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a25:d15:0:b0:bac:7086:c9b2 with SMTP id
 21-20020a250d15000000b00bac7086c9b2mr1521872ybn.12.1686114120259; Tue, 06 Jun
 2023 22:02:00 -0700 (PDT)
Date:   Tue,  6 Jun 2023 22:01:46 -0700
In-Reply-To: <20230607050148.3248353-1-irogers@google.com>
Message-Id: <20230607050148.3248353-2-irogers@google.com>
Mime-Version: 1.0
References: <20230607050148.3248353-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 1/2] perf annotate: Fix parse_objdump_line memory leak
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
        Andres Freund <andres@anarazel.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

fileloc is used to hold a previous line, before overwriting it ensure
the previous contents is freed. Free the storage once done in
symbol__disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b708bbc49c9e..fc5f44535ebe 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1524,6 +1524,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	/* /filename:linenr ? Save line number and ignore. */
 	if (regexec(&file_lineno, parsed_line, 2, match, 0) == 0) {
 		*line_nr = atoi(parsed_line + match[1].rm_so);
+		free(*fileloc);
 		*fileloc = strdup(parsed_line);
 		return 0;
 	}
@@ -1572,7 +1573,6 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	}
 
 	annotation_line__add(&dl->al, &notes->src->source);
-
 	return 0;
 }
 
@@ -2114,6 +2114,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		nline++;
 	}
 	free(line);
+	free(fileloc);
 
 	err = finish_command(&objdump_process);
 	if (err)
-- 
2.41.0.rc0.172.g3f132b7071-goog

