Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CEAC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 02:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiE0CHA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 May 2022 22:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiE0CG7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 May 2022 22:06:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738AC5FC3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 19:06:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-306f3830324so550267b3.13
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 19:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t432bOj9HNNyvwVqFkTcjkKR+K0Bmhu30IV4FVjsgoY=;
        b=b3JXmJSg81a9cCK4Qjk0xcyCb+s5bCsYHXtaTB/4K+Hl98m0MtxyYoobjDFBTB7CFB
         HK26ktpzNug4q4LPiNU/r4aRz3Cd1IFlwQ1riNeU7GWInC/YcT0FrdS4RclYpbP797Hg
         Oa49gKiCb5LTpVK+EC5OdYiEFzh4nzZwdR3sI7Gf7Kw5upguEhIkLAkMTEabl5sM4X8H
         buwqsT9qzsltd5mDKZaIByOHs59VhFUg2m0EG9xZK60XvvM8+Ti1SK1454iDDcUTk0XT
         ZvoKuDWvEzZRG/ZfJs0qkFmkmu1lG/7ILKFrlD7hqqPcJdE7ohUgAUl+67rxn9cTw+Qh
         4FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t432bOj9HNNyvwVqFkTcjkKR+K0Bmhu30IV4FVjsgoY=;
        b=aOQJXR2MZUBRwYv04j6OxSsHdsQdrQ8bP/xLdEHAxU/VD0mJnU1nD4LGCJ3wQN7kyq
         h/K16LPvY/li1L6zu0CD8iVPJVfrLtDoPRPrEccXo1AVWNEgYPmmhcySfDg56VC7ATYs
         +CJXCSOqxAF9d/iae9DhREu5IB3EjeGNpOdcoYry5GXq4KIlnp9ZFIQ2ayUVyFVTfxo+
         aO0NKkp1apEx3G/CbeXw31PxVAn6oTC1weAusKWeKO1i/EStf2WTKjQkL6uJml8BXObc
         k6NjVK71pIvlEkCOuClml00TKTmvPG6y1+Ymy3qdufNCQWkNAk8iz9n9MwCZq42k9rpz
         YmgA==
X-Gm-Message-State: AOAM533qHgxqA2/+mu9zWnSfJzcSsz8kKV/5EL7Wu6PMXjnks19qAcQl
        Fi7V1EFEJwryv13hs60s/SPqkLuCjcZg
X-Google-Smtp-Source: ABdhPJzEVEPw+BMNvtb1jZpBoUKmkT3ERjQ/T4WthU6YPLykYRzhQAmiFOkVgzeG1dhQrUwWnlZiClN6c/y4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4b39:e167:e698:7d4])
 (user=irogers job=sendgmr) by 2002:a25:e788:0:b0:64d:87c1:8fa with SMTP id
 e130-20020a25e788000000b0064d87c108famr38666633ybh.302.1653617217585; Thu, 26
 May 2022 19:06:57 -0700 (PDT)
Date:   Thu, 26 May 2022 19:06:53 -0700
Message-Id: <20220527020653.4160884-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH] perf expr: Allow exponents on floating point values
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Pass the optional exponent component through to strtod that already
supports it. We already have exponents in ScaleUnit and so this adds
uniformity.

Reported-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 2 ++
 tools/perf/util/expr.l  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index d54c5371c6a6..5c0032fe93ae 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -97,6 +97,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	ret |= test(ctx, "2.2 > 2.2", 0);
 	ret |= test(ctx, "2.2 < 1.1", 0);
 	ret |= test(ctx, "1.1 > 2.2", 0);
+	ret |= test(ctx, "1.1e10 < 1.1e100", 1);
+	ret |= test(ctx, "1.1e2 > 1.1e-2", 1);
 
 	if (ret) {
 		expr__ctx_free(ctx);
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 0a13eb20c814..4dc8edbfd9ce 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -91,7 +91,7 @@ static int literal(yyscan_t scanner)
 }
 %}
 
-number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)
+number		([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)(e-?[0-9]+)?
 
 sch		[-,=]
 spec		\\{sch}
-- 
2.36.1.124.g0e6072fb45-goog

