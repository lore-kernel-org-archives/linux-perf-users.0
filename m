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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC539C4320E
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD29361206
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbhHUJWw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhHUJWP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D7EC06114F;
        Sat, 21 Aug 2021 02:20:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i6so17675592edu.1;
        Sat, 21 Aug 2021 02:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRWPQ8HxhbjIOSVCF9fueneGQHgaEtyHF4yxY4sSzec=;
        b=JIHhV+40z3DGp/eALzG7aaet5twMq1a/vpBct8kXXSCGkw+XCFmERWJNER2GFveio/
         o0v9jX4CHSnNnHTKAaLukGGLDp5nxdG437LX+P2XTSMmDD4FLHlGq3MlDtZZQ5LwCqNu
         h5MM8t54E+8Hp8LRtBDgRjk+uopp2T0BAKJz5UMjtglzVwaHBBITdDWWHTDj9rVOZK9g
         5Tg/fIEXHBhA0YDvBe1aUDPliS/qD7LPuuWZlmkDmB6VCGcoYYkmhFxY8zRBZiRr9f0G
         RXU2fUxbSdKXMwZEvSlA+gN7CyjpG9SfpM8uJYVeqTn5rm5OaggXF6hRmQ/7FBRUO86d
         jV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRWPQ8HxhbjIOSVCF9fueneGQHgaEtyHF4yxY4sSzec=;
        b=lIyfXcLrBbv/h41p0lBUBw4l1JzJsVSYRyUJQWF78Jl369H0ujlKGts2aq0QhzIs9y
         /k7AcaMJKdAnhJmoesJXcJp6st1cUiuivM+olkEtx5lM+LfZFLePTHkpS5Rjkwsn8zlS
         w/YO3K8H2Io2NA4Yu/VILspK+kcNELKvtwmh7Evp0L9Lw8L8XM0QvDZIMUu+2clOHRdA
         p3kDONxyQaOIrZz+jdWGB3I+aPggpmGE6lW7lUPRY2YwjjGsJe+5OwKKBEGC4U6OR/3K
         /AFsKPoeu2l0vgyHBe1mDnaCM2qAasXgde4efXvAUhATykuYOEcA6sMcllI5aE5+l7SI
         +BPg==
X-Gm-Message-State: AOAM531Np01P85TtlhrH9X58aRkVWT1M4ENp7G4dbiuOzkwD7ffenQdx
        qYxjyyPvHiRI0IdH2tuoukE=
X-Google-Smtp-Source: ABdhPJzrnyo88qRgBmIhxwLlVU5nAHryT91dUbv2RLu+LkECJzI0/fIabuml8GZTahoyGQD+6eqbmw==
X-Received: by 2002:a05:6402:220f:: with SMTP id cq15mr5378154edb.142.1629537627317;
        Sat, 21 Aug 2021 02:20:27 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:27 -0700 (PDT)
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
Subject: [RFC PATCH v1 31/37] tools lib/subcmd: add OPT_UINTEGER_OPTARG option type
Date:   Sat, 21 Aug 2021 11:19:37 +0200
Message-Id: <c46749b3dff796729078352ff164d363457a3587.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds OPT_UINTEGER_OPTARG, which is the same as OPT_UINTEGER,
but also makes it possible to use the option without any value, setting
the variable to a default value, d.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/lib/subcmd/parse-options.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index d2414144eb8c9927..41b9b942504d398e 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -133,6 +133,7 @@ struct option {
 #define OPT_SET_PTR(s, l, v, h, p)  { .type = OPTION_SET_PTR, .short_name = (s), .long_name = (l), .value = (v), .help = (h), .defval = (p) }
 #define OPT_INTEGER(s, l, v, h)     { .type = OPTION_INTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, int *), .help = (h) }
 #define OPT_UINTEGER(s, l, v, h)    { .type = OPTION_UINTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned int *), .help = (h) }
+#define OPT_UINTEGER_OPTARG(s, l, v, d, h)    { .type = OPTION_UINTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned int *), .help = (h), .flags = PARSE_OPT_OPTARG, .defval = (intptr_t)(d) }
 #define OPT_LONG(s, l, v, h)        { .type = OPTION_LONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, long *), .help = (h) }
 #define OPT_ULONG(s, l, v, h)        { .type = OPTION_ULONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned long *), .help = (h) }
 #define OPT_U64(s, l, v, h)         { .type = OPTION_U64, .short_name = (s), .long_name = (l), .value = check_vtype(v, u64 *), .help = (h) }
-- 
2.31.1

