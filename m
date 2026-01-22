Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBD367F24
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100869; cv=none; b=TC475pPh7JQxMgp6zWzkENuyuQADEo0vrRge90J2L/LAIGf3jRINndm+a+v6qAYA3iy40CBcYxwzPgrWgO96ltCRC9+lfDANhqbVPFqOna3MEj39AJPPCmoByawaUNQRyXgTHkfR31bUYSGB0l3YBWpi0E7MII8U1K+k7D91/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100869; c=relaxed/simple;
	bh=tI6CnFHFGW2mHe/ilKBHMpKa7DzCNr0AjpSz8C0GdXU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=dNqyVHBgs92ZkQS91HrkxMfT8oTKFaLjRoNgYf4DBOSbMSGkZgXS490/YY6tJ2yJ0UOtS9i1+oGmRYse7n5FGU27MuCk30YvKQY7hyhLkcOQphEolrE0YXZY4fT5fWB4eafXAcFlbclAlq1T+DgohgkGJTWBNh2iJt2CcuO+oCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hFPF4O7L; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hFPF4O7L"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b70bd4a2ccso5364654eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100855; x=1769705655; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ptohnX8yCM46UmZak3D8AP5tKkb3cPUe+4O8l8XtsLs=;
        b=hFPF4O7LLQhPU1E679fOzOI7s0dlGyeS4TGkUMe4ePXneJ2Eun6r4wcw8gfh/1w03A
         go5yG12geARak4vsCQusXYhx2wNgyzEUUmKFU+z/JSSvXXS03tQGYnAWFxN5S1+SwICA
         vaHd9T6ro4ZstNQ3uLWrQ83CTKWY7CGytTPZsumk2nM6zMdCkmSiTd26/7JtKfLhvrqa
         DlOxFmy/5u4F5/nj4+xt0hP9SQhQE+oFWwnRcsQJsehtkCDAI2EO1aOvDDN6Nr2UFsc2
         z7CHVagvS+L+cUgLn6hlgzlhv7xedqvevYGQzLTIMCGix3hF8d5+i2jCQ8rabP/Bzi0l
         k4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100855; x=1769705655;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptohnX8yCM46UmZak3D8AP5tKkb3cPUe+4O8l8XtsLs=;
        b=JS2x0bZbmjLpvms2CLgwT0m/ljTMzbllWVPDuTqfvYaHychLZ3uxrBKhTNugM2EbTz
         5SZKyEx8t6ZDjJ6bOkEy4WYiaSrA8YYey/M9e+fZfscCV2qwJk86h0TKnyHmwwzg97pg
         5CllypLyGjKcxcP9o1zeIYartfWhnDmKkFJCypw/9DlwZ9L1bbzlT30eHST/GsTi5PhO
         MMiaz5aQWI8Dpz8ZNee2dMVI3Qwb1ebJdkmJXl9F8YoUNHJyeKfVO+YUptOklfd1oQzX
         tb0bhG1jUAJKNhv3owqr9yjbHk0KHL9GKTbnfXTMN1PBI6crtYUvVFfyrf+zGMR/xrPh
         1Y3g==
X-Forwarded-Encrypted: i=1; AJvYcCWUYynDFf69GGPK2QhiWTqCO73ebWE5u1jXFL49WzF8ahWxrRgZjr3SaR85Hqs67srurGLDTzQYD0dfqFIrS4Av@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2k3KzMiVAcGp64s7RMKbyVP6/efS6UEWl4uP9pJTbB7hS/1M
	jzaPQzGkXBqVXPxVKA4jdh5LdZoFpzl3NywrJnnmH6yvI9p6ba++T8QLeFGd5jDIkMlC2ExhXmY
	lN4p6No+TGQ==
X-Received: from dybgn17.prod.google.com ([2002:a05:7301:2511:b0:2b7:3bb:5997])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:650c:b0:2ae:51ae:5cfd
 with SMTP id 5a478bee46e88-2b6b4104264mr16128244eec.22.1769100854683; Thu, 22
 Jan 2026 08:54:14 -0800 (PST)
Date: Thu, 22 Jan 2026 08:53:55 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122165407.561888-1-irogers@google.com>
Subject: [PATCH v2 00/12] perf annotate arch clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

3 initial memory leak fix patches for perf annotate.

Move the disasm.c #included arch files into a new util/annotate-arch
directory. Make the code compile standalone. Try to better encapsulate
architecture specific code within the files and with a
arch__new_<arch> function that allows additional data to be associated
with the struct arch using the standard container_of trick.

Make the lookup of struct arch use the ELF machine gather from a
thread rather than an evsel. For example, the evsel can't determine
the difference between EM_386 and EM_X86_64 so generally the latter
has currently been used. This means the dwarf registers are off as
register 1 is CX with EM_386 and DX with EM_X86_64. To facilitate this
change map_symbol is refactored to use a struct thread rather than a
struct maps, the maps being obtainable from the thread.

To make in and out arguments clearer, for safety, etc. try to constify
struct arch and its related structs.

v2: Add a patch to fix a domain info memory leak that was blocking
    leak sanitizer analysis. Fix more map_symbol leaks or uses after
    reference count put (Suchit Karunakaran
    <suchitkarunakaran@gmail.com>).  Try to repro annotate test crash
    (James Clark) but suspect it was addressed in the other reference
    count fixes.

v1: https://lore.kernel.org/lkml/20260122073127.375139-1-irogers@google.com/

Ian Rogers (12):
  perf header: Fix memory leaks in process_cpu_domain_info
  perf annotate: Fix args leak of map_symbol
  perf maps: Fix reference count leak in maps__find_ams
  perf disasm: Constify use of struct arch
  perf disasm: Constify use of struct ins_op
  perf disasm: Constify use of struct ins
  perf disasm: Rework the string arch__is to use the ELF machine
  perf disasm: Don't include C files from the arch directory
  perf disasm: Refactor ins__is_call/jump to avoid exposing arch ins_ops
  perf map_symbol: Switch from holding maps to holding thread
  perf disasm: Refactor arch__find and initialization of arch structs
  perf disasm: Minor layout tweaks for struct arch

 tools/perf/arch/arc/annotate/instructions.c   |  11 -
 .../perf/arch/riscv64/annotate/instructions.c |  36 --
 tools/perf/ui/browsers/annotate.c             |   6 +-
 tools/perf/ui/browsers/hists.c                |   3 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/addr_location.c               |   4 -
 tools/perf/util/addr_location.h               |   1 -
 tools/perf/util/annotate-arch/Build           |  11 +
 tools/perf/util/annotate-arch/annotate-arc.c  |  18 +
 .../annotate-arch/annotate-arm.c}             |  48 +-
 .../annotate-arch/annotate-arm64.c}           |  59 +--
 .../annotate-arch/annotate-csky.c}            |  29 +-
 .../annotate-arch/annotate-loongarch.c}       |  71 +--
 .../annotate-arch/annotate-mips.c}            |  29 +-
 .../annotate-arch/annotate-powerpc.c}         | 125 ++++-
 .../util/annotate-arch/annotate-riscv64.c     |  41 ++
 .../annotate-arch/annotate-s390.c}            |  70 +--
 .../annotate-arch/annotate-sparc.c}           |  26 +-
 .../annotate-arch/annotate-x86.c}             |  89 ++--
 tools/perf/util/annotate-data.c               |  12 +-
 tools/perf/util/annotate-data.h               |   2 +-
 tools/perf/util/annotate.c                    |  88 ++--
 tools/perf/util/annotate.h                    |  10 +-
 tools/perf/util/callchain.c                   |  12 +-
 tools/perf/util/capstone.c                    |  18 +-
 tools/perf/util/db-export.c                   |   1 -
 tools/perf/util/disasm.c                      | 428 +++++++-----------
 tools/perf/util/disasm.h                      |  95 ++--
 tools/perf/util/event.c                       |   2 -
 tools/perf/util/header.c                      |  17 +-
 tools/perf/util/hist.c                        |  18 +-
 tools/perf/util/llvm.c                        |   8 +-
 tools/perf/util/machine.c                     |  13 +-
 tools/perf/util/map_symbol.c                  |   5 +-
 tools/perf/util/map_symbol.h                  |   3 +-
 tools/perf/util/maps.c                        |   1 +
 tools/perf/util/sort.c                        |   2 +-
 tools/perf/util/unwind-libdw.c                |   2 +-
 tools/perf/util/unwind-libunwind-local.c      |   2 +-
 39 files changed, 774 insertions(+), 643 deletions(-)
 delete mode 100644 tools/perf/arch/arc/annotate/instructions.c
 delete mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
 create mode 100644 tools/perf/util/annotate-arch/Build
 create mode 100644 tools/perf/util/annotate-arch/annotate-arc.c
 rename tools/perf/{arch/arm/annotate/instructions.c => util/annotate-arch/annotate-arm.c} (59%)
 rename tools/perf/{arch/arm64/annotate/instructions.c => util/annotate-arch/annotate-arm64.c} (70%)
 rename tools/perf/{arch/csky/annotate/instructions.c => util/annotate-arch/annotate-csky.c} (67%)
 rename tools/perf/{arch/loongarch/annotate/instructions.c => util/annotate-arch/annotate-loongarch.c} (60%)
 rename tools/perf/{arch/mips/annotate/instructions.c => util/annotate-arch/annotate-mips.c} (59%)
 rename tools/perf/{arch/powerpc/annotate/instructions.c => util/annotate-arch/annotate-powerpc.c} (73%)
 create mode 100644 tools/perf/util/annotate-arch/annotate-riscv64.c
 rename tools/perf/{arch/s390/annotate/instructions.c => util/annotate-arch/annotate-s390.c} (66%)
 rename tools/perf/{arch/sparc/annotate/instructions.c => util/annotate-arch/annotate-sparc.c} (85%)
 rename tools/perf/{arch/x86/annotate/instructions.c => util/annotate-arch/annotate-x86.c} (93%)

-- 
2.52.0.457.g6b5491de43-goog

