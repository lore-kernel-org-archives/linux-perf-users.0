Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A44C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Nov 2022 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiKISue (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiKISuT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569F2C66D
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Nov 2022 10:50:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q62-20020a25d941000000b006cac1a4000cso17451063ybg.14
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Nov 2022 10:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRgbCoc/lULFyNJb294eYOHrQbLaJy+ZT5w1IQWAa5I=;
        b=EumB9bc4LH+lOr72gPsmnqZkbUVJvtNqnAVGqcBRzbOPIPb93lyP9xToyLVVrTW3xi
         pE+Cb4RJx8qP+7rA7yW7Lo/U5cfjAW3dN1yaug91A2NmofBdX2kRGhXyoID3tcEjVg3V
         lnwEX8y2VL5Xz3GSosbkHJtAWKZTiqCCH5IZUjJn92jP9Mr+v69xYOxll43mTd2txxGN
         oQVNVy9V/+H0bFD77QGdw8vtLTZMf+Ynbj5kBjTJ+H7JvvJaPeOhhzJyjKdF6V3kvBbK
         irywbIPvvygBGF5IyDes/rIC7V83mRqgk7KoeO+v+1pqCWkWPTXB5X8fdFa7wg1stjV4
         B6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRgbCoc/lULFyNJb294eYOHrQbLaJy+ZT5w1IQWAa5I=;
        b=lVaTJ6BoeslK+6uUyKLNopR0CTta7at19pw+IKYVvzlNN+lz0OKoHs67IVDueqNMFF
         VYj5Q6XijaTcF7Q4tVzB/tKrvquRoGrOGx4/7D375kWphLtX5JaZPG0jV27DE8H77mgB
         khKq10EUjRCK6gQCLiOkYKLLcLq2lo5mh12yZCuVk9U54tP1hUCmfK9N4Gld0MTI9cOu
         8bg36lHhjmk48GPdj0hR3vpgQz9vwnkczifoB7lqAmbrbv1iQQH4kJQK7UkToC8xDntT
         ab1/AxzDBCRQTADh/ftk5pLZwYKBqgYYeAY4Rv59KpMbz0AnuniSHydrq9HNGsiF0Adz
         ZmlA==
X-Gm-Message-State: ACrzQf1+MNdtUU9Cs6DfxngPSBcXIXI5nMm1ol6i8baQyqaxNF/PcLu/
        FqNVIS16/bUAfPYK6uFYlMb833xJVTwN
X-Google-Smtp-Source: AMsMyM6KIdfrpnuXHUD5FvQVfsOL1ei9T1aZnZ6PxsfVWAnlux/l0AOjXJKp4Xtin/4Hi/yL3cr1WxHC4aFw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a5b:6d1:0:b0:6cb:77dc:1cde with SMTP id
 r17-20020a5b06d1000000b006cb77dc1cdemr58509073ybq.447.1668019815231; Wed, 09
 Nov 2022 10:50:15 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:06 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-7-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 06/14] perf build: Install libtraceevent locally when building
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

The perf build currently has a '-Itools/lib' on the CC command
line. This causes issues as the libapi, libsubcmd, libtraceevent,
libbpf headers are all found via this path, making it impossible to
override include behavior. Change the libtraceevent build mirroring
the libbpf, libsubcmd, libapi and libperf build, so that it is
installed in a directory along with its headers. A later change will
modify the include behavior.

Similarly, the plugins are now installed into libtraceevent_plugins
except they have no header files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore    |  3 ++-
 tools/perf/Makefile.perf | 57 ++++++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 43f6621ef05e..65b995159cf1 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -42,6 +42,7 @@ libapi/
 libbpf/
 libperf/
 libsubcmd/
+libtraceevent/
+libtraceevent_plugins/
 fixdep
-libtraceevent-dynamic-list
 Documentation/doc.dep
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 57aec5a97270..6e5e3f7730b5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -242,7 +242,8 @@ sub-make: fixdep
 else # force_fixdep
 
 LIBAPI_DIR      = $(srctree)/tools/lib/api/
-TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
+LIBTRACEEVENT_DIR = $(srctree)/tools/lib/traceevent/
+LIBTRACEEVENT_PLUGINS_DIR = $(LIBTRACEEVENT_DIR)/plugins
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
 LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
@@ -292,16 +293,17 @@ grep-libs = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
 
 ifneq ($(OUTPUT),)
-  TE_PATH=$(OUTPUT)
-  PLUGINS_PATH=$(OUTPUT)
+  LIBTRACEEVENT_OUTPUT = $(abspath $(OUTPUT))/libtraceevent
 else
-  TE_PATH=$(TRACE_EVENT_DIR)
-  PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
+  LIBTRACEEVENT_OUTPUT = $(CURDIR)/libtraceevent
 endif
-
-LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
+LIBTRACEEVENT_PLUGINS_OUTPUT = $(LIBTRACEEVENT_OUTPUT)_plugins
+LIBTRACEEVENT_DESTDIR = $(LIBTRACEEVENT_OUTPUT)
+LIBTRACEEVENT_PLUGINS_DESTDIR = $(LIBTRACEEVENT_PLUGINS_OUTPUT)
+LIBTRACEEVENT_INCLUDE = $(LIBTRACEEVENT_DESTDIR)/include
+LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
 export LIBTRACEEVENT
-LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
+LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
 
 #
 # The static build has no dynsym table, so this does not work for
@@ -821,21 +823,33 @@ $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
 LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(filter-out -static,$(LDFLAGS))'
 
-$(LIBTRACEEVENT): FORCE
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
-
-libtraceevent_plugins: FORCE
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR)plugins $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) plugins
-
-$(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR)plugins $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent-dynamic-list
+$(LIBTRACEEVENT): FORCE | $(LIBTRACEEVENT_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBTRACEEVENT_DIR) O=$(LIBTRACEEVENT_OUTPUT) \
+		DESTDIR=$(LIBTRACEEVENT_DESTDIR) prefix= \
+		$@ install_headers
 
 $(LIBTRACEEVENT)-clean:
 	$(call QUIET_CLEAN, libtraceevent)
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) O=$(OUTPUT) clean >/dev/null
+	$(Q)$(RM) -r -- $(LIBTRACEEVENT_OUTPUT)
+
+libtraceevent_plugins: FORCE | $(LIBTRACEEVENT_PLUGINS_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
+		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
+		plugins
+
+libtraceevent_plugins-clean:
+	$(call QUIET_CLEAN, libtraceevent_plugins)
+	$(Q)$(RM) -r -- $(LIBTRACEEVENT_PLUGINS_OUTPUT)
+
+$(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
+	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
+		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
+		$(LIBTRACEEVENT_FLAGS) $@
 
 install-traceevent-plugins: libtraceevent_plugins
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) install_plugins
+	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
+		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
+		$(LIBTRACEEVENT_FLAGS) install
 
 $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
@@ -1060,6 +1074,11 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
+ifndef LIBTRACEEVENT_DYNAMIC
+$(LIBTRACEEVENT_OUTPUT) $(LIBTRACEEVENT_PLUGINS_OUTPUT):
+	$(Q)$(MKDIR) -p $@
+endif
+
 ifdef BUILD_BPF_SKEL
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
 BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
@@ -1102,7 +1121,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
-- 
2.38.1.431.g37b22c650d-goog

