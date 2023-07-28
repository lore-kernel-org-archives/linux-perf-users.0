Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB579EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 06:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjG1GuM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjG1GuA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 02:50:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0263A9F
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573cacf4804so18929447b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526991; x=1691131791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvpEokk/Mu+ZE+CJyBkDreLaqziwX68WuK1LqhXECqc=;
        b=hVmuTBJ1Yox9HBREo2lnQL3+qmpioV9r5UsFkBpcTMWs9ujPbivpL62+ixWzmxYbld
         2oj5+aaUkdI7MiXvfOBbiXL6vzkchIAT7sgf/1xEqv1qyiVTkUXz46qqAzkz8YE7IjAc
         a7dAw3ZtkKE0Hdi0zukSamMUV+hxfnGCH1q0cA12gs0ILJz3moGg3LylCmSfm5vhIZ0H
         1nxyLuWhnWNjY6730d+R+507i6pKyHJOqb1BFoQMRvynVEhaUkfZy+JvYJdFIeA3lhV3
         fjl0oWJqm5kdcfw2zmcGWXuqcb300wHWC8naQmdWY1IonPToG6OaTflMjrpM9bqM63Bd
         F1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526991; x=1691131791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvpEokk/Mu+ZE+CJyBkDreLaqziwX68WuK1LqhXECqc=;
        b=ZPsvREJX97yrb1kBupvGgiN4q/BsqVpN1p2C0TtwoswuAFN9+r9ae/QwT/FrQXdTTQ
         Z0FUD8qoneIzXn5Nje7rjn7EYSasHd34P6+S+Txf2tRCkHbKDHYdYvRDHB/Kk1ef7yNU
         q/wG2/zk4zf5G9Am/uDy1WeUztmqyMnfd1EFrNqsy1HjDEIceGE9UlS0DJZbzPC1UF19
         P/Pyx72o885ueMUp5kCAI7cnjM5aO6rVaHdi5g9l7aKQB4qxvcWDoPLH/+Tpv8xWedRF
         K++zHtby2Qqs1l4C2pK81oTtTSSCqPAwC8/3GU0JrRhdCaUR2VU27+fAyZW3h3QvX9wV
         pliw==
X-Gm-Message-State: ABy/qLYwwHoA8bpNpz7xZo4AxyqZtrZ0BG2KgitBi+LF4GM9K2wZdYhc
        tucRQWA2fc1z0F6enoIDDZcJD8xMwrKU
X-Google-Smtp-Source: APBJJlE4sPZ8c2Rq2bZAztF25wIkgTHXbSIfDU4obqALIt5bZH9JO3jXTK5qgYFJMBGfyHqayH2sgvVAeYMT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:2311:0:b0:d0c:e71d:fab with SMTP id
 j17-20020a252311000000b00d0ce71d0fabmr5532ybj.0.1690526991697; Thu, 27 Jul
 2023 23:49:51 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:15 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-5-irogers@google.com>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 4/6] perf build: Disable fewer flex warnings
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If flex is version 2.6.4, reduce the number of flex C warnings
disabled. Earlier flex versions have all C warnings disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 96f4ea1d45c5..32239c4b0393 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -279,13 +279,9 @@ $(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filt
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/bpf-filter-bison.c -p perf_bpf_filter_
 
-FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
-ifeq ($(FLEX_GE_26),1)
-  flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter -Wno-missing-prototypes -Wno-missing-declarations
-  CC_HASNT_MISLEADING_INDENTATION := $(shell echo "int main(void) { return 0 }" | $(CC) -Werror -Wno-misleading-indentation -o /dev/null -xc - 2>&1 | grep -q -- -Wno-misleading-indentation ; echo $$?)
-  ifeq ($(CC_HASNT_MISLEADING_INDENTATION), 1)
-    flex_flags += -Wno-misleading-indentation
-  endif
+FLEX_GE_264 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 264)
+ifeq ($(FLEX_GE_264),1)
+  flex_flags := -Wno-redundant-decls -Wno-switch-default -Wno-unused-function
 else
   flex_flags := -w
 endif
-- 
2.41.0.487.g6d72f3e995-goog

