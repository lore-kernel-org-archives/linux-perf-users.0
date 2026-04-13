Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2911FD4
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048493; cv=none; b=r+Cupx/PNIckaQJApm2m8X+jihWBbCR/9Tgh3ZXXVEaX55dwMj0hWf3mmGrD287uUine5g3MWjeLMQaTaU3Ef7TpI1Za6TjU6Pzfh0qxxsmww5d2G0hc40Ag2hqXJkhnOdzl/PZ6Jd/lwXNOpSmBzl2KnkDrOQh4H9+BpeVIkmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048493; c=relaxed/simple;
	bh=2E+9zj8/SkKfdVsNcdQAzHiLGCeLvBwcwaFg+Ma2uRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SAPLfzxTXeWmzpfHZCofK9W5yeZIDpA8xupPNXkY3k8VG2f6o6GwrXO9XwcECrcmUPvFOtLfW34Y/OHK9aMZQgZ0GASRAloYTXgHhTo+MWSnDm88qC1vOG6PXeLjfIzOkYvCXXfdRZx0vzsrjc24fjDALKHT9r0mx2psWXPCqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQ1+/nt1; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQ1+/nt1"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d443c3b094so8671896eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776048490; x=1776653290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1hYaaoL2TK3xqrMtTO2We7nUeIa8+5wMOYf3VUga0c=;
        b=VQ1+/nt1A+XW245N43pxv/epCaWPhSRSmrof9Wrzqx4Q2TUQT5VLOneD/+ALLFxaip
         Dt4UQ4yh9BQoxG/4Ofptkid8GYbNxWLYiHiL8Ol+wU2W7lCWuj8JJG/P/AtAJVvBgx6R
         egV3GKyedEDJKuhOMkf2RO7yfDzOdQ2cvoQppF9PR9nD63cx5wvbFPogj2FLnotx7zul
         doy7+3g8TftXnudDbm2pWsDIfDKZBzUSpvrraGCrs0LqbCS9psOE1een9icqlp5oz30T
         O+CU70ClS3hehJlYw6ksoykeRO+OtI7kvmlReXrixQwgiUCdFhHdG/aXZQ74o7Ry7NB5
         jEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048490; x=1776653290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1hYaaoL2TK3xqrMtTO2We7nUeIa8+5wMOYf3VUga0c=;
        b=F44rNdeF/bhvOQu1ETjmXiafibYh/tpYPN1L35RCSGYXE5DDhMSHvCncMQEJk3w78a
         L04Hvgxe2LrCv4SBILBtldyphjxpskPh3ubPJ0rUo0HMzz87FEemlX2XISsiDxae1wea
         P59LY4ODQ0mKGbqN5hOzogPqPEtdwYgI8A68XHd58GTSflk8H6RDCbAetN7tnPnVGzxL
         xRK4cApbPcQ1lAlKgDKdQF/Sk1EVystemzuo4YycvpWKPfDUswYiZteo9k0JJCcdeJnm
         cIA+shyirtqqDCW6mF6s+J5YfQi+S8IbrVCSsIanhEWXIHrk96GczSzF4XWrZzwBxVq1
         7BFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DyNX92DpRtpL2x0EXomUKDzIhCp6plDKJAqnxKUdnOVIGyizN/M5IMjqrTEIUn5C3qSBOmLFQ2b7fvDMG8f1d@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhv/725NILA0ftBburn76zujCAlcYRm3dowsW2/chb3PfuGFHw
	xvp0M66R7stY7uKPldXsNcoFKNBpM7rS/a9T0wyCxNXPithdZD+UgziwdvHLh2HPLngwk61umNT
	+7Be94m3SHQ==
X-Received: from dyt12.prod.google.com ([2002:a05:693c:808c:b0:2d7:37d5:85cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5787:b0:2da:10f0:a8df
 with SMTP id 5a478bee46e88-2da10f0b2e4mr76194eec.12.1776048489353; Sun, 12
 Apr 2026 19:48:09 -0700 (PDT)
Date: Sun, 12 Apr 2026 19:47:57 -0700
In-Reply-To: <advv6twWCEVBo_Hc@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <advv6twWCEVBo_Hc@x1>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413024805.1316480-1-irogers@google.com>
Subject: [PATCH v4 0/8] perf libunwind multiple remote support
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, howardchu95@gmail.com, 
	irogers@google.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"

Fix the libunwind build for when libdw and libunwind are feature
detected, currently failing with a duplicate symbol.

Refactor the libunwind support so that whenever a remote target is
available, perf functions using the ELF machine can use that remote
target regardless of what the host/local machine is. Migrate existing
libunwind supported architectures like powerpc, arm64 and loongarch so
that they can work in a cross-architecture way. Add support for
RISC-V. Make the code more regular in function names, etc. and avoid
including a C-file. This increases the lines of code. It is similar in
style to the unwind-libdw implementation. It is hoped that the more
uniform nature of the code with help with refactoring the perf
registers for SIMD/APX support.

Aside from local host testing these patches are under tested, in part
as I'm failing to see how to build libunwind with support for multiple
remote targets. Please could I get help in testing.

v4: Rebase, in particular the zalloc->calloc change conflicted.

v3: Minor whitespace clean up and warn when a dynamic choice of libdw
    or libunwind is selected for unwinding and support is missing (Arnaldo).
https://lore.kernel.org/lkml/20260404054032.1538095-1-irogers@google.com/

v2: Move two fixes patches to position 1 and 2 in the series. Fix
    struct naming inconsistency, Andrew Jones
    <andrew.jones@oss.qualcomm.com>. Fix other inconsistencies and
    potential non-x86 build issues.
https://lore.kernel.org/lkml/20260305221927.3237145-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.com/

Ian Rogers (8):
  perf unwind: Refactor get_entries to allow dynamic libdw/libunwind
    selection
  perf build loongarch: Remove reference to missing file
  tools build: Deduplicate test-libunwind for different architectures
  perf build: Be more programmatic when setting up libunwind variables
  perf unwind-libunwind: Make libunwind register reading cross platform
  perf unwind-libunwind: Move flush/finish access out of local
  perf unwind-libunwind: Remove libunwind-local
  perf unwind-libunwind: Add RISC-V libunwind support

 tools/build/feature/Makefile                  |  38 +-
 tools/build/feature/test-libunwind-aarch64.c  |  27 -
 tools/build/feature/test-libunwind-arm.c      |  28 -
 .../test-libunwind-debug-frame-aarch64.c      |  17 -
 .../feature/test-libunwind-debug-frame-arm.c  |  17 -
 .../feature/test-libunwind-debug-frame.c      |   1 -
 tools/build/feature/test-libunwind-x86.c      |  28 -
 tools/build/feature/test-libunwind-x86_64.c   |  28 -
 tools/build/feature/test-libunwind.c          |   1 -
 tools/perf/Makefile.config                    | 215 ++---
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/unwind-libunwind.c   |  50 --
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/unwind-libunwind.c |  17 -
 tools/perf/arch/loongarch/util/Build          |   3 -
 .../arch/loongarch/util/unwind-libunwind.c    |  82 --
 tools/perf/arch/mips/Build                    |   1 -
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/unwind-libunwind.c  |  22 -
 tools/perf/arch/powerpc/util/Build            |   1 -
 .../perf/arch/powerpc/util/unwind-libunwind.c |  92 --
 tools/perf/arch/x86/util/Build                |   3 -
 tools/perf/arch/x86/util/unwind-libunwind.c   | 115 ---
 tools/perf/builtin-inject.c                   |   4 +
 tools/perf/builtin-report.c                   |   4 +
 tools/perf/builtin-script.c                   |   4 +
 tools/perf/util/Build                         |   5 +-
 tools/perf/util/libunwind-arch/Build          |  11 +
 .../perf/util/libunwind-arch/libunwind-arch.c | 319 +++++++
 .../perf/util/libunwind-arch/libunwind-arch.h | 296 +++++++
 .../perf/util/libunwind-arch/libunwind-arm.c  | 290 ++++++
 .../util/libunwind-arch/libunwind-arm64.c     | 289 ++++++
 .../perf/util/libunwind-arch/libunwind-i386.c | 312 +++++++
 .../util/libunwind-arch/libunwind-loongarch.c | 297 +++++++
 .../perf/util/libunwind-arch/libunwind-mips.c | 299 +++++++
 .../util/libunwind-arch/libunwind-ppc32.c     | 301 +++++++
 .../util/libunwind-arch/libunwind-ppc64.c     | 303 +++++++
 .../util/libunwind-arch/libunwind-riscv.c     | 297 +++++++
 .../perf/util/libunwind-arch/libunwind-s390.c | 299 +++++++
 .../util/libunwind-arch/libunwind-x86_64.c    | 320 +++++++
 tools/perf/util/libunwind/arm64.c             |  40 -
 tools/perf/util/libunwind/x86_32.c            |  41 -
 tools/perf/util/maps.c                        |  29 +-
 tools/perf/util/maps.h                        |   4 +-
 tools/perf/util/symbol_conf.h                 |  10 +
 tools/perf/util/thread.c                      |  29 +-
 tools/perf/util/unwind-libdw.c                |   2 +-
 tools/perf/util/unwind-libunwind-local.c      | 831 ------------------
 tools/perf/util/unwind-libunwind.c            | 679 ++++++++++++--
 tools/perf/util/unwind.c                      |  98 +++
 tools/perf/util/unwind.h                      |  77 +-
 51 files changed, 4549 insertions(+), 1731 deletions(-)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
 delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/mips/Build
 delete mode 100644 tools/perf/arch/mips/util/Build
 delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
 create mode 100644 tools/perf/util/libunwind-arch/Build
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.h
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-i386.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-loongarch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-mips.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc32.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-riscv.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-s390.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-x86_64.c
 delete mode 100644 tools/perf/util/libunwind/arm64.c
 delete mode 100644 tools/perf/util/libunwind/x86_32.c
 delete mode 100644 tools/perf/util/unwind-libunwind-local.c
 create mode 100644 tools/perf/util/unwind.c

-- 
2.53.0.1213.gd9a14994de-goog

