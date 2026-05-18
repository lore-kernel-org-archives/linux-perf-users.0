Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A4481A81
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119230; cv=none; b=nycW0tpbkc/s94XJM1FznutIvkf3u5P5rI75vZPFchz8VKEgxfx8V91aaUcl3WVeKIn2jaKExR7wYhmvctN2F1cLdtgkuJSiY4b33z6t3YITgbUqOhCeYJAiNJo+Jokg9+XAsOwRHKEgLxFw6lxrSIdtdLJlIKSL+3R6YuvXQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119230; c=relaxed/simple;
	bh=+U/Ns4U0n1I6K6DVg25733xbH6/xIUj21YSyt3UqYhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u5PKlkNNHvpy5+IIEJ0ZsFe4JIQGtba6K5zyV4DFjB8aaOf/OmHMgPHU+9pn8R1QU+hi4NKqe+OIOnUoboBnu8lQkPHenc6H1+4y/MIzDHnbkQwrxQho6Oc3f54qLlGCJaB4w7Is4WV1ieLd8bCLR+jCVQeVPS/06OK0zEgbKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dx/ZvRs8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dx/ZvRs8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so1028172a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779119220; x=1779724020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=Dx/ZvRs8iPBwt85T9MdPPogNuStVk1R/jFXAVdee33pEcChHLAhatDJeblGBQPGfDi
         FH4WkyGOL192PGOe/L3Zfq1ZsLsTEH4IvoKcpfBBe4ey/nHYBQXTdsrO1tF3ZOjP8DJ4
         HBqXKucc8/DL/U/Vd6lEn0Jnwd4iALpubvoYFJNvXQ6sVWQi++KOIv4tf1+/1c/tAp4t
         E77TnkQ/gFE6+n0uu+FzLFKMWucc+JWB/uEYw9pCq3AfuqoEXblfWhM8Pmicpk2Z0MCo
         gq1kanqSEjq0gAI/+/N97ywmq6vuMIOazOIGxNwANFzV4do2RJ7EXKVZiVc36da7PJAy
         YPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119220; x=1779724020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=HxcoZdu4MMXsYT6lIq30+FwLQgTATF4OO7j3IsW3HrwiFNxrZuYyrNE01FjXKJs55D
         YFBCrTWhXEA0e03SRs1FkwAFnisUIZCNi6V97LMiW88w1EYbndlCIGrpTYBUPpN3HNx2
         6DZ29vMfvaTQ+V0eBS9cEo9NSqj4PwlXnNHLJHhjlmLzb7ivPaA2tTXc/1/YWfhHw7aV
         vSj7ZAp0dQ/nL4BzXzvRBdKf2PTHSxZhBJx747N3CyRCq+fKWt42GLZqwfKyETgBje7j
         Y7T98J7rRZCb/Avdc2RAyPsufcf1hGEJFk3tvqXRK+xs88rDh0SQ6HmVCGuwDHp1Y1Nz
         IN5w==
X-Forwarded-Encrypted: i=1; AFNElJ/v/YPXRwwJXEo8jZ/08swjmIhdW5sqI3F7bpT6HnYX2A9YUQI6p8YILUOvX7SoQRiHkg6fb/z37TbHlTMZrNh7@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMNsoAhXozxNBnYBJybGY0C/zSRtw/x6e0uhkMyAS6BxbG9sE
	5CTUyJ3KAEAJZVUcZpsoeVkVgQbS8k/wyPP/9g6n3NXd/ABRteBDvxpFInx+LSBnR4MwnVVfV1E
	3X3cjXZYYuQ==
X-Received: from pgbda3.prod.google.com ([2002:a05:6a02:2383:b0:c73:bc95:cca8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:39c:787:f197
 with SMTP id adf61e73a8af0-3b22ec70cacmr17175514637.36.1779119219461; Mon, 18
 May 2026 08:46:59 -0700 (PDT)
Date: Mon, 18 May 2026 08:46:31 -0700
In-Reply-To: <20260518154638.2798789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044740.2526802-1-irogers@google.com> <20260518154638.2798789-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518154638.2798789-8-irogers@google.com>
Subject: [PATCH v7 07/14] perf build: Pre-generate BPF skeleton tooling during
 umbrella prepare phase
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
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

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 8 ++++++--
 tools/perf/bpf_skel.mak  | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ec0e91bedce1..876065a02de6 100644
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
@@ -971,7 +975,7 @@ FORCE:
 
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
+.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare bpf-skel-prepare
 .PHONY: python_perf_target
 
 endif # force_fixdep
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index 30924ad140c4..7704e7e635d8 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -15,6 +15,10 @@ ifeq ($(CONFIG_PERF_BPF_SKEL),y)
 BPFTOOL := $(SKEL_TOOL_TMP_OUT)/bootstrap/bpftool
 VMLINUX_H := $(SKEL_TOOL_OUT)/vmlinux.h
 
+.PHONY: bpf-skel-prepare
+bpf-skel-prepare: $(BPFTOOL) $(VMLINUX_H)
+	@:
+
 define get_sys_includes
 $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
        | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
@@ -93,6 +97,10 @@ $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(BPFTOOL)
 
 .PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
 
+else # CONFIG_PERF_BPF_SKEL
+.PHONY: bpf-skel-prepare
+bpf-skel-prepare:
+	@:
 endif # CONFIG_PERF_BPF_SKEL
 
 clean:
-- 
2.54.0.563.g4f69b47b94-goog

