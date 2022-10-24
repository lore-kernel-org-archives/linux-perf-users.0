Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441A0C38A2D
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiJXS5T (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiJXS45 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 14:56:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1315B06D
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:36:59 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36772c0c795so97032067b3.23
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yf//nKniGE2IxHdCyFgbypJdJyKGDk5InFKRkZy7usI=;
        b=bkFsx7xRDT4SOzYnBWia39BL6PfxRv41NyEx8ZpXPvEJYtzo9fD7KHXUZq7dZ0kSp+
         Cb52tElChTP5b28SYmcB5d9ym6Xy42R3VF0Ln930bKL9ke9DhtRKIIj95iTOkT7ehVgJ
         hSggoy02P/39UXt24GxVtWyl2QObBaYL2BAmTtIolM+YJ++faLGH2iBBfPtYnK7ZtOUm
         0CH2aOJb0eXXsFA0urZ42cb0ZzLHirPS5E5WFPYWibD3/LMGxhPsBWW3gHfyZJl9Fcuu
         ou2vxzk0+j+CYMcIiAA/4ZOc/qL+YRdYHKuvBaoUeBWquw8scpTG1PNaCPz9/VIf1/+K
         l6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf//nKniGE2IxHdCyFgbypJdJyKGDk5InFKRkZy7usI=;
        b=dyAnzL3rq9JMeYc9Pz4o/yhtYJg8luWNR/r+MIucY89sBEmh0x2O5GWnagWQsQBRXI
         JSQzMFUNyRI7LaA4emyV/skWijqHPH3iNtmXXCknvLRwOnrm2KPw+G/OVrnqSHNGcb6f
         GYomskUMICYpqYfNXNlMsdtMO7+A2Nonvm6NE2r3lOyKyPUYVEnH6wZnERmKYIm0CB6L
         TKeJOVdP5pOEeHDWEeSfm/mKHt7g8IHHb/tvbnJbfeSfS15q9L5CRdnYB5860UoUCYYm
         JMOib7NNLQVZLtJ0GWACgDUt4Z94w0KAgjiQybYBatC5E6Xhnc2ObFSyMN27UpdKkCQ9
         lSOg==
X-Gm-Message-State: ACrzQf0g4BvMlWAKfjr4LxqROhZgBBwhdzRD/wGTsaVyrLaugSIGW9eZ
        4Txu/3UhrzZlRBpaY10hXCmgMSQ67ISI
X-Google-Smtp-Source: AMsMyM6Wr8wyOuCzkrlfckTajnVv3nw2ax6iWqt2oiTLtFpq7+Hk7ri7Cu+yvY0A4Ah9bvi0LsEH9lFR6zy7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a25:bd8b:0:b0:6cb:d10:a5b6 with SMTP id
 f11-20020a25bd8b000000b006cb0d10a5b6mr5711316ybh.173.1666632951410; Mon, 24
 Oct 2022 10:35:51 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:16 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-2-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 1/8] perf build: Update to C standard to gnu11
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

C11 has become the standard for mainstream kernel development [1],
allowing it in the perf build enables libraries like stdatomic.h to be
assumed to be present. This came up in the context of [2].

[1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6fd4b1384b97..29c49e6e76a1 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -307,7 +307,7 @@ CORE_CFLAGS += -ggdb3
 CORE_CFLAGS += -funwind-tables
 CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
-CORE_CFLAGS += -std=gnu99
+CORE_CFLAGS += -std=gnu11
 
 CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
-- 
2.38.0.135.g90850a2211-goog

