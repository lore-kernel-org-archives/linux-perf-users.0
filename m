Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867043C3421
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564177; cv=none; b=csUohRuhx1snEfa9+JGC+dqhm4TVRJ5CJBMfIxU+9Jdu/Qe/8KClPkJnGgduSuVSMTXzfwHj8AWbB4n2rbALBIwht7mNJTU6EbBqRY0iiClQAACsx3ah32yrpYZpWc+pihT3tL4D7k/Ykibx0/ayYKD7DQ86XyPpiYad0n+D2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564177; c=relaxed/simple;
	bh=dXwLegb16bAA2QZUdEs8E+I+y3aG8fUQ/IeCoSTD22w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nN71H94IsDX4voFEn1Xe0okDvMpPLSBM0m7FQ9bBrno4l256gsd4x2VfPuZg5xoopKh5LL8LE5yyHV8KQk+xX84Vux6llr2xM/fWYjfPASTb/l92N6Mr2wYtK1TZt3Q9v1eDxvkx+rQZdmYJuY8elVMTdOtE9xiUQoPrSPs52EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqHQBo0d; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqHQBo0d"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2eebb099efbso5052257eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564166; x=1779168966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7eMv9vVl9kPkB1b964FI4KWr9nwoYDhI53YZ3Ct1D2E=;
        b=GqHQBo0dK3PX8AxisIHGBNmT2aWE7RczvrjEolLcIFNdFxocDteGB20+KzOr1XMzXE
         67/uONgNt0FcglpAmqhdFObt7zo36wC8RnCqFjEWxDkE+NxoEfQlS5YnOLa6Fx4dLsoa
         rnzdxcr/K6KB8gBiLPyR4PoPfP3JYzL73gf4tOGU4e8I30sSLP7PSxwkrZEoVR3uiORU
         ONBkRGvfiYpX8BviYxq0YiBrEsShMcOhfN3EGXOGQd4JbUvnS35Z5HWfI//QScrkCJi9
         6hi3txeW2OrdV4DL8SpGw/TP8wvDWCODvBbBJIPhQ68UNLOFm4XcFwAZhRzEy7YopmWb
         hrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564166; x=1779168966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eMv9vVl9kPkB1b964FI4KWr9nwoYDhI53YZ3Ct1D2E=;
        b=PO3Fh6gokiJ4pkbUE0uyqz6qvxN+W9r6fscm80iNfAXtErofmvFBGxsmBWE917PS2c
         9+B0E8qW2qi0Yy+NV74YWqzPOic/n/ABqLL1x9OnpD39PCXcMXNbBMSpPNRPhlqQOySX
         vS3pq22QIjuGq7GEdxr5u52nJU0tQxS88MiAg9PIG+fOyu0PHFOPA7+Pj18rPxAZNie2
         xpTLECw2Hr2hskbDEf20O2yJhu4WU4RmfAdeS1NO9l0G+vxeDM98okYUnwPwWJhDBieL
         GL5UzgEyqBqRYvdnnPSozkm6ln/kIdLOLJsnupXCMsm4OYclerMqV/d7xMGkDSwUNeVG
         EJjg==
X-Forwarded-Encrypted: i=1; AFNElJ+dxs26IuRMoaVlG+IR6jqg4lWuBjKE/vjPd1Hkl+maCFQkTYXGQ+HXQJHnKlhN6B+d/OeKsjyb0nwtRSFw7Ste@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjVrE5vtmuD/xjCYmBoPwd+AsdhyTIzuE3Q9xdHD1M19AIMKi
	TCDE/Bh4tflyA05mj7SY+nKNy09w6IIA85Obv4Trn6o2bmsIkHIW3+NcTr1w6xqqRWaWYzBAiVl
	KyUgxTC/Sqg==
X-Received: from dybgz3.prod.google.com ([2002:a05:7301:2603:b0:2cc:a1bf:2dd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c01:b0:2ce:f3d7:221
 with SMTP id 5a478bee46e88-2f54c97183cmr15002168eec.17.1778564166099; Mon, 11
 May 2026 22:36:06 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:33 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-9-irogers@google.com>
Subject: [PATCH v1 08/14] perf build: Pre-generate BPF skeletons during
 umbrella prepare phase
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

Currently, BPF skeleton generation rules (bpf_skel.mak) are evaluated as
part of util/Build. However, because LIBPERF_UTIL_IN explicitly depends
on the top-level static libbpf archive, Make completely blocked the
execution of bpftool bootstrap and skeleton generation until libbpf
finished compiling midway through the build.

Since bpftool bootstrap compiles its own independent copy of libbpf.a, it
does not depend on the top-level libbpf target.

Decouple early skeleton tooling generation by attaching bpf-skel-prepare
to the umbrella prepare target, exporting CONFIG_PERF_BPF_SKEL to ensure
accurate feature propagation. This allows Make to compile bpftool and
dump vmlinux.h in the background at build startup, eliminating the initial
sub-make startup bottleneck before BPF object compilation while keeping
100% of tooling rules perfectly encapsulated in bpf_skel.mak. Provide an
empty fallback target to ensure builds succeed when BPF skeletons are
disabled.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 6 +++++-
 tools/perf/bpf_skel.mak  | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5af767415c11..df68d29ecab7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -275,7 +275,7 @@ ifeq ($(PYLINT),1)
 endif
 
 export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF READELF
-export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT CONFIG_PERF_BPF_SKEL
 
 include $(srctree)/tools/build/Makefile.include
 
@@ -629,8 +629,12 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(or $(__build-dir),.)
 
+bpf-skel-prepare:
+	$(Q)$(MAKE) -f bpf_skel.mak bpf-skel-prepare
+
 prepare: $(OUTPUT)PERF-VERSION-FILE \
 	arm64-sysreg-defs \
+	bpf-skel-prepare \
 	$(LIBAPI) \
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index ded578b9570c..c4340a218323 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -16,6 +16,10 @@ BPFTOOL := $(SKEL_TOOL_TMP_OUT)/bootstrap/bpftool
 VMLINUX_H := $(SKEL_TOOL_OUT)/vmlinux.h
 bpf_skel_deps := $(BPFTOOL) $(VMLINUX_H)
 
+.PHONY: bpf-skel-prepare
+bpf-skel-prepare: $(bpf_skel_deps)
+	@:
+
 define get_sys_includes
 $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
        | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
@@ -94,6 +98,10 @@ $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(BPFTOOL)
 
 .PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
 
+else # CONFIG_PERF_BPF_SKEL
+.PHONY: bpf-skel-prepare
+bpf-skel-prepare:
+	@:
 endif # CONFIG_PERF_BPF_SKEL
 
 clean:
-- 
2.54.0.563.g4f69b47b94-goog

