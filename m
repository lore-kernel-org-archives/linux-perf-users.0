Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C33D45FC
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608036; cv=none; b=Y+GWoR1VjoZgtiligrLle68Af0zbtuIXX0dTLmqPSfZ6nBPnWp46Houmdi26X7uhBWA4+8PpEul9lgR4m9+BufSLAdgXtTJE6u6XONrZRM+r4r5eulEV3YIqGRRIzQjvwQlfymx1YEm2sVZdBFogIGu2MExDPS9eJEexpYQEvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608036; c=relaxed/simple;
	bh=bhZ2hY6MSv532Che0Y8RNtMfS5lmLi1CAbUeT+WGv3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJ4CfTDoJmTeYfS485EgB7XYq03rZd2n/ni+zLPGZfJNfL4P3uRUBXlLW3oMpUBUzMelv6wOhXEoNn99+PsIxEQR5WsXTd35BGfiD4ZdNc+j54gnJkTa9bqLdG/EU/DJMoHumqZpTIqL7di6j2v8atTMYEpuic1aAWihpqdF0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UUyeVwlP; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUyeVwlP"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so11668264c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608033; x=1779212833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hm7qoj0ZGArqNuRl8x36cXklyqsz/vJwzKuTWLKP+4A=;
        b=UUyeVwlPRv14a/u+t0LpJ8p9XUpPzZGkk97zqbdFQmtagmktQH1qfvIykE9Mq8l1VT
         NPbcZFQ5jleyHBLPeg7TM8mdU6lEM4y/PTxuk+Vv0n/3ib9Upm4ZTg/0f01gJfBL2rha
         jWllkdiD7dkVZBlqlRejH2Na2AMVJLcKTp+FHpY6tMZEtCg0hadIPwpdAtryXCDCFjvF
         voeuvCW3d4U3ApUa9C6JZkQ8GEHk25fvZUi1kGULTV/9lmvIAKlXe0fQEU3InTUQSNfW
         vvtULIxowJDMqVopyF3prmv2IiOJa8MNBqUIfeyoasq0x+s21fZZmT7rYUo/41eoHNGw
         ii5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608033; x=1779212833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hm7qoj0ZGArqNuRl8x36cXklyqsz/vJwzKuTWLKP+4A=;
        b=Y9mqAm1wWVT6dESgdJgOWlT0rj6GQl1LlIjs9K+6JD/ZEbpv7UWoqeY8fkT6G2xQW/
         pnGUOXtjmFrDlSt1/AIbE6DLCkasfLFUYvR8ubXjpLh8r2eGZ6ipH1WpJ0Hbv5MmMXv/
         r5I9CsnOuvKGldHbA5H3HqN2S1RydRuRLAXTmtui7eQuy1AaZBmE1iOkATibKd9QsBzC
         Ay+qaowXY5QRkszy9WVUqr/0PG05mr54PxSVGQvDlLv3/0/ymwMut5RkHs7NMtX79n46
         1BF+t19UIYVMTc8UWT0BBkeIb0knJZCSMxu/LkXZtllW1UUtX8vNu06GsBzwBjEsiwfC
         Mu9w==
X-Forwarded-Encrypted: i=1; AFNElJ8p8Jn+5a5xfNOM74679Cg+ZQxBLoRZBa9kbyQnNjNLhTLxeUyz4dU14wNlba0K/+S3gG4mADnnQkgun1mXTuFk@vger.kernel.org
X-Gm-Message-State: AOJu0YzBuzIPHZFcgLfbbX6X9Ep9c202A19SBmAiLHVDxN9m6J/TJgKh
	WJY5QOg97T8v7lKKSU6pJo/MV9SvRJl+ApktjYZQNrA23Kh2cfi374/jJUpLdrXW+1DIZXfd4xn
	Kd690ZVVRMA==
X-Received: from dlah5.prod.google.com ([2002:a05:701b:2605:b0:132:e3a2:6717])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f102:b0:119:e56b:98a4
 with SMTP id a92af1059eb24-1319763be96mr15409551c88.11.1778608033142; Tue, 12
 May 2026 10:47:13 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:31 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-12-irogers@google.com>
Subject: [PATCH v2 11/18] perf build: Pre-generate BPF skeleton tooling during
 umbrella prepare phase
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

