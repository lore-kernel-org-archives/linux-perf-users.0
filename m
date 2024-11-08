Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761401AA1EA
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109573; cv=none; b=HxvQCzUoeyYKTZFE4CNelSgsfxrJ2kCIitSe7Lk4UdrMii8DYEtKHy4ofMlNZ2EInX3dItxZm5eY6S0ICUNZgFYh2Vj1N/0algOjkUu/JusZVf18SgekZZusO+Wa6Ee58Xk7VnkkJmGf90lz9RcWrEpVGn+5E8vdN7jropc0HQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109573; c=relaxed/simple;
	bh=slTDJpkuXaI2FSflzZPrxxPFD5Jf9rX1KtNIM7MAfoU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QEA4WAja7gQ2sA0XkTzyFaSbG3paHEoOd2p0ru5BJl+PDK3/skz7+9601IfjDfve4a7Ip74s58ihRPWJh0UX1u/FnBmIWuOGT2e+DjYqkluR6F9xyM+K1cn0HrXMuit0+j+qWRHPLElpqvShj8/xYYuIqgc8C5kztMEAVF+Hcvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnpg/lLr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnpg/lLr"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33aad097so41864307b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109570; x=1731714370; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bo+XoNcfTiWt9dXZSAxdrxoaHvpnygZk759HUW2Tdtc=;
        b=cnpg/lLrrHzrGjA6Xnsfa6VxTMuT2o3uTHL1sWo5/cPFNSF28T+05JpuIFjMCCz6v9
         xte1vqJ43SHIIyEiYzissF3qG1h+FQApnvXBWKARh0iT3cL+C598hy5rV0sbnBbCW/ko
         3SyOUaZ9cnLMGOMHP63meI8n09upT7ZgWihwb+zvDPe0t3P+embVW1qaV/klQjteG5BA
         xrXLgRC+8Bb7/nVozy1V+LcvpyHKvk7FkkGlFVOnpFR9Xb+5scysop3MQc9sshLjnFBu
         nFFctVDR4B91YQNiTtbCKKNRe1hWIGNdZIGzgDNu6dRCNlXcVGCIsmPNjIrYRcOq0W8h
         IXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109570; x=1731714370;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bo+XoNcfTiWt9dXZSAxdrxoaHvpnygZk759HUW2Tdtc=;
        b=iistiWBxDT7mFxRVZVWXBEb+GUxuZYpMEXbEq1cFzkj7D9T3SDx9CobqdNoz61oSd4
         92RB1u0Av4w9GYBa1oVBX9BijNkhsGx7evCFb457ngJEUTY52Efh0AuQ50YHFbvESpuW
         WyrQJ/Iey5XHA6f23/G6HWtvzgHXSu61v9e50GJgx2MFIvEw2MSl2ZK6606TIu9jL3Dy
         6RZko3Kq+cCu/ywapncTwkMXAWR3Y9eTeh+DhPXD1wVSyHFGZ62e1QMl43NZp6qwL39y
         OxmaXeDqimPNaACIeHop/VPDEkgDRFT5hsO5WoYLde/FyU2gHK+FmDq9Ff7v1r+G1u8R
         TwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXrqnvg5yRmvU/GO+kBpMctc7WTGxFSXq3w/R5jP7S1XhYDgkLEoCF6iJHuO5ayfVN9AIx+ZrPsHiZ5FMGxMxH@vger.kernel.org
X-Gm-Message-State: AOJu0YwgfdAquIhTU6LtYej9XmNOUqUWERMVpaqkYTmJ4iUfylj2Hfjs
	58NI6PWR6INembNhNx6yz6h5O1Krjy5oyJVRKpeFhEPpfw4PvDdkpFIyomKtxR4vAgSR1jnKOMu
	fCq3DpA==
X-Google-Smtp-Source: AGHT+IG7nNHrZbf62YTEIFaabL+CBo69CYr9RS79+TUQD474jGBOE4r4BpO1ymNXWY8gOslRzk6deJr/eKGp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:d843:0:b0:e29:7454:e773 with SMTP id
 3f1490d57ef6-e337e1d738cmr20475276.5.1731109569972; Fri, 08 Nov 2024 15:46:09
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:45 -0800
Message-Id: <20241108234606.429459-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 00/20] Remove PERF_HAVE_DWARF_REGS
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

These changes were originally on top of:
https://lore.kernel.org/lkml/20241017001354.56973-1-irogers@google.com/

Prior to these patches PERF_HAVE_DWARF_REGS indicated the presence of
dwarf-regs.c in the arch directory. dwarf-regs.c provided upto 4
functions:

1) regs_query_register_offset would translate a register name into a
pt_regs offset and was used by BPF prologues. BPF prologues existed
for BPF events and support for these was removed many releases ago.
This code was dead and could be removed.

2) get_arch_regstr duplicated get_dwarf_regstr and so it could be
removed.  The case for csky was a little more complicated as the ABI
controlled the string. The callers of get_dwarf_regstr were updated to
also pass the ELF flags so that on csky the ABI appropriate table
could be used. As the argument is only used on csky this a no-op for
everything else.

3) get_arch_regnum translated a register name back to a dwarf number
and only existed on x86 where "al", "ax", "eax" and "rax" could all
mean register 0. This code was moved to util with similar
machine/flags logic to get_arch_regstr and for consistency with it.

4) get_powerpc_regs a PowerPC specific function used by annotate that
should really be in util.

2 and 3 required the wiring through of the ELF machine and flags in
callers to get_dwarf_regstr and get_dwarf_regnum. When these values
weren't dependent on an ELF file a new EM_HOST and EF_HOST were added
to give the host ELF machine and flags. These 2 #defines got rid of
the existing separate arch files and #ifdefs.

v4: Add CSky defines to dwarf-regs.h Add reviewed-by tags from Masami.
v3: These files were separated from the rest of the v2 libdw clean up
    in:
https://lore.kernel.org/lkml/CAP-5=fVZH3L-6y_sxLwSmT8WyMXDMFnuqUksNULdQYJCPNBFYw@mail.gmail.com/

Ian Rogers (20):
  perf bpf-prologue: Remove unused file
  perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
  perf dwarf-regs: Add EM_HOST and EF_HOST defines
  perf disasm: Add e_machine/e_flags to struct arch
  perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
  perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
  perf dwarf-regs: Move x86 dwarf-regs out of arch
  perf arm64: Remove dwarf-regs.c
  perf arm: Remove dwarf-regs.c
  perf dwarf-regs: Move csky dwarf-regs out of arch
  perf loongarch: Remove dwarf-regs.c
  perf mips: Remove dwarf-regs.c
  perf dwarf-regs: Move powerpc dwarf-regs out of arch
  perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
  perf s390: Remove dwarf-regs.c
  perf sh: Remove dwarf-regs.c
  perf sparc: Remove dwarf-regs.c
  perf xtensa: Remove dwarf-regs.c
  perf dwarf-regs: Remove get_arch_regstr code
  perf build: Remove PERF_HAVE_DWARF_REGS

 tools/perf/Makefile.config                    |  17 +-
 tools/perf/arch/arc/annotate/instructions.c   |   2 +
 tools/perf/arch/arm/Makefile                  |   3 -
 tools/perf/arch/arm/annotate/instructions.c   |   2 +
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/dwarf-regs.c         |  61 -------
 tools/perf/arch/arm64/Makefile                |   4 -
 tools/perf/arch/arm64/annotate/instructions.c |   2 +
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/dwarf-regs.c       |  92 -----------
 tools/perf/arch/csky/Makefile                 |   4 -
 tools/perf/arch/csky/annotate/instructions.c  |   7 +-
 tools/perf/arch/csky/util/Build               |   1 -
 tools/perf/arch/loongarch/Makefile            |   4 -
 .../arch/loongarch/annotate/instructions.c    |   2 +
 tools/perf/arch/loongarch/util/Build          |   1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c   |  44 -----
 tools/perf/arch/mips/Makefile                 |   4 -
 tools/perf/arch/mips/annotate/instructions.c  |   2 +
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/dwarf-regs.c        |  38 -----
 tools/perf/arch/powerpc/Makefile              |   5 -
 .../perf/arch/powerpc/annotate/instructions.c |   2 +
 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/powerpc/util/dwarf-regs.c     | 153 ------------------
 tools/perf/arch/riscv/Makefile                |   5 +-
 .../arch/riscv/include/dwarf-regs-table.h     |  42 +++++
 tools/perf/arch/riscv/util/Build              |   1 -
 tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ---------
 .../perf/arch/riscv64/annotate/instructions.c |   2 +
 tools/perf/arch/s390/Makefile                 |   4 -
 tools/perf/arch/s390/annotate/instructions.c  |   2 +
 tools/perf/arch/s390/util/Build               |   1 -
 tools/perf/arch/s390/util/dwarf-regs.c        |  43 -----
 tools/perf/arch/sh/Build                      |   1 -
 tools/perf/arch/sh/Makefile                   |   4 -
 tools/perf/arch/sh/util/Build                 |   1 -
 tools/perf/arch/sh/util/dwarf-regs.c          |  41 -----
 tools/perf/arch/sparc/Build                   |   1 -
 tools/perf/arch/sparc/Makefile                |   4 -
 tools/perf/arch/sparc/annotate/instructions.c |   2 +
 tools/perf/arch/sparc/util/Build              |   1 -
 tools/perf/arch/sparc/util/dwarf-regs.c       |  39 -----
 tools/perf/arch/x86/Makefile                  |   4 -
 tools/perf/arch/x86/annotate/instructions.c   |   3 +-
 tools/perf/arch/x86/util/Build                |   3 -
 tools/perf/arch/x86/util/dwarf-regs.c         | 153 ------------------
 tools/perf/arch/xtensa/Build                  |   1 -
 tools/perf/arch/xtensa/Makefile               |   4 -
 tools/perf/arch/xtensa/util/Build             |   1 -
 tools/perf/arch/xtensa/util/dwarf-regs.c      |  21 ---
 tools/perf/util/Build                         |   3 +
 tools/perf/util/annotate.c                    |   6 +-
 tools/perf/util/bpf-prologue.h                |  37 -----
 tools/perf/util/disasm.c                      |   1 +
 tools/perf/util/disasm.h                      |   4 +
 .../dwarf-regs.c => util/dwarf-regs-csky.c}   |  19 +--
 tools/perf/util/dwarf-regs-powerpc.c          |  61 +++++++
 tools/perf/util/dwarf-regs-x86.c              |  50 ++++++
 tools/perf/util/dwarf-regs.c                  |  38 +++--
 tools/perf/util/include/dwarf-regs.h          | 120 +++++++++++---
 tools/perf/util/probe-finder.c                |  13 +-
 tools/perf/util/probe-finder.h                |   3 +-
 63 files changed, 339 insertions(+), 927 deletions(-)
 delete mode 100644 tools/perf/arch/arm/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/csky/Makefile
 delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/riscv/include/dwarf-regs-table.h
 delete mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sh/Build
 delete mode 100644 tools/perf/arch/sh/Makefile
 delete mode 100644 tools/perf/arch/sh/util/Build
 delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sparc/Build
 delete mode 100644 tools/perf/arch/sparc/util/Build
 delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/xtensa/Build
 delete mode 100644 tools/perf/arch/xtensa/Makefile
 delete mode 100644 tools/perf/arch/xtensa/util/Build
 delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c
 delete mode 100644 tools/perf/util/bpf-prologue.h
 rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)
 create mode 100644 tools/perf/util/dwarf-regs-powerpc.c
 create mode 100644 tools/perf/util/dwarf-regs-x86.c

-- 
2.47.0.277.g8800431eea-goog

