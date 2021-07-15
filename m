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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72C5C47E48
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF255613F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhGOQK3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhGOQK2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C0C06175F;
        Thu, 15 Jul 2021 09:07:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so3987017wms.5;
        Thu, 15 Jul 2021 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YzH8sqrASJbCt/2FNg8W8hQhxyFOqQaNvu5d409D1Xg=;
        b=lv+1lQm/pVmOsbm18WDThNHsNReHdf8X9dopzMS7aDUCZASJODkllgcXf7gRj9ZUdc
         MWofV6gdui6af8lzuQwP07KhDJKxOhBcR/0XKmi+PsYfXIITuQfkiA9psz/We7NbW3nk
         D+KItQEItzKn6L7L+PfalP/Rcu42o2aNZt2MDzlodJ7li+QCyY30Iea/SSmny8Ntf/ph
         Srb2/D/ERwBXBfGW6xshxuiE7iNFWVyEi/zUfx4MNUfhUEog7X92MzBBOOVSK6wFRlCh
         lp3b+6/H/JjtfOhdPlh/m15mOvKStrq5khO6+f6g3N/KLkjzZ5Yp7h7C6zkw7ZV0k4Xh
         v7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzH8sqrASJbCt/2FNg8W8hQhxyFOqQaNvu5d409D1Xg=;
        b=nHW16gvfwOQfOWqAmmUaMd0eBPb/Nf0Xgf5qe/fw6LYM/ZaaZQs7hcncbyW08YqK1s
         BH4KYOuEcgimdisqqs7Hd4U0RfkksKmYzneS45756aoyyLbrdrbMLe8Z1+Z3imLcdoB6
         nUORRCOW0vJdF/BLaKKcSo9hAP1xK0Dtqdxf3RWTxCXxbfFZyhhXh0LqEgLAzi6jgLKE
         Sy8x5AxoCIl60bkyvQqq9iql591NqRv/KNQEGp+hldROtbLy8R3THjp40sVj3B7tUfrT
         46J1pgVb/7Wc2Rj8oGzwweStSYTr6YLLPY6gR+x4z4E0VNw4SbNLrpMX4eYR7FBMTjqF
         IeZg==
X-Gm-Message-State: AOAM5310r9x0WddDyRu3EDmpatJtOHrvstu24nwUW8IUhb9MyCsuUP/r
        AMwcf6OqJ9kmm4e0Q9xfNAc=
X-Google-Smtp-Source: ABdhPJz6iICZJrflimuNHwoN+cJNvOhFf0uoJMKVbH4ux1gHFr4D7WywzeJ73LrSDMi/EFqs8HakAQ==
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr8768694wmj.143.1626365253110;
        Thu, 15 Jul 2021 09:07:33 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:32 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH 05/20] perf test: event_update: fix memory leak of unit
Date:   Thu, 15 Jul 2021 18:07:10 +0200
Message-Id: <1fbc8158663fb0d4d5392e36bae564f6ad60be3c.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak while running the perf test
"49: Synthesize attr update" caused by a string being duplicated but
never freed.

This patch adds the missing free().

Note that evsel->unit is not deallocated together with evsel since it
is supposed to be a constant string.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/event_update.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 932ab0740d11ced6..44a50527f9d95170 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -88,6 +88,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	struct evsel *evsel;
 	struct event_name tmp;
 	struct evlist *evlist = evlist__new_default();
+	char *unit = strdup("KRAVA");
 
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
@@ -98,7 +99,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	perf_evlist__id_add(&evlist->core, &evsel->core, 0, 0, 123);
 
-	evsel->unit = strdup("KRAVA");
+	evsel->unit = unit;
 
 	TEST_ASSERT_VAL("failed to synthesize attr update unit",
 			!perf_event__synthesize_event_update_unit(NULL, evsel, process_event_unit));
@@ -118,6 +119,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
 
+	free(unit);
 	evlist__delete(evlist);
 	return 0;
 }
-- 
2.31.1

