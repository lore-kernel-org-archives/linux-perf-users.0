Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDE134750B
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079689; cv=none; b=iRGMsE3PypjZ+SuW7oNii27K5pmJ1HQ2cM0Wc+yKGWvw7j1b57z+tqDarX3fR4D4Pf9C3GBwtFI58MCKvKMTj1r+4qajxQniE6CrThKnRCXJbjl2l/wIaPQtRKDBSsAKjhjqO9xouK0v8KAF4vOuL/fU0H5TCQGRiIfhcmmOPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079689; c=relaxed/simple;
	bh=qGIGcXBZNocRlR3JFELM4l1uEoG1XLzekHqz1ZDyUMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BBjili62KfKsfNYYFh66jZAAJSMunNRmXZ2hbTYQYmhh9DYxOSrNKgIe/Tqea6YQsL5rwpimp+tG/vLhPUo8m+BI0jrTJNyO/x0EVylO28+9wI69/vjgyo+y3h/hl6Sq5dM3VB81uObByEyIUDchxTiZ1m5L1U2KFwtlPw05jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uj4oy4lX; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uj4oy4lX"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dba1e866dso1229631c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079685; x=1779684485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IYhcsGACL8LkG71M/mjaAqqSQSXVQ89TKnDLzXk5kps=;
        b=uj4oy4lXHgWWf9uclxAkM968o75uDn2ndbGcqKlyHaJ3ypkQORptItcVdtMYPpGYoJ
         7QvEKJe+YPwvaQHN8zesfoX6sG1/0VaR1OYFCgMN759Hbwae7o1pbr14+dyIsg4SQCh7
         AhnbrCuxzz4pjsgNtenICYL/XS+1YKaZeqNUYoIX1oHyX49LecCpzCzXy8ovs+ApXhX9
         +mtjE7gD5K2b3ngK++3wHGjkuWCVQpx+NVpkfEdZDOczLFaKMz+zhGLpEopGtL7BqVnO
         sznOM9KJpJKVG7s31JQGautIW3HafjuRVQwKqrbhrzabOv7+ImvSUQlHNdrRP90u9onA
         hCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079685; x=1779684485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYhcsGACL8LkG71M/mjaAqqSQSXVQ89TKnDLzXk5kps=;
        b=jyTiqmxy7w1EgrNM3UGcu/e2Xs+jx3HiYXpfSsoAZhqAJ71JPOV4kjCYh1QGQ/sIC8
         CiN/xBFpiht4quTMFbCbdWBxFM2Xc6Xgg1gGE5NHjMpK+GfQViDuFOaEf3WCELQyeJnO
         wcT4CTnmEE99byxz8I3MVzEPE5+7AgHOu0s+wUIr+fuEfQ17vxcRYO/J1n1gjdy0HWwh
         cEqv2g0iscKznulYca1DXFNDfKOk4nXWmVZXfDY0VnZCV2Y8EMXY/Dpv/QCCG7tYEvX7
         K7enFFd/o/S/XMaEsd5JjZlist3g/5ZOkocWQyqq6jS6OJ193jvlzkQW8Ob5WPzueB8F
         dvnw==
X-Forwarded-Encrypted: i=1; AFNElJ+xSOPt/4MMcPYB8oQXkd2te5kxRLhkqFOvOoQn8nFAQkqJLWJjxQLwuDYC0L3xLvTfF9SVdEh5uroDI7f1LMMD@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiAPL0nJ30vpOwSSn7FzXgXDeQ1iBJwB2WOWzSTlQBjaj1MX3
	T8YCw4EnKraU/pfpGYuLT/l7HDAJ8p/3DaPmwYxy7usdAZ6wLFBwRPK/gjk3u0IEmva/OCYTVxu
	KjpsX+ufsyQ==
X-Received: from dly24-n1.prod.google.com ([2002:a05:701b:2058:10b0:135:66d8:351c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b9a:b0:12c:15ce:a71b
 with SMTP id a92af1059eb24-134c8d4fb1fmr7374154c88.25.1779079684991; Sun, 17
 May 2026 21:48:04 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:32 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-7-irogers@google.com>
Subject: [PATCH v6 06/14] perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
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
index 7a0e372824c6..8437c3f72125 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -681,7 +681,7 @@ ifeq ($(BUILD_BPF_SKEL),1)
 endif
 
 ifndef GEN_VMLINUX_H
-  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
+  VMLINUX_H_FILE=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
 endif
 
 ifndef NO_LIBUNWIND
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

