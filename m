Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557A9C61DA4
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Mar 2023 06:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCKG6X (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 01:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCKG6Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 01:58:16 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B521E5D9
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536be78056eso76645757b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Mar 2023 22:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517894;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwwywuV0dZU1czvMnaqVuf21dNJ0Sgzpp/JikcaGwIM=;
        b=iyrOLKNXgp5pumM5DPnUpRoFROT7RshhOsI0yeo95KWRoGMdlcNQFCDjSYJF/fd4gd
         7hu12qdHoHdYgm5zqyEXci3bfX0dydaKiArEDp0hM+neBf5ZBCosEv8IMARvBPjkqvmb
         yyD03otq1Y3WrtRW1ipFvMJEFdzz4bTnUoWXEjLsUOaY2TTFbdm4WovCLsZ2ZMDxdDWx
         ahYVziJPegDQKv0SeE+vgbJ/BrG1XcS0IJjpZIdltdzjzWegZRCUU4PBAwH//URFsDzl
         qYjgfQT96MzCh+0XPNa8h0mKffrqvjZKoqCnZjWCb3uAKrC7+1bdEynScYjzx9wmJgNd
         WA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517894;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwwywuV0dZU1czvMnaqVuf21dNJ0Sgzpp/JikcaGwIM=;
        b=L1Gt8PMe+jzbpVjIM4Rt5oFWIhV1088j9TATkjG1sLjyK06Ueg1D4Nzc2TCkdHcQQY
         PIHp2gdrOyp7Gh4WtvoEpbAy6kfHgNUQ42ipbzO/1oLEXdoYluCpiCoB6rPOu6/bW1ne
         xgn10EPVCp8jL9dd5reOAjJ1uI7d4ATd6rOUKtMPE2wU6Yiz/GpFK1hVRbZumwEcNflu
         bKE6v3CfrjZPTfgoy5A1GWK3xDWYMemW//w8ACx+2gTsDJbAWh5jODqvEJ+r2cFjzx2R
         7U4PtfSl43TlIAkMNCKuKUgMKUxKvJy7oHe4YW8iahXJtc5LqAi3wazLeEchW9XUgEiE
         sgUA==
X-Gm-Message-State: AO0yUKVR09o9Whf69Nq51ULFHBYGSJy411UjECSFpZd8v6JsL6uOSDj/
        nN7LHwqL34q3HjnHr5/Cl7E6gv0JNP05
X-Google-Smtp-Source: AK7set/zGiooCzj2OYBw/Kwkd+hENEaJ42PWysldu6pOmjd3+QpAqaf5IiY56xK1QlQisJb8LjrjQIF7eeVF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a05:6902:251:b0:9f1:6c48:f95f with SMTP id
 k17-20020a056902025100b009f16c48f95fmr6264375ybs.5.1678517894743; Fri, 10 Mar
 2023 22:58:14 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:41 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-2-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 01/13] perf build: Support python/perf.so testing
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

Add a build target to echo the python/perf.so's name from
Makefile.perf. Use it in tests/make so the correct target is built and
tested for.

Fixes: caec54705adb ("perf build: Fix python/perf.so library's name")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 7 +++++--
 tools/perf/tests/make    | 5 +++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bac9272682b7..2fcee585b225 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -647,13 +647,16 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF) $(LIBSUBCMD)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
 
+python_perf_target:
+	@echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	$(Q)$$(:)
 
@@ -1152,7 +1155,7 @@ FORCE:
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
-.PHONY: archheaders
+.PHONY: archheaders python_perf_target
 
 endif # force_fixdep
 
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 009d6efb673c..deb37fb982e9 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -62,10 +62,11 @@ lib = lib
 endif
 
 has = $(shell which $1 2>/dev/null)
+python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{print $$3}')
 
 # standard single make variable specified
 make_clean_all      := clean all
-make_python_perf_so := python/perf.so
+make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
@@ -204,7 +205,7 @@ test_make_doc    := $(test_ok)
 test_make_help_O := $(test_ok)
 test_make_doc_O  := $(test_ok)
 
-test_make_python_perf_so := test -f $(PERF_O)/python/perf.so
+test_make_python_perf_so := test -f $(PERF_O)/$(python_perf_so)
 
 test_make_perf_o           := test -f $(PERF_O)/perf.o
 test_make_util_map_o       := test -f $(PERF_O)/util/map.o
-- 
2.40.0.rc1.284.g88254d51c5-goog

