Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BE3DE44D
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866755; cv=none; b=R8QDbuJ9zG5MXEX1E+aZ2m/dEWB4WkAPLWpA2LlrWlhRb78C8XSQowXDmhwm0rsJoJ/TgivNmNVYy5AvW+xW8AOqahTN/kDsAp4OkPfMu1xzTqVfYIx6vqYQanhQzKsbIhEgoAZ+MHXXmA/ia60X6mpm5ZijHBa10oY/ImHPYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866755; c=relaxed/simple;
	bh=iX/pomdbV09fUUx5qN/QkCwv4mZZgoReI8KSf6RgqUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kCVsE43Hi/ljyaiQOkkcJ8p507of9Z/ETHijO4XxCfpLBcThZBv0vOrH8uDP+HDQYqGwhGq+h2S4NxetGTLkuf0IoHOPTKDCvJE+t3BGMjMnVxhlDGVIZJMPmw7ubs5wiW6UqUZtgq5s261HTMb0x+tSW/s0AtNLIks6jVJAwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQy6d8zB; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQy6d8zB"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee34588671so90406eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866753; x=1779471553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfCl4yhDEQPzWh5om3NIawhO9j1SZgFCQ0pogc9oRc0=;
        b=pQy6d8zBqy/Pfru1Y2VKF6dSANqG/758jopAsDyljB044Wp/OmXA/yMzNoS2QD7Z3n
         6GoYsSk1w+exMj7Uf1FXY181OLq8ys715ZgHe1t914F6RtKx69FPTjh4Vk0bdfd+mbRr
         BmCsZhvYZW7kL9Wg1u54zVGXjRUKMI5CM4sP0MSH7dxCdT3Q91eNKb61enXcr1E76szS
         CQjLa7C7QCul585Fz6OI87sFT3R0BsFpONxaLFz6r2c4JtZ9FQnMS5kqv8yqh5poHQ0z
         bPGHRHePElobFfdYpoodBm9rFmpzd7yvx87L+ZNSTtjDWL5EoX+ypQiZzIm9wrPULlzP
         Bzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866753; x=1779471553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfCl4yhDEQPzWh5om3NIawhO9j1SZgFCQ0pogc9oRc0=;
        b=XUbfO2798NLC7Px0rnT5E8KhMPT+7LfqpPJWuWYvckKXtCDP5boBB/39hilA3ZAxUL
         LFYbFvgrcnDazvPaLv1cPYt7MUVAeUYBEBn9JpCQfXBd3dqC6/0mhFvXcj1Pv96xXTqW
         tbkceOPLmNnP+sD92PIogr++8uEm8rzZeydZDZqbJ7uaNvAXnuQtdfpVBFMPPgrqpSSY
         ltnSn8h4SO8gl6I3AahACWuExI40RtSVacpYZmWxDJmZIyoDDSSBItav/VHcEymaF5Tk
         PS7PsvjXKYsCSwyAkb/6P/dgM0v9Qk9+G5Tvu4xsCRbRmHGMsS4Z18EARSEranPRfpGX
         6FLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8GHjnd2FgKN+bNHuiAkUBz15apmfwH7gwHGwcNR7KdYSIteBbiCxB7yCJgMo0+nj6+k1x2uejSQEKBf3Fa4sGi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/863jxy0QuqGsX6WgJspbuZmv8WGxrCiTI4UeG5sg53yF0fr
	cJCAQrO4JZTW3ztSZRp9Pu8K89gUIdOu9R0g7f4NgAMKxeFXfu6pzyR7ScIA32uNpDTZLrJ6Ihh
	WgsCZ/Hz1PA==
X-Received: from dyw7.prod.google.com ([2002:a05:7300:8807:b0:302:542a:8cad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:600c:b0:2dd:6937:79d5
 with SMTP id 5a478bee46e88-303982b788dmr2341883eec.8.1778866753104; Fri, 15
 May 2026 10:39:13 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:43 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-7-irogers@google.com>
Subject: [PATCH v4 06/14] perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
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

Tested-by: James Clark <james.clark@linaro.org>
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
index 373eae7fb72a..ec0e91bedce1 100644
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
-	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKEL_OUT)/*.skel.h $(SKEL_OUT)/vmlinux.h $(OUTPUT)bench/bpf_skel/*.skel.h $(OUTPUT)bench/bpf_skel/.tmp
+	$(Q)$(MAKE) -f bpf_skel.mak clean
 
 pmu-events-clean:
 ifeq ($(OUTPUT),)
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index aa04d8b3ee07..30924ad140c4 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -35,6 +35,47 @@ ifneq ($(WERROR),0)
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
@@ -51,4 +92,10 @@ $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(BPFTOOL)
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

