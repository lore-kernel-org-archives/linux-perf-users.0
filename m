Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D554B8DE3
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608031; cv=none; b=AAVolZ9qudQQbUfzJ6vb8iV8GapAnRX6ZtTUxixp3j51LRldfMXqzMoO9TlMF1JsJaibj3IiAd9HEoSNzo5o+E4ofMH4W5W8p24ZiTHw/Bu7Y7zTSyUR0EbkA7IN6qfBz4+0LLDT3uEVs2sdVNDx6LvbuFZoeO+fYLzJ//w5v+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608031; c=relaxed/simple;
	bh=cRUfYLXCoHYdcJf7petym2SaUqyYp1wK8ZawGIFjxks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D3G0yr5y+/1/zqFcFgJlL0WrdJqQCHcpuESg5GKdqyTenmIAwcPccfNwZefN39zRMAX4K8WvPMrh9gKHL85T+8zmtWnhdMj1AYSdRPLmrKIASzfLCbrT16zq3edMVh9Ex/FJiypUffSDkbk/VmMuM/w/64oSQFWvuAbWa7zUtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/rWHH0/; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/rWHH0/"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso6268418c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608029; x=1779212829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQz/WCb5j0166DK49KzL5MgWB2a5AIO3DA7/MM9BNeU=;
        b=u/rWHH0/F0m9Y8DmgN4h+6D9RDyCm1+gkAI6BimXZvBpEwcVjkcWqpgkh8pvQcoEl6
         mKbMUF3QE5xWj54uyGB2Ztzglesc9neRvB4K25o57txLBDX3jPEXEFG+dIrfa6lkDRlt
         wJzQKYKDgHYdqahMF6g8vKmDtiGCn7ZYA6q+tQ9j8gOYugj4/wMA9gTXlrR9k3M/SYiG
         rmqBtY9KjD99z1irfPH6QV2aNyFzdFkrh61qI9vRoCnGKXZEAdYgRDFHgBWgmA4bVLhZ
         AQJUr1tJ/ynwkcS+kbNDLZRweLZHz6l2Xt1GXA5klCk4/YtXkzeESvJKdVLaew6WV3Of
         0kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608029; x=1779212829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQz/WCb5j0166DK49KzL5MgWB2a5AIO3DA7/MM9BNeU=;
        b=q/fmnWOGDsfjDLcix4iarvmgzbLfizMf4EflXU8KmO9FybzJHAPyqsKiL9sj4Cirmv
         dqkhf/+GDoxOAw2tzEL7kePVEEhxA4rIk8qnQSyfHc++R4p3/VHfTDzfA3K7O5a8vTy5
         5akJAtefdQMh3Iy2TuhS/TrITyXyjF22+HlBotrqSfc+NmxNm0XPQQ0DjbBbl6JweFBh
         RE7telKgba/rpdsVZm9Pz2+Law235ogT5q1pfF/1ZQraQGEGz3oovSHFVgTg7ivRtJ40
         rUqDIC0T8MIrZH9pDmWoPBuZdaqaDaBeNLsoshYPqAEKjM7a2wh6YhK45gpOeeRCvwHB
         rZtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jDGU0H40CY/Sb0d65a6gomZOgVgeHP060VXExemqYUi3SYipj2gGgyFEfOql8aiF1QjzZVscULe/QJGpAyq1h@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhkYc5v++dMf1pzZvd2gNJlqNm7ZqX+pvA5gMhW3Sq4dKPSbO
	hDmOjmf8ErOyVCKnDVJ8JSys/Tx0Ltzgun2RCrmNzZu+HzGYMrYeAfBxEm4Ff6K3VFIxqQYSF4b
	AItC9Ik0UWQ==
X-Received: from dlbsj9.prod.google.com ([2002:a05:7022:f909:b0:132:8d92:4d68])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b83:b0:12d:31cb:b806
 with SMTP id a92af1059eb24-1333b4e94ddmr2899885c88.26.1778608029032; Tue, 12
 May 2026 10:47:09 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:29 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-10-irogers@google.com>
Subject: [PATCH v2 09/18] perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
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

