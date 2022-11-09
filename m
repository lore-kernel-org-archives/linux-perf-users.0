Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEB7C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 18:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKIStg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKIStf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 13:49:35 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F6513F20
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 10:49:34 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso1855768pjk.3
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWTS1f0segyhlSbmQWDTAnD8D0Og1YhYgrPvc18rTU=;
        b=h8+HoLUbYhCjId0Y+B244sJvGF1KwrxdyFZTx69OSLbRfEnws6kzRpSaCdTIRDjYnp
         4Piy3y3cJ7wY6F4MjoLW/ZrCko/VItNGisyhAiDlUOLT6Loa+OB7OMvNK9kP6TthCM4+
         81YfXJYk7kVGXTg/7LoouhUv0QE89yJpr3qltAyaS9g2UORODNXSwHeaBLJD6KwtXbHj
         7VEBC7nKz4YtZ4+Dai53TP4wIm937JBC0Hbt0aX56Ivx4y1O/N0s5HAk84haphososiM
         qW8Q7Qj7rkQM7veSWJ/SBAMl+aq+9hLOofy3340Ga92XUKXsL+EXRoDfTTJ99cgyyti3
         ZBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWTS1f0segyhlSbmQWDTAnD8D0Og1YhYgrPvc18rTU=;
        b=Gmwf4YSkaL/Azpmza+AR3Q9rRp3BZnwUA4viwugdaA7lwpnjVMD+06Nd3JSSnTdfuL
         h1BM/SMD01Tsfj6ODv3VW7LuEdo09zOyWMtL3+QcrSyaBUUvR/k2Pfm0aOAhfAsGMDqu
         jQFn84RZUj0b7hYz3JH5g8D95+d0ACpjSeSMExoLvPK5dkkgT4uR75FTgtXI36fpPfQe
         5gahgVPU5tFasdAo2aVhLhW7XoSSh1xPZODYvtPWWfcUnQ3qX4syYaJO399IEFoP8038
         zoUlRKJcfdRqSiLUX/eQlZrHAjt5IDOL7TBJf0UYXRor/JF/izkODBrCKIw6KMxBPfsA
         G0Qg==
X-Gm-Message-State: ACrzQf3CqHwyUIvpWGyicrW0y74jA45/Hy9ZZ5PbKoL+r2GEIyfmK6Yg
        7ya5sVE1CqOMjTCQZh24gCfthR5NZHny
X-Google-Smtp-Source: AMsMyM5xbUA/rskJrvjee/Gig9EwkjMLwfHK7DAHXLoRP2Wt7Pd/WfJSt74tu+vCa0w33TdxjKA8n5JVmqVt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a17:902:9692:b0:186:6180:fb89 with SMTP id
 n18-20020a170902969200b001866180fb89mr1199782plp.142.1668019774263; Wed, 09
 Nov 2022 10:49:34 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:01 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-2-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 01/14] tools lib api: Add install target
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

This allows libapi to be installed as a dependency.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index e21e1b40b525..6629d0fd0130 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -15,6 +15,16 @@ LD ?= $(CROSS_COMPILE)ld
 
 MAKEFLAGS += --no-print-directory
 
+INSTALL = install
+
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
 LIBFILE = $(OUTPUT)libapi.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
@@ -45,10 +55,23 @@ RM = rm -f
 
 API_IN := $(OUTPUT)libapi-in.o
 
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
 include $(srctree)/tools/build/Makefile.include
+include $(srctree)/tools/scripts/Makefile.include
 
 all: fixdep $(LIBFILE)
 
@@ -58,6 +81,32 @@ $(API_IN): FORCE
 $(LIBFILE): $(API_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(API_IN)
 
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
+		$(call do_install,cpu.h,$(prefix)/include/api,644); \
+		$(call do_install,debug.h,$(prefix)/include/api,644); \
+		$(call do_install,io.h,$(prefix)/include/api,644);
+
+install: install_lib install_headers
+
 clean:
 	$(call QUIET_CLEAN, libapi) $(RM) $(LIBFILE); \
 	find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
-- 
2.38.1.431.g37b22c650d-goog

