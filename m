Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B16C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1200A61381
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbhKHNk2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:40:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235351AbhKHNk1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIGumL/EcdNbxsIXcI8yCffKn2ZKfy5+5KT1yt3I5BI=;
        b=NHiM65Qha/hc/QaJBqZqBqcPPbXUtG3VVILxcnjJk3QKXY31e6xVtkLQD5epOx0KjtkcQ5
        mHSDrFGkSsUfM4kgnLOZ0XChud6Wyjk69Qacygvdea7F7luKhlDUZo+LOtgR9JP3GM6M/z
        osso7Ybrazd5ByimPtbEEs9ZmFjZXaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-SprqDJQWOzyRrM1Av8Vxow-1; Mon, 08 Nov 2021 08:37:41 -0500
X-MC-Unique: SprqDJQWOzyRrM1Av8Vxow-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso4048319wrj.12
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIGumL/EcdNbxsIXcI8yCffKn2ZKfy5+5KT1yt3I5BI=;
        b=aZ2s5rHfq69Ke+huDVldBvE9E5plwYGmSS/y6yhw3++vMKDqM/zJcWkwnqP/fcb9DC
         qJml8o4GD28PBbjmnb99bwbhId5oMV0pOUVeGTpVkWUDufMPNOULoeUi4vpoaPYEoNxo
         YzZAQXtKPQ1LokaoKNCTqpmwK95F/vtxWteFFl3tvR5xDoIiRBE7R/jqyIhhR6ii69wP
         LD5/0jjMfAH8UnWtlgAZ0FoPgcwjAdLnU21RWvmX2RK2nfVFUYea5zPiRT8oN5fvaOmc
         TtD+geJtr9mgwM72gvUdn2/6kyzTY6M0Mg4nqNlVnuWQ8yJ7Sdzxth/nBeJRHMSo94Tg
         NnPA==
X-Gm-Message-State: AOAM530G5+ZTKI7/Zb7cP4EjjUL8snhOZtIweUfIY69oJqVq1UmtzwnY
        FxBIzU1werGTwV3s6Cd7FxlR28tco2nm3W+Wqhr+sWDBrme086ZerEYzocM9nxoTGYAYMMSGd/E
        QTZW8l/g+buvV3Bf8gXSgKzToFTOPsw==
X-Received: by 2002:a5d:6b04:: with SMTP id v4mr101720805wrw.148.1636378660241;
        Mon, 08 Nov 2021 05:37:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwe6a4/4aSMjTNKUIa6RSvX4jV1Jm6XvSImrIS3uWCyVyjKs3mLp3QHX+5My4pJwkYKdEqIxw==
X-Received: by 2002:a5d:6b04:: with SMTP id v4mr101720783wrw.148.1636378660097;
        Mon, 08 Nov 2021 05:37:40 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t127sm20479900wma.9.2021.11.08.05.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:37:39 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 03/59] libperf: Move pmu-events build to libperf
Date:   Mon,  8 Nov 2021 14:36:14 +0100
Message-Id: <20211108133710.1352822-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving the compilation of pmu-events under libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Makefile  | 33 +++++++++++++++++++++++++++++----
 tools/perf/Makefile.perf | 22 +++-------------------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 08fe6e3c4089..a7a919fb9e62 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -7,6 +7,12 @@ LIBPERF_EXTRAVERSION = 1
 
 MAKEFLAGS += --no-print-directory
 
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+.SUFFIXES:
+
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
@@ -80,6 +86,8 @@ all:
 
 export srctree OUTPUT CC LD CFLAGS V
 export DESTDIR DESTDIR_SQ
+export HOSTCC HOSTLD HOSTAR
+export SRCARCH
 
 include $(srctree)/tools/build/Makefile.include
 
@@ -111,6 +119,22 @@ endif
 LIBAPI = $(API_PATH)libapi.a
 export LIBAPI
 
+JEVENTS    := $(OUTPUT)pmu-events/jevents
+JEVENTS_IN := $(OUTPUT)pmu-events/jevents-in.o
+
+export JEVENTS
+
+PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+
+$(JEVENTS_IN): FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=jevents
+
+$(JEVENTS): $(JEVENTS_IN)
+	$(QUIET_LINK)$(HOSTCC) $(JEVENTS_IN) -o $@
+
+$(PMU_EVENTS_IN): $(JEVENTS) FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
+
 $(LIBAPI): FORCE
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
 
@@ -121,10 +145,10 @@ $(LIBAPI)-clean:
 $(LIBPERF_IN): FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
-$(LIBPERF_A): $(LIBPERF_IN)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
+$(LIBPERF_A): $(LIBPERF_IN) $(PMU_EVENTS_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
-$(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI)
+$(LIBPERF_SO): $(LIBPERF_IN) $(LIBAPI) $(PMU_EVENTS_IN)
 	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so \
                                     -Wl,--version-script=$(VERSION_SCRIPT) $^ -o $@
 	@ln -sf $(@F) $(OUTPUT)libperf.so
@@ -139,7 +163,8 @@ all: fixdep
 clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
                 *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBPERF_VERSION) .*.d .*.cmd tests/*.o LIBPERF-CFLAGS $(LIBPERF_PC) \
-                $(TESTS_STATIC) $(TESTS_SHARED)
+                $(TESTS_STATIC) $(TESTS_SHARED) \
+                $(OUTPUT)pmu-events/pmu-events.c $(OUTPUT)pmu-events/jevents
 
 TESTS_IN = tests-in.o
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a3966f290297..6d10996388b4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -647,30 +647,14 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
 
-JEVENTS       := $(OUTPUT)pmu-events/jevents
-JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
-
-PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
-
-export JEVENTS
-
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(JEVENTS_IN): FORCE
-	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=jevents
-
-$(JEVENTS): $(JEVENTS_IN)
-	$(QUIET_LINK)$(HOSTCC) $(JEVENTS_IN) -o $@
-
-$(PMU_EVENTS_IN): $(JEVENTS) FORCE
-	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
-
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS) \
-		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
+		$(PERF_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE
 	$(Q)$(MAKE) $(build)=gtk
@@ -1086,7 +1070,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
-	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(OUTPUT)$(LIBJVMTI).so
+	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-- 
2.31.1

