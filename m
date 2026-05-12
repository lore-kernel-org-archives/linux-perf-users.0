Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9103BE632
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564171; cv=none; b=XgaRjgFq15cQeHI6PqQLnWdkvJ8f2TaNzTGRm0Uc82ZFsxUDkn5vsR7f6p798KTY7V9Nr5489NhhNiCpDD0AxclgWJJRrCP/oL77KeVpwu0+AP2+ilTdi1I8sZNBf/zhyqwN3+x5MBpx6M3iPVkGxUYl2yFPEoOHXPm8KHr+dps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564171; c=relaxed/simple;
	bh=qOoEjUZQqs0pck6afAvYzywuhSITWf8HozawSBby3OM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dOLooOFggdq98DRR1Nc7UnCuPnwHjHyDVqtpGD5iTALEOC6nupZ8rIOv2sE5PjSh/Yjyts2C4liQAbEKjwPJvTuP37+YuXhsXUr65DCM4LoMJkteeNTZM90OsFGcV4bFZiNoNzQCvOdWy/EmLH8jR7ImwMHGcU3OJYXfsTH6ONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbaQWlLd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbaQWlLd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fded513994so5609778eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564161; x=1779168961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gpcjl6KXcC729RYNnRD+ZPsgtjUbkaBeQzVG0D0VEc=;
        b=pbaQWlLdCf3Lbjcid3nn2zpvDKhmd6qERXE85Fs++V0kU/zfI/kLUqo1R49J5jJT9f
         U5NiaDsGyC9+ROfD2PSBGk/TGRVtw4OfMaPp2333jpjHKX8XeAEupG5j5m4M/mALbl7r
         wHD906f+f8ojBvbjHvsp/6e5+JDM+k6uy+rzO80P0av7LCn8qJNHrjknvbZDM/YXVYjO
         XGyWEnr6T6BlPMSJRxuW1lBd9Bx2nHNVrrRTFd2gJM17k9hTDcaePYbrKfGbsnXYQrFl
         imDa4zReNaug/hlU6h8EawUJ1UfMjbVozgy7y9wljJbeh2hVznnW2ox2hSQleiG0/v4C
         lCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564161; x=1779168961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gpcjl6KXcC729RYNnRD+ZPsgtjUbkaBeQzVG0D0VEc=;
        b=HHHhy0M8GtjrGATekW567DLNRI/Ukm/Efmmkqy0jzGOBMONPyZtOO8HyALOljUHF1l
         DbsU26hkn6hg08KZM2nZIw1NOU1IlWM+ququzJnbplAPuClb3m5PsdBPpnYCbXlQZOCw
         Hjnk70aieyG7b7hWcqyuDYqgOsI76CgDgte0dZXJ/7XrOQiZ3EXKg/TbBRO1GO1e5Uw3
         F10CQuHuxuYNqD3hkJYpm7VrMmn8GL1Bk5egyN7zNqiWx58tgXMYMg3U9+6nUrbl4KBV
         qnhMct4w2rtqWuPT4sbigPo95LtISY124N2N+TfphJ0xBgoOSh6HWmRS0xE7qv1my9Hv
         vXzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WBWcnHMrSxJLdpwcnFDD0zV7fBA6f+FsWcmg8Y60iDLV3wkozdwIi0q0TlG06tPgJv7XVCJR/SyhIKVJs+4Lq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dTGerRLIfjk/9mqXq4aoZ2ofjbLV7IQtEjCl/Mc64KJu+8Zv
	LhzTc3HFVHSGtohScN9jHT3AF3tj/TiRR2q/m5FheRkZiYyDnVNceC8bmGLVrnshknIeVzREAQE
	wzb/tyo1K2A==
X-Received: from dyr13.prod.google.com ([2002:a05:693c:400d:b0:2f9:af7:5051])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6784:b0:2d8:c521:c157
 with SMTP id 5a478bee46e88-2f54c971847mr13772768eec.18.1778564160744; Mon, 11
 May 2026 22:36:00 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:30 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-6-irogers@google.com>
Subject: [PATCH v1 05/14] perf build: Move BPF skeleton generation out of Makefile.perf
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

Currently, the top-level Makefile.perf defines a massive global bpf-skel
umbrella target that pre-compiles all 12+ BPF skeletons (%.skel.h) upfront
before launching sub-makes. This forces unrelated sub-makes to serialize
behind bpftool and clang BPF target evaluations, causing parallel build
bottlenecks.

Furthermore, bench_uprobe.bpf.c lived inside util/bpf_skel/, breaking
conceptual directory encapsulation since it is consumed purely by
bench/uprobe.c.

Refactor the BPF skeletons to better achieve directory isolation:
1. Move tools/perf/util/bpf_skel/bench_uprobe.bpf.c directly into
   tools/perf/bench/bpf_skel/.
2. Extract the skeleton generation infrastructure out of Makefile.perf into
   a shared inclusion file tools/perf/bpf_skel.mak.
3. Include bpf_skel.mak locally inside tools/perf/util/Build and
   tools/perf/bench/Build and bind precise local prerequisites.
4. Safely synchronize the shared bpftool bootstrap and vmlinux.h targets
   via the conditional prepare: umbrella to avoid parallel sub-make races,
   while evaluating the actual skeletons completely locally on demand. A
   later patch will move these targets into bpf_skel.mak.
5. Export CLANG from the global Makefile to ensure accurate tool propagation.
6. Clean up Makefile.perf by stripping the global bpf-skel umbrella target
   and its SKELETONS list.

While removing code from Makefile.perf generally helps build
performance, the impact here is minimal. The main motivation for the
change is to better encapsulate things in the build and simplify
Makefile.perf that has around 50 lines removed.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf                      | 59 ++-----------------
 tools/perf/bench/Build                        |  6 ++
 .../bpf_skel/bench_uprobe.bpf.c               |  0
 tools/perf/bench/uprobe.c                     |  2 +-
 tools/perf/bpf_skel.mak                       | 55 +++++++++++++++++
 tools/perf/util/Build                         | 15 ++++-
 6 files changed, 80 insertions(+), 57 deletions(-)
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 24581941e912..d4fc10f36781 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -274,7 +274,7 @@ ifeq ($(PYLINT),1)
   PYLINT := $(shell which pylint 2> /dev/null)
 endif
 
-export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK
+export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include
@@ -632,8 +632,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	$(LIBAPI) \
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
-	$(LIBSYMBOL) \
-	bpf-skel
+	$(LIBSYMBOL)
 
 ifdef LIBBPF_STATIC
 prepare: $(LIBBPF)
@@ -914,44 +913,13 @@ python-clean:
 
 SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
-SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
-SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
-SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
-SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
-SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h $(SKEL_OUT)/sample_filter.skel.h
-SKELETONS += $(SKEL_OUT)/kwork_top.skel.h $(SKEL_OUT)/syscall_summary.skel.h
-SKELETONS += $(SKEL_OUT)/bench_uprobe.skel.h
-SKELETONS += $(SKEL_OUT)/augmented_raw_syscalls.skel.h
 
 $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
 	$(Q)$(MKDIR) -p $@
 
 ifeq ($(CONFIG_PERF_BPF_SKEL),y)
+prepare: $(BPFTOOL) $(SKEL_OUT)/vmlinux.h
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
-# Get Clang's default includes on this system, as opposed to those seen by
-# '--target=bpf'. This fixes "missing" files on some architectures/distros,
-# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
-#
-# Use '-idirafter': Don't interfere with include mechanics except where the
-# build would have failed anyways.
-define get_sys_includes
-$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
-       | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
-endef
-
-ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif
-
-CLANG_OPTIONS = -Wall
-CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
-TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
-
-ifneq ($(WERROR),0)
-  CLANG_OPTIONS += -Werror
-endif
 
 $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
@@ -993,29 +961,10 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-$(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
-$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
-	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
-	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
-	  -fms-extensions -Wno-microsoft-anon-tag \
-	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
-
-$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
-	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
-
-bpf-skel: $(SKELETONS)
-
-.PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
-
-else # CONFIG_PERF_BPF_SKEL
-
-bpf-skel:
-
 endif # CONFIG_PERF_BPF_SKEL
 
 bpf-skel-clean:
-	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
+	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKEL_OUT)/*.skel.h $(SKEL_OUT)/vmlinux.h $(OUTPUT)bench/bpf_skel/*.skel.h
 
 pmu-events-clean:
 ifeq ($(OUTPUT),)
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index b558ab98719f..67b76fe20ba6 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -24,3 +24,9 @@ perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
 
 perf-bench-$(CONFIG_NUMA) += numa.o
+
+ifeq ($(CONFIG_PERF_BPF_SKEL),y)
+include $(srctree)/tools/perf/bpf_skel.mak
+
+$(OUTPUT)bench/uprobe.o: $(SKEL_OUT)/bench_uprobe.skel.h
+endif
diff --git a/tools/perf/util/bpf_skel/bench_uprobe.bpf.c b/tools/perf/bench/bpf_skel/bench_uprobe.bpf.c
similarity index 100%
rename from tools/perf/util/bpf_skel/bench_uprobe.bpf.c
rename to tools/perf/bench/bpf_skel/bench_uprobe.bpf.c
diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 89697ff788ef..616873bca243 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -44,7 +44,7 @@ static const char * const bench_uprobe_usage[] = {
 };
 
 #ifdef HAVE_BPF_SKEL
-#include "bpf_skel/bench_uprobe.skel.h"
+#include "bench/bpf_skel/bench_uprobe.skel.h"
 
 #define bench_uprobe__attach_uprobe(prog) \
 	skel->links.prog = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.prog, \
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
new file mode 100644
index 000000000000..bcb704d5af32
--- /dev/null
+++ b/tools/perf/bpf_skel.mak
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+# Shared BPF Skeleton Generator Rules
+
+include $(srctree)/tools/scripts/Makefile.include
+
+# Shared foundational tooling always lives in util/bpf_skel
+SKEL_TOOL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
+SKEL_TOOL_TMP_OUT := $(abspath $(SKEL_TOOL_OUT)/.tmp)
+
+# Component specific output lives in $(dir)/bpf_skel
+SKEL_OUT := $(abspath $(OUTPUT)$(dir)/bpf_skel)
+SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
+
+ifeq ($(CONFIG_PERF_BPF_SKEL),y)
+BPFTOOL := $(SKEL_TOOL_TMP_OUT)/bootstrap/bpftool
+VMLINUX_H := $(SKEL_TOOL_OUT)/vmlinux.h
+bpf_skel_deps := $(BPFTOOL) $(VMLINUX_H)
+
+define get_sys_includes
+$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
+       | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+CLANG_OPTIONS = -Wall
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+LIBBPF_INCLUDE := $(abspath $(or $(OUTPUT),.))/libbpf/include
+BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(SKEL_TOOL_OUT) -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
+TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
+
+ifneq ($(WERROR),0)
+  CLANG_OPTIONS += -Werror
+endif
+
+# Consolidated Pattern rule for $(dir)/bpf_skel/
+$(SKEL_TMP_OUT)/%.bpf.o: $(srctree)/tools/perf/$(dir)/bpf_skel/%.bpf.c $(LIBBPF) $(VMLINUX_H) $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h
+	$(call rule_mkdir)
+	$(QUIET_CLANG)
+	$(Q)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
+	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
+	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
+	  -fms-extensions -Wno-microsoft-anon-tag \
+	  -c $< -o $@
+
+$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(BPFTOOL)
+	$(call rule_mkdir)
+	$(QUIET_GENSKEL)
+	$(Q)$(BPFTOOL) gen skeleton $< > $@
+
+.PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
+endif # CONFIG_PERF_BPF_SKEL
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index abc9a2926e85..40c258ac99b9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -442,4 +442,17 @@ $(OUTPUT)%.pylint_log: %
 
 perf-util-y += $(PYLINT_TEST_LOGS)
 
-
+ifeq ($(CONFIG_PERF_BPF_SKEL),y)
+include $(srctree)/tools/perf/bpf_skel.mak
+
+$(OUTPUT)util/bpf_ftrace.o: $(SKEL_OUT)/func_latency.skel.h
+$(OUTPUT)util/bpf-filter.o: $(SKEL_OUT)/sample_filter.skel.h
+$(OUTPUT)util/bpf_kwork_top.o: $(SKEL_OUT)/kwork_top.skel.h
+$(OUTPUT)util/bpf_off_cpu.o: $(SKEL_OUT)/off_cpu.skel.h
+$(OUTPUT)util/bpf-trace-summary.o: $(SKEL_OUT)/syscall_summary.skel.h
+$(OUTPUT)util/bpf_counter_cgroup.o: $(SKEL_OUT)/bperf_cgroup.skel.h
+$(OUTPUT)util/bpf_trace_augment.o: $(SKEL_OUT)/augmented_raw_syscalls.skel.h
+$(OUTPUT)util/bpf_counter.o: $(SKEL_OUT)/bpf_prog_profiler.skel.h $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
+$(OUTPUT)util/bpf_lock_contention.o: $(SKEL_OUT)/lock_contention.skel.h
+$(OUTPUT)util/bpf_kwork.o: $(SKEL_OUT)/kwork_trace.skel.h
+endif
-- 
2.54.0.563.g4f69b47b94-goog

