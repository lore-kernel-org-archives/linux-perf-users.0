Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E131AD3F0
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193910; cv=none; b=DSwJUG1O749nbpa4XFqQ5HTCOi5zlg8Oi2aFk5AcCW2f/1y697ZoNJTBdjFBbsdQKDeeSbeyORVE7pMprAiPxemOs7MWoTkv1gl3OasPL6HFNYNayfsLeGUMCQx8Cik1LYdDVAn997I0DZGt6hDxmoFolYyoTJk7rTNrVd9Z6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193910; c=relaxed/simple;
	bh=yR3S/QpjquObBe7JFP5pEHpgsdRsAxAPtK1ohMcO5pM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PrzsN7l1jIUJvETA5rLeiEnLtLgDp40q27d0AXVFiPZ5QjIn4jX5zuZ1BdqEYwXpLu8ADhRNesmIfzZBwF+ZuqVGmJtgIG8XqTHMCFysbaBkAqX3JJNtDs+R0KGKiKRsXQC4aXC7zv1z5XTXM6IYhryd5Mmw98fPZChC33Uostw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFmGTMH4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFmGTMH4"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e000d68bb1so42240137b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193907; x=1727798707; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wghZHiK6xOuwsFpy1Cr3uM6o408gcIshRLTrqEU1l1A=;
        b=AFmGTMH4h/kf+jDbZaPCHIdcTfoauWzK4wxP2rcg1FJkscCOvgECI3h1dcz79g5vE1
         i62wg9Msn0WuF+0wv3r/0tEXhFWGZxJAScqMm+QN2nHVkpZN+ea0Wb5HM3zr7oIQPp/U
         A0YOAWhWJI0DM8zOENUQ4xCoNZVgBQ90ghkPMfBnRZ1uw2PYjRsApoLoLvzRmXgt65VS
         0q/RTKgmwh45qw3lHn5kER8NzBqERr5Zni5qylgoSOmzebBC8qtzUCJp/u8FaP/KE/Wf
         FB37hVo61YKoWKjNQOyIRqvUiHQQR9piugbNDQH4z+vsGldGuItQZ91dQd9tTP9QCE6K
         SsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193907; x=1727798707;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wghZHiK6xOuwsFpy1Cr3uM6o408gcIshRLTrqEU1l1A=;
        b=TrAaCCNZurorzucR2BtAy9aoQbRpwB8NT6dj+Vl4DCWkBnEVhhPCfNX0NV6ImnoIhM
         3hEVORwoIYOAUI3EBIHEXw0b+Ze8nF5Z6W4eLkCrE+gRGFgAkC8/1fyvLP7Fh+mFfocY
         EY/wVZWJI7LeQCr8d6Jn2KCtZ8Ju+dxpTMr5a4gYOUc9l1TKbIM1xwhiJ1plhdKtnRSx
         h+PRFODdZDa2u9MpyngFcn3ay3AJ2jTfSoKy3LSP7IcAwrjz78AcOZ3pxFuADGzhF9bq
         PGz0Q+N5pjYf8o/2+s2+pkzl7gvz378BBZcIsEE68/a6w0xnKeI/YZRNrLIWPY9f7Qqm
         B9UA==
X-Forwarded-Encrypted: i=1; AJvYcCW001XhD2hClw8A4GZJh+b/cfU4tKST3xHmanU+HO6LWpq0H+AfzUqlPPOYz9hMugMW0KXwUKeYaZOYgSkEXpkq@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJs1/n66QFPl8lEuuDlQvOphUsbrOeqyrSGGJoZgIZOyv+zyh
	CCPdGsWPfb48Fmzs3k3tbb3kNJOrJiUaBS6UvbOkB0tnfeZxAHTJgjCwaA5M9LsSh2pcUruc8cp
	WXeYfFQ==
X-Google-Smtp-Source: AGHT+IHK7CWmw4K4/CFOVeEQBpTQhVH3F5ZQ+PWdG+TbKzCE3GwA+6c3+rdZhZyxVVfJZ/FHS/aE7lmcBSID
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:dc8c:0:b0:e0b:b36e:d73d with SMTP id
 3f1490d57ef6-e24979369b9mr22619276.4.1727193907464; Tue, 24 Sep 2024 09:05:07
 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:17 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 10/11] perf build: Rename CONFIG_DWARF to CONFIG_LIBDW
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
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

In Makefile.config for unwinding the name dwarf implies either
libunwind or libdw. Make it clearer that CONFIG_DWARF is really just
defined when libdw is present by renaming to CONFIG_LIBDW.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config           |  2 +-
 tools/perf/arch/arm/util/Build       |  2 +-
 tools/perf/arch/arm64/util/Build     |  2 +-
 tools/perf/arch/csky/util/Build      |  2 +-
 tools/perf/arch/loongarch/util/Build |  2 +-
 tools/perf/arch/mips/util/Build      |  2 +-
 tools/perf/arch/powerpc/util/Build   |  4 ++--
 tools/perf/arch/riscv/util/Build     |  2 +-
 tools/perf/arch/s390/util/Build      |  2 +-
 tools/perf/arch/sh/util/Build        |  2 +-
 tools/perf/arch/sparc/util/Build     |  2 +-
 tools/perf/arch/x86/util/Build       |  2 +-
 tools/perf/arch/xtensa/util/Build    |  2 +-
 tools/perf/util/Build                | 12 ++++++------
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9ed0909db170..b14430ab2898 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -559,7 +559,7 @@ ifndef NO_LIBELF
       CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
       LDFLAGS += $(LIBDW_LDFLAGS)
       EXTLIBS += ${DWARFLIBS}
-      $(call detected,CONFIG_DWARF)
+      $(call detected,CONFIG_LIBDW)
     endif # PERF_HAVE_DWARF_REGS
   endif # NO_LIBDW
 
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index e6dd7cd79ebd..e06fea1ea8ff 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,6 +1,6 @@
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 343ef7589a77..4387a6d6a6c3 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -4,7 +4,7 @@ perf-util-y += perf_regs.o
 perf-util-y += tsc.o
 perf-util-y += pmu.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
index 99d83f41bf43..1325310cab6a 100644
--- a/tools/perf/arch/csky/util/Build
+++ b/tools/perf/arch/csky/util/Build
@@ -1,4 +1,4 @@
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index b6b97de48233..06ff95394921 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,7 +1,7 @@
 perf-util-y += header.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
index e4644f1e68a0..b328109fc16c 100644
--- a/tools/perf/arch/mips/util/Build
+++ b/tools/perf/arch/mips/util/Build
@@ -1,3 +1,3 @@
 perf-util-y += perf_regs.o
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 6c588ecdf3bd..3d979480a188 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -7,8 +7,8 @@ perf-util-y += sym-handling.o
 perf-util-y += evsel.o
 perf-util-y += event.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
-perf-util-$(CONFIG_DWARF) += skip-callchain-idx.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
 perf-util-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index f865cb0489ec..8f93091b8345 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -2,5 +2,5 @@ perf-util-y += perf_regs.o
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 1ac830030ff3..787410f99bb3 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -2,7 +2,7 @@ perf-util-y += header.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-util-y += machine.o
diff --git a/tools/perf/arch/sh/util/Build b/tools/perf/arch/sh/util/Build
index 32f44fc4ab98..2337a0b710a2 100644
--- a/tools/perf/arch/sh/util/Build
+++ b/tools/perf/arch/sh/util/Build
@@ -1 +1 @@
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/sparc/util/Build b/tools/perf/arch/sparc/util/Build
index 32f44fc4ab98..2337a0b710a2 100644
--- a/tools/perf/arch/sparc/util/Build
+++ b/tools/perf/arch/sparc/util/Build
@@ -1 +1 @@
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 2607ed5c4296..9705cda4f240 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -12,7 +12,7 @@ perf-util-y += evsel.o
 perf-util-y += iostat.o
 perf-util-y += env.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
diff --git a/tools/perf/arch/xtensa/util/Build b/tools/perf/arch/xtensa/util/Build
index e813e618954b..2d1a48696ad9 100644
--- a/tools/perf/arch/xtensa/util/Build
+++ b/tools/perf/arch/xtensa/util/Build
@@ -1 +1 @@
-perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index dc616292b2dd..1d08608b7e1b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -199,11 +199,11 @@ ifndef CONFIG_SETNS
 perf-util-y += setns.o
 endif
 
-perf-util-$(CONFIG_DWARF) += probe-finder.o
-perf-util-$(CONFIG_DWARF) += dwarf-aux.o
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
-perf-util-$(CONFIG_DWARF) += debuginfo.o
-perf-util-$(CONFIG_DWARF) += annotate-data.o
+perf-util-$(CONFIG_LIBDW) += probe-finder.o
+perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += debuginfo.o
+perf-util-$(CONFIG_LIBDW) += annotate-data.o
 
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
@@ -234,7 +234,7 @@ perf-util-$(CONFIG_LIBLLVM) += llvm-c-helpers.o
 ifdef CONFIG_JITDUMP
 perf-util-$(CONFIG_LIBELF) += jitdump.o
 perf-util-$(CONFIG_LIBELF) += genelf.o
-perf-util-$(CONFIG_DWARF) += genelf_debug.o
+perf-util-$(CONFIG_LIBDW) += genelf_debug.o
 endif
 
 perf-util-y += perf-hooks.o
-- 
2.46.0.792.g87dc391469-goog

