Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E48158DCC
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Oct 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158160; cv=none; b=jHBUFvLm8hOyRQ6jYt2jTuRPu4m8A9bWL7/gV60QuwCXuawKJr9wWm6W/PcvlYW5VkhrCGBAc2iZOIwcmzNbDk1Vis5KpxYVx9UdNSaJ1uJ2odwhvWVwpkXmzsEUbXQkEUhnbwmJjkoi69XnoO42v8ZkIz25wMW2rEJVaLC6rCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158160; c=relaxed/simple;
	bh=hgb9wBnFI2K1JcNYB1Gr2y66PY6zuzgMm0senkI4xfQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=NQ7odb9pUjoyLnT8FBHyhrdCkyhrQTnmEqERrayZUrDAwKwkyqg/A+OKqJJ/94jj/ACCn6KP7vksYxR4epiTBzAmYnnreixN31ws+Ghqajt9K9seXjZVluOGrvu27l6JeVHBh8TCd5JyqaM78qLRq9Z1tHC0qfESFfZ/yoWnIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVECoMvb; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVECoMvb"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2555d3d0eso54455947b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Oct 2024 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158158; x=1728762958; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Ia1pxUxtivl837TCEzwnkRhGXsXOccOACzKPX2t/h8=;
        b=jVECoMvbUbY018/UphOJ2/w7PuSiuch8hFa0O+6i98e9jn65/WpJydxdKPTTi7JUoz
         yIy0ZtAGg0qWRLht5pPN1yNt/opFWKXTMm7MsIDYu3dUzDYXwJV9RBvke8DOtrpnrmaR
         I8nCxtAc57FSThx78783iN25ZHRnnS3twLDcMzfEvbhcBfRcgZqCe1XLFwqxX8TEy6VU
         fetDj/jR3D8ViBvna3idAexL3vPGRlyYdjjr1ik1oQrBAmn32tw2xGZSIMV20EqKe+Pu
         91k7wEF9W8ah76WWGHeAO04Cw4ffcdB4XsLQVp4idU+xJW03ma1/qoycM3VoKjs/IS42
         nHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158158; x=1728762958;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ia1pxUxtivl837TCEzwnkRhGXsXOccOACzKPX2t/h8=;
        b=ncxd9MMDvuZYUuIH/zYP1e3w5qgXoMtd11GM3YLm+kD4jWiELzQzEdm+FEPuyd1vnK
         d6L12Z8iPSwnNCBQBkPhvMD2MblRR+tbjve5sLeyA7uB+1vpCO6VknOYJeaKIyuZsAz7
         0AeeWk/pvNS8JHQJbMUxpC0jse5JmN9uYJJCDYVQ5CAHpzQSsWeZ7QPLGHqqq2HyDM+J
         VAMMiPy4UYVVqAbkdaXQiqynjjv9DQ6/HW+wfZ1x3e5Sz0vhsWAuuYaSOj6YN2h1i88f
         cOHOM8yZEw6FfVlZK4v9JgiNWoas+wx3LgF8QScpAIBRvU3sN1WkmWBgLSG+jYnAp9iX
         umhw==
X-Forwarded-Encrypted: i=1; AJvYcCWqBj5wLMIojK3GHchnTPjR/k5PB8EzaL7OSwk3QUTUm3avW3FNqWw50MOorgO6bpiJdq5nqOuEYNqXQLDPj3xH@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFD7D9wg4njxhjHcWXqMSlg0pesUWWk217pU95WCSZhBKBQPZ
	NeliZ3FsKGUQmdujdawyKKpyi9dS/ljjpfs30lYHCYdA2Q4PEVfZceJa0XMtyMzwMdB5MjvaCJh
	Oba85cg==
X-Google-Smtp-Source: AGHT+IEASCaY05lrXQKKNEqOZGA4D4bafeubD7up1cQ89dxTILSgemClarJHc4Z6Y6dnUZEhXAABTIp0GUvt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f8c:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6e2c72ca7d4mr2444947b3.8.1728158158105; Sat, 05 Oct 2024
 12:55:58 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:10 -0700
Message-Id: <20241005195541.380070-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 00/31] Libdw/dwarf build clean up
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

There patches are on top of:
https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/
where it was pointed out that a lot of the libdw conditional
compilation was due to features that have now been standard for 10 or
15 years. The patches remove the conditional compilation assuming the
features are in libdw where the feature test is expanded to check
there pressence.

In the Makefile code, and for `perf record --call-graph`, dwarf tends
to mean unwind or libdw support for dwarf things. To make it clearer
when dwarf really just means libdw numerous build variables and
defines are renamed. PERF_HAVE_DWARF_REGS was particularly tricky and
has been removed as it isn't necessary as was somewhat inversely
guarding libdw support. The Makefile variable indicated an
architecture having a dwarf-regs.c file. This file contained code for
BPF prologues, which were removed with BPF event support. The files
also often just contained a redundant get_arch_regstr function. The
function was redundant as get_dwarf_regstr would do the appropriate
thing if the ELF machine were given. To remove get_arch_regstr the ELF
machine is computed for the host machine. This now makes the logic
work across platforms, but the testing I was able to do across
platforms was minimal.

There is some tech debt in the changes as perf check still reports the
values using the old name and for features that are no longer
tested. This can be cleanup for another day.

v2: Instead of renaming PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS,
    remove it.

Ian Rogers (31):
  perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT
  perf build: Rename NO_DWARF to NO_LIBDW
  perf build: Remove defined but never used variable
  perf build: Rename test-dwarf to test-libdw
  perf build: Combine libdw-dwarf-unwind into libdw feature tests
  perf build: Combine test-dwarf-getlocations into test-libdw
  perf build: Combine test-dwarf-getcfi into test-libdw
  perf probe: Move elfutils support check to libdw check
  perf libdw: Remove unnecessary defines
  perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
  perf build: Rename CONFIG_DWARF to CONFIG_LIBDW
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

 tools/build/Makefile.feature                  |  11 +-
 tools/build/feature/Makefile                  |  24 +--
 tools/build/feature/test-all.c                |  16 +-
 tools/build/feature/test-dwarf.c              |  11 --
 tools/build/feature/test-dwarf_getcfi.c       |   9 --
 tools/build/feature/test-dwarf_getlocations.c |  13 --
 tools/build/feature/test-libdw-dwarf-unwind.c |  14 --
 tools/build/feature/test-libdw.c              |  56 +++++++
 tools/perf/Documentation/perf-check.txt       |   6 +-
 tools/perf/Makefile.config                    |  58 ++-----
 tools/perf/Makefile.perf                      |   2 +-
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
 .../perf/arch/powerpc/annotate/instructions.c |   6 +-
 tools/perf/arch/powerpc/util/Build            |   3 +-
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
 tools/perf/arch/x86/annotate/instructions.c   |   5 +-
 tools/perf/arch/x86/util/Build                |   3 -
 tools/perf/arch/x86/util/dwarf-regs.c         | 153 ------------------
 tools/perf/arch/xtensa/Build                  |   1 -
 tools/perf/arch/xtensa/Makefile               |   4 -
 tools/perf/arch/xtensa/util/Build             |   1 -
 tools/perf/arch/xtensa/util/dwarf-regs.c      |  21 ---
 tools/perf/builtin-annotate.c                 |   2 +-
 tools/perf/builtin-check.c                    |   6 +-
 tools/perf/builtin-probe.c                    |  14 +-
 tools/perf/builtin-report.c                   |   4 +-
 tools/perf/util/Build                         |  15 +-
 tools/perf/util/annotate-data.h               |   8 +-
 tools/perf/util/annotate.c                    |   6 +-
 tools/perf/util/bpf-prologue.h                |  37 -----
 tools/perf/util/debuginfo.h                   |   6 +-
 tools/perf/util/disasm.c                      |   4 +-
 tools/perf/util/disasm.h                      |   8 +-
 tools/perf/util/dwarf-aux.c                   |   6 -
 tools/perf/util/dwarf-aux.h                   |  53 ------
 .../dwarf-regs.c => util/dwarf-regs-csky.c}   |  19 +--
 tools/perf/util/dwarf-regs-powerpc.c          |  61 +++++++
 tools/perf/util/dwarf-regs-x86.c              |  50 ++++++
 tools/perf/util/dwarf-regs.c                  |  38 +++--
 tools/perf/util/genelf.c                      |   4 +-
 tools/perf/util/genelf.h                      |   2 +-
 tools/perf/util/include/dwarf-regs.h          | 114 ++++++++++---
 tools/perf/util/probe-event.c                 |   4 +-
 tools/perf/util/probe-finder.c                |  19 +--
 tools/perf/util/probe-finder.h                |   9 +-
 84 files changed, 454 insertions(+), 1157 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf.c
 delete mode 100644 tools/build/feature/test-dwarf_getcfi.c
 delete mode 100644 tools/build/feature/test-dwarf_getlocations.c
 delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c
 create mode 100644 tools/build/feature/test-libdw.c
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
2.47.0.rc0.187.ge670bccf7e-goog

