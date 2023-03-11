Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935B1C61DA4
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 06:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCKG7h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCKG7a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8A7D557
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w200-20020a25c7d1000000b00b3215dc7b87so3127530ybe.4
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517937;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pq+mKZowelrihgZxRhsuEZHUM4AjdLByKfzOTWop3w=;
        b=WCpB1voDzndaohurNNZYQGv0vrqsEJxdv42rkVIZwjJfH7whmhOKEBaX1/oAFnc74Z
         zcO5YSNux0MCfvJfD8ZHjPWUeYjHzNGqUczp4XQaT16TZ+PIRtBs6x7K4zv7OVhY0xSk
         5gH5mQiBKsjvMd82GAPqiULNfojeP7aVd6i/lK1KQSJERsjQe78tBuapzfeUT6vp+gNH
         LfBvxdKgQwhCP8xtS2L9sxnh0OvBnSTj9RYS2SQFuWrl7V10lsdoizZdl4+nilttIthq
         rq+yeLwFjlivAk+KJslhScF8GXvNDH+922JgCOkqH9J0oxNVqjZWOWe61IwvvU7dd6gJ
         lXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517937;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pq+mKZowelrihgZxRhsuEZHUM4AjdLByKfzOTWop3w=;
        b=CYotLTuKKg786Z6DFoQwA8MD3s/92n/MIXYH24HJ38d8HTtavuxswRGbQwKhEFVzGd
         eiEx4RGDYmXLRs8+1RQafyNf6VBK6yySaN92c2m6ZPUOXkkka5Vnf2uW7UZML8pDG2K1
         WmKtSMFQaHDVRt1s0FhfIBVbWbYUkbkhpUd2vAMJtfoA7gWaM++Vmn/N/F5/8/W+qSTS
         WbDtYrqx19zrTHWEhh6hhvyhrxz+MX9KK+k5OCh21PNqHdYSGRT2Nvpb7+T1Hrz3mCoW
         EcJ42C7etf2uPWxV2YaHno/1Rn8xOg4SufYkL5c0RmRon0Jmnvq+zJ/HPyhF0VOYvH+s
         rq2g==
X-Gm-Message-State: AO0yUKVPSFvwFjs1Zq7TfXC6SWYSxCki8pqdX/Cncn2MiL30rTZa0ylk
        MPH1uB2ZZUGG36BawT011YOFjzn/qYrr
X-Google-Smtp-Source: AK7set8aUqc8K5cZUVUsFpXNndv1liCiw25sradrgvIfHuLhCd2KbosYVbgxeqUpBlh9ZgLyL4l4p2TpvgWe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a05:6902:185:b0:acd:7374:f15b with SMTP id
 t5-20020a056902018500b00acd7374f15bmr17294166ybh.13.1678517937040; Fri, 10
 Mar 2023 22:58:57 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:47 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-8-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 07/13] perf build: Make binutil libraries opt in
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

binutils is GPLv3 so distributions cannot ship perf linked against
libbfd and libiberty as the licenses are incompatible. Rather than
defaulting the build to opting in to libbfd and libiberty support and
opting out via NO_LIBBFD=1 and NO_DEMANGLE=1, make building against
the libraries optional and enabled with BUILD_NONDISTRO=1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 25 ++++++++++---------------
 tools/perf/Makefile.perf   |  2 ++
 tools/perf/tests/make      |  2 ++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2557654d8e29..5756498248e0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -882,7 +882,7 @@ ifneq ($(NO_JEVENTS),1)
   endif
 endif
 
-ifndef NO_LIBBFD
+ifdef BUILD_NONDISTRO
   ifeq ($(feature-libbfd), 1)
     EXTLIBS += -lbfd -lopcodes
   else
@@ -905,6 +905,7 @@ ifndef NO_LIBBFD
     $(call feature_check,disassembler-init-styled)
   endif
 
+  CFLAGS += -DHAVE_LIBBFD_SUPPORT
   ifeq ($(feature-libbfd-buildid), 1)
     CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
   else
@@ -915,32 +916,26 @@ endif
 ifdef NO_DEMANGLE
   CFLAGS += -DNO_DEMANGLE
 else
-  ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
-    EXTLIBS += -liberty
-  else
+  ifdef BUILD_NONDISTRO
     ifeq ($(filter -liberty,$(EXTLIBS)),)
-      $(call feature_check,cplus-demangle)
-
-      # we dont have neither HAVE_CPLUS_DEMANGLE_SUPPORT
-      # or any of 'bfd iberty z' trinity
-      ifeq ($(feature-cplus-demangle), 1)
+      ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
         EXTLIBS += -liberty
       else
-        msg := $(warning No bfd.h/libbfd found, please install binutils-dev[el]/zlib-static/libiberty-dev to gain symbol demangling)
-        CFLAGS += -DNO_DEMANGLE
+        $(call feature_check,cplus-demangle)
+        ifeq ($(feature-cplus-demangle), 1)
+          EXTLIBS += -liberty
+        endif
       endif
     endif
   endif
 
   ifneq ($(filter -liberty,$(EXTLIBS)),)
     CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
+  else
+    CFLAGS += -DNO_DEMANGLE
   endif
 endif
 
-ifneq ($(filter -lbfd,$(EXTLIBS)),)
-  CFLAGS += -DHAVE_LIBBFD_SUPPORT
-endif
-
 ifndef NO_ZLIB
   ifeq ($(feature-zlib), 1)
     CFLAGS += -DHAVE_ZLIB_SUPPORT
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 283ee4f56234..a35bc995d5d8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -128,6 +128,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_BPF_SKEL to disable BPF skeletons
 #
+# Define BUILD_NONDISTRO to enable building an linking against libbfd and
+# libiberty distribution license incompatible libraries.
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index deb37fb982e9..c2f74ed43418 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -68,6 +68,7 @@ python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{pri
 make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
+make_nondistro      := BUILD_NONDISTRO=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -134,6 +135,7 @@ MAKE_F := $(MAKE) -f $(MK)
 endif
 run += make_python_perf_so
 run += make_debug
+run += make_nondistro
 run += make_no_libperl
 run += make_no_libpython
 run += make_no_scripts
-- 
2.40.0.rc1.284.g88254d51c5-goog

