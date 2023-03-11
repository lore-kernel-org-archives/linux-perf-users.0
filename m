Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBBC61DA4
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 07:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCKHAJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 02:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCKG7u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:50 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6CAE20DA
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:25 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a545bfbaso77700067b3.20
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517959;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UaJIIcBEzyZNOhgIC/lIx2fcWxamKUkNGMgdjyQDc5Y=;
        b=JbwMyb82arUwYsbpp+2CR3MOHnK4Bsgb7d87J6uyhp979D8l8HMxntJlXJ4Ze9lD8o
         iFmBbKwqDAo3XhKpHsyaZSNeXtsidCNlvJm0M4gN9mCD3eta1g0KxeorDAWq9p68P34H
         xeb/mr6jj4e0OdWAZrQOZphdhr2VY3Mdtb3Rj6aM9M/JVn0koMGGTASHDtYSHDlzwTUY
         3IyCYa58D7A0JflpKOIKrnlZTrtELd+rFMGtv4aiKRORbakk4zVXOML7dZQAJ7k3X2Hz
         VdhFBzRYTBm18iPXmY4AhKQIpdedyNTxP6bKwMYmVRtPEFAvg7WLEC32TfF36clrZ4+Z
         U3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517959;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaJIIcBEzyZNOhgIC/lIx2fcWxamKUkNGMgdjyQDc5Y=;
        b=wGzZHhNZ4jGFbOVCsEqctQuj7LG5NTjDVzrvfYNeDW9FAruqB11QNsEtPad1F3cbhG
         j9sZrxNSZJR8inIkjoQwT0dDUWfnmChRFritsXiPVvKgEOWUp5PgNrv/Bt0fObHOsBWq
         u1n4MBmEnJ8jwrUpQ8cFVAaWxBIODXPw3UGpo3Iz4CisQRNW+ZFA9G4PVCQx58uyKfbx
         /CBrCpxGiWytAIJW53i4q0LK/q8riETD04KQEm/XpkSwr3GyBGzT2eTgCzErCCyR+2qE
         lEchWdkYqg4NiCOtWxrJukbFeYPA0LE6MaxzYCWleIHA94pxMPMIFRxZgZExcklenIGe
         TtRA==
X-Gm-Message-State: AO0yUKVryXwAnZGdqmn4wTf5if0DN8x/wXic3+2R57JUklA5qYQYrC9G
        una+qFml+34OZ2qVWzVfBXAB0TD+mwra
X-Google-Smtp-Source: AK7set8r7y5C4YRsyVKjA7xb6uMrDtNqf2buJwznbMCVbDT8O9J9H12jt+MiPLw/Ik+0AdXWYz2LqVnm5lPL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ac28:0:b0:536:55e5:2eaa with SMTP id
 k40-20020a81ac28000000b0053655e52eaamr18111377ywh.3.1678517959721; Fri, 10
 Mar 2023 22:59:19 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:50 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-11-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 10/13] perf build: Switch libpfm4 to opt-out rather than opt-in
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

If libpfm4 passes the feature test, it would be nice to have it
enabled rather than also requiring the LIBPFM4=1 build flag.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 3 +--
 tools/perf/Makefile.perf   | 2 +-
 tools/perf/tests/make      | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fdeca45cf15f..9754218bd418 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1130,7 +1130,7 @@ ifdef LIBCLANGLLVM
   endif
 endif
 
-ifdef LIBPFM4
+ifndef NO_LIBPFM4
   $(call feature_check,libpfm4)
   ifeq ($(feature-libpfm4), 1)
     CFLAGS += -DHAVE_LIBPFM
@@ -1139,7 +1139,6 @@ ifdef LIBPFM4
     $(call detected,CONFIG_LIBPFM4)
   else
     msg := $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev);
-    NO_LIBPFM4 := 1
   endif
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a35bc995d5d8..3e06915f6bd0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -122,7 +122,7 @@ include ../scripts/utilities.mak
 # generated from the kernel .tbl or unistd.h files and use, if available, libaudit
 # for doing the conversions to/from strings/id.
 #
-# Define LIBPFM4 to enable libpfm4 events extension.
+# Define NO_LIBPFM4 to disable libpfm4 events extension.
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
 #
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c2f74ed43418..47c665659022 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -94,7 +94,7 @@ make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_syscall_tbl := NO_SYSCALL_TABLE=1
 make_with_clangllvm := LIBCLANGLLVM=1
-make_with_libpfm4   := LIBPFM4=1
+make_no_libpfm4     := NO_LIBPFM4=1
 make_with_gtk2      := GTK2=1
 make_tags           := tags
 make_cscope         := cscope
@@ -161,7 +161,7 @@ run += make_no_syscall_tbl
 run += make_with_babeltrace
 run += make_with_coresight
 run += make_with_clangllvm
-run += make_with_libpfm4
+run += make_no_libpfm4
 run += make_help
 run += make_doc
 run += make_perf_o
-- 
2.40.0.rc1.284.g88254d51c5-goog

