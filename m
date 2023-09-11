Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBF0CA0ED0
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Sep 2023 21:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346364AbjIKV2M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243337AbjIKRGP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Sep 2023 13:06:15 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA5121
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5701dbeaf9fso6271639a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Sep 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451971; x=1695056771; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Vzz2XipswXqhRAZU8hIAWN5QKsHwhXA4M9PtsNSBLg=;
        b=YWCOnLA3d4/1GNUUBAPQ7IGBWC9j9mXhT7x0i2jwYLaTNsKaNXktq7Oo0GS4HN20XH
         D1x2yETJaiV4uDvGIoS6zXvlugijlRvIJMEKFnAIepyz6nUx7atxJAvwCSDeR4p3Z39S
         qan3tfA0QYt6XRy30ikBmsZB/MfvX23i26yLDzClGhRoX0rt0IlLIvV+23h5ssKYpBKd
         B84NpEqQnuqrdbVuNLHb3OIWny4mgBoXqMOjFxlTLcPLl4cUHSE3nNhNnD4zy9YAwE1C
         YgAMxrRyzLkrSrjOpIlSMo2bcifnDylyzpaGeVxDEi71j5LffHk6ae0AsuR3LnEoMoN8
         j6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451971; x=1695056771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vzz2XipswXqhRAZU8hIAWN5QKsHwhXA4M9PtsNSBLg=;
        b=LZA6s1Zq5UDA7DpVlu/+y0YQ11YWiIC25+PyUI7Xixd959xggC38RyhBS5fu4jr5Ss
         rrvTcBEv1pNzFvW/vLFnHId56aZVOoibtoUEmd1DxiOdP5TbnJYOtrGgq3799SFoFaEx
         VwXA6xstexVFW+5JxQG4A61EigPmQaIPhTMq98Lbh2A1mEpVICWKaqlJQ2k6SloI8PUl
         sNyhZDmFcdI7DhAscCgrqrQwng9BLZnvDvydmaq/sslCP6AAkE+W9a1jDky8j8lRSMbE
         72LYgiROLJiKb3BrL/ZbtSIsPYI8X7aWFt3U0z7o9JszhcWYhJhtY2zmhrLf8Uc9jNVt
         WOaw==
X-Gm-Message-State: AOJu0YyAxN05v1aq8xgfGVYmlosJV1VwdlsC4uUANwexTvCMWIGASs/s
        knKzHP/2tIss/VR99wWZ2q/WCAOIP9Z0
X-Google-Smtp-Source: AGHT+IGIhSAWZ1imjQEKI5kVl5ekILjaw0OmXTbC9BInGiGxTOTdQVla++ZMTYyGVj4IXpyev+Ua2Gvq2EsG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a92:55a:3ba0:c74b])
 (user=irogers job=sendgmr) by 2002:a65:6ab5:0:b0:573:f899:b6f with SMTP id
 x21-20020a656ab5000000b00573f8990b6fmr2287578pgu.10.1694451971254; Mon, 11
 Sep 2023 10:06:11 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:05:57 -0700
In-Reply-To: <20230911170559.4037734-1-irogers@google.com>
Message-Id: <20230911170559.4037734-3-irogers@google.com>
Mime-Version: 1.0
References: <20230911170559.4037734-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 3/5] perf expr: Make YYDEBUG dependent on doing a debug build
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
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

YYDEBUG enables line numbers and other error helpers in the generated
expr-bison.c. These shouldn't be generated when debugging
isn't enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 6c93b358cc2d..e364790babb5 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -1,6 +1,8 @@
 /* Simple expression parser */
 %{
+#ifndef NDEBUG
 #define YYDEBUG 1
+#endif
 #include <assert.h>
 #include <math.h>
 #include <stdlib.h>
-- 
2.42.0.283.g2d96d420d3-goog

