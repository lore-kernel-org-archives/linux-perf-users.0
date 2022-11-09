Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0618C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 18:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKIStt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKIStq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5815734
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 10:49:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h4-20020a5b02c4000000b006bc192d672bso17634181ybp.22
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 10:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05tcS3sAQNNzElcGvhYcBZhblO5ft3NSeZEHHXzfROg=;
        b=FrfJDilUGgqEU/9xZ+Sx8LJdZL5uNGHCI2s8HC7ZCFe709f+PQu2+EUpf7+hVKuye/
         c8mNJ8oEOMdgrGrCmMK7Yogk0cFIeax8K4SVFScGSYN+5uM/gxzjJWykyEv7IO1Erb7G
         oY3CkH1dU1SBAxSogNxpJq8MaD/fREJrv4LGWTr2fOVfIUCmu7Aidpvfj0Yt453x+n1P
         60wOo9fn3505b90GaT6vLmhfwGihiU03pR6pNi1Hw63c9YQ5QjPZYPPKflBa0yqm8g7l
         bSk2VA9zIDYZwCREZCRpMLDsYX15xZXt72ROcOSt3pNfspfwAePUifyKmJDtl/TXimBc
         vJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05tcS3sAQNNzElcGvhYcBZhblO5ft3NSeZEHHXzfROg=;
        b=CsB0lh1qBQ3P3tRSBlCdqnKtt72JezDAR+nSThaVsqCLPvEwLWuDgYtV0cGWFSKNZX
         vPt7ELzUkYjqie35Xw2+sltH2c5MumvsTYWJJ882XxIj64uOdd+Q9P601IB8aOxkiMAu
         n2Av7zHA4mqJDhIeNpmAhpqvsspRbQDn9sMIr7XwlAWw7ERBA97jhSG/KIJGjSZD3+EJ
         +4fyNXL3X1XcNXJ+yOjxe5UixtCWtN46RTRocVEvslSY45DFsnWvn63STF+EkW5XgS5a
         uKbmKoqMN3gKjqAez8Y7yPmMSr5yFraJdQEgIuVVpl9tvNEZe62MTZ1zQzN47/JpnXY4
         AlyQ==
X-Gm-Message-State: ACrzQf15Ggbgmh5N3LdEI7FOoBpNG0OUpZIy4VJXBF5i+Rwn8EDIiqik
        P/cGN5gHV497tGu5VX6Dd+ViceDEpIoU
X-Google-Smtp-Source: AMsMyM4LuD0xOiXFa9VTn835MwJvnx4tty3fk6NsDMzkkxI/Oa7orJu46gG+n077o2x4ODuIFKZ5ACHUDA0U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:ab33:0:b0:6be:a6ab:6955 with SMTP id
 u48-20020a25ab33000000b006bea6ab6955mr1110559ybi.230.1668019782047; Wed, 09
 Nov 2022 10:49:42 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:02 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-3-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 02/14] tools lib subcmd: Add install target
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This allows libsubcmd to be installed as a dependency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/Makefile | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 8f1a09cdfd17..e96566f8991c 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -17,6 +17,15 @@ RM = rm -f
 
 MAKEFLAGS += --no-print-directory
 
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
 LIBFILE = $(OUTPUT)libsubcmd.a
 
 CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
@@ -48,6 +57,18 @@ CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+
 all:
 
 export srctree OUTPUT CC LD CFLAGS V
@@ -61,6 +82,34 @@ $(SUBCMD_IN): FORCE
 $(LIBFILE): $(SUBCMD_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(SUBCMD_IN)
 
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: $(LIBFILE)
+	$(call QUIET_INSTALL, $(LIBFILE)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,help.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,pager.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,parse-options.h,$(prefix)/include/subcmd,644); \
+		$(call do_install,run-command.h,$(prefix)/include/subcmd,644);
+
+install: install_lib install_headers
+
 clean:
 	$(call QUIET_CLEAN, libsubcmd) $(RM) $(LIBFILE); \
 	find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
-- 
2.38.1.431.g37b22c650d-goog

