Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C7EC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 22:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CD26113E
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 22:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhIJW7M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhIJW7M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 18:59:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC8C061574
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Sep 2021 15:58:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j4-20020a258b84000000b005a203c5e066so4423036ybl.19
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Sep 2021 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BJDLzCz2E12CBMys6DrXt32TSGJ21rsoRK0PrUSpQaA=;
        b=Endbm9Pm/v/6QwrJl3ZzV/vcW123iunM5yLNVPg4NPtCTmORPntR5zaUHX26ypI+rg
         jdaOoLhdv0gBepuVLuvwyQrP3INJq8EauSB40e7jU2gYvWJziFoMJ7s0I6tia6XfU+Xt
         kPOLVAqO31NLtDwiQM/N2O1ryfSRpOYcJN7xexG+iVrnNdTSAoNNcQPDIN1dvrir5U09
         6jdUfofz3mdPk1uYQ+rFz4Y2SnFN3w4NmxmK9AtKL42n5BIW38wArMiAE19dd2OokpZu
         HdyANTju6RWAFtAW5DZxQIcQ2tzMsAvAir68L1c7tI1Qj1dmRCQIh/rltOc/+bb0S5ul
         b8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BJDLzCz2E12CBMys6DrXt32TSGJ21rsoRK0PrUSpQaA=;
        b=2AbfgzAz4sKeDOBl7V+NehmmV7dtHnOOBxuAc14PkyA+CCxUKEyyvyXPpv6G06ngWE
         GXPN51Wrn+co3x7ISAYhZKD/OlYUpBen79G2a8SOhARnwd7A1MII8ARM4PXCOseQ6xCV
         KWycDgBrlxC+h1B6hKjO5/L6Zv9lZ6edJ9NXGw4ivMNfQcDAB1e3OD0zD7TjF03SZVhn
         yu1AV3R/SwX2T6wNwkLFPlKZXvGE/TI64HBM5P/2ytf0xzHAitrSgbSsP7u5coLH3M2C
         TR7DGI6pf6WuNUuf5Bfb++OkeAI3pnWKQRBlxFFDX2tdRtcp7Ug7OwmciIcfD7qRNbmy
         CL7g==
X-Gm-Message-State: AOAM530UfxxQGO+y0OTB5tRVPcsGLXDdT/WnBVtbosSmqNFbSc2Lzk7Y
        iI/FQwY1QEP3RTMP6j8jDKLJgqSbrGql
X-Google-Smtp-Source: ABdhPJzS86peoZljfp47qbw+FvGX+MGtXWrIz+ZRaWfNVukgk5qwMaShTaAD4ktnHLowYYL7S+2xnEPktOo9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:245:160a:d9eb:a3dc])
 (user=irogers job=sendgmr) by 2002:a25:5205:: with SMTP id
 g5mr180791ybb.292.1631314680039; Fri, 10 Sep 2021 15:58:00 -0700 (PDT)
Date:   Fri, 10 Sep 2021 15:57:56 -0700
Message-Id: <20210910225756.729087-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] perf tools: Add an option to build without libbfd
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Garnock-Jones <tonyg@leastfixedpoint.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Some distributions, like debian, don't link perf with libbfd. Add a
build flag to make this configuration buildable and testable.
This was inspired by:
https://lore.kernel.org/linux-perf-users/20210910102307.2055484-1-tonyg@leastfixedpoint.com/T/#u

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 47 ++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b66cf128cbc7..446180401e26 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -827,33 +827,36 @@ else
   endif
 endif
 
-ifeq ($(feature-libbfd), 1)
-  EXTLIBS += -lbfd -lopcodes
-else
-  # we are on a system that requires -liberty and (maybe) -lz
-  # to link against -lbfd; test each case individually here
-
-  # call all detections now so we get correct
-  # status in VF output
-  $(call feature_check,libbfd-liberty)
-  $(call feature_check,libbfd-liberty-z)
 
-  ifeq ($(feature-libbfd-liberty), 1)
-    EXTLIBS += -lbfd -lopcodes -liberty
-    FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+ifndef NO_LIBBFD
+  ifeq ($(feature-libbfd), 1)
+    EXTLIBS += -lbfd -lopcodes
   else
-    ifeq ($(feature-libbfd-liberty-z), 1)
-      EXTLIBS += -lbfd -lopcodes -liberty -lz
-      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+    # we are on a system that requires -liberty and (maybe) -lz
+    # to link against -lbfd; test each case individually here
+
+    # call all detections now so we get correct
+    # status in VF output
+    $(call feature_check,libbfd-liberty)
+    $(call feature_check,libbfd-liberty-z)
+
+    ifeq ($(feature-libbfd-liberty), 1)
+      EXTLIBS += -lbfd -lopcodes -liberty
+      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+    else
+      ifeq ($(feature-libbfd-liberty-z), 1)
+        EXTLIBS += -lbfd -lopcodes -liberty -lz
+        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+      endif
     endif
+    $(call feature_check,disassembler-four-args)
   endif
-  $(call feature_check,disassembler-four-args)
-endif
 
-ifeq ($(feature-libbfd-buildid), 1)
-  CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
-else
-  msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+  ifeq ($(feature-libbfd-buildid), 1)
+    CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
+  else
+    msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+  endif
 endif
 
 ifdef NO_DEMANGLE
-- 
2.33.0.309.g3052b89438-goog

