Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F7C48BE5
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 04:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABE9600D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 04:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhFVEkk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 00:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVEkj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 00:40:39 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7836C061756
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 21:38:24 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 12-20020a05621420ecb02902766cc25115so3085633qvk.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jun 2021 21:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xjwwJU2DWInl98UuzSucz8mPGJZAy/tZZF05M3ACx4g=;
        b=SxBmB9zwpriFS+ea7DTHPna7ObAx1Cbp+mOw1qXB+g4ea7l5TOmE7zYhrd7srwZDoB
         maJ1PbCbyKa/mt2QsXSGsAHPRGej7A5HBveqrdnmn9gjth4JtCNBZghET/YSwF6gTOGK
         R6Ms7Q+LNea+msHOO5SUpbmZmCBYBa46v83hcIxioi2cfRL2mDJaiplJAOiIpilKD0qx
         s1PMWgszH2bH3ZqrAfiSKYeFZ7u5tsRbx66eFSo/4Sat9aQkR2DlDvJIB76wuh0Zbe7d
         aMkT3wuMBYNeB2j/KtBYf9+AL/Lev5K/N55O4BnWG4n4ZnPg2Ks6xYY35ljMHHwmXNyB
         9HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xjwwJU2DWInl98UuzSucz8mPGJZAy/tZZF05M3ACx4g=;
        b=Hw/leBVIm+of6W5OoxJ8ZxQVvqHS/Rz2dtlCBPlH3KB8wcRzA6V1GXnrAixP73RrAV
         ejYbmtH2ECw9iSwBAKaRYRQtK9FSK4WAytIyFmPIWrCHkTjxMEFTFLjpBIjECOqWka4Y
         o08HJhOdARx6cW8RJ3YiKKUaFBH5ro+KBonkJ4bX4roGGZ9gLl+QpSaZTDUj9I0wynZp
         H5G7quKSTaVAf7cMOOcwsQTmAFXaWOxbGz2itWlC5JMzW+ovkeeeBrQei7yCEplroQ42
         kVACCBOmkuxXeW9PrwXsPN68ifTM1r1na9HkzTCK0+bOU8KvMHYL9iC1PtUug25oCDAR
         cKNg==
X-Gm-Message-State: AOAM531u7UsGzNKwdEhOMYTu3f0q/P/EXBF+fclsnWoVRXn9CfrHbWzt
        HyecuneEWfZpjj+n4D91FcJ6VUtqvCJv
X-Google-Smtp-Source: ABdhPJw4zp2WT6JLXLxngSGapcryB06Lr0NnqU3In77xsNtieZm2+cdkweostg0xo1GRduLuGfoAhdbmMAwd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a25:b70c:: with SMTP id
 t12mr2273490ybj.90.1624336703769; Mon, 21 Jun 2021 21:38:23 -0700 (PDT)
Date:   Mon, 21 Jun 2021 21:38:08 -0700
Message-Id: <20210622043811.3108564-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 1/4] perf: Enable libtracefs dynamic linking
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Claire Jensen <cjense@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently libtracefs isn't used by perf, but there are potential
improvements by using it as identified Steven Rostedt's e-mail:
https://lore.kernel.org/lkml/20210610154759.1ef958f0@oasis.local.home/

This change is modelled on the dynamic libtraceevent patch by Michael
Petlan:
https://lore.kernel.org/linux-perf-users/20210428092023.4009-1-mpetlan@redhat.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 4 ++++
 tools/perf/Makefile.config   | 9 +++++++++
 tools/perf/Makefile.perf     | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 04a8e3db8a54..c87e876b6dd7 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libslang                        \
         libslang-include-subdir         \
         libtraceevent                   \
+        libtracefs                      \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index ec203e28407f..9488c4b4026e 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -37,6 +37,7 @@ FILES=                                          \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
+         test-libtracefs.bin                    \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
          test-libunwind-debug-frame.bin         \
@@ -200,6 +201,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
+$(OUTPUT)test-libtracefs.bin:
+	$(BUILD) -ltracefs
+
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a62d09808fef..3a8a54b71654 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1098,6 +1098,15 @@ ifdef LIBTRACEEVENT_DYNAMIC
   endif
 endif
 
+ifdef LIBTRACEFS_DYNAMIC
+  $(call feature_check,libtracefs)
+  ifeq ($(feature-libtracefs), 1)
+    EXTLIBS += -ltracefs
+  else
+    dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
+  endif
+endif
+
 # Among the variables below, these:
 #   perfexecdir
 #   perf_include_dir
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..b56e26b703ff 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -130,6 +130,8 @@ include ../scripts/utilities.mak
 #
 # Define LIBTRACEEVENT_DYNAMIC to enable libtraceevent dynamic linking
 #
+# Define LIBTRACEFS_DYNAMIC to enable libtracefs dynamic linking
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
-- 
2.32.0.288.g62a8d224e6-goog

