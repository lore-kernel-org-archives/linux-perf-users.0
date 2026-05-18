Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F7385529
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079689; cv=none; b=mIHXoHvlXxsROiSQH77Y8YqROPR6uE0MEtF4hXLe2PsgdkS5RjVB/2Zxfu5/gsmYz33S//IKJMJy7NJbaII+/hnOe7WL0a8ja4SQAZiAUyj80n858yYbbEsnaDDNUopBEAkt+hxR3hM5pNvr3TH6b4jRac/eyd+qs+vau70fT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079689; c=relaxed/simple;
	bh=+U/Ns4U0n1I6K6DVg25733xbH6/xIUj21YSyt3UqYhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dQvyRn1B4JEO2Kwxl8PblPmAIhAhMLNmBsuee1ebXtg11Ir7pP0nWnWuwfrS8qJaEk98lx2oA2yNVyy5Orn+xSnrbTOfCx3wMAHd73vDFVLndwClkgNSUV/95FKolfp88OiIisgdKcpmPYTKuIb22daqzt2JWjKkdwJEPHKN2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hR0pT3TH; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hR0pT3TH"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353ac304f3so3383160c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079687; x=1779684487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=hR0pT3TH1l8SXApItBrGcvYgm9YZ2ZzUmO3d4hpQkBMNYX1/ZWtYIvpWVj/uuXXYvK
         0/6vHWaXH7w7nNf1Szi81xFXJ+jeEClphD06KVKjH4Cbxh+BqDhqcYWV1nto9E60Jf9y
         lAnjogTyuFpwVMPHYC1wTBeE1lKEDBnPyO1cqO0RHTx6WWUloY47c4LWwpa6LsCHjalj
         1ca253gkkfykhcwVUjo8N1x+8bSP5vyeoWIyDwvDLGH/kIbomUOe84hXTWjdujJdda0M
         SMpKAlCXbhoA7zJYT+niwiXH1Ri04nQnK+hDV+3zeLySikbS6R3gLrrhrIrDTJ+H1iTE
         FKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079687; x=1779684487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=Hy+IB2SndqQoMZVEwTPX/8ToWQCS1bK8ZjbWpagFqzyH8Zvx5sgCQbC6oh/5+lpfRF
         U9W9Nu4aSS+n3THHYSfubyZ/hye34xkiYjnl7IzRpDLgBmxq77/ijZ5cDfUr9Sv00eQy
         Oq+56Lc4mVq/XXQWpRQ7TB0/IqG2yIT2jrX6nmCM6Yvbo4zV986+wHkSZ3itXSQPOPVC
         e0naHRWsWG5Q7bVjTZ8I8+jEuLjv28OpPhWnb1l7MO3n+SCS88oikOUCq/W5spfRXo3F
         W7aaKb/SAPE09zIkOdbQKP04KYWUR3CUqP3tvVuaY7IodKsjgxIL2ECKqa4MlW2asdup
         5nXg==
X-Forwarded-Encrypted: i=1; AFNElJ/wgUUx0sGdyNte2F2x37Zc3vkXzeXO736wldqJCl2HpD/hJpbk7pBJW+mC2N6Xk+mEhc67m0AWubMsrRMckKte@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbMIrsx+4IoXqRLhb6zdK+rhG1CgVh7mmlFtDQDoQYlP72gmh
	VjstdmIZedK+aCa5qQxlg08hsMAtpIqXoBgRX94EuULy8xgU1qsYaBXiKO4BQSYhd6yAsOCezEQ
	h5NRFJDNP3A==
X-Received: from dlboy10.prod.google.com ([2002:a05:7022:128a:b0:134:feba:1ec8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7a2:b0:130:c9cc:3384
 with SMTP id a92af1059eb24-13504840a80mr5199961c88.30.1779079687040; Sun, 17
 May 2026 21:48:07 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:33 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-8-irogers@google.com>
Subject: [PATCH v6 07/14] perf build: Pre-generate BPF skeleton tooling during
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

