Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A61C61DA4
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 06:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCKG7v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCKG7n (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:43 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F8E6FFE2
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53700262a47so76010397b3.4
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517945;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TeLjpZEBElZPq770pHQ3cqTtDu48PrMd6iajkLxZXoU=;
        b=Ua++G/pPd+SVDJwvl19ZJsDG1Or/TZ/BFSKNdrAmYWdlWCZ/iFomFaBUwI0T5lTgOm
         xWfKU5/Bwli59xtjTjo+LvLnIbOmWR8cgnp7hb1NjIlSzo+khMAZRqdJ7g6wNgAZ//6K
         oZdtIP7+Kdy3nvqTB6B04pijjfOeie0Hf1QccsJhVwceP78G/J1wbT+FQNpjgHIfl+OH
         FWBtsQo9zfspq9m+CreQOdsqyBGbr0Q2nNsJRtvkSqrHutbXWoGADqwcJbESnMQDEnv1
         oiiRTPBevzcT/2RXis5IoSDZyeRElEE8Uf3/yhtx94aYTkUDApVo7blkQ5nkkY/NTzAm
         cpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517945;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeLjpZEBElZPq770pHQ3cqTtDu48PrMd6iajkLxZXoU=;
        b=M41eb1tHuRuldOMAeJzlJ2BnysCfP7i5M3Onina3rAwZrg1EqxpJkZK/9ImZz1+e5r
         faJMUd6cHt7oqS7P3q7hST62qfjl6HHwWFoLstbnOhA+bSBdB+uBQTwCujCtWWHWlZIg
         I337pIeMrj+af+sgrZpW0fm4ToG/ft4mB8ulKaN4dPFqcz3N+ACcV2fOBLeqapt1PG10
         gwKin7WICeQgDmThXo/jxgL/FZpmFi/b84BzmwJs7St3Om4lV2zuutp+j2hM4uw3H1oK
         rRptmNJ/iBujxaWl6fsjqgLtlWFjJiUK4mxUc0LtdkQmr6EMBFttWzy/c2znOlixVooT
         4n7A==
X-Gm-Message-State: AO0yUKXranaJMkNN/ylWMS/rUbQFdTEzR/z4vRwG8VoYizvzgZQQ3D4x
        DMptg7s+uDlFUUGZfG1r42vUP5i/peth
X-Google-Smtp-Source: AK7set/6+p+yFgDiDQyRYorbvgodf9XCwu4OA2mDN8JFQ4h3Y3vVuSxNelxVt3B5EzESzr56CUvMk0R6m5mw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:4328:0:b0:541:642f:709c with SMTP id
 q40-20020a814328000000b00541642f709cmr2ywa.388.1678517944974; Fri, 10 Mar
 2023 22:59:04 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:48 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-9-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 08/13] tools build: Add feature test for abi::__cxa_demangle
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
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

cxxabi.h is part of libsdtc++ and LLVM's libcxx, providing
abi::__cxa_demangle a portable C++ demangler. Add a feature test to
detect that the function is available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature              |  1 +
 tools/build/feature/Makefile              |  4 ++++
 tools/build/feature/test-cxa-demangle.cpp | 17 +++++++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 tools/build/feature/test-cxa-demangle.cpp

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 38f8851bd7cb..214622d7537c 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -80,6 +80,7 @@ FEATURE_TESTS_EXTRA :=                  \
          compile-32                     \
          compile-x32                    \
          cplus-demangle                 \
+         cxa-demangle                   \
          gtk2                           \
          gtk2-infobar                   \
          hello                          \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index dc9323e01e42..0a3b9281f8b0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -23,6 +23,7 @@ FILES=                                          \
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
          test-cplus-demangle.bin                \
+         test-cxa-demangle.bin                  \
          test-libcap.bin			\
          test-libelf.bin                        \
          test-libelf-getphdrnum.bin             \
@@ -262,6 +263,9 @@ $(OUTPUT)test-libbfd-liberty-z.bin:
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty
 
+$(OUTPUT)test-cxa-demangle.bin:
+	$(BUILDXX)
+
 $(OUTPUT)test-backtrace.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-cxa-demangle.cpp b/tools/build/feature/test-cxa-demangle.cpp
new file mode 100644
index 000000000000..a3e712f65c37
--- /dev/null
+++ b/tools/build/feature/test-cxa-demangle.cpp
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <cxxabi.h>
+
+int main(void)
+{
+  size_t len = 256;
+  char *output = (char*)malloc(len);
+        int status;
+
+        output = abi::__cxa_demangle("FieldName__9ClassNameFd", output, &len, &status);
+
+        printf("demangled symbol: {%s}\n", output);
+
+        return 0;
+}
-- 
2.40.0.rc1.284.g88254d51c5-goog

