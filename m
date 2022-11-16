Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B35C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 22:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiKPWqS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiKPWp4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 17:45:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEB56CA31
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 14:45:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f71-20020a25384a000000b006dd7876e98eso16006585yba.15
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 14:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fahfTN7gQdYGghMf/BqQFGqnV5aYRbsgDQfX2spz1M=;
        b=J7ejO2+4pPwjvYasRYxGqprxcZToIIQir/+zCv8XJOXAMoIEz5oHnj13Y8NijHrFhl
         omJb9OhW/gqGpL1NLmRkpbxYcnrraM5LGPZJwFksGnOgQ/DzMb5BTrVy7kM1SmnB7TOZ
         ochF4Ipzbw6mYxgQRV+7WVG35O5xbVpFHMM+lIfNW2uizI14ZHcnEN6muh/uPbnLch2U
         wUcrjLJXXvi1Rf2bjwAzb608dtEh7Nn3O+4LPDUG0pKk52Bx7ZPJeXV6kxRD5SRH/AiW
         37sWLNgegGpwsAPiqmGDEPYburNB4KofqnCAOFjBpivk2rXIBmw7axJX5G0D+ZbvwZ0p
         z1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fahfTN7gQdYGghMf/BqQFGqnV5aYRbsgDQfX2spz1M=;
        b=GB0y55gncn3pgYWQIVD5FyfATFCEv50j3P1hVVeF7RpZZztxZElz04mYOedmFs3XLl
         7bb9zRNFAY95LG4kS6/wK8FH7NqVWo96ZoaKXOYKkqu4zOwfZYbV6jwi2opcA0ghQM4f
         +0buj2yoXAKpUwbYx7LryX3uz7FfHtYw/DhbShzSrvB+PdaHAnU5R8cE3jUUtIsUX1Kq
         bhPnepd2/DvgCi7Ylfv7IQkTYbs1kfZj2xVfv88HX67GHx6VM6cox/YOC6lk2X5aocjV
         YkCba2I+ot1U0b2HlbtBwhrLUuau7dIz5SPsXKzVNNcpIDehCfIxsVl5c+SswAgM2yb4
         uCFg==
X-Gm-Message-State: ANoB5plWJ35qSiXH7l9bDP890ee+uZR3lBDh1f1sFyhQitNYDfTGYXXo
        qj9DLuBPIqO7tb6lUqvMDvYltfFzwdzX
X-Google-Smtp-Source: AA0mqf4Nb9ngGN3qX4fMKqqiImwtvR4v0w2iedkDOCXier2Uk2gOkfn2P+l1BjX+RTvpu1mgdn+Sr0cKx7BR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a25:55d4:0:b0:6ca:363a:9a1b with SMTP id
 j203-20020a2555d4000000b006ca363a9a1bmr23754825ybb.1.1668638730427; Wed, 16
 Nov 2022 14:45:30 -0800 (PST)
Date:   Wed, 16 Nov 2022 14:45:11 -0800
Message-Id: <20221116224511.207235-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH] perf build: Fix LIBTRACEEVENT_DYNAMIC
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

The tools/lib includes fixes break LIBTRACEVENT_DYNAMIC as the
makefile erroneously had depdendencies on building libtraceevent even
when not linking with it. This change fixes the issues with
LIBTRACEEVENT_DYNAMIC by making the built files optional.
---
 tools/perf/Makefile.perf | 25 ++++++++++++++++++++++---
 tools/perf/util/setup.py |  3 ++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index dd096aba4430..59c4e8f9b014 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -242,8 +242,10 @@ sub-make: fixdep
 else # force_fixdep
 
 LIBAPI_DIR      = $(srctree)/tools/lib/api/
+ifndef LIBTRACEEVENT_DYNAMIC
 LIBTRACEEVENT_DIR = $(srctree)/tools/lib/traceevent/
 LIBTRACEEVENT_PLUGINS_DIR = $(LIBTRACEEVENT_DIR)/plugins
+endif
 LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
 LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
 LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
@@ -293,6 +295,7 @@ SCRIPT_SH += perf-iostat.sh
 grep-libs = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
 
+ifndef LIBTRACEEVENT_DYNAMIC
 ifneq ($(OUTPUT),)
   LIBTRACEEVENT_OUTPUT = $(abspath $(OUTPUT))/libtraceevent
 else
@@ -306,13 +309,16 @@ LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
 export LIBTRACEEVENT
 LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
 CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
-
 #
 # The static build has no dynsym table, so this does not work for
 # static build. Looks like linker starts to scream about that now
 # (in Fedora 26) so we need to switch it off for static build.
 DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
 LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
+else
+LIBTRACEEVENT_DYNAMIC_LIST =
+LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS =
+endif
 
 ifneq ($(OUTPUT),)
   LIBAPI_OUTPUT = $(abspath $(OUTPUT))/libapi
@@ -375,7 +381,11 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
 python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
 
 PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
+ifndef LIBTRACEEVENT_DYNAMIC
 PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT) $(LIBAPI)
+else
+PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
+endif
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
 
@@ -785,9 +795,12 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
 	$(LIBSYMBOL) \
-	$(LIBTRACEEVENT) \
 	bpf-skel
 
+ifndef LIBTRACEEVENT_DYNAMIC
+prepare: $(LIBTRACEEVENT)
+endif
+
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
@@ -843,6 +856,7 @@ endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
+ifndef LIBTRACEEVENT_DYNAMIC
 LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(filter-out -static,$(LDFLAGS))'
 
 $(LIBTRACEEVENT): FORCE | $(LIBTRACEEVENT_OUTPUT)
@@ -872,6 +886,7 @@ install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
 		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
 		$(LIBTRACEEVENT_FLAGS) install
+endif
 
 $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
@@ -1152,7 +1167,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
+clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
@@ -1192,6 +1207,10 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 	$(call QUIET_CLEAN, Documentation) \
 	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
 
+ifndef LIBTRACEEVENT_DYNAMIC
+clean:: $(LIBTRACEEVENT)-clean libtraceevent_plugins-clean
+endif
+
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
 # file if defined, with no further action.
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 5b1e6468d5e8..43e7ca40b2ec 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -77,7 +77,8 @@ perf = Extension('perf',
 		  include_dirs = ['util/include'],
 		  libraries = extra_libraries,
 		  extra_compile_args = cflags,
-		  extra_objects = [libtraceevent, libapikfs, libperf],
+		  extra_objects = [ x for x in [libtraceevent, libapikfs, libperf]
+                                    if x is not None],
                  )
 
 setup(name='perf',
-- 
2.38.1.431.g37b22c650d-goog

