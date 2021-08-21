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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CBDC4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB25461186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhHUJWu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbhHUJWM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7E6C061147;
        Sat, 21 Aug 2021 02:20:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj8so17663773edb.2;
        Sat, 21 Aug 2021 02:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QtVrbhUZ3Hz139HgNIy3r2BPh97ZYhKrBaN0u3auT0=;
        b=DGc30yDbq10hT70Gm0uu0F0HMpNHf5J1ZCabb5/ql6pQ3LOwTIwaH9Ae86bdHHu8bm
         rlJTeCXr3NfO84mQ3Bb4iWo34tFO1MuV7V1TPqaK1Fh3j7IZt2Lx48xhzTo0wPesdiTO
         f//2AOdzNPmlGdSTIWcY3p9UuaeEsYSRaHWB+MHT0XOwsU97KnrBBdyfks/ob7Xlt1D8
         NO5E5wZpnzZEoRc/TRww20DlATvS8eGa5ccYibAK+YGWrlaAICTU1aT2FZMhW36/oAq7
         rr8MQiCGbWSaD69wb/uVHP0OcMZnUbU5vMf4xnkoT/vhKHxzPGHcwSBnY7EqQnTnwucf
         W7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QtVrbhUZ3Hz139HgNIy3r2BPh97ZYhKrBaN0u3auT0=;
        b=D3GOg+AItVYPLi3y/i7GEj5OzEU27WkK2u3Ql+uX2g1q2u4o8gDOP5OSY1LKQGQCWi
         8gI5FwAsC0Pr0acOhffPyfeMllOM/HZ0tH54BV7zwAFBUwx40QeN4mjTIelYKPvNVW5p
         PwctdrJhmx1rcQECQWgoYQCeXe2MBUQDBO9rTMomLW8xhoOxTOw88sIVi4f4MXE2k8ka
         3m6OYDr+YVTfktaXT1Dk7ZcHy54SiGq9EvllwNZscCjFWfuRXX5IMbj4GuCv8mF5atEY
         nAiK2Apj6N4xPl4GUPMHrisB1QLKRv46jA45u1Ubrv9GvuKPgKKpgf4fSnRY7h1ACkgg
         Ut2Q==
X-Gm-Message-State: AOAM5339Ml33353ZR7iEAdvHeEgfkyJQ0MWe65S5M984bOQN1uw7XYvx
        NvaBqP8aWcARRumqQwjH4pY=
X-Google-Smtp-Source: ABdhPJwN8y6ZGwYt+8hKntEco2UM8aUU8Q7M6zB5LuTrBbZ/bumj6BPvutj5FabQGsG40AiYOqN6XA==
X-Received: by 2002:a50:998f:: with SMTP id m15mr26362842edb.193.1629537622314;
        Sat, 21 Aug 2021 02:20:22 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:22 -0700 (PDT)
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
Subject: [RFC PATCH v1 27/37] perf evlist: add evlist__for_each_entry_from macro
Date:   Sat, 21 Aug 2021 11:19:33 +0200
Message-Id: <2386505f8b598adf0dbcd04ec21804c6bcf00826.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds a new iteration macro for evlist that resumes iteration
from a given evsel in the evlist.

This macro will be used in the next patch

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evlist.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 5f24a45d4e3cf30a..b0c2da0f9755b2d1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -275,6 +275,22 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
 #define evlist__for_each_entry_continue(evlist, evsel) \
 	__evlist__for_each_entry_continue(&(evlist)->core.entries, evsel)
 
+/**
+ * __evlist__for_each_entry_from - continue iteration from @evsel (included)
+ * @list: list_head instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define __evlist__for_each_entry_from(list, evsel) \
+	list_for_each_entry_from(evsel, list, core.node)
+
+/**
+ * evlist__for_each_entry_from - continue iteration from @evsel (included)
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define evlist__for_each_entry_from(evlist, evsel) \
+	__evlist__for_each_entry_from(&(evlist)->core.entries, evsel)
+
 /**
  * __evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
  * @list: list_head instance to iterate
-- 
2.31.1

