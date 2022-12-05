Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D62C47089
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Dec 2022 23:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiLEXA5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiLEXAr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Dec 2022 18:00:47 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24D1EAE0
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Dec 2022 15:00:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3c2837e751fso135968687b3.15
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Dec 2022 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29cYpp0Ewjs+gzHUrxa4ZZynn8ecl1yz6sJ+mMKI1iY=;
        b=dqkx3dA8M0NS4ER0/zeH9vkBKGWQA2qFb96pbTe+HXR6K5Bma3er6/Rye2j+T83NJh
         /0hrvbMHcozNXhfKwmXHN4cX4i806/ymuNMuJudRJSgQHlBN1OOcxQcNjm3gg3DnIfAJ
         3ApwLjyxTABgKG3eGbIfOqEUsgF2yHh3zY41Hzao63Ms3damiiKD58QcXXRdZTGXQdKv
         JQ4/H/qq8eTcEdVBmTGQM6CaprOBkOgjxQ3PukxoWJ2+8Q2C21Zs6l/pmeEsvx+apBmE
         A5qUGbzJjYfRGGWvzGeV04FgJ2q28hKVfaxkKf5NY8et2/ZuqGHzJUVMgv618bH+VH8R
         Z8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29cYpp0Ewjs+gzHUrxa4ZZynn8ecl1yz6sJ+mMKI1iY=;
        b=PRhz0w7wae32c3vBd3AuClv3rtZwah9MquQ2HvkD2KG/cJrrQ8xrwqf5oGF1b0LoS5
         u8SaPIYaa0g2PcRPvOm+6u6t85hFpJXCiZSNac2DTIUpV5Rncs+VlxyFAslRvEozmpDt
         csHoKTSBdd39ihgySsJ0fGDqac/Xdonp/gVHTJT6LYHrcBILhVssKgrmd/x1f2uLUuA1
         Ux/U8mYMRpE3CNztgpqkZbliOxxrzLyI6/4Cu1vD/i4ZMcWNd1RE6E23aEWzN9OEQZx6
         gcGME2nr+nEY1Qskbq1deFgofc7lwil9gVrlAGHZ95wbI/DWOt2SoQyKEK5oAGI4/obU
         CJIw==
X-Gm-Message-State: ANoB5pl1zO0MTbKeEVYMYmURF/ztPEO9hgHhh+gN8yEzuG0I0NoF8uXK
        lXKXyJkDsrUrHDQO3C82sVBrEuK6+kAJ
X-Google-Smtp-Source: AA0mqf4B9f2CkgsFsBObCG8SX92pN+WkJJT00KkEcVBC93nZPIyGaYd1Bl5QMGXw876c8d0tKTX669flR8QZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d2ab:5fbb:e81a:9151])
 (user=irogers job=sendgmr) by 2002:a25:a290:0:b0:6fe:efb3:2e29 with SMTP id
 c16-20020a25a290000000b006feefb32e29mr11389698ybi.616.1670281243531; Mon, 05
 Dec 2022 15:00:43 -0800 (PST)
Date:   Mon,  5 Dec 2022 14:59:40 -0800
In-Reply-To: <20221205225940.3079667-1-irogers@google.com>
Message-Id: <20221205225940.3079667-4-irogers@google.com>
Mime-Version: 1.0
References: <20221205225940.3079667-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 3/3] perf build: Fix python/perf.so library's name
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since Python 3.3 extensions have a suffix encoding platform and
version information. For example, the perf extension was previously
perf.so but now maybe perf.cpython-310-x86_64-linux-gnu.so. Compute
the extension using Python and then use this in the target name. Doing
this avoids the "perf.so" target always being rebuilt.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 +++-
 tools/perf/Makefile.perf   | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b34288cb1900..ede04e07e9cb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -871,6 +871,7 @@ define disable-python_code
   NO_LIBPYTHON := 1
 endef
 
+PYTHON_EXTENSION_SUFFIX := '.so'
 ifdef NO_LIBPYTHON
   $(call disable-python,Python support disabled by user)
 else
@@ -889,7 +890,8 @@ else
       else
          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
          EXTLIBS += $(PYTHON_EMBED_LIBADD)
-         LANG_BINDINGS += $(obj-perf)python/perf.so
+         PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
+         LANG_BINDINGS += $(obj-perf)python/perf$(PYTHON_EXTENSION_SUFFIX)
          CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
       endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f0e4daeef812..869856bdfdc9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -642,7 +642,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

