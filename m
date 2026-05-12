Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B513BED24
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564169; cv=none; b=pPY7OROBBQaEMHfD1hILFJ0PswV7drLuXG+N3Y9byU1uwTcMqZGFtbFYkxb+jpyBtPy0+kc/4TPLZCYydirXkDkbT57SwZnZTEEdxb66/Z6Db1mbKz6Nb80XZmimQgE80BbRtz/m2O1RbMB4BwL9bOB47aFLJ+s1pZopSzDJ2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564169; c=relaxed/simple;
	bh=VxjcUxSsLSfsFXeIhnp/GYb9CrFTlZkvQfyNK9xwFus=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SoqaIYLTZx7aYPnC3kQ8DZ1sQqPhlg5obs7SLWC4yvfDYXdYYVpD40pKQp606HeKaOrYoucOUoaUNEgEUL26A/KxoTGsyA4Ss81UricPnuqJDeWZGL/G5h32mLodxCAIqMJNblDEQ+0aBVwf6jh+iU30dngedD5mP+1vYqjV3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzMSnTaN; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzMSnTaN"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d631edaaso11163547c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564163; x=1779168963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3sCs1mxWjVxvkd7ZNQav4e6xlAEleXdzpcL9J1uLpjQ=;
        b=JzMSnTaNhEkYMtoQyag2cYh0hxIBHp8praRwwOv0/f7jcdoygJSzbIcCQ+UnuvSfxN
         3FbAII2IfWTohMATnzVnwApcQEOmZ3TNwgAd6dkiQrIOmF3gzOkTfP3VCHRElIPKXuMo
         7gXgOSfdldmT71aP7DKrbock0KSPfdvf2kUz/Mde3UonHRDY7tvsuGWX15+WkbGtZXQl
         J0RghzxMHXAm0yCVkl/JL0yjllDCNSEGt6BOHRsLYdlsLyMcS4g4N04hHfgEWw0jkcLX
         5EDTOEhW1vxdUhHUvdlNsmVI+w8GCmJoggwRJrBjIY5jQ7fQr8t9nUXXduy4kVvG1KIw
         rQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564163; x=1779168963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sCs1mxWjVxvkd7ZNQav4e6xlAEleXdzpcL9J1uLpjQ=;
        b=NGz/MhOySgKwo0LEp/jgCu3DCcCNo7Zu25uGgKBtQJkVGv5TnHG6uu/l5tSIxqYg01
         wrXk2AvDu89xgdoh34DAcWTpxcTAzhgrg4V33tv0H+Pofz/ureJ0iwvQVyTnwcByYV0o
         utoK7gpkKmMwb5tzzsl+c3zaOEwFOufkZ4TAsHwBzpGM3TIiIbOJFn6fXI3lJx8tNabV
         3TPEva0mHu2aOMuqa+2PJsXepr7UcRYbiOs8Cx5ooBKsBBQ412xeG5cDMqR9zhl4+7Lg
         4/d0ppkKWNnVT1fIx8cXj2zedbqC0opAoNBfKkfLc52nXN4pHJWNC94BK7rrehrrrD0H
         AKsA==
X-Forwarded-Encrypted: i=1; AFNElJ/TvPzUOwwhf4pLtKlcSki9FIyvQkoDMexekMvyOu9xQwqLh7XDHauZKluKZK6cltOTFGPOUAz0gVQ0x4jvOBs/@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZAh9YmF6fg5e5JQvmvuAZtcLCr4WD8rug+CJug7rlNMcT/UH
	KrLBGpnL1KbG1b5+lHTB8u+X8ZRpATRGsU87zV6BRDqNdKi06Jo8BLpT3290BGwWKgms/oMrYYD
	U8ezL/MmX9g==
X-Received: from dldz1-n2.prod.google.com ([2002:a05:701b:4181:20b0:12d:bafb:54f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:523:b0:119:e56b:958a
 with SMTP id a92af1059eb24-132a7aef0cdmr6510597c88.15.1778564162653; Mon, 11
 May 2026 22:36:02 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:31 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-7-irogers@google.com>
Subject: [PATCH v1 06/14] perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, bpftool and vmlinux.h are prerequisites of the top-level
prepare target in Makefile.perf. This unnecessarily blocks the massive
parallel C compilation of libraries (perf-util, perf-ui, pmu-events) during
the initial startup phase.

Move all bpftool and vmlinux.h generation rules down into
tools/perf/bpf_skel.mak to encapsulate BPF tooling completely within the
skeleton framework. Remove them entirely from prepare to unblock immediate
parallel build execution.

To prevent parallel sub-makes (perf-util and perf-bench) from racing to
build shared prerequisites concurrently, while maintaining strict directory
encapsulation without top-level inclusions, serialize bench after the util
static archive finishes using an order-only prerequisite:
  $(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config |  2 +-
 tools/perf/Makefile.perf   | 61 +++++---------------------------------
 tools/perf/bpf_skel.mak    | 47 +++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 06d7a3f9990c..bc1111c88226 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -736,7 +736,7 @@ ifeq ($(BUILD_BPF_SKEL),1)
 endif
 
 ifndef GEN_VMLINUX_H
-  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
+  VMLINUX_H_FILE=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
 endif
 
 dwarf-post-unwind := 1
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d4fc10f36781..ec0e91bedce1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -274,7 +274,7 @@ ifeq ($(PYLINT),1)
   PYLINT := $(shell which pylint 2> /dev/null)
 endif
 
-export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF
+export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF READELF
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include
@@ -324,7 +324,7 @@ else
 FEATURE_DUMP_EXPORT := $(realpath $(FEATURES_DUMP))
 endif
 
-export prefix bindir sharedir sysconfdir DESTDIR
+export prefix bindir sharedir sysconfdir DESTDIR VMLINUX_H_FILE
 
 # sparse is architecture-neutral, which means that we need to tell it
 # explicitly what architecture to check for. Fix this up for yours..
@@ -556,7 +556,9 @@ $(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
 $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_BENCH_IN): FORCE prepare
+# The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
+# aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
+$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -911,60 +913,11 @@ $(INSTALL_DOC_TARGETS):
 python-clean:
 	$(python-clean)
 
-SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
-SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
-
-$(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
+$(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
-ifeq ($(CONFIG_PERF_BPF_SKEL),y)
-prepare: $(BPFTOOL) $(SKEL_OUT)/vmlinux.h
-BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
-
-$(BPFTOOL): | $(SKEL_TMP_OUT)
-	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
-		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
-
-# Paths to search for a kernel to generate vmlinux.h from.
-VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
-		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
-		     ../../vmlinux					\
-		     /boot/vmlinux-$(shell uname -r)
-
-# Paths to BTF information.
-VMLINUX_BTF_BTF_PATHS ?= /sys/kernel/btf/vmlinux
-
-# Filter out kernels that don't exist or without a BTF section.
-VMLINUX_BTF_ELF_ABSPATHS ?= $(abspath $(wildcard $(VMLINUX_BTF_ELF_PATHS)))
-VMLINUX_BTF_PATHS ?= $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS); \
-			do \
-				if [ -f $$file ] && ($(READELF) -S "$$file" | grep -q .BTF); \
-				then \
-					echo "$$file"; \
-				fi; \
-			done) \
-			$(wildcard $(VMLINUX_BTF_BTF_PATHS))
-
-# Select the first as the source of vmlinux.h.
-VMLINUX_BTF ?= $(firstword $(VMLINUX_BTF_PATHS))
-
-ifeq ($(VMLINUX_H),)
-  ifeq ($(VMLINUX_BTF),)
-    $(error Missing bpftool input for generating vmlinux.h)
-  endif
-endif
-
-$(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) $(VMLINUX_H)
-ifeq ($(VMLINUX_H),)
-	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
-else
-	$(Q)cp "$(VMLINUX_H)" $@
-endif
-
-endif # CONFIG_PERF_BPF_SKEL
-
 bpf-skel-clean:
-	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKEL_OUT)/*.skel.h $(SKEL_OUT)/vmlinux.h $(OUTPUT)bench/bpf_skel/*.skel.h
+	$(Q)$(MAKE) -f bpf_skel.mak clean
 
 pmu-events-clean:
 ifeq ($(OUTPUT),)
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index bcb704d5af32..ded578b9570c 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -36,6 +36,47 @@ ifneq ($(WERROR),0)
   CLANG_OPTIONS += -Werror
 endif
 
+$(BPFTOOL):
+	$(Q)mkdir -p $(SKEL_TOOL_TMP_OUT)
+	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TOOL_TMP_OUT)/ bootstrap
+
+# Paths to search for a kernel to generate vmlinux.h from.
+VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../vmlinux					\
+		     /boot/vmlinux-$(shell uname -r)
+
+# Paths to BTF information.
+VMLINUX_BTF_BTF_PATHS ?= /sys/kernel/btf/vmlinux
+
+# Filter out kernels that don't exist or without a BTF section.
+VMLINUX_BTF_ELF_ABSPATHS ?= $(abspath $(wildcard $(VMLINUX_BTF_ELF_PATHS)))
+VMLINUX_BTF_PATHS ?= $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS); \
+			do \
+				if [ -f $$file ] && ($(READELF) -S "$$file" | grep -q .BTF); \
+				then \
+					echo "$$file"; \
+				fi; \
+			done) \
+			$(wildcard $(VMLINUX_BTF_BTF_PATHS))
+
+# Select the first as the source of vmlinux.h.
+VMLINUX_BTF ?= $(firstword $(VMLINUX_BTF_PATHS))
+
+ifeq ($(VMLINUX_H_FILE),)
+  ifeq ($(VMLINUX_BTF),)
+    $(error Missing bpftool input for generating vmlinux.h)
+  endif
+endif
+
+$(VMLINUX_H): $(VMLINUX_BTF) $(BPFTOOL) $(VMLINUX_H_FILE)
+	$(call rule_mkdir)
+ifeq ($(VMLINUX_H_FILE),)
+	$(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
+else
+	$(Q)cp "$(VMLINUX_H_FILE)" $@
+endif
+
 # Consolidated Pattern rule for $(dir)/bpf_skel/
 $(SKEL_TMP_OUT)/%.bpf.o: $(srctree)/tools/perf/$(dir)/bpf_skel/%.bpf.c $(LIBBPF) $(VMLINUX_H) $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h
 	$(call rule_mkdir)
@@ -52,4 +93,10 @@ $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(BPFTOOL)
 	$(Q)$(BPFTOOL) gen skeleton $< > $@
 
 .PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
+
 endif # CONFIG_PERF_BPF_SKEL
+
+clean:
+	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TOOL_TMP_OUT) $(OUTPUT)bench/bpf_skel/.tmp $(SKEL_TOOL_OUT)/*.skel.h $(OUTPUT)bench/bpf_skel/*.skel.h $(SKEL_TOOL_OUT)/vmlinux.h
+
+.PHONY: clean
-- 
2.54.0.563.g4f69b47b94-goog

