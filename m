Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB21DC001E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 06:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjG1GuJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjG1Gtz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Jul 2023 02:49:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D729235A6
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso1756082276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526989; x=1691131789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+NuSN9XkT+qsQuvKgJBdNq4nk4vcI3JH0hFT1DVHgI=;
        b=dBWfagtHD8/GX5CfSM0USkliKrcgjg7HFq51oTJfadYnvK2v3CXXfjwoGKERNpv3cI
         4AUh0LL57JfZLlBfahYZs7188BkkTzaC6XOahh1G7K6UlM+Ll8rC86zWvjSKyi7LhZP5
         M7RMyGdKmtrbQ8AI3nAe18nKyqLPfckUcaMM3nVyHIue/AQSImE85rbc2i4MXRJmHCN9
         TNXXK0CuMC8RLg39DqApn3XqceSzf0vyA3QhKs3XLbwDbUmTT6bLYabPOh73nfBhDH1H
         oH9n2bueV+aOOiThlR2LuT0Qa+Dq1E2g02ybR//9V6PXxgIS5SzcAGGaW5wpHjsLXWuT
         gI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526989; x=1691131789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+NuSN9XkT+qsQuvKgJBdNq4nk4vcI3JH0hFT1DVHgI=;
        b=MNHLo3hI4b4MUSabnCygk+QgQSGTImxW25KXHL6amSJxdOWmLKBo0eb9801EU69pa2
         Ia6sU/lXjKCQX4C0YwbYlVChUx7WyblU/3CxsfnLVZjE70IkTM0krSEHZPY/+fmpMATH
         MB0E0yhWP1yAYAPs0A7Pspc+tS2F7qRIs5qWEsiul05B7Ey07+QbUFt0YpfZwbsEFYg7
         IhQ46xycmS8ufWU/TczLNW0LBT+mWxYD6B2SDWycMBBK/qTgQMIGwm1O6wNHCmsXHsk3
         houZRx+LwcPZGMwiZODzIjRk7IKGzq3pthvRFiHcv5tBt06e1qr/wnUe7yeAZWP+o2Rj
         S2hQ==
X-Gm-Message-State: ABy/qLbDHAmR7wrcciQxigP4w40dHixOODToBNlDfhx2/VtHsV8MCWBc
        4Rk/dzwMy/2NoENEPb6H/YFDoYm6XtcF
X-Google-Smtp-Source: APBJJlH1isPienb9pKw3EcA/eACCf//JnX+EHZyFmUKd3n/1Raax6Ty/uxc322vFBpfbg4KszcnotojxYicG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:37d8:0:b0:c64:2bcd:a451 with SMTP id
 e207-20020a2537d8000000b00c642bcda451mr4280yba.7.1690526989081; Thu, 27 Jul
 2023 23:49:49 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:14 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-4-irogers@google.com>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 3/6] perf build: Add Wextra for C++ compilation
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

Commit d58ac0bf8d1e ("perf build: Add clang and llvm compile and
linking support") added -Wall and -Wno-strict-aliasing for CXXFLAGS,
but not -Wextra. -Wno-strict-aliasing is no longer necessary, adding
-Wextra for CXXFLAGS requires adding -Wno-unused-parameter clang.cpp
and clang-test.cpp for LIBCLANGLLVM=1 to build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 +-
 tools/perf/util/c++/Build  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 14709a6bd622..fe7afe6d8529 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -333,8 +333,8 @@ CORE_CFLAGS += -std=gnu11
 
 CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
+CXXFLAGS += -Wextra
 CXXFLAGS += -fno-omit-frame-pointer
-CXXFLAGS += -Wno-strict-aliasing
 
 HOSTCFLAGS += -Wall
 HOSTCFLAGS += -Wextra
diff --git a/tools/perf/util/c++/Build b/tools/perf/util/c++/Build
index 613ecfd76527..8610d032ac19 100644
--- a/tools/perf/util/c++/Build
+++ b/tools/perf/util/c++/Build
@@ -1,2 +1,5 @@
 perf-$(CONFIG_CLANGLLVM) += clang.o
 perf-$(CONFIG_CLANGLLVM) += clang-test.o
+
+CXXFLAGS_clang.o += -Wno-unused-parameter
+CXXFLAGS_clang-test.o += -Wno-unused-parameter
-- 
2.41.0.487.g6d72f3e995-goog

