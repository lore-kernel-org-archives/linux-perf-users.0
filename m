Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4B7C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 07:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiKHHg3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiKHHgT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1B286C2
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Nov 2022 23:36:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349423f04dbso130629017b3.13
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Nov 2022 23:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt5L+rcJ0Z3Ar+COVpIl3YNXFFBBoIXGGhEqR9zS/0U=;
        b=chNIMMdiDfMy5AFaiiwEmi96C6LP4lDlTQ0vLia+gfqQJa8XcilCoy7OAAxAr73IyS
         92fbIJgdfUtPDqbqVNRnC++Qg93iYiUiwWNDc9Lkon3KU57Rl9oTJcinnyHtWmkGSlHZ
         OGFHFMY4/SpoHv0CYVaIk1rB6mV7cFNuM11HmIcVzqPGNHPZppiMTxkPqNXmmbqd9GZ6
         mye1GKOqEv2+kESltdGarNVEabgNhp8wy/eOPCrlJqjt8e6SdhywZ3FFM4h/nPs3yjuT
         WtkoQ2bGINEoWNEYHsQ/R9XMBNKDwoiEHLFnajWOXcdvic4S+n/Sk3ZB9IP0uCLjEDD/
         cjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt5L+rcJ0Z3Ar+COVpIl3YNXFFBBoIXGGhEqR9zS/0U=;
        b=y3pbjiMryd4uxcqaT98Ine1FY+KKxQqT/WMysnQxNBcIhpX4fqVLsEyKznlKIEDNSa
         OwqqEx36oD2LIq4F6oO44JCuHT67TTLMq5ANvzKuX/k8kNdThxhdYU3fCqxzA/MMi6Oz
         nlpNritc65KNWuzVHXpZ1woI7p0yfXoWxh/kyct8rOLl+JAhs3FUNk04YKWK9Bq/r4DE
         DQAk2BCMQ3NuNC29xqVZd2Ju+sx/gAkDkQbuk/SQU3pI1P8l1C5WWwZGgRD64ivbkcrP
         5xJqPPtQPFtR+hvIpOe+7XoLo7dJ6QSiVQ0YSGYFlLaHwT9rylCQGYDAB0tyofmht69o
         vy6A==
X-Gm-Message-State: ACrzQf1tKwZhfyV1OrDXX66B5LorWF+DNhe+uxzTsXuC8f+BHEhQXQRg
        Bh6ewb9FT/7M4BTv+pvlpVqXzs05yuth
X-Google-Smtp-Source: AMsMyM4I2RS90/1ju5gkN/dUwm1nTMwN/H4iL3st65/znxM/2vYkQFhzaZN2JJbjJhNhhuyK2Q8RdQilR85G
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a25:bd47:0:b0:6cc:c5e:f831 with SMTP id
 p7-20020a25bd47000000b006cc0c5ef831mr53947958ybm.432.1667892978082; Mon, 07
 Nov 2022 23:36:18 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:10 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-7-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 06/14] perf build: Install libtraceevent locally when building
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
index 5a2a3c4f045d..537ac7055a35 100644
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
@@ -1065,6 +1079,11 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
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
@@ -1107,7 +1126,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean libtraceevent_plugins-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
-- 
2.38.1.431.g37b22c650d-goog

