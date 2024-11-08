Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48021E136
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109620; cv=none; b=Hq3aH0/CQxUzS+NUl7NfuJ8nS7ICOb6CugsaTr8SI5Ie/bZEunxfJ1fYvyH18viBQD5HVlP/jmVywntVYay07VE3P66aWCCEJB0rPNOu9MhZiHPq18dvvswusEMOjebxiRl457Y2jWkJuyrnTjl2P0dB8dwKv73GpsL6JjwneYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109620; c=relaxed/simple;
	bh=+qbC1BllbCYTtNQ2/CjIoZXsicAaiGDn8oCzA7nIsmw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=N2z6KzTP1NIXgwS/AzA79+amFdYwG8dG6ROvpsgptmXIoJdrrQtaaBd1J+DJAcic7im4r1r/6/KcKKwo44zMS5hQsgxFVuxpsr2LYSuW/8mWyN24292NahouMd0rCqrRYZ2elWfJEZi18qIWMUE5F4gqYziSfUzpB0twnq0zglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx6cpxVZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx6cpxVZ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso41349287b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109617; x=1731714417; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKslcm2V1UHcqGqqi4FAiYTJwpOr2SEQn/AjeUS4EGg=;
        b=Mx6cpxVZqWlUPMKFCr/DQ0cJ+S1BxN/I14UvdZGnDvhtelq7MYcZZXNJ0TatBjZr1b
         wFG19KPoHLYlOxsfjvxSCyidCT5NeB1rjUE7+4Dvlax94RLuOsgVuArHgw3o6n7W4W5m
         /aMQU1IwpDeJxIStnRd+9iBi+mMfgvdVFY4sw/Fvcz5/wQBhQw6Z9Y0nID/wOCnxl3cc
         hYFDsNBnhjhjprKODfzmgt+/GzXbxsr6VKv1O3GBH/oej8tsPfHq5Yq6fNOXMFI+Eem1
         4gwmaJGuLWcQAlTFg/ixzy+FJrBwrjzDY85KE11O0DM5W5KpqQklPVZ1+OLr78KnvaF2
         JshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109617; x=1731714417;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKslcm2V1UHcqGqqi4FAiYTJwpOr2SEQn/AjeUS4EGg=;
        b=HHxwG5O6Snu2hIBkiTCh/u1ce95vFG0jfDLYfNsbZh7zhOIkYoHgW3bIlWMh4R889u
         6JUZwN4xrK4fFbRy0lF72lkZ1IABuU1AIRlteCKdT5o6v9uMIffDDQAoVJMjT0dn/vsE
         FCVjHIPT8dbdEzvG7zRK79XWTNI2x8FoU/UF0y2cjPN9NBmhgdUw/0wE+/vnbI/WXG4A
         alH2ukVQrJ2aKuMGx1084rOZlIOoPea0Sct0DoXjI0dA2fAAUMst1/htn4vK3hIY9MFf
         5krnfre8wn1sC22YHDCuUoTRoyJRz4a13T+BdCq/e6yTo3kMd5KeHHBg2dBht8Y5XyP/
         1KMg==
X-Forwarded-Encrypted: i=1; AJvYcCUf1VwCIOh0a3WuxAYb1+RhxNK7bJATDOGNkoeEow5ty63pHp2lH3rbqVLgMsAcfBSDRoluip/TcOgp1E4DbKEC@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQM0sIOFJZC93WmjxFV/AMNgiy/2tvD5DBnbIEVO3D+odDIX9
	ssWMB7w6D2OnMCxTJuuDZGojoXyivzdfds0Ws/A2OOP+ZIn/ZL0zZxftK8ztBE+VtnLsSVt1+DF
	EF58cnQ==
X-Google-Smtp-Source: AGHT+IG1zx26qQHAzqiLBUtrRzJXR+kqfJstP7FYSoC2xoOMAWBu+eO7OrTp0s/Fw2wwPvD/OOi7YEUCvyL0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:ae63:0:b0:e11:639b:6428 with SMTP id
 3f1490d57ef6-e337f77f713mr8790276.0.1731109617162; Fri, 08 Nov 2024 15:46:57
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:46:05 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 20/20] perf build: Remove PERF_HAVE_DWARF_REGS
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

PERF_HAVE_DWARF_REGS was true when an architecture had a dwarf-regs.c
file. There are no more architecture dwarf-regs.c files, selection is
done using constants from the ELF file rather than conditional
compilation. When removing PERF_HAVE_DWARF_REGS was the only variable
in the Makefile, remove the Makefile.

Add missing SPDX for RISC-V Makefile.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config         | 13 ++++---------
 tools/perf/arch/arm/Makefile       |  3 ---
 tools/perf/arch/arm64/Makefile     |  3 ---
 tools/perf/arch/csky/Makefile      |  4 ----
 tools/perf/arch/loongarch/Makefile |  3 ---
 tools/perf/arch/mips/Makefile      |  4 ----
 tools/perf/arch/powerpc/Makefile   |  4 ----
 tools/perf/arch/riscv/Makefile     |  4 +---
 tools/perf/arch/s390/Makefile      |  3 ---
 tools/perf/arch/sh/Makefile        |  4 ----
 tools/perf/arch/sparc/Makefile     |  4 ----
 tools/perf/arch/x86/Makefile       |  3 ---
 tools/perf/arch/xtensa/Makefile    |  4 ----
 13 files changed, 5 insertions(+), 51 deletions(-)
 delete mode 100644 tools/perf/arch/csky/Makefile
 delete mode 100644 tools/perf/arch/sh/Makefile
 delete mode 100644 tools/perf/arch/xtensa/Makefile

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 52a216df9e2a..2916d59c88cd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -559,15 +559,10 @@ ifndef NO_LIBELF
   endif
 
   ifndef NO_LIBDW
-    ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
-      $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
-      NO_LIBDW := 1
-    else
-      CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
-      LDFLAGS += $(LIBDW_LDFLAGS)
-      EXTLIBS += ${DWARFLIBS}
-      $(call detected,CONFIG_LIBDW)
-    endif # PERF_HAVE_DWARF_REGS
+    CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
+    LDFLAGS += $(LIBDW_LDFLAGS)
+    EXTLIBS += ${DWARFLIBS}
+    $(call detected,CONFIG_LIBDW)
   endif # NO_LIBDW
 
   ifndef NO_LIBBPF
diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
index 9b164d379548..8b59ce8efb89 100644
--- a/tools/perf/arch/arm/Makefile
+++ b/tools/perf/arch/arm/Makefile
@@ -1,5 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index ca2e35961287..91570d5d428e 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/csky/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 79b432744296..52544d59245b 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index 733f7b76f52d..827168f1077a 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 # Syscall table generation for perf
 out    := $(OUTPUT)arch/mips/include/generated/asm
 header := $(out)/syscalls_n64.c
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index ae05727835d8..dc8f4fb8e324 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index d83e0f32f3a8..18ad078000e2 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,6 +1,4 @@
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
+# SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 58e79f5b67a4..c431c21b11ef 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/sh/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 7741184894c8..8b59ce8efb89 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,6 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 51cf267f4d85..a6b6e0a9308a 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/xtensa/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-- 
2.47.0.277.g8800431eea-goog

