Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9CC6FD1D
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 03:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCTDiy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Mar 2023 23:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCTDiv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Mar 2023 23:38:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FB2203E
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:38:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536cb268ab8so110664127b3.17
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Mar 2023 20:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283525;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=viZfwPvf0caSxtFGqLDwlsYO52BarmzoWX8M5eoZoBk=;
        b=OrtovnaInILlCIRf6L7NJjDGfa5k9Acce0mhfYh+s2Wus1VqddW29oleoAHbBhIYMW
         CLvXLUKZdLagltpnwPsXblMivLI1AhDXqhqEcM2yE+7p7ApY/HG4ppObxPG8d3YwOiv8
         dflRvDhpHRs4mqPmCyGWkPo4ZkqxvbKa1DJk6JP2BdaS5UUsqWwJPNWzHj5HDtWlvRe8
         xeBVg7JpyIWD9gZA+mLvpjfG2mbGsaCsa/Dw+5Xj2zgu5SidlZpOPFoXoVplKR0O+i8L
         XwkrQFXf2VtuRN9zTLijz4IxotpxF1jgCM7/+p1HQW4tD/vzxBewwT1c4opH5TBvo3Hv
         DdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283525;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viZfwPvf0caSxtFGqLDwlsYO52BarmzoWX8M5eoZoBk=;
        b=Ru91UthZwQNzlyKX/51q0h20MzsvNZXOpycSq8Bns/nYYh80+vvhuORw9DCpX/trbn
         uNz0Y4mFZqHF22UuS5na2X3zcTPT6fR7LkNjKTnWdVazJxbadpNrTPxRmAyT5XuaoWBa
         iED+C+UIHdfMhLSQDA7YThmXtPL9wH3RaXwc9ErSWmxrzkymH33MUvDuBmJnHK9ggFH1
         EUtLFnMnVE63EdlAe9kqV5bO8y5tkOZVEUNKMCuTvN/GklHHwSlV60SAuh4e64VNmAf5
         E8HvIQPfcK/vRVGnSuS2tw7Njahz3Q9oL8Pt7BZRLqQDG8JdcS94V7ozifN8VtNuEfHo
         cJwA==
X-Gm-Message-State: AO0yUKVkdhQlLwytvpoC8xktlkoVBWuqjpd8oLacoVVvKqMG8S3ibYMr
        zlpfrz8paw2/P21oElRg+a6zv4+C3zd7
X-Google-Smtp-Source: AK7set9HA6GCjS7rQXIB5sBheW9QzDYpHx1Wud7NltgUnVFzU4bZ2gsYo7N/ovZdaIdTTmaYEv6lK0iOD5xj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:a27:3ecc:ffe7 with SMTP
 id w2-20020a056902100200b00a273eccffe7mr4343205ybt.3.1679283525119; Sun, 19
 Mar 2023 20:38:45 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:37:49 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-2-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 01/22] perf symbol: Avoid memory leak from abi::__cxa_demangle
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Rather than allocate memory, allow abi::__cxa_demangle to do
that. This avoids a problem where on error NULL was returned
triggering a memory leak.

Fixes: 3b4e4efe88f6 ("perf symbol: Add abi::__cxa_demangle C++ demangling support")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/demangle-cxx.cpp | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/demangle-cxx.cpp b/tools/perf/util/demangle-cxx.cpp
index 8708bcafd370..85b706641837 100644
--- a/tools/perf/util/demangle-cxx.cpp
+++ b/tools/perf/util/demangle-cxx.cpp
@@ -38,11 +38,10 @@ char *cxx_demangle_sym(const char *str, bool params __maybe_unused,
 
         return cplus_demangle(str, flags);
 #elif defined(HAVE_CXA_DEMANGLE_SUPPORT)
-        size_t len = strlen(str);
-        char *output = (char*)malloc(len);
+        char *output;
         int status;
 
-        output = abi::__cxa_demangle(str, output, &len, &status);
+        output = abi::__cxa_demangle(str, /*output_buffer=*/NULL, /*length=*/NULL, &status);
         return output;
 #else
         return NULL;
-- 
2.40.0.rc1.284.g88254d51c5-goog

