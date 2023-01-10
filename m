Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B4C54EBC
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Jan 2023 22:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjAJWWY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjAJWVt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Jan 2023 17:21:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8310563F7E
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 14:21:13 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4bdeb1bbeafso141305697b3.4
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sg2Aa5uCHWcDC8jm9J4EAv2OJFGtXnNHMXMT9mO4Gw=;
        b=AW29Ki0ipdxS14sshMxXhqz4FZFcNVmZ3WvoBGdx8Bla7+yjxNrYSNmR1ihsyWRsrf
         X60XFLMewiYm9IGefUm4eEzu+c8CeyIivN4qFu4JpwnYwB3jA2QMO7bOOM3Ko7g1jq8K
         C5RnWXn1KhH66oHffsmy/GqlYcVahiBR3eqjUSNwhLqIpkauqFmAyRmy+3bD+cnZC0dZ
         KFqMPnIG2GLgHMH6PYQiwuTfPPwsF8vA5I0JxA/flSZfhMIfeqXMaRE2xMVljQClk+CN
         NAwV6KvZTl/6ClD/vaGcAe7VaWC8QwAk0u7Hs7wmIUwxTE33GdGdAYSdTQfnpepXNN/1
         khRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sg2Aa5uCHWcDC8jm9J4EAv2OJFGtXnNHMXMT9mO4Gw=;
        b=ph9FuVRhe708bEfvBH+sQzRzHE5S3H4M3z9ldACsKy/zkkepN3T0eQOi3e10NxJ6Rs
         RhD3aykxLSM8f7ORt1AjeM1THa+mZ9aL6tZ2Zqb4pF/PBIQJ9T5a9nzCvwkN6Uhg7S30
         lev2V0xGhr33bqB/v014WzxftVKgoaaHYFJdUSYBAEaJjpsxwfQQf+mCOH+rjBF4auYC
         Ptl6P1eapHIO/SlPIP1QLoTYx2xQiwrBqF3Zg30LQRQ8iPS+idsvRuvVzcMoPtwHEkCr
         MciVEPf5aEpqCdH0OBsQ3EI/kE57i9GFHvorF6c+Gf8xgUzTYsw5xmByqbHfS7TpPVuE
         uyVg==
X-Gm-Message-State: AFqh2krRRXL9aECWEdzNU4wDPN01P16Mw3f2GH45xGBGyo9ep0fk+kEN
        NU2C+IB5b0jR9LljmtDneJD9UvJGkFRE
X-Google-Smtp-Source: AMrXdXul//OabQOCLWyx1Luc6Hl+ueTmgO396xd2lzHTTOh6r4Z7uBXUeTt67VSekVDq2442YXd8T9SPuWGF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:449:0:b0:7b6:f8d5:82f4 with SMTP id
 70-20020a250449000000b007b6f8d582f4mr2181307ybe.646.1673389264926; Tue, 10
 Jan 2023 14:21:04 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:20:01 -0800
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
Message-Id: <20230110222003.1591436-6-irogers@google.com>
Mime-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 5/7] tools lib api: Tweak strbuf allocation size computation
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

alloc_nr gives an estimate of the actual memory behind an allocation
but isn't accurate. Use malloc_usable_size to accurately set the
strbuf alloc, which potentially avoids realloc calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/strbuf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/strbuf.c b/tools/lib/api/strbuf.c
index eafa2c01f46a..a3d7f96d8b9f 100644
--- a/tools/lib/api/strbuf.c
+++ b/tools/lib/api/strbuf.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <malloc.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -42,7 +43,6 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 	return res;
 }
 
-#define alloc_nr(x) (((x)+16)*3/2)
 int strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	char *buf;
@@ -54,9 +54,6 @@ int strbuf_grow(struct strbuf *sb, size_t extra)
 	if (nr <= sb->len)
 		return -E2BIG;
 
-	if (alloc_nr(sb->alloc) > nr)
-		nr = alloc_nr(sb->alloc);
-
 	/*
 	 * Note that sb->buf == strbuf_slopbuf if sb->alloc == 0, and it is
 	 * a static variable. Thus we have to avoid passing it to realloc.
@@ -66,10 +63,9 @@ int strbuf_grow(struct strbuf *sb, size_t extra)
 		return -ENOMEM;
 
 	sb->buf = buf;
-	sb->alloc = nr;
+	sb->alloc = malloc_usable_size(buf);
 	return 0;
 }
-#undef alloc_nr
 
 int strbuf_addch(struct strbuf *sb, int c)
 {
-- 
2.39.0.314.g84b9a713c41-goog

